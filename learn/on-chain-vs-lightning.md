---
layout: article.njk
title: "Bitcoin On-Chain vs Lightning: What Merchants Need to Know"
subtitle: ""
description: "On-chain or Lightning? A fair look at what each does well, what each costs, and which one better suits how merchants and freelancers get paid in Bitcoin."
canonical: "https://cryptozing.app/learn/on-chain-vs-lightning/"
author: "Nate Barlow, CryptoZing"
date: 2026-11-20
---

Say a client wants to pay us in Bitcoin. Do we take it on-chain, or over Lightning?

Ask around and we'll hear both answers, each with plenty of confidence. Lightning is fast and cheap. On-chain is simple and proven. How long would we actually wait for an on-chain payment, and what would it cost our client? If we take Lightning, how much setup is needed on our end before we can get paid?

## Where does the payment land?

Say one client pays $200 in Bitcoin to an address from our on-chain wallet. We can see the payment there and, once it confirms, spend it from that wallet. Tomorrow another client pays a $200 [Lightning invoice](/learn/what-is-a-bitcoin-invoice/). That payment shows up in our Lightning balance. We could watch the on-chain address all day and we'd never see that second payment come in.

Both clients have paid us in Bitcoin, but if we want to send the full $400 to an on-chain address, the Lightning part still has to move over. Some wallets handle that step for us. If we keep separate wallets, it's a transfer we have to arrange, and there's usually a fee.

## The problem Lightning solves

An invoice due in two weeks gives us room to wait for a confirmation. A customer standing at the counter with a cup of coffee probably has somewhere else to be. An on-chain payment takes about ten minutes on average to get its first confirmation, whether the customer is paying us $5 or $500.

Lightning lets us take the payment without waiting for a block. It usually takes a few seconds, and on a $5 sale the routing fee is typically small. By the time the customer puts their phone away, the cashier can see they've paid.

