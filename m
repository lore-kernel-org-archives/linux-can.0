Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D94A2A78;
	Wed,  2 Sep 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359416; cv=none; b=pneM8U5W3kYLIHiqLCCHGafvCF7mHXWxnpMtRFPs6uggROoVmYmJEaDOFFLP/oweD10nNkFVZetu56t5ggKeDbWqMEHccHrQIVQdXGbK2+bycKJbQi5MVKlIvl4MPHWGSzdLnInVfum1ZXpUOFh5i+6tT+uVLpJHh8t2+MxWmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359416; c=relaxed/simple;
	bh=cqS1w9tLpEle17MBTQW0K1Ef/6cuDw1L04lOcONpGsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PJR3RFmPJoWHF0HbfsEXJEOaWOAIl7xhPGFse6QGUq5RQPAcGVsm3vU01YN2DG3XZJd7DcegbvmdIE/cznuhfS3PZKYRL7AdX1mM7/C8dnrXeZYtb0yHXE7PiDEH9jUMRdmZ3z3Kty768IqP2aGtrYwhUTb9UWkNNUAxJxiK7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd5lJCK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd5lJCK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70171F00A3A;
	Wed,  2 Sep 2026 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359414;
	bh=bDDpXd4TfTwJVWImeOMcfpAVpoJzFYAGf+OolKT3VDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dd5lJCK3pYPauFRYQEOOzu3ageMYg9m3lUaySrLYSHwaM9y9vbtk6ziwiueJXpJqF
	 efsGXdRzvqojZ5IhmwD0AdkaFgiqOwczir/U5DpSLZyFxSTYWMmE1vrq7P9cTRem4G
	 jjvuF632YiG7zVUfmhUZVNTWwbWDyxMG1+7APDfoPwdxjTCggdO7PYfFd5Px1tVS+1
	 896QGsVne86CUhULPz9URw+RjTJfrwr3Shk0xELQuz2Q3xjYqs3fsdzFp7G//nxgzP
	 82AinNWQG1uxVd2O8Q/VFJ2LyPx4jPnsUGOvIpkQldo4cylZesyC6i1quoIwOIeSGs
	 PLzNYMQI+KdHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: robh@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:30:13 +0000
Message-Id: <20260902143013.D70171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lack of validation for Classical CAN mode on CAN FD-only hardware.

Pre-existing issues:
- [High] Dangling pointer in global array leads to double free when registe=
r_candev fails.
--

commit 1c2240055c546ef67856ad4716f6c425dbce01c6
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Add support for Renesas RZ/G3S

This commit adds support for the Renesas RZ/G3S CAN-FD controller.
The RZ/G3S controller supports two channels, 16 AFL pages, and operates
exclusively in CAN-FD mode.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index bed7cde1aa01b..48e0573a73a44 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info=
 =3D {
>  	.fixed_canfd =3D 0,
>  };
> =20
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info =3D {
> +	.nom_bittiming =3D &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming =3D &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const =3D &rcar_canfd_gen4_tdc_const,
> +	.regs =3D &rcar_gen4_regs,
> +	.sh =3D &rcar_gen4_shift_data,
> +	.rnc_field_width =3D 16,
> +	.max_aflpn =3D 15,
> +	.max_cftml =3D 31,
> +	.max_channels =3D 2,
> +	.postdiv =3D 2,
> +	.shared_global_irqs =3D 0,
> +	.multi_channel_irqs =3D 1,
> +	.ch_interface_mode =3D 1,
> +	.shared_can_regs =3D 1,
> +	.external_clk =3D 1,
> +	.fcan_pclk =3D 1,
> +	.fixed_canfd =3D 1,

[Severity: High]
If the device tree specifies the "renesas,no-can-fd" property, could this
lead to a silent mismatch between the software network stack configuration
and the hardware state?

In drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe(), if the property is
present, the driver will set fdmode =3D false:

	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode =3D false;

However, when rcar_canfd_configure_controller() runs, it skips the
controller mode update because fixed_canfd is true:

	if (gpriv->info->fixed_canfd)
		continue;

This effectively leaves the hardware locked in CAN FD mode, while the rest =
of
the driver initializes the software stack for Classical CAN. For example,
rcar_canfd_channel_probe() initializes a max MTU of 16 bytes, and
rcar_canfd_configure_rx() restricts the physical hardware Rx FIFO payload
size to 8 bytes.

If the hardware receives a 64-byte CAN FD frame, will it attempt to write
64 bytes into an Rx FIFO configured for 8 bytes, causing a buffer overflow?

> +};
> +
[ ... ]
> @@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, =
rcar_canfd_suspend,
> =20
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] =
=3D {
>  	{ .compatible =3D "renesas,r8a779a0-canfd", .data =3D &rcar_gen4_hw_inf=
o },
> +	{ .compatible =3D "renesas,r9a08g045-canfd", .data =3D &r9a08g045_hw_in=
fo },

[Severity: High]
This is a pre-existing issue, but does probe failure on this newly added
hardware expose a potential double-free?

In drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe(), the global
array is populated before device registration:

	gpriv->ch[priv->channel] =3D priv;
	...
	err =3D register_candev(ndev);
	if (err) {
		...
		goto fail_candev;
	}

If register_candev() fails, the error path calls free_candev(ndev), which
also frees the embedded priv structure, but leaves the dangling pointer in
gpriv->ch[priv->channel].

When the failure propagates back to rcar_canfd_probe(), the cleanup block
iterates over all configured channels and calls rcar_canfd_channel_remove()
for each, including the one that just failed:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_remove() {
	...
	unregister_candev(priv->ndev);
	...
	free_candev(priv->ndev);
}

Could this lead to memory corruption when it attempts to unregister and free
the already freed dangling pointer?

>  	{ .compatible =3D "renesas,r9a09g047-canfd", .data =3D &r9a09g047_hw_in=
fo },
>  	{ .compatible =3D "renesas,r9a09g077-canfd", .data =3D &r9a09g077_hw_in=
fo },
>  	{ .compatible =3D "renesas,rcar-gen3-canfd", .data =3D &rcar_gen3_hw_in=
fo },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902141544.5657=
63-1-claudiu.beznea+renesas@tuxon.dev?part=3D5
