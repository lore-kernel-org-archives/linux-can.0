Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D593CB57D;
	Sat, 10 Oct 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640979; cv=none; b=L4kfMOb34DbDSDP4pxez4A4N1riJuPO0bMcqwBKdURC8Gsh+7UMlGFRsyClk5Z9iJC7b3Tzv1ukkcdho/OlO9jqskr/pcJG3lAVEzPZA0GxZsrW4UIV53JGjLF7qX5QLRMCndvLnQtCyUud/xmtmGtMlvrXL4BCu5t3Jq+Suosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640979; c=relaxed/simple;
	bh=0cNb+GSc1/HwJVIj8bIpSj45h5OmnjkXamDVt0Y8KFs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEe6er5DhRm6VK2+hyLgAFEZJZGtqJhNRttRSWOovz6/DbuRKKGhU6fSoQwShM3cFu01c5qmx2pRE/o0Gx2Mk8UOOEMeAuIuMpsApxdaj2m3PffUTmZTwF7L7wS1hmOZumYuAujF6i5XYNwYBjnniaZBNYUNdIAJL24MnfBBfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+KrWgCM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+KrWgCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84041F00898;
	Sat, 10 Oct 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640978;
	bh=S9K8EzAVWy/Qtj2O0lQBRgr2Z7ae6Z5WLNpvu534Wso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m+KrWgCMKICYBCQKIt12a4S9s+nTMZN4hm5W7nqDpQo0vtmqkxOJpNHKo4hDQtCN3
	 cZT3X/89Vd1njj2SHZ3/SRHlKNjzkO2BKYp91KzT5YTb+iP/tbQ/vVnr0ytBZ04aRD
	 XkdmsolKr4MG2wBe3MH2TYQmCUd1wbEBnpjjHhwxMtGGi/PoYGTKjp7DP+po57xdMl
	 RXS8Yvrv3b88T1Obgjq2VDTUXlLPEnMHyhOZeMb6UYW4fdrZ2OXblIleAYytRHmKr9
	 1vr9W+rApDeDIkslLcP7c9QrMrgwZ4qWIq0QJKtR3q2/ICR5Gnyh0PY/LShEEtg3wF
	 AkAukMgXOwHDQ==
Subject: Re: [PATCH net-next 17/37] can: rcar_canfd: Derive max_channels from
 the device tree
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:57 +0000
Message-ID: <179164097719.434549.3112868355732068792@kernel.org>
In-Reply-To: <20261009134323.64064-18-mkl@pengutronix.de>
References: <20261009134323.64064-18-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rcar_canfd_probe() now sets max_channels from
  of_get_child_count(dev->of_node), which is the number of child nodes.
- [Low] The patch removes the per-SoC max_channels from struct
  rcar_canfd_hw_info.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the probe
  error path has a use-after-free and double free.
