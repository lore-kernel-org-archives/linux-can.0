Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87A381AF4;
	Sat, 10 Oct 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640983; cv=none; b=jk+46Da8b5btiZx+U9orAuLO/dct5MLYNuBPExSpnWLopLgsH29lECsoijOLwk18Nan+PVKAc+Oc8phHJ0rQBdstH6eT86Z+kkB+v0D3gKDrZcdlzI/E6iZXyDt11yGc4QC2mFDGiFlwpKuI92BKVddZqsySzLwmyq4Tsv1gq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640983; c=relaxed/simple;
	bh=Bsb0sgLG0IRiNCHZ/m0+BQz5nNbtRN4V6ymNkTv/za0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOQqkIDaj8BRvDVRIctObuJPVR9tARUJwTrQxrujRt2I6OVk+uSp8QnJprE2hZMu+hdRQKxvrTzuoOnujDrFTvH0n9SQBoLz6DBuFgjuIb6uWRJ78y2ecboN1bvwiAYat9R6rw/3MV4vHK0WAkDGBUmJxTfr7Kj9Plj3xBPDKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvV5I6Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvV5I6Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81141F00893;
	Sat, 10 Oct 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640980;
	bh=L12GP1EV9Lsh+ypifn5nkYCmgdF2dnHPl2fN56zvTE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VvV5I6RkMUx0B+PRS+WcrxruKX8/7u2FIehARvyuP62T8kgUZtKe312Ke0m/4xvPZ
	 hSgrWc5z+/3QjWPjfDwd0aopE0AtcgV0gRzkRmHN1ROpgMLpDeTYvJf16BbDw9PXeh
	 bqSSqKKcgv6QsgOJtD21xadXOsY9B+8QGjAdKxLIT9mIxrU/4vuK6LuDqAR+1Lgv0t
	 J8WsziJIVOH3s5VW1xCEpwkXpr/sueHS7+U7aTOZrKdhabM8meWeMc78LnuFHpmw/T
	 OClXMzHF/hBzRMdVNP4SfHW96sLpU4LwHq8KhvlaDiGO5CaPzzWxeo9a0yoIR7uT8U
	 XAH+kayujhOwQ==
Subject:
 Re: [PATCH net-next 19/37] can: rcar_canfd: Add support for Renesas RZ/G3L
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:59 +0000
Message-ID: <179164097935.434549.10115546216438585595@kernel.org>
In-Reply-To: <20261009134323.64064-20-mkl@pengutronix.de>
References: <20261009134323.64064-20-mkl@pengutronix.de>
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

- [Low] This patch maps "renesas,r9a08g046-canfd" (RZ/G3L) to
  r9a08g045_hw_info, so RZ/G3L gets exactly the RZ/G3S handling in…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  probe path the new compatible uses.
- [High] This problem wasn't introduced by this patch, but the reused
  remove/teardown path frees channel objects while interrupt handlers…
- [Medium] This problem wasn't introduced by this patch, but
  rcar_canfd_global_init() already unwinds its own resources on every…

--

can: rcar_canfd: Add support for Renesas RZ/G3L

This adds the "renesas,r9a08g046-canfd" compatible to rcar_canfd_of_table.
The new entry reuses the existing RZ/G3S hardware info, r9a08g045_hw_info.
The commit message says RZ/G3L has 3 channels, 11 interrupts and 288
buffers.

Link: https://patch.msgid.link/20261001075742.21961-4-biju.das.jz@bp.renesas.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 41c3951189490..c643879673680 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2403,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
>  	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
>  	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
> +	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },

[Severity: Low]
This entry gives RZ/G3L the same handling as RZ/G3S, and that handling
expects the rstp_n and rstc_n resets. Should the binding also make those
resets mandatory for RZ/G3L?

In renesas,rcar-canfd.yaml, the block that requires them lists only three
compatibles:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,r9a08g045-canfd
              - renesas,r9a09g047-canfd
              - renesas,rzg2l-canfd
    then:
      required:
        - resets
        - reset-names

The r9a08g046 block only has "resets: minItems: 2", and that rule only
applies when the property is present.

Two other rules list RZ/G3S and RZ/G3L together: the no-can-fd/fd-only ban
and the assigned-clocks exemption. This rule does not.

As a result, an RZ/G3L DT with no resets, or with resets but no
reset-names, still passes dtbs_check. rcar_canfd_probe() gets both resets
as optional:

	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
	...
	gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");

