#!/usr/bin/env bash
# Publish a built site release to the VPS, then notify IndexNow (M21.1 §1.6).
#
# This replaces the GitHub Pages deploy once M21.2 §3 activates it. Until
# then Pages is the public target and this script must not be run.
#
#   scripts/publish-vps.sh [<commit-sha>]    # default: origin/main HEAD
#
# Rollback is the same command with the previous sha (the box prints it).
# Needs: ssh alias cz-prod (one-shot commands only), docker (to confirm the
# container workflow published that sha), curl.
set -euo pipefail

SHA="${1:-$(git rev-parse origin/main)}"
IMAGE="ghcr.io/n8bar/cryptozing-site"
KEY="465536a63a3c14ac146077111999e458"
PUBLIC="https://cryptozing.app"

# 1. container.yml must have pushed this commit's image.
docker manifest inspect "${IMAGE}:${SHA}" > /dev/null \
    || { echo "ERROR: ${IMAGE}:${SHA} is not published yet (check the container workflow)" >&2; exit 1; }

# 2. Roll the box's site container onto it (prints the rollback target).
ssh cz-prod "cd /opt/cryptozing && ./publish-site.sh ${SHA}"

# 3. Only notify once the public site actually serves this release.
if ! diff -q <(git show "${SHA}:sitemap.xml") <(curl -fsS "${PUBLIC}/sitemap.xml") > /dev/null; then
    echo "ERROR: ${PUBLIC}/sitemap.xml does not match ${SHA}; not notifying IndexNow" >&2
    exit 1
fi

git show "${SHA}:sitemap.xml" | grep -oP '(?<=<loc>)[^<]+' | while read -r url; do
    curl -s -o /dev/null -w "%{http_code} ${url}\n" "https://api.indexnow.org/indexnow?url=${url}&key=${KEY}"
done

echo "Published ${IMAGE}:${SHA} to ${PUBLIC}"
