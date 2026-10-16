Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E24A4400;
	Fri, 16 Oct 2026 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159979; cv=pass; b=U9hsMpWXrVUIIU/NxaCycq8SixCwxCQkw1ohdMMwb3VyxnF4c348XxN8HYqkv3izh1/lVWjBtBjwr8Y7tjqhvXIB7e+ftYqOWr5XPWKYZFyFetjHOCnIWYsdAV7zuGVfBpyWT8blXl5RarvAxDNihE60pMRmlLvAq35xgEuDFY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159979; c=relaxed/simple;
	bh=16p4EwDpi7ZkT+CE0IEXcQRPnPnweDbZSnjGOh+fZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgPPyGhVMEoDIyuFAhVHwiRc6/iDhbvWVMT3Tn4WjsV2ZxSV0Ptdff+EjRLRyVIX879avYYu4PVCwuJBLWlmyysquydAYscstGQZHWmp9Dyrkq9uY9CvaDr251HNG8oKJ5gaGeprYCpp/elib9x60RWNpQXrmDEN/OR3JcrmzMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gNiJOSgp; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gNiJOSgp"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 839962022CD;
	Fri, 16 Oct 2026 16:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792159966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5kvpZ060aOpgMsckomR7J6FNzbK4e8ySVFQCWgNzms=;
	b=gNiJOSgptvu0betEc9ge99sY1aZFCxufqF90U7Uf3RditJJAdaPqJNjNt65wsjPcEbfbwf
	GbXYEbYk11X5dY3W2emVL3EbT/z5KRTQj3rGy+70nsImFrodkQ92qfkQH4q0rNZ1vallqh
	H+azyjXZHMQ2onM9jjCYO1fY0KAxUfQWPqOq3amG6xjLP+zXJ2oihD9LfQM0Jh50XizEfT
	39zAJNrukOQAtuFjXSibmTsvCuGZYeHtoHkbtyYEfLTLvPZZ6dAAiCXGelU5B5xgp1fgjh
	5qqUE/rYWpM+Ytk+SXWk6UIuGCy4BrKk1jmRWSNZ6Ou9M/UO/J0bmIjR+WRARg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792159966; a=rsa-sha256;
	cv=none;
	b=N08yNpG1iTqshczCqqTWN7LAuBILDnWXGj5RsXIsGi1PYI+uPUb0cD+QcGY68TjbeJvJYD
	GNrSC6kVZUmZ4046xdrPrZ4LQ3Vq5uOZ3ejigntGF11iDXDStaLr2G01N6azpXz44YjpL1
	O2lUCFLDP4W2xWtiCVBGCOfssv5crXuzkYCTAicGPkIvAWq6sTGEadiGdPrVLI9s3P6HhM
	EPLG68tkSHrsvw0EDRV2lSAs7VfRM80eMtYyqmur+KFN7xpQ9REhTnGfzdcJuyPdn41Y9n
	dsTD+UW0c09PTcymIzL47kdy2Y0xs9U+iKw0ZynggC2DYhXHEwBseNzDA8DN8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792159966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5kvpZ060aOpgMsckomR7J6FNzbK4e8ySVFQCWgNzms=;
	b=CCP9x+MSig/qEIHNhdU/Qq/TCgpWejOhB6b49bgkiPPnYgO3SPpuwp2pPwjlmruLMepujK
	AUGDLZCu0okkDZ25b6GknetIuKpSVJos3PiGoc0hv0yQhRiMRhG8kQk/G74Q4nCrlBcldv
	hWX+0h+Hv4HmErZSZcrAfpTv4DBicCQLkqViW+wUYMrvPTx3CKwb72suvF+aq+UY5fMCUF
	g8HxVP3CMeM5wNorRMDPXmvU8rKl+3TgtAE/U0al5evBDlqtRzbMk0AVdd9drvat7GlSLp
	JxjJiXJPUxusfST0X00mTm23v7EYHNVeyW/5okdUQlIqPpgrEjIBn5POwu+aTw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHifu-006CMD-1L;
	Fri, 16 Oct 2026 16:12:46 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1CCB45C62B7;
	Fri, 16 Oct 2026 14:12:46 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:12:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
Message-ID: <20261016-moth-of-rampant-exercise-ecc0ee-mkl@pengutronix.de>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xywm42ucvzgj54nk"
Content-Disposition: inline
In-Reply-To: <20261001075742.21961-3-biju.das.jz@bp.renesas.com>


--xywm42ucvzgj54nk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
MIME-Version: 1.0

