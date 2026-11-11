Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363303;
	b=hgc3B0ibE9NaWJLLNHugkGsRoAbeZk5eDl0ccIOwjxFNp+dq4/Ww7tECJ7MrUEtv2w+A
	 rhk4AbVr0ONpynhsK1NFhLTk5PxkRwA/VKdGcYH00Sj2MvepiAKPcBk41aRve+jpRtrNR
	 IAY/c3e7fYEWWZ4x5L3RKuaR8vgKj6bf8KfGT68/pBqmHINFGDzD40zH2YPfGWMo5+3b1
	 LMTgUhJ9LTtQMNRG6wIOX4iTQ2oiFN54KWoz6AMVKEwtUJ00RGU17iMuhrHR9Di9NcCbU
	 Nm+9GjfGEV1zaEkoQEsA5RYOyHwnNtmyUrdOk80tt+OUzBT6NFY8HTvTLeGIThOxe3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363303;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8Khbbrx8RtYMMbTHptqZ8BeBrgbUwTQxKVRyE2HzIXU=;
	b=Fi1CAF32ZxsF7Xc/wY+UPDFL/svgFo6lJ4VOtFvRHYfaqYIGiSEIhb4bAIwSVwkrzbTD
	 FnZXvh4KViQ2PTZW1r/4zZGoWPCpy2FckCzOEeNlbgY+7jhsXBDJeqfRql8lkccYpl96c
	 /gr0i1Z7msbeYsNtzPLXqGSZ2pXX1ObRfT4nAJdroNjLA9ljCZLH8T1RMOMoz2LAQWp/j
	 tUcBSZKmIMD5zqGtISflE2WkGWLff4lMgAKnom/QEx0EgxZkMRrIKD6LUGLmj3LtlyR+w
	 35xw4mHqp1UwEq8gBvq0ySEg+XcThq1Jc6ouB1kHY9KF6T37y5ybWh35PvhjMIWyL3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XejXyDI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FA606A32E;
	Wed, 11 Nov 2026 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XejXyDI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E91F0089F;
	Wed, 11 Nov 2026 02:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363302;
	bh=8Khbbrx8RtYMMbTHptqZ8BeBrgbUwTQxKVRyE2HzIXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XejXyDI84coFVpqhr9IUyGQtKRbZ3O413i2nxS6YrMB8FfK31rjx7gaOydfEt1YoF
	 Nm4P5uzqRON4Ez9Is3f8QL3EMHLazQGRrmBCCyy0oPlzF2FwBTCUwoufU1kSBAHi9X
	 HAkYymAseTwdllyYSbAvZLfKNr3RM90Pu9p1Mpl2q53udhXXyKNGgFjoRLjl6aJbZe
	 Dua3eeTxAVYhoP5hVUI7xvL7aynEk1pXfDOs69DMPxzH5ZWXVcXGcMTkDRfSIkuswL
	 wEqGJPyDCzLKZoTgF2cQQ53sjWvkpQ6ffjtMAroBSS8lBo1FBBXBezsrZ0zhHtWpP9
	 AHjp9nxRxQ/nw==
Subject:
 Re: [PATCH net] can: peak_pci: Fix potential use-after-free during removal
From: netdev-bot+sashiko@kernel.org
To: liguangshuo@mail.sdu.edu.cn
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 11 Nov 2026 02:15:01 +0000
Message-ID: <179436330191.488853.6308521949106037669@kernel.org>
In-Reply-To: <20261109-21df1234b2-can-peak-pci@mail.sdu.edu.cn>
References: <20261109-21df1234b2-can-peak-pci@mail.sdu.edu.cn>
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] peak_pci_remove() can still hit a use-after-free after this
  patch.

Pre-existing issues:
- [High] The failure_remove_channels cleanup in peak_pci_probe() reads
  chan->pciec_card from freed memory.
- [High] When channel 0's register_sja1000dev() fails on a PCAN-
  ExpressCard, peak_pci_probe() never cleans up the ExpressCard context.

--

can: peak_pci: Fix potential use-after-free during removal

This patch moves unregister_sja1000dev() ahead of peak_pciec_remove() in
peak_pci_remove(). The first channel's write_reg callback,
peak_pciec_write_reg(), then still has a valid ExpressCard context and I2C
adapter when set_reset_mode() writes the controller reset register.

> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index 69c61ccf621df..618f8f6a57500 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -752,10 +752,10 @@ static void peak_pci_remove(struct pci_dev *pdev)
>  		struct net_device *prev_dev = chan->prev_dev;
>  
>  		dev_info(&pdev->dev, "removing device %s\n", dev->name);
> +		unregister_sja1000dev(dev);
>  		/* do that only for first channel */
>  		if (!prev_dev && chan->pciec_card)
>  			peak_pciec_remove(chan->pciec_card);
> -		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);
>  		dev = prev_dev;
>  

