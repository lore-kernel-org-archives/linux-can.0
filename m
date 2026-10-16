Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C36A39F184;
	Fri, 16 Oct 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118230; cv=none; b=lnlva+qIexnOvh8Jr6Zb185fW+PyqVHmQG7ieCQta7qAOZoM2LbUypQQaBpycmFkScTiohNyazqwyEh4osm4TWANn1qJr5cERRU51b9cpcs2/ZXUu6z3e6oWbHjNjahAtWmoZo/e5j0Nk5KrmijnTKS4tKdmMbhi9fyexFjyO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118230; c=relaxed/simple;
	bh=asyX4Q02RRCSWSPzVlwERUn6CqVtsxe8kb3A7z1AjLA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Shzq0um+2KaDorWQQ3SPU9z/q5RD7pRe7hlyqSLq8f9a/+xhL15XthciQtfufQn/s/qJq8f6a5R8t71fwRLvWaP+fDSdgFwq6wCHdvDsz2/rPtXvGG/woMdtjYZ5jzFuI/Z8OIlPqWAGysmtTmfCCTbm/MG4sY+g2eEfSD/XgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZCoEfGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZCoEfGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1E1F000C5;
	Fri, 16 Oct 2026 02:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118229;
	bh=C4ThltfP1H/uWz5TwkkPv81EedpYep4cXw1sQGOulvM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EZCoEfGL9YW5/zXtkt6Ax+ipl7ioLIHCYMZB3pwLdYYLkZjYd5ik8qAdCyryppUVy
	 dbvFJxSletinT4fDrjYYlOjSnuNeKy3y6l+fO8b+tWrPHk8qMUmLtSvgXgn+eFIL60
	 dtDNmxuC3dBy4yNgV0G7G4Jwi1I83Za3U4r/klrZs0Cu4pjQeHVRR97JpziUfuvwwH
	 WqdMbOZjpNxLbEnMVLI30yVL6D1TPTm/jvskS2ffo02ee+E4v8tgC1NO3+j4xAbEYi
	 LXLT80e916jFusPhgWWz0PWGjYPSFWFIrIXPduPfM9K2DQz0M3GMdea4e9XL8i0Ejr
	 p9c3E172z+6dA==
Subject:
 Re: [PATCH net-next 17/37] can: rcar_canfd: Add support for Renesas RZ/G3S
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:08 +0000
Message-ID: <179211822831.434549.16106222466489918568@kernel.org>
In-Reply-To: <20261015015336.816543-18-mkl@pengutronix.de>
References: <20261015015336.816543-18-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On renesas,r9a08g045-canfd (RZ/G3S), rcar_canfd_probe() reads the
  "renesas,no-can-fd" and "renesas,fd-only" DT properties without…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a use-
  after-free and double free in the probe error path, now also reachable…
- [High] This problem wasn't introduced by this patch, but it is a use-
  after-free in IRQ context during driver removal, also reachable on the…

--

can: rcar_canfd: Add support for Renesas RZ/G3S

This adds r9a08g045_hw_info for the RZ/G3S CAN-FD controller: two
channels, 16 AFL pages, a CAN FD clock derived from pclk and a fixed
CAN-FD mode. It also adds the "renesas,r9a08g045-canfd" compatible to the
OF match table.

Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index ac5d5959d8e4..74c3c3f20991 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.fixed_canfd = 0,
>  };
>  
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info = {

[ ... ]

> +	.external_clk = 1,
> +	.fcan_pclk = 1,
> +	.fixed_canfd = 1,
> +};

[Severity: Low]
This is the first hw_info with fixed_canfd set. That makes the early
continue in rcar_canfd_reset_controller() reachable:

	/* Set the controller into appropriate mode */
	if (gpriv->info->fixed_canfd)
		continue;

As a result CLOE/FDOE are never programmed, and the hardware stays in
CAN-FD mode.

rcar_canfd_probe() still reads the mode properties for every compatible
and does not check info->fixed_canfd:

	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode = false;			/* Classical CAN only mode */
	...
	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */

