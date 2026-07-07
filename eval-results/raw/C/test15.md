That's not correct — please don't send it.

**The math:** a 20% discount then a 20% fee leaves the customer at **96% of the original price**, not 100%.

- Start: $100
- After 20% discount: $80
- After 20% fee **on the discounted price**: $80 × 1.20 = **$96**

The reason it doesn't cancel: the two 20%s apply to *different bases*. The discount comes off the full $100 (−$20), but the fee is charged on the smaller $80 (+$16). The fee is smaller in dollar terms, so you land $4 below where you started. The percentage that *would* restore $80 to $100 is +25% (20/80), not +20%.

**One caveat worth confirming before you send:** this assumes the 20% fee is applied to the discounted subtotal, which is the normal case. If your system instead charges the fee on the *original* price ($100 × 20% = $20), then $80 + $20 = $100 and it *would* be cost-neutral. Which base the fee uses is the one thing that flips the answer — worth checking how it's actually implemented.

Under the standard interpretation, the promotion is a net **4% discount**, not cost-neutral. I'd correct the note before it goes out.