[Severity: High]
Can peak_pciec_led_work() still read a freed net_device during removal?
This ordering also seems to make the window wider.

peak_pciec_probe() stores a raw pointer for every channel. Nothing clears
it when the channel is freed:

    card->channel[card->chan_count++].netdev = dev;

peak_pciec_led_work() dereferences each of those pointers. It re-arms
itself every second while any channel is up:

    netdev = card->channel[i].netdev;
    if (!netdev || !(netdev->flags & IFF_UP))
        continue;
    ...
    if (netdev->stats.rx_bytes != card->channel[i].prev_rx_bytes) {
    ...
    if (up_count)
        schedule_delayed_work(&card->led_work, HZ);

The loop in peak_pci_remove() walks from the last channel back to
channel 0. Channels N..1 go through unregister_sja1000dev() and
free_sja1000dev() first.

The only cancel_delayed_work_sync() on led_work is in
peak_pciec_remove()->peak_pciec_stop_led_work(). That runs only on
channel 0's iteration.

On a two-channel ExpressCard with channel 0 up, this is the sequence
after this patch:

peak_pci_remove()
  free_sja1000dev(ch1)            <- card->channel[1].netdev now dangling
  unregister_sja1000dev(ch0)
    set_reset_mode()
      peak_pciec_write_reg()      <- bit-banged I2C LED write
    unregister_candev()           <- RTNL, close, synchronize_net(), ...
  peak_pciec_remove()
    cancel_delayed_work_sync()

Before this patch, only dev_info() ran between free_sja1000dev(ch1) and
cancel_delayed_work_sync(). Now the whole unregister of channel 0 runs in
between. During that time the 1 Hz work can fire and read
card->channel[1].netdev->flags and ->stats from freed memory.

The commit aims to fix use-after-free during removal. Could the teardown
be restructured to fix this as well, for example:

  1. unregister all channels,
  2. call peak_pciec_remove(),
  3. free the net_devices.

Cancelling led_work, or clearing card->channel[i].netdev, before the
first free_sja1000dev() would also close this.

The probe error path in peak_pci_probe() has the same ordering. The
failure_remove_channels loop frees every net_device before
peak_pciec_remove() cancels led_work.

[Severity: High]
This isn't a bug introduced by this patch, but the
failure_remove_channels path in peak_pci_probe() seems to have the same
chan-after-free pattern that commit 949fe9b35570 fixed in
peak_pci_remove():

drivers/net/can/sja1000/peak_pci.c:peak_pci_probe() {
    ...
	chan = NULL;
	for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
		priv = netdev_priv(dev);
		chan = priv->priv;
		prev_dev = chan->prev_dev;

		unregister_sja1000dev(dev);
		free_sja1000dev(dev);
	}

	/* free any PCIeC resources too */
	if (chan && chan->pciec_card)
		peak_pciec_remove(chan->pciec_card);
    ...
}

chan points into the net_device private area: alloc_sja1000dev() sets
priv->priv to just past struct sja1000_priv. After the last iteration,
chan points into channel 0's freed allocation.

Is chan->pciec_card then read from freed memory and passed to
peak_pciec_remove()? That function calls cancel_delayed_work_sync(),
i2c_del_adapter() and kfree() on it.

This path is reachable on any multi-channel board when
alloc_sja1000dev(), peak_pciec_probe() or register_sja1000dev() fails for
channel i >= 1. Channels 0..i-1 are already registered at that point.

[Severity: High]
This is also a pre-existing issue, but what happens on a PCAN-ExpressCard
when register_sja1000dev() fails for channel 0?

For i == 0, peak_pciec_probe() has already done three things:

  - allocated the card,
  - registered the bit-banging adapter with
    i2c_bit_add_bus(&card->led_chip),
  - set chan->pciec_card.

The error path then does:

failure_free_dev:
	pci_set_drvdata(pdev, chan->prev_dev);
	free_sja1000dev(dev);

failure_remove_channels:
	...
	chan = NULL;
	for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
	...
	if (chan && chan->pciec_card)
		peak_pciec_remove(chan->pciec_card);

For channel 0, prev_dev is NULL, so drvdata becomes NULL. The loop body
never runs, chan stays NULL, and peak_pciec_remove() is skipped.

Does this leak the card? It also seems to leave the "peak_i2c" adapter
registered after cfg_base has been unmapped with pci_iounmap() and the
PCI device has been disabled.

The adapter's pita_setsda(), pita_setscl(), pita_getsda() and
pita_getscl() callbacks access card->cfg_base. A later transfer on the
adapter, for example through /dev/i2c-N, would touch unmapped MMIO. After
rmmod, the adapter would still point into the unloaded module.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-21df1234b2-can-peak-pci%40mail.sdu.edu.cn