Suppose renesas,no-can-fd were present on an RZ/G3S node. Then
gpriv->fdmode is false, and rcar_canfd_channel_probe() sets the channel
up as classical CAN: no CAN_CTRLMODE_FD, no data bittiming, and RFFDF
ignored on rx. The controller would still be in CAN-FD mode. Would the
software mode and the hardware mode then disagree?

With renesas,fd-only, the only effect would be that the "global
operational state" message prints "fd-only". That doesn't match the
hardware either.

The binding added earlier in this series sets renesas,no-can-fd and
renesas,fd-only to false for renesas,r9a08g045-canfd. A DT that passes
schema validation therefore can't reach this path; only a DT that breaks
the binding can.

Would it still make sense to ignore these properties, or warn about
them, when info->fixed_canfd is set? The RZ/G3L compatible added later
in the series reuses r9a08g045_hw_info and has the same behaviour.

[ ... ]

> @@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>  
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
>  	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
> +	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },

[Severity: High]
This isn't a bug introduced by this patch, but RZ/G3S can now hit a
use-after-free and double free in the probe error path.

rcar_canfd_channel_probe() publishes the channel before registering it,
and does not clear the slot if registration fails:

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

priv lives in netdev_priv(ndev), so after this gpriv->ch[ch] points to
freed memory. rcar_canfd_probe() then unwinds every channel in
channels_mask, including the one that just failed:

fail_channel:
	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
		rcar_canfd_channel_remove(gpriv, ch);

The stale pointer passes the NULL check in rcar_canfd_channel_remove():

	struct rcar_canfd_channel *priv = gpriv->ch[ch];

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

Suppose register_candev() fails, for example with -ENOMEM from
register_netdevice() or a NETDEV_REGISTER notifier veto. Doesn't this
path read priv->ndev from freed memory, call unregister_candev() on a
netdev that was never registered, and then call free_candev() on it a
second time?

The assignment comes from commit c5048a7b2c23 ("can: rcar_canfd:
rcar_canfd_channel_probe(): register the CAN device when fully ready").
The error path dates back to commit dd3bd23eb438 ("can: rcar_canfd: Add
Renesas R-Car CAN FD driver"). Nothing later in the series changes it.

Two possible fixes: clear gpriv->ch[priv->channel] on the fail_candev
path, or assign it only after register_candev() succeeds (after checking
that no IRQ handler needs it earlier).

[Severity: High]
This is also a pre-existing issue and not introduced by this patch. Is
there a use-after-free in IRQ context during rcar_canfd_remove() that
RZ/G3S now inherits?

	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
		rcar_canfd_channel_remove(gpriv, ch);
	}

	rcar_canfd_global_deinit(gpriv, true);

rcar_canfd_disable_channel_interrupts() only clears the CCTR error
interrupt enables. It does not touch the RX FIFO RFIE bit.

rcar_canfd_channel_remove() then frees the channel but leaves
gpriv->ch[ch] and gpriv->channels_mask unchanged.

Global interrupts are only disabled afterwards, in
rcar_canfd_global_deinit(). The global IRQ handlers were requested with
devm_request_irq() and dev_id = gpriv, so they stay installed until after
remove() returns.

Consider the case where channel 0 has been freed but channel 1 is still
open and receiving. An RX FIFO interrupt for channel 1 runs
rcar_canfd_global_receive_fifo_interrupt() (g_recc on RZ/G3S and RZ/G2L)
or rcar_canfd_global_interrupt() (Gen3/Gen4). Both walk all of
channels_mask, starting with channel 0:

rcar_canfd_global_receive_fifo_interrupt()
  rcar_canfd_handle_global_receive(gpriv, 0)
    priv = gpriv->ch[0];   /* already freed */
    sts = rcar_canfd_read(priv->base, RCANFD_RFSTS(gpriv, ridx));

Could this dereference the freed priv and perform MMIO through a base
address loaded from freed memory? The global error path also uses
priv->ndev of the freed channel and can call rcar_canfd_global_error()
on it.

Nothing later in the series addresses this. Either of these would close
the window: disable all global and per-channel interrupt sources and
synchronize the IRQs before freeing any channel, or clear gpriv->ch[ch]
and its channels_mask bit before the free.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
