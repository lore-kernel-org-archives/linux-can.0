Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB23A3E6F;
	Fri, 16 Oct 2026 02:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118234; cv=none; b=mXuaGdhJtp6e3Q9/GL6WTRnVkuCOdSh/SFKlQC9H1YUK5Dd+N3CphhENNWcnK5nhj83QAiukkixZmR1pdSGTnkFByHMfhRwqZPVyNHP3RbsO1biUdJ0Zh+PkcHZl2UEHOuVnvJ8tLIbhZ1JD/FTo4taeR/6Pgp39gRLapUEpDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118234; c=relaxed/simple;
	bh=qVKG3dMLyW7k1/kBtGsBkorcneGOOMcQNPbwTbmumKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rml+nOCTaty2kj2kJ7wbparGlJAS7rN6fnNTaBtHzJfkxc+Z5zVtM7D23cpBZZ+llZL7LOkiCqQCal2IY+TyNtuKFalfXIfndZXG4jnTOjCyulxHxlmJYBh0CkSrzay+DrWXWNdVfLCkIej2cDzB+hq6kMNXN5iN6x/Fu6GHJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wo5DiNQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo5DiNQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61761F000C4;
	Fri, 16 Oct 2026 02:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118232;
	bh=NeUiG8Wr2o5moQ0pkOpABnBN8C9W/cYoadKILJqrhns=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wo5DiNQWfdLpBZX1j7ZzmXHSphgRJjfXyPBtEcSrWt1DJw7LZsTjfRovahqE2SSSQ
	 Gv1VRsi4hIvJX/1QyXIXRoQ+zaU5AQFH/pRrJorYOhkrusqn2tRqeL1OPyKAgKanR9
	 T0rn1wEwUoIpjZ3w6MoDfp0VPQxOk/fuEvAM3eRRX7i4nOoZj+kTHIMUXA5Ahh0Wqf
	 l36Y8GQPkfJ2ukNPLEoNv5/1+TzMfVRsZK9wLDPmKztyYZl7oVDYliZleKGSTZmtbe
	 RXDjDJVQAlA6WYKB3Dm+S/MyuaK6aqLmx7t4Ci5HSHI+CpKlNWqmOKHifkuVv0XODF
	 PKFfFRNax2zsQ==
Subject: Re: [PATCH net-next 20/37] can: rcar_canfd: Derive max_channels from
 the device tree
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:11 +0000
Message-ID: <179211823132.434549.18097465547112673284@kernel.org>
In-Reply-To: <20261015015336.816543-21-mkl@pengutronix.de>
References: <20261015015336.816543-21-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rcar_canfd_probe() now takes the channel bound from
  of_get_child_count(dev->of_node).
- [Low] The patch removes the per-SoC channel limit
  (rcar_canfd_hw_info.max_channels).
- [Low] In rcar_canfd_probe(), the int returned by of_get_child_count()
  is stored in `u8 max_channels` before the `> RCANFD_NUM_CHANNELS`…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is in the
  error-path loop the patch edits.
- [High] This problem wasn't introduced by this patch, but it is in the
  loops the patch edits.

--

can: rcar_canfd: Derive max_channels from the device tree

This commit removes the hardcoded per-SoC max_channels from struct
rcar_canfd_hw_info. Probe now computes it with of_get_child_count() on
the controller node and stores it in struct rcar_canfd_global. All
for_each_set_bit() loops over channels_mask now use gpriv->max_channels
as their bound.

Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.renesas.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 74c3c3f20991..41c395118949 100644
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

This isn't a bug for binding-valid DTs, but of_get_child_count() returns
an int, and the result is stored in the u8 max_channels before the range
check. With 256 or more children the comparison sees the value modulo 256
(256 becomes 0, 260 becomes 4), so the check would not reject such a node.

The binding only allows "^channel[0-7]$" children and sets
unevaluatedProperties: false. The truncated value is also still bounded
by RCANFD_NUM_CHANNELS before it is used as an index bound, so nothing is
accessed out of bounds.

Would it be cleaner to keep the result in an int until after the
comparison?

[Severity: Low]

With max_channels gone from struct rcar_canfd_hw_info, this check against
RCANFD_NUM_CHANNELS (8) is the only limit left. It is the family-wide
maximum, not the channel count of the specific SoC.

Suppose a DT declared channel nodes the IP doesn't have, for example
channel2..channel7 on a 2-channel Gen3, RZ/G2L or RZ/T2H part. Then
rcar_canfd_reset_controller(), rcar_canfd_configure_controller() and
rcar_canfd_global_init() would program and poll the CCTR/CSTS,
fcbase[ch].cfdcfg, FIFO and AFL registers of channels that don't exist.
Before this patch those nodes were never looked up.

