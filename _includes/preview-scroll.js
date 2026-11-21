(() => {
  const article = document.querySelector('.article-wrap');
  const viewport = article.closest('.scroll-area');
  const blocks = Array.from(article.children);
  const headings = blocks.filter(block => block.matches('h1, h2, h3'));
  const key = 'article-preview:' + location.pathname;

  function sectionFor(block) {
    return headings.findLast(heading =>
      heading === block || (heading.compareDocumentPosition(block) & Node.DOCUMENT_POSITION_FOLLOWING)
    );
  }

  window.addEventListener('pagehide', () => {
    const bounds = viewport.getBoundingClientRect();
    const block = blocks.find(item => item.getBoundingClientRect().bottom > bounds.top);
    const position = { y: viewport.scrollTop };
    if (block && viewport.scrollTop > 0 && block.getBoundingClientRect().top < bounds.bottom) {
      position.text = block.textContent;
      position.section = sectionFor(block)?.textContent;
      position.top = block.getBoundingClientRect().top - bounds.top;
    }
    sessionStorage.setItem(key, JSON.stringify(position));
  });

  if (performance.getEntriesByType('navigation')[0]?.type !== 'reload') return;
  const saved = JSON.parse(sessionStorage.getItem(key) || 'null');
  if (!saved) return;
  history.scrollRestoration = 'manual';
  window.addEventListener('pageshow', () => {
    requestAnimationFrame(() => {
      const block = blocks.find(item => item.textContent === saved.text &&
        sectionFor(item)?.textContent === saved.section);
      const heading = headings.find(item => item.textContent === saved.section);
      const top = viewport.getBoundingClientRect().top;
      let y = saved.y;
      if (block) y = viewport.scrollTop + block.getBoundingClientRect().top - top - saved.top;
      else if (heading) y = viewport.scrollTop + heading.getBoundingClientRect().top - top;
      viewport.scrollTo({ top: y, behavior: 'instant' });
      history.scrollRestoration = 'auto';
    });
  }, { once: true });
})();