When Square started letting its US sellers take Bitcoin at the counter, it used Lightning and capped each payment at $600. [Square’s payment guide](https://squareup.com/help/us/en/article/8622-accept-and-manage-bitcoin-payments)

## "Lightning" is really three different setups

We can run our own node. We can use a wallet where a provider manages the channels for us. Or we can hand the whole thing to a company that holds the Bitcoin. The work and the trust are very different in each one.

| Setup | What it costs to receive | What we give up |
|---|---|---|
| Our own node | No processor's cut, but we pay for the channels and the Bitcoin in them | Our time, and the backups are on us |
| A wallet where a provider manages the channels | Little or nothing while there's room, about 1% plus mining fees when there isn't | We depend on that one provider |
| A company that holds the Bitcoin | Usually between 0% and 1% | Our keys, and the account comes with limits |

About 1% is the number that keeps coming up. OpenNode and Speed both list it. Square's Bitcoin payments carry a 0% processing fee through the end of 2026, then 1%. [Phoenix](https://phoenix.acinq.co/faq), a popular wallet of the second kind, charges 1% plus mining fees when it has to make room for a payment.

We've written before about [what giving up the keys means](/learn/custodial-vs-noncustodial-bitcoin-payments/) and about [the work of running a node](/learn/btcpay-server-alternatives/), so we'll leave those there.

## The Bitcoin that has to sit in channels

A channel holds Bitcoin split between two sides, ours and our channel partner's. To pay, we need Bitcoin on our side. To get paid, the Bitcoin has to be on the partner's side, where it can be pushed over to ours.

That last part is the one that catches people. If we open a channel with our own Bitcoin, it starts out on our side. We can pay with it, but there's no room yet for anyone to pay us. Lightning Labs [puts it plainly](https://docs.lightning.engineering/the-lightning-network/liquidity/how-to-get-inbound-capacity-on-the-lightning-network): to receive, we need inbound capacity.

So to get paid, someone has to commit their Bitcoin to a channel with us. Usually that's a provider, and usually we pay for it, which is where a lot of that 1% comes from.

Each payment we receive moves Bitcoin over to our side and leaves less room for the next one. If we spend some of that Bitcoin back through the channel, we make room to receive again.

Say a client owes us $2,000. The median public channel holds about $1,500 in Bitcoin as we write this, and that's the two sides put together. Even if all $1,500 is on our partner's side, the payment won't fit. We'd need a channel with enough room on its own, or enough room spread across several channels for the payment to be split between them.

With a custodian we don't see any of this. It's still happening, and it's part of what their fee pays for.

## The costs that don't show up on the invoice

Opening and closing a channel are on-chain transactions, so Lightning still pays on-chain fees. It just pays them at different moments. Then there's staying online, and keeping backups current.

On a quiet day, opening and closing a channel is cheap. The one to watch is the forced close, where one side shuts the channel without the other’s help. A [study of public channel closes](https://arxiv.org/abs/2611.16311), still awaiting peer review, found that a forced close cost two to six times as much as closing together. It can also take days before the side that closed the channel can spend its Bitcoin again. Phoenix tells its users to expect about five days.

Staying online matters because of how Lightning hands off a payment. On-chain, a client can pay our address while our computer is off. On Lightning, the receiving side has to be there when the payment comes through. With a phone wallet that means the app, and Phoenix warns that payments can fail when the app is closed or in the background. A custodian gets around this by being online for us.

Then backups. An on-chain wallet comes back from its seed words. If we run our own Lightning node, the seed words aren't enough by themselves. The channel records need backing up too, and they change every time we open a channel.

The node operators whose accounts we read described the time they spent keeping things running, the fees they paid to close channels, and the wait to get their Bitcoin back.

## Can the client even pay that way?

A client using Robinhood Crypto in the U.S. can pay us on-chain. Robinhood doesn’t support Lightning. [Robinhood’s transfer guide](https://robinhood.com/us/en/support/articles/crypto-transfers/)

A client using a self-custody wallet might run into the same limit. They control the keys, but whether they can pay a Lightning invoice depends on the wallet they use.

How often do customers use Lightning when they pay a merchant? At CoinGate, about one Bitcoin order in ten went over Lightning in the first half of 2026, down from about 15% in 2024. [CoinGate’s payment report](https://coingate.com/blog/post/crypto-payments-data-report-h1-2026)

If our client’s wallet only sends on-chain, we can give them a Bitcoin address and they can pay us from the wallet they already use. Lightning users typically have on-chain wallets too.

There’s a catch, though. If we’re selling a laptop or a TV, we may want a confirmation before the customer walks out with it. Bitcoin blocks come about ten minutes apart on average. Even if the payment makes the next block, that’s a long wait with a line behind them. For a cup of coffee, a pending payment with enough fee to confirm soon may be enough. It’s just a coffee.

## What plain on-chain actually looks like

If we already have a wallet, all our client needs from us is a Bitcoin address. They pay the network fee, which has been [around ten cents](https://mempool.space/) lately.

The fee depends on how much space the transaction takes up. A $20,000 payment can cost about the same to send as a $20 one.

The wait is about ten minutes on average for the first confirmation and about an hour for six. We covered what those mean in [Bitcoin Pending vs Confirmed Payments](/learn/bitcoin-pending-vs-confirmed-payments/). For an invoice due in two weeks, an hour is easy to live with.

With a Bitcoin invoicing tool like our very own [CryptoZing](https://cryptozing.app/), each invoice gets an address from our wallet. When the client pays, the Bitcoin goes straight to that wallet. CryptoZing watches the address so we can see how much came in and how many confirmations the payment has.

## Where on-chain bites

On April 20, 2024, the average Bitcoin transaction fee hit $128. That spike passed in days. The one around December 2023 lasted longer. Fees averaged over $10 on 51 days between early November and mid-January.

What would a spike cost our client? Take a simple payment with Bitcoin at $60,000. At a quiet-day fee rate it costs about 8 cents to send. At a rate like we saw in December 2023, it costs about $13.

| Payment | Quiet day | Fee spike |
|---|---|---|
| $20 | 0.4% | 63% |
| $200 | 0.04% | 6.3% |
| $2,000 | 0.004% | 0.6% |
| $20,000 | 0.0004% | 0.06% |

A large invoice barely feels a spike. A small sale gets swallowed by it. A client who sets a low fee can wait hours for the payment to confirm.

There's a cost on our end too. If we receive lots of small payments, spending them together takes more space and costs more. We can gather them up on a quiet day when fees are low.

A [fresh address for each invoice](/learn/how-to-receive-bitcoin/) helps with privacy, and our own CryptoZing is perfect for this because it gives each invoice a fresh address automatically. However, a client can easily look up the address they paid and see where that Bitcoin goes next.

## So which one?

Selling coffee across a counter and sending a $2,000 invoice due in two weeks are two different jobs.

If we want to know a $5 sale is settled before the customer leaves, Lightning can do that in seconds. If our provider charges us 1%, that’s a nickel. In an on-chain fee spike, our client could spend more on the fee than on the coffee.

On a $2,000 invoice, that same 1% costs us $20. If the client pays on-chain, they cover the network fee, around ten cents on a quiet day. And with two weeks to pay, we can wait for a confirmation.

On-chain gets us most of the way there for little effort. Adding Lightning to cover the last 20% could be 80% of the work.

## Where we stand

CryptoZing tracks on-chain payments only, so weigh what we’ve said with that in mind.

We built it for invoices where the client pays from a distance and has a few days to pay. If most of your sales happen across a counter, Lightning deserves a real look.