The binding rejects these layouts per compatible ("^channel[2-7]$": false
and similar), so this only affects DTs that violate the schema.

Separately, this -EINVAL path prints nothing. Could it report the reason,
for example with dev_err_probe()?

>  
>  	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
>  		fdmode = false;			/* Classical CAN only mode */
>  
> -	for (i = 0; i < info->max_channels; ++i) {
> +	for (i = 0; i < max_channels; ++i) {
>  		name[7] = '0' + i;
>  		of_child = of_get_available_child_by_name(dev->of_node, name);
>  		if (of_child) {

[Severity: Medium]

of_get_child_count() returns how many child nodes there are, not the
highest channel index plus one. Can channels be missed when the DT
numbering has a gap?

renesas,rcar-canfd.yaml matches "^channel[0-7]$" and only requires
channel0 and channel1, so a gap looks valid. Take a Gen4 DT with
channel0, channel1 and channel4, or a board that removes channel2 with
/delete-node/. Either way the child count is 3.

The loop above then only looks up channel0 to channel2, so channel4's bit
is never set in channels_mask. Every later for_each_set_bit() loop is
also capped by gpriv->max_channels. As a result channel4 is never reset
or configured, never registered as a netdev and never serviced by the IRQ
handlers. No warning is printed.

Before this patch the bound was info->max_channels (8 on Gen4, 6 on
RZ/G3E), so such a channel was found and probed. Does that fit with the
"No functional change" statement in the commit message?

All in-tree SoC dtsi files appear to use contiguous numbering, so only
out-of-tree DTBs or overlays would be affected.

[ ... ]

> @@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>  	return 0;
>  
>  fail_channel:
> -	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
>  		rcar_canfd_channel_remove(gpriv, ch);

[Severity: High]

This is a pre-existing issue and was not introduced by this patch, but
since this unwind loop is being changed: if register_candev() fails,
could the channel's net_device be freed twice?

rcar_canfd_channel_probe() publishes the pointer before it registers the
device:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
	gpriv->ch[priv->channel] = priv;
	err = register_candev(ndev);
	if (err) {
		dev_err(dev, "register_candev() failed: %pe\n", ERR_PTR(err));
		goto fail_candev;
	}
    ...
fail_candev:
	netif_napi_del(&priv->napi);
fail:
	free_candev(ndev);
	return err;
}

When rcar_canfd_probe() reaches fail_channel, gpriv->ch[ch] still points
into the freed ndev. This loop also calls rcar_canfd_channel_remove() for
the channel that failed, and that function only checks for NULL:

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

So priv->ndev is read from freed memory, unregister_candev() is called on
a netdev that was never registered, and free_candev() runs a second time.

Would it work to set gpriv->ch[ch] only after register_candev() succeeds,
or to clear it on the failure path?

>  fail_mode:
>  	rcar_canfd_global_deinit(gpriv, false);

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

This is also a pre-existing issue and not introduced by this patch. Can
the IRQ handlers reach an already freed channel while this loop runs?

Each pass frees a channel through
rcar_canfd_channel_remove()->free_candev(). gpriv->ch[ch] is never
cleared, and the global interrupts are only disabled later, in
rcar_canfd_global_deinit().

The shared handlers walk every bit in channels_mask and dereference
gpriv->ch[ch]:

rcar_canfd_channel_interrupt()
    for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
        rcar_canfd_handle_channel_err(gpriv, ch);
        rcar_canfd_handle_channel_tx(gpriv, ch);
    }

Take two channels. After ch0 has been freed, ch1 keeps running until
unregister_candev() stops it. Any RX, TX or global interrupt from ch1 in
that window runs one of the shared handlers:

- rcar_canfd_global_interrupt() or rcar_canfd_channel_interrupt()
- rcar_canfd_global_receive_fifo_interrupt() or
  rcar_canfd_global_err_interrupt() on RZ/G2L-style parts

That handler then reads ch0's priv->ndev and priv->base from freed
memory.

In rcar_canfd_handle_channel_err(), the stale priv->can.state
(CAN_STATE_STOPPED after close) passes this check:

	if (unlikely(priv->can.state != CAN_STATE_ERROR_ACTIVE &&
		     priv->can.state != CAN_STATE_BUS_OFF))
		rcar_canfd_state_change(ndev, txerr, rxerr);

so rcar_canfd_state_change() runs on the freed ndev.

On multi_channel_irqs parts, the per-channel devm IRQs use dev_id = priv.
They stay registered after free_candev(), and there is no
synchronize_irq(), so a handler already running on another CPU can also
see the freed priv. The fail_channel path in rcar_canfd_probe() has the
same problem.

Would it help to disable the global interrupts and synchronize or free
the IRQs before any channel is freed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
