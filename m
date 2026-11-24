Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559206;
	b=PdZL1EWgh7Tjzl0Op1pCGReREt/sOPUQDh0rVeWpxChNv9Q7Uuo+XRuUeiLbT/n8ZWFO
	 I/Zu1hJaAum3RmbP6qyAvrvOCwYCAceORhE3069UFqqaMt6ng1abFgZbAowf25xVHD9Lw
	 bbxErZA8IMhZhrm7s5HaIflcnL1zHTm2Fax3Tr02GzY4uub0NiqJoeRjNufSHOh76zVkO
	 nx9WmNZpZ6KT2Aeg5NCVvtfiaUdm7Gj4rT3pDXonsO+StYlIbZ1tTYXj/Fr1BMz2Skzyr
	 7cQkJjtOEq6cBE59weu7KyGr13LHYsZTramiT76rwiE1u1D3/K393x74mZIriB4gAmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559206;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kh2kJ+2Np8Dw/qOxyLMonL7roGXEOyoYyokdh8x2BgI=;
	b=wyi09CqSIg14EPEsl79o/Yqldlma1SFhFzrWUeE09xpfFOLdpwcnRmoD0Uv9xjpT+g88
	 6RAa0FPP/YokNvfqYp4gqxwoMYf/8iOD0BWVDpoGx1EH9mNxWT75R7/Lhf16Ip7Fzc9Nh
	 IB79IV4F19vAbUlyM7TFVKv3rylTvTTT0icwkLiPKI8DEW4e5hyT50gf4gbxXuTgbJj/p
	 Q3RTE+Tf6FxCbls4/9nAuhAtY/5ogmuslQ909DaBSoVbm/LLv7GtpQNaj8bXGGfpKwPga
	 S0ZZYW9m+BP+6g11/+xrfJgDSi4zvg2Fk1uKuL33bN71VV99bWjGYppjz7QLHq+mDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk8cE3P5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AF606A31E
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk8cE3P5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E301F000C4;
	Tue, 24 Nov 2026 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559205;
	bh=kh2kJ+2Np8Dw/qOxyLMonL7roGXEOyoYyokdh8x2BgI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mk8cE3P5+Q0cZBmKoL766TXh31qKcWdfKWLTtEl+Q9SloCSYUbNsLUOyrOOrMqWCu
	 HWnaL9GeOgXZMRob5ukvC2NgS4ptuha3Y/dorM83WGlT27pdw57NtiO8Ni/wDZ4fXf
	 Hfe0SB1onkWNcZLCzwROcIclTL+Ah5VCIrMlg1mOCzWzBNquKtmWs/SieqWZrEf91F
	 Z0RC+stbdHHSliTqGtwfI1BTXOicdJqWDnLoHm5LpFLyezRywKOPAaFCC0FIxcmN6C
	 2TQQa8MvvF77K1Jts7IFe+dOnxRmt6eJo38o7D2BDVOpPh3Ks1DCrnLQ/VgG6UkuxR
	 iSFZEPFD3LUrA==
Subject: Re: [PATCH] can: peak_pci: fix UAF and leak of PCIeC resources
From: netdev-bot+sashiko@kernel.org
To: b.lane130@outlook.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, s.grosjean@peak-system.fr,
 wg@grandegger.com, linux-can@vger.kernel.org, kuba@kernel.org
Date: Tue, 24 Nov 2026 22:26:44 +0000
Message-ID: <179555920456.3131.15451986872188013076@kernel.org>
In-Reply-To: <BN8PR06MB6177DC485B9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com>
References: <BN8PR06MB6177DC485B9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a use-after-free in the failure_remove_channels
  loop of peak_pci_probe() (drivers/net/can/sja1000/peak_pci.c).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  copies it.
- [Medium] This problem wasn't introduced by this patch, but
  peak_pciec_led_work() (drivers/net/can/sja1000/peak_pci.c:287) can…

--

can: peak_pci: fix UAF and leak of PCIeC resources

This commit adds a peak_pciec_remove() call to the failure_free_dev path
of peak_pci_probe(), so the PCIeC card is not leaked when the first
channel fails to register. It also moves the peak_pciec_remove() call in
failure_remove_channels into the channel loop, ahead of
unregister_sja1000dev() for the first channel, following the order used
by commit 949fe9b35570.

> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index 69c61ccf621df..d5f862f05480a 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -697,6 +697,10 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return 0;
>  
>  failure_free_dev:
> +	/* free any PCIeC resources too */
> +	if (!chan->prev_dev && chan->pciec_card)
> +		peak_pciec_remove(chan->pciec_card);
> +
>  	pci_set_drvdata(pdev, chan->prev_dev);
>  	free_sja1000dev(dev);

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. On a
PCAN-ExpressCard, when this path runs for a channel i > 0, can
peak_pciec_led_work() read the net_device freed here?

peak_pciec_probe() adds each channel to the shared card, and nothing
ever clears that entry:

    chan->pciec_card = card;
    card->channel[card->chan_count++].netdev = dev;

peak_pciec_write_reg() arms led_work once channel 0 enters normal mode.
The work re-arms itself every HZ while any channel is up, and it reads
every entry below chan_count:

    netdev = card->channel[i].netdev;
    if (!netdev || !(netdev->flags & IFF_UP))
        continue;
    ...
    if (netdev->stats.rx_bytes != card->channel[i].prev_rx_bytes) {

Here, channel i is freed while card->channel[i] still points to it. The
failure_remove_channels loop then frees channels i-1..1. led_work is only
cancelled once the loop reaches peak_pciec_remove() for channel 0.

peak_pci_remove() has the same window. It unregisters and frees channels
N-1..1 before channel 0's peak_pciec_remove() calls
cancel_delayed_work_sync().

If can0 is up, can led_work run in that window and read the flags and
stats of a freed netdev?

>  
> @@ -709,15 +713,12 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		priv = netdev_priv(dev);
>  		chan = priv->priv;
>  		prev_dev = chan->prev_dev;
> -
> +		if (!prev_dev && chan->pciec_card)
> +			peak_pciec_remove(chan->pciec_card);
>  		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);

[Severity: High]
Does this add a new use-after-free of the peak_pciec_card?

For the first channel, peak_pciec_remove() runs i2c_del_adapter() and
kfree(card), and then unregister_sja1000dev(dev) runs on that same
channel. Channel 0 is the one whose priv->write_reg was set to
peak_pciec_write_reg() in peak_pciec_probe(), so the call chain is:

peak_pci_probe()
  peak_pciec_remove(card)          /* kfree(card) */
  unregister_sja1000dev(dev0)
    set_reset_mode()
      priv->write_reg(priv, SJA1000_IER, IRQ_OFF)
        peak_pciec_write_reg()
          card = chan->pciec_card;
          c = (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;

set_reset_mode() always does the IER write, so the freed card is read
every time this error path runs.

If the chip does not report MOD_RM (for example, can0 was brought up
after it registered), set_reset_mode() also writes SJA1000_MOD with
MOD_RM up to 100 times. Each write goes through peak_pciec_set_leds()
and peak_pciec_write_pca9553() to i2c_transfer() on card->led_chip,
which has already been deleted and freed. If can0 is up,
unregister_candev() then calls sja1000_close(), which runs
set_reset_mode() again.

can0 is also still registered between peak_pciec_remove() and
unregister_candev(). Could a concurrent "ip link set can0 up" write
MOD=0x00 here? That would reach peak_pciec_start_led_work() and call
schedule_delayed_work() on the freed card->led_work.

Before this patch, the only use-after-free on this path was the read of
chan->pciec_card from the freed netdev after the loop. Would it be better
to save the card pointer, stop led_work, unregister and free all the
netdevs, and only then call peak_pciec_remove() on the saved card?

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. The new
loop copies the order used in peak_pci_remove(), and that function looks
like it has the same problem every time a PCAN-ExpressCard is removed:

drivers/net/can/sja1000/peak_pci.c:peak_pci_remove() {
    ...
		if (!prev_dev && chan->pciec_card)
			peak_pciec_remove(chan->pciec_card);
		unregister_sja1000dev(dev);
		free_sja1000dev(dev);
    ...
}

The card is freed before channel 0 is unregistered. set_reset_mode()
then reaches peak_pciec_write_reg() and reads card->reg_base from freed
memory.

On a normal rmmod or unbind with can0 up, the MOD_RM write also reaches
i2c_transfer() on the deleted and freed led_chip. sja1000_close(),
called from unregister_candev(), then does the same thing again.

The commit message cites 949fe9b35570 as the model for this order.
Should peak_pci_remove() get the same fix in this series?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/BN8PR06MB6177DC485B9CA4729F930DBDA4452%40BN8PR06MB6177.namprd06.prod.outlook.com
