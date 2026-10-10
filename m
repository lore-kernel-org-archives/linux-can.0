Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025F3A5E65;
	Sat, 10 Oct 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640977; cv=none; b=DZT2g7uSk2L17wylpRkud2kj/KsqY7QhlGCjLM9sEmpt4uk1+pI9AZ+SU1gISXHCVmU5N6lz1eiGIyf/UPVxe63YoDTVBvbL6byLmlNAP9gM5CuZHJMEfBHwILJ5LbfMm0AXc33zOFphjvkWiUiFnQ79vsXQfDy/jZU1nWSz3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640977; c=relaxed/simple;
	bh=r9pgw5kD/P0TR/UjW77hin9ZhmKhIvfpvFJPBmzMK8c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZL9KPdXIG784i6GzTv+8hW3JMCZJtTSV8Q+D4rKs/CWCiGBEz4ICOA/XgJ/wcW8WWEEtCsxwQpdBnxEwiq3CBWIrGyAX+4zdgPxW6sy+qkj6jH4IBAlzDkx/laiPAguQUh3il7ObqNtSxjuXuG3ReNJDDiZpMXPX8iKnl2bNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R38SvYpf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R38SvYpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8B01F00893;
	Sat, 10 Oct 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640975;
	bh=I6CRd2Sfmlf5Jc8VSYHcNzDF9qi58Up9OZWi3soYpJU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R38SvYpfBtparSotK5qOfrciuu8ExeNWW1My19hcdxeVRwkd4qi0Ik3JwQxvCkLhU
	 wJ1NFp9ajB+HQkLRBlRppIbyVceVNOBsVkMRnh05CeLaBQSNIFk0Tbc8AHvfbZR6rL
	 x0lDs1yF0wENXMN4Hkan+uftzn9gWZVKzh0z/PeL4F8bTa7lVQQbprzpTabxpCTYap
	 sjr6oH5UOv3/gOBchvi/PkjjciikXw9KmpcdS3CqxrIJFHTX4LN0RUZv7P6IV2o4mu
	 Y0jIbMeJv5ru8UYfkAuOvLRn12bQuSKkxPOqz4bKLgDIjjpz72vHdfgLK3eQsXOfHU
	 vm5EvzQqGTalg==
Subject:
 Re: [PATCH net-next 15/37] can: rcar_canfd: Add support for Renesas RZ/G3S
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:55 +0000
Message-ID: <179164097503.434549.16041101731070524253@kernel.org>
In-Reply-To: <20261009134323.64064-16-mkl@pengutronix.de>
References: <20261009134323.64064-16-mkl@pengutronix.de>
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

- [Low] r9a08g045_hw_info sets fixed_canfd = 1.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is
  reachable on the newly added RZ/G3S variant.
- [High] This problem wasn't introduced by this patch, but RZ/G3S
  (multi_channel_irqs = 1) uses the affected path.

--

can: rcar_canfd: Add support for Renesas RZ/G3S

This commit adds an rcar_canfd_hw_info entry for the RZ/G3S (r9a08g045)
CAN-FD controller and binds it to the "renesas,r9a08g045-canfd"
compatible. The new variant has two channels, 16 AFL pages, per-channel
IRQs, a CAN FD clock taken from pclk and a fixed CAN-FD mode.

Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index ac5d5959d8e4c..74c3c3f20991f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.fixed_canfd = 0,
>  };
>  
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
> +	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,

[ ... ]

> +	.postdiv = 2,
> +	.shared_global_irqs = 0,
> +	.multi_channel_irqs = 1,

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. RZ/G3S
sets multi_channel_irqs, so it uses the affected path. Can the IRQ
handlers touch a channel object after it has been freed?

rcar_canfd_channel_probe() registers the per-channel handlers with priv
as dev_id:

	err = devm_request_irq(dev, err_irq,
			       rcar_canfd_channel_err_interrupt, 0,
			       irq_name, priv);

priv lives inside the ndev allocation. rcar_canfd_channel_remove()
frees that allocation with free_candev(priv->ndev), but the managed IRQs
are only released after remove() returns.

Nothing calls synchronize_irq(), devm_free_irq() or disable_irq() before
the free, and gpriv->ch[ch] is never cleared.
rcar_canfd_disable_channel_interrupts() only masks the controller. It
does not wait for a handler that is already running on another CPU.

The global handlers look easier to hit. In rcar_canfd_remove():

	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
		rcar_canfd_channel_remove(gpriv, ch);
	}

	rcar_canfd_global_deinit(gpriv, true);

Channel 0 is freed while channel 1 is still up. The global interrupts
stay enabled until rcar_canfd_global_deinit() runs. If channel 1
traffic or a global error raises g_recc or g_err, the handler walks
every bit in channels_mask:

rcar_canfd_global_receive_fifo_interrupt()
  rcar_canfd_handle_global_receive(gpriv, 0)
    priv = gpriv->ch[0];
    sts = rcar_canfd_read(priv->base, RCANFD_RFSTS(gpriv, ridx));

That reads priv->base from the freed channel 0 object, and the handler
may also schedule priv->napi on it.

Should the IRQs be released or synchronized, and gpriv->ch[ch] cleared,
before free_candev()? Should the global interrupts also be disabled
before any channel is freed?

> +	.ch_interface_mode = 1,
> +	.shared_can_regs = 1,
> +	.external_clk = 1,
> +	.fcan_pclk = 1,
> +	.fixed_canfd = 1,

[Severity: Low]
With fixed_canfd set, rcar_canfd_reset_controller() skips the mode
programming, so the hardware always stays in CAN-FD mode:

	/* Set the controller into appropriate mode */
	if (gpriv->info->fixed_canfd)
		continue;

rcar_canfd_probe() still reads the DT mode properties without checking
info->fixed_canfd:

	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode = false;		/* Classical CAN only mode */
	...
	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */

If either property appears on an r9a08g045 node, wouldn't the software
state disagree with the hardware?

With renesas,no-can-fd, the FIFOs are set up for 8-byte payloads and
CMPOC is left clear. CMPOF also goes unreported, because
rcar_canfd_global_error() checks gpriv->fdmode first, and
CAN_CTRLMODE_FD is never set.

With renesas,fd-only, the probe message says "fd-only" even though FDOE
is never written.

The binding already forbids both properties for this compatible, so
only a DT that fails schema validation can get here. Would it still be
worth forcing fdmode = true and fd_only_mode = false, with a warning,
when info->fixed_canfd is set?

> +};
> +
>  static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> @@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>  
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
>  	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
> +	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },

[Severity: High]
This isn't a bug introduced by this patch, but the new compatible makes
it reachable on RZ/G3S. Is the ndev freed twice when register_candev()
fails?

rcar_canfd_channel_probe() publishes the channel before it registers
it:

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
	return err;

After this error path, gpriv->ch[ch] still points at the freed priv.
rcar_canfd_probe() then jumps to fail_channel and calls
rcar_canfd_channel_remove() for every bit in channels_mask, including
the channel that just failed:

	struct rcar_canfd_channel *priv = gpriv->ch[ch];

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

That reads freed memory and unregisters a netdev that was never
registered. It then calls free_candev() on it a second time.

One way to hit this is a controller node with termination-gpios whose
GPIO provider has not bound yet. In that case can_get_termination()
returns -EPROBE_DEFER and register_candev() fails.

The assignment came from commit c5048a7b2c23ab and the error path from
commit dd3bd23eb43891. Should gpriv->ch[ch] be cleared on this error
path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