On 01.10.2026 08:57:38, Biju Das wrote:
> The maximum number of channels is currently hardcoded per SoC in
> struct rcar_canfd_hw_info. Since the DT describes the channels as
> child nodes of the controller, the count can be obtained at probe time
> with of_get_child_count() instead.
>
> Drop max_channels from struct rcar_canfd_hw_info and store the value
> in struct rcar_canfd_global, so it no longer needs to be maintained
> for each SoC variant. Update all for_each_set_bit() users over
> channels_mask to use gpriv->max_channels.
>
> No functional change.
>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

the netdev sashiko is not happy.

pw-bot: cr

regards,
Marc

--- Patch [20]: [PATCH net-next 20/37] can: rcar_canfd: Derive max_channels=
 from the device tree ---
commit f2792c210c20d626154d87626c44459c153936fd
Author: Biju Das <biju.das.jz@bp.renesas.com>

can: rcar_canfd: Derive max_channels from the device tree

This commit removes the hardcoded per-SoC max_channels from struct
rcar_canfd_hw_info. Probe now computes it with of_get_child_count() on
the controller node and stores it in struct rcar_canfd_global. All
for_each_set_bit() loops over channels_mask now use gpriv->max_channels
as their bound.

Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.renesa=
s.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 74c3c3f20991..41c395118949 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	bool fdmode =3D true;			/* CAN FD only mode - default */
>  	char name[9] =3D "channelX";
>  	u32 ch, fcan_freq;
> +	u8 max_channels;
>  	int i;
>
>  	info =3D of_device_get_match_data(dev);
> +	max_channels =3D of_get_child_count(dev->of_node);
> +	if (max_channels > RCANFD_NUM_CHANNELS)
> +		return -EINVAL;

Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-gemi=
ni =C2=B7 Called a false positive by: gpt-6-astra

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

Discovered by: opus-5-5, opus-5 =C2=B7 Missed by: gpt-6-astra, sashiko-gemi=
ni =C2=B7 Called a false positive by: gpt-6-astra

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
>  		fdmode =3D false;			/* Classical CAN only mode */
>
> -	for (i =3D 0; i < info->max_channels; ++i) {
> +	for (i =3D 0; i < max_channels; ++i) {
>  		name[7] =3D '0' + i;
>  		of_child =3D of_get_available_child_by_name(dev->of_node, name);
>  		if (of_child) {

Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-gemi=
ni =C2=B7 Ranked High by: gpt-6-astra

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

> @@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_device =
*pdev)
>  	return 0;
>
>  fail_channel:
> -	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
>  		rcar_canfd_channel_remove(gpriv, ch);

Discovered by: gpt-6-astra, opus-5-5, opus-5 =C2=B7 Missed by: sashiko-gemi=
ni =C2=B7 Ranked Critical by: gpt-6-astra

This is a pre-existing issue and was not introduced by this patch, but
since this unwind loop is being changed: if register_candev() fails,
could the channel's net_device be freed twice?

rcar_canfd_channel_probe() publishes the pointer before it registers the
device:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
	gpriv->ch[priv->channel] =3D priv;
	err =3D register_candev(ndev);
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

> @@ -2327,7 +2326,7 @@ static void rcar_canfd_remove(struct platform_devic=
e *pdev)
>  	struct rcar_canfd_global *gpriv =3D platform_get_drvdata(pdev);
>  	u32 ch;
>
> -	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
> +	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
>  		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
>  		rcar_canfd_channel_remove(gpriv, ch);
>  	}

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: opus-5, sashiko-gemi=
ni =C2=B7 Ranked Critical by: gpt-6-astra

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

	if (unlikely(priv->can.state !=3D CAN_STATE_ERROR_ACTIVE &&
		     priv->can.state !=3D CAN_STATE_BUS_OFF))
		rcar_canfd_state_change(ndev, txerr, rxerr);

so rcar_canfd_state_change() runs on the freed ndev.

On multi_channel_irqs parts, the per-channel devm IRQs use dev_id =3D priv.
They stay registered after free_candev(), and there is no
synchronize_irq(), so a handler already running on another CPU can also
see the freed priv. The fail_channel path in rcar_canfd_probe() has the
same problem.

Would it help to disable the global interrupts and synchronize or free
the IRQs before any channel is freed?

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xywm42ucvzgj54nk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIw2gAKCRDMOmT6rpmt
0pU6AP9LUtXs4nvnzzau36Vy73pykCNVlHORgPneMZ5uXQYRFAEApAVpBVDxUHce
XSHovNxFxsQ/g5SiZsJMFWWSuOko1wY=
=PhzF
-----END PGP SIGNATURE-----

--xywm42ucvzgj54nk--