- [High] This problem wasn't introduced by this patch, but the
  controller-wide IRQ handlers (rcar_canfd_global_interrupt,…

--

can: rcar_canfd: Derive max_channels from the device tree

This commit removes the per-SoC max_channels from struct
rcar_canfd_hw_info. Probe now gets the channel count from
of_get_child_count(), and the value is stored in struct
rcar_canfd_global. All for_each_set_bit() loops over channels_mask now
use gpriv->max_channels as their bound.

Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.renesas.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 74c3c3f20991f..41c3951189490 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  	bool fdmode = true;			/* CAN FD only mode - default */
>  	char name[9] = "channelX";
>  	u32 ch, fcan_freq;
> +	u8 max_channels;
>  	int i;
>
>  	info = of_device_get_match_data(dev);
> +	max_channels = of_get_child_count(dev->of_node);
> +	if (max_channels > RCANFD_NUM_CHANNELS)
> +		return -EINVAL;

[Severity: Low]
With max_channels gone from struct rcar_canfd_hw_info, the only limit
left here is RCANFD_NUM_CHANNELS (8). That is the IP-wide maximum, not
the number of channels a given SoC implements.

Suppose a DT enabled channel2 on a 2-channel part (R-Car Gen3, RZ/G2L,
RZ/G3S, RZ/T2H). Would rcar_canfd_reset_controller() and
rcar_canfd_global_init() then access CCTR/CSTS/RFCC/CFCC/AFL registers
for a channel that does not exist? Probe would then fail after the
CSTS poll times out, with a "reset controller failed" message.

The binding already rejects such DTs for every compatible (for example
"^channel[2-7]$": false). This only affects DTs that fail schema
validation. Is it intended that the driver no longer has a per-SoC
limit?

>
>  	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
>  		fdmode = false;			/* Classical CAN only mode */
>
> -	for (i = 0; i < info->max_channels; ++i) {
> +	for (i = 0; i < max_channels; ++i) {
>  		name[7] = '0' + i;
>  		of_child = of_get_available_child_by_name(dev->of_node, name);

[Severity: Medium]
Does this loop still find every channel node when the channel numbers
have gaps?

of_get_child_count() returns the number of child nodes. The number in
the "channelN" name, however, is the hardware channel index. It becomes
the bit in channels_mask and the ch used for RCANFD_CCTR(ch),
RCANFD_CSTS(ch), fcbase[ch], the RX FIFO index and the AFL rules.

renesas,rcar-canfd.yaml requires only channel0 and channel1 and allows
any subset of channel[2-7].

Take R-Car V4H as an example. It uses rcar_gen4_hw_info, which had
max_channels = 8 before this patch. With only channel0, channel1 and
channel5 in the DT, max_channels becomes 3. This loop never looks up
channel5, so bit 5 is never set in channels_mask. Every later
for_each_set_bit() is also capped at 3.

Hardware channel 5 is then never put into reset mode, its FIFOs and AFL
rule are never configured, and no candev is registered for it. Probe
still succeeds and nothing is logged. Before this patch, channel5 was
found.

All in-tree dtsi files list their channel nodes without gaps. Setting
status = "disabled" keeps the node, so the count stays the same. Only
DTs that omit a middle channel node or remove it with /delete-node/ are
affected. This code is unchanged at the end of the series.

The commit message says "No functional change". Should this loop be
bounded by the highest channel index, or by a per-SoC limit, rather
than by the number of nodes?

[ ... ]

> @@ -2300,7 +2299,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  	if (err)
>  		goto fail_mode;
>
> -	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
>  		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
>  					       transceivers[ch]);
>  		if (err)
> @@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  	return 0;
>
>  fail_channel:
> -	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
>  		rcar_canfd_channel_remove(gpriv, ch);

[Severity: High]
This isn't a bug introduced by this patch, but can this cleanup loop
free the failing channel's netdev twice?

rcar_canfd_channel_probe() sets the channel pointer before it calls
register_candev():

	gpriv->ch[priv->channel] = priv;
	err = register_candev(ndev);
	if (err) {
		...
		goto fail_candev;
	}
	...
fail_candev:
	netif_napi_del(&priv->napi);
fail:
	free_candev(ndev);

priv is netdev_priv(ndev). After free_candev(), gpriv->ch[ch] still
holds a non-NULL pointer to freed memory. The fail_channel loop then
visits the same channel, and rcar_canfd_channel_remove() does:

	struct rcar_canfd_channel *priv = gpriv->ch[ch];

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

This calls unregister_candev() through freed memory on a netdev that
was never registered. A second free_candev() follows.

The ordering goes back to commit c5048a7b2c23 ("can: rcar_canfd:
rcar_canfd_channel_probe(): register the CAN device when fully ready"),
which moved the gpriv->ch[] assignment ahead of register_candev(). It
is still present at the end of this series.

Would clearing gpriv->ch[priv->channel] on the failure path, or setting
it only after register_candev() succeeds, avoid this?

[ ... ]

> @@ -2327,7 +2326,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
>  	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
>  	u32 ch;
>
> -	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
>  		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
>  		rcar_canfd_channel_remove(gpriv, ch);
>  	}

[Severity: High]
This is a pre-existing issue, but can the global IRQ handlers
dereference a freed channel while this loop runs?

Four handlers walk every bit in channels_mask: rcar_canfd_global_interrupt(),
rcar_canfd_global_err_interrupt(),
rcar_canfd_global_receive_fifo_interrupt(), and the shared Gen3 handler
rcar_canfd_channel_interrupt(). They use gpriv->ch[ch] with no NULL
check, lock or RCU:

rcar_canfd_handle_global_err() {
	struct rcar_canfd_channel *priv = gpriv->ch[ch];
	struct net_device *ndev = priv->ndev;
	...
	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
	...
}

In this loop, channel 0 is unregistered and freed while channel 1 is
still running.

rcar_canfd_stop() disables only that channel's CCTR interrupts and its
own FIFOs. The global interrupts stay enabled until
rcar_canfd_global_deinit() runs after the loop. The devm IRQs are
released only after remove() returns.

Suppose a frame arrives on channel 1 in that window. The handler starts
at ch = 0 and reads priv->ndev and priv->base from the freed channel 0
priv, in hardirq context.

rcar_canfd_probe() has a similar window. rcar_canfd_global_init()
enables the global interrupts before rcar_canfd_channel_probe() fills
gpriv->ch[]. Once can0 is registered and brought up, traffic can raise
the global IRQ while gpriv->ch[1] is still NULL. The fail_channel path
also frees channels before the global interrupts are disabled.

This patch only changes the loop bound to gpriv->max_channels. The race
is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
