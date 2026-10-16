Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4339E6FD;
	Fri, 16 Oct 2026 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118237; cv=none; b=OPNl5X23xl0AsCMnYtf1pU+O36bPiDvAIpwGaajqKD+EbsjFL23suPveaJ9U+9iyscCL74QnMrJ4knXI6pdlx3kQRy1Zh/KVsvepOjaPny3HcE0xcnJcIP4fgoiLSCjIELrPB8/TBAAz8RmKBTXTaElFrWu3CT9vRY/PCJXRyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118237; c=relaxed/simple;
	bh=prrK4/87F9cOi0Xh5RrmtdyCZlfLc4miz434IzGnxfk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCtzkvL22+/6v1fLsPwhgv3Xj8d6xF5jLFBHo89Z9j3soGkNA5WyzWnIFNeXzFmQ5Ias/D9Xb+iPCB5fY5+su9ZEqQ3JvVYemtJ1DfVDSTu5otXovPKBr4y6SwJjY6ww/9WKYbkCvKuNo8O+lmuxC2YGq3ID3B7Ms8TeL8ihDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPCd+g+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPCd+g+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A41F000C5;
	Fri, 16 Oct 2026 02:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118234;
	bh=V0mGf7nIGo0+8JQjApyYrKxE2tHfI6BN8S4R5OWkOvg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XPCd+g+R3aHuTxngwhc12zAW+tcR3FmA2xbx9TM6ayQMzZa1Pb3eAxaXZPuXXNxA3
	 GAh8iJD3ytlTUB4mWRWC8qPS6RCaR2Myb9KdWjxqD+PHcK0tj7r0MQTw5AJzwP2jLw
	 gdYdLCgNRADJS3IYbQaJTy2bB0PgbdPcjNZiV9MJpQQDpsWb2kYx06lNZE9NdulJRD
	 VNSxmLZkYSxE83yC0o0zAUUOpj4I7CY42XhVsQ+2NyY+xOi2VpdVRaUHUcVkUhZl4a
	 b87AmXIvNQeJRkD6UYhenT0p9SbhD4JTk8XojpiPI6aFC0DhrH+nsPR8GKas8d19nf
	 GwbF+1T96S1Fg==
Subject:
 Re: [PATCH net-next 22/37] can: rcar_canfd: Add support for Renesas RZ/G3L
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:13 +0000
Message-ID: <179211823337.434549.12652981577769724778@kernel.org>
In-Reply-To: <20261015015336.816543-23-mkl@pengutronix.de>
References: <20261015015336.816543-23-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The RZ/G3L binding never makes resets/reset-names required,
  but the driver gives RZ/G3L the same reset handling as RZ/G3S.

Pre-existing issues:
- [High] Use-after-free and double free of the channel net_device when
  register_candev() fails during probe.
- [Medium] Unbalanced clock disable/unprepare (and register access with
  the clocks gated) when rcar_canfd_global_init() fails.

--

can: rcar_canfd: Add support for Renesas RZ/G3L

This patch adds the renesas,r9a08g046-canfd compatible to
rcar_canfd_of_table and maps it to the existing RZ/G3S hw_info
(r9a08g045_hw_info). The commit message says RZ/G3L has 3 channels,
11 interrupts and 288 buffers.

Link: https://patch.msgid.link/20261001075742.21961-4-biju.das.jz@bp.renesas.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 41c395118949..c64387967368 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2403,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
>  	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
>  	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
> +	{ .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },

[Severity: Medium]
With this patch, RZ/G3L probes and resets exactly like RZ/G3S. Should
the binding also make resets and reset-names required for RZ/G3L?

In Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml,
r9a08g046 is missing from the allOf block that requires them:

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

The RZ/G3L block only has "resets: minItems: 2", which applies only when
the property is present. So an RZ/G3L node without resets would pass
dt_binding_check and dtbs_check.

The driver would not catch this either. rcar_canfd_probe() gets both
resets as optional:

    gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
    ...
    gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");

In that case reset_control_reset(NULL) in rcar_canfd_global_init()
does nothing and returns 0. Could the IP then stay in reset with
nothing printed to explain it?

The same RZ/G3L block also sets minItems: 11 for interrupts and
interrupt-names, but has no maxItems: 11. Is that intended?

The schema gap comes from "dt-bindings: can: renesas,rcar-canfd:
Document RZ/G3L SoC" earlier in this series. It is still there at the
end of the series.

[Severity: High]
This isn't a bug introduced by this patch, but RZ/G3L adds a third
channel, so is the register_candev() failure path in
rcar_canfd_channel_probe() safe?

gpriv->ch[ch] is set before registration. The failure path then frees
ndev, and priv with it, without clearing gpriv->ch[ch]:

rcar_canfd_channel_probe() {
    ...
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
}

rcar_canfd_probe() then calls remove for every enabled channel:

fail_channel:
	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
		rcar_canfd_channel_remove(gpriv, ch);

The only check in rcar_canfd_channel_remove() is for a NULL priv:

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

For the channel that just failed, does this read priv->ndev from freed
memory? It would also call unregister_candev() on a netdev that was
never registered, then free_candev() on the same net_device again.

The early assignment to gpriv->ch[] goes back to at least commit
c5048a7b2c23a.

[Severity: Medium]
This is a pre-existing issue, but when rcar_canfd_global_init() fails,
does rcar_canfd_probe() release the clocks and resets a second time?

rcar_canfd_global_init() already cleans up on its own error paths:

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

But rcar_canfd_probe() still sends every error to fail_mode:

	err = rcar_canfd_global_init(gpriv);
	if (err)
		goto fail_mode;
    ...
fail_mode:
	rcar_canfd_global_deinit(gpriv, false);

rcar_canfd_global_deinit() calls rcar_canfd_disable_global_interrupts(),
which writes GCTR/GERFL while clkp is off and the resets are asserted.
It then asserts the resets again and calls clk_disable_unprepare() on
clk_ram and clkp a second time.

Would this trigger the clock core's "already disabled" and "already
unprepared" warnings? If the clocks are shared, could it also remove
another consumer's enable reference?

Possible triggers are a reset_control_reset() error, or a
readl_poll_timeout() timeout in rcar_canfd_reset_controller() or in
the GOPM mode check. The global_init/global_deinit split came from
commit fa5f4ec8fff8b.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