Either mistake in the DT returns NULL without an error. In that case
reset_control_reset(NULL) in rcar_canfd_global_init() does nothing. The IP
then stays in reset, and the GRAMINIT/GRSTSTS poll in
rcar_canfd_reset_controller() times out. The resulting probe error does not
mention the missing reset.

The later patch in this series, "dt-bindings: can: renesas,rcar-canfd:
Restrict resets in top-level", does not add r9a08g046 to this list either.

[ ... ]

[Severity: High]
This is a pre-existing issue, not one introduced by this patch, but RZ/G3L
also goes through this probe error path. rcar_canfd_channel_probe() stores
the channel pointer before it registers the netdev:

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

free_candev() frees priv, because priv is netdev_priv(ndev). gpriv->ch[ch]
still points to it afterwards.

rcar_canfd_probe() then unwinds every channel in channels_mask:

fail_channel:
	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
		rcar_canfd_channel_remove(gpriv, ch);

rcar_canfd_channel_remove() only checks for NULL:

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

When register_candev() fails, does this read priv->ndev from freed memory?
It would also call unregister_candev() on a netdev that was never
registered, then call free_candev() on the same allocation again.

Could gpriv->ch[ch] be cleared on the fail_candev path, or set only after
register_candev() succeeds?

[Severity: High]
This is also a pre-existing issue, not one introduced by this patch. It
still affects RZ/G3L, which has shared_global_irqs == 0 like RZ/G3S.

rcar_canfd_remove() frees the channels one by one while the global
interrupts are still enabled:

	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
		rcar_canfd_channel_remove(gpriv, ch);
	}

	rcar_canfd_global_deinit(gpriv, true);

rcar_canfd_channel_remove() calls free_candev() but does not clear
gpriv->ch[ch]. The global interrupts are masked only later, in
rcar_canfd_global_deinit().

The g_recc and g_err IRQs come from devm_request_irq(), so they stay
registered until remove returns. The same applies to the per-channel
err/trx IRQs, which use the freed priv as dev_id.

Both global handlers loop over every channel in channels_mask and use
gpriv->ch[ch] without checking it:

rcar_canfd_handle_global_receive():
	struct rcar_canfd_channel *priv = gpriv->ch[ch];
	...
	sts = rcar_canfd_read(priv->base, RCANFD_RFSTS(gpriv, ridx));

rcar_canfd_handle_global_err():
	struct rcar_canfd_channel *priv = gpriv->ch[ch];
	struct net_device *ndev = priv->ndev;

Suppose channel 0 is already freed and channel 1 is still up. A frame
received on channel 1 then raises g_recc:

rcar_canfd_global_receive_fifo_interrupt()
  rcar_canfd_handle_global_receive(gpriv, 0)
    priv->base, priv->napi   <- channel 0, already freed

Can this cause a use-after-free in hardirq context? The g_err path looks
the same: rcar_canfd_handle_global_err() could call
rcar_canfd_global_error() on the freed ndev.

rcar_canfd_disable_channel_interrupts() only clears the CCTR error and
TX-abort enables. It does not affect the global RX FIFO interrupt.

[Severity: Medium]
This is a pre-existing issue as well, not one introduced by this patch.
rcar_canfd_global_init() already unwinds its own resources on every error
path:

fail_mode:
	rcar_canfd_disable_global_interrupts(gpriv);
fail_reset2:
	reset_control_assert(gpriv->rstc2);
fail_reset1:
	reset_control_assert(gpriv->rstc1);
fail_ram_clk:
	clk_disable_unprepare(gpriv->clk_ram);
fail_clk:
	clk_disable_unprepare(gpriv->clkp);
	return err;

rcar_canfd_probe() still sends that failure through the full deinit:

	err = rcar_canfd_global_init(gpriv);
	if (err)
		goto fail_mode;
	...
fail_mode:
	rcar_canfd_global_deinit(gpriv, false);

rcar_canfd_global_deinit() then calls rcar_canfd_disable_global_interrupts()
again, asserts both resets again, and calls clk_disable_unprepare() on
clk_ram and clkp a second time.

Are both clocks disabled and unprepared twice whenever
rcar_canfd_global_init() fails? Possible triggers are a
reset_control_reset() error, a rcar_canfd_reset_controller() timeout (as in
the missing reset case above), or the GSTS mode change timeout.

If clk_prepare_enable(gpriv->clkp) is the call that failed, the clocks are
disabled without ever having been enabled. In all of these cases, GCTR is
read-modify-written after the module clock has already been turned off.

Should the probe error path jump to fail_dev here instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
