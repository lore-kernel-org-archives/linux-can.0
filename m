Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4728F3D45E5;
	Tue,  7 Jul 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421356; cv=none; b=javJqbjvpmsIXAumyRSf0MKcCQQ2vOglOhTWHKNDA8k7kQIdpG0KskysLexThR0cgwaYzpgGPFwa/s5elLvATJ+w7IO+t6gPQe7IDNKV5nNowpV7ZKBHOhGk/yIkafTWhn3UlB9fSVOPxOiZposQhIECRu80uu6TUk2sBwEZRjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421356; c=relaxed/simple;
	bh=VIQYHGXNl4JrcNHeGdN3pisSGnJloaOCMG7ehAaKqs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FNa195RkpXEF76sjXqripe1Vrz0XzfLtNV6uBi1PzhF0YLDTo4PdQPAGCQhAR1tnSmW74JyWKYNNh3zHn4H5fw9WznPjVDMk1imMIDS6Pg+QO17JirT2ibk3lVWJ2xdTn5tYsR+OgZG0RDvcgr202HBv8yyZyyvvLapVxrmpyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY5FmQSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY5FmQSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FBD1F000E9;
	Tue,  7 Jul 2026 10:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421354;
	bh=w8mNu35jn6zKtvNzIwFMdXHyMkBEaKY/eVEkl2PXay0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TY5FmQSNMw8lGbulhnB9N3AwwDIlkE8Xr59juJg/KmTBdh+ngJWsuV0f3JjlYgAzC
	 asMJVIXHfUDTerlaAyKDwpB+GeTCY7l6dNE0NtJ7fe+dmVARAzWsPXA+misvt1Vv/a
	 dVXs12xMJQDdH07c8S0xbC+QGHe0mS503D7B9b3UnsscaQW4jLlvVg300ViuVECxFm
	 1qepqOu8r0ruJAgxgttY+v4dULjw2qM0wIj8nqapaSMGv90SEeKvQ2ekFsffuc3L16
	 yTOuatyk2nvM9Hb+ZNwrtGH9hujWKNuBs7kaVAZUa0EFFQdfgRYb8II4x1uPesOHln
	 fe/VOZaXcnNLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: robh@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260707102418.1646159-7-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-7-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:49:13 +0000
Message-Id: <20260707104914.60FBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing enforcement of CAN-FD mode when hardware does not support =
classical CAN mode.
- [High] The variable `fcan_freq` is used uninitialized when clock fallback=
 branches fail.
--

--- Patch [6]: [PATCH 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S =
---
commit cd9e80c9be5a9e3af3e5266e74d95204fb8cf5b3
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

    can: rcar_canfd: Add support for Renesas RZ/G3S

This commit adds CAN-FD support for the Renesas RZ/G3S controller. It
configures the hardware info struct to reflect the controller's capabilitie=
s,
including its lack of support for classical CAN mode and its internal clock
divider.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 7f01afe60a4c2..6d6b2d999b782 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,25 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info=
 =3D {
[ ... ]
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info =3D {
> +	.nom_bittiming =3D &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming =3D &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const =3D &rcar_canfd_gen4_tdc_const,
> +	.regs =3D &rcar_gen4_regs,
> +	.sh =3D &rcar_gen4_shift_data,
> +	.rnc_field_width =3D 16,
> +	.max_aflpn =3D 127,
> +	.max_cftml =3D 31,
> +	.max_channels =3D 2,
> +	.postdiv =3D 2,
> +	.multi_channel_irqs =3D 1,
> +	.ch_interface_mode =3D 1,
> +	.shared_can_regs =3D 1,
> +	.external_clk =3D 1,
> +	.fcan_pclk =3D 1,
> +	.mode_select_na =3D 1,

[Severity: High]
Since this hardware sets .mode_select_na =3D 1 because it does not support
classical CAN mode, could there be a mismatch if the device tree contains t=
he
"renesas,no-can-fd" property?

In rcar_canfd_probe(), we set the software mode to classical CAN if this
property is present:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode =3D false;			/* Classical CAN only mode */
    ...
}

Since the hardware configuration bits are bypassed by .mode_select_na =3D 1,
would this leave the hardware in CAN-FD mode while the software driver allo=
cates
MTU and payload sizes for classical CAN frames?

[Severity: High]
While reviewing the clock configuration related to .postdiv =3D 2 and
.fcan_pclk =3D 1, I noticed a potential regression in the clock fallback lo=
gic
that might affect older platforms.

In rcar_canfd_probe(), if "can_clk" and "canfd" clocks are missing from the
device tree, devm_clk_get_optional() returns NULL instead of an error, which
skips the error path but leaves gpriv->can_clk as NULL:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
	...
	gpriv->can_clk =3D devm_clk_get_optional(dev, "canfd");
	if (IS_ERR(gpriv->can_clk))
		return dev_err_probe(...);

	if (gpriv->can_clk)
		fcan_freq =3D clk_get_rate(gpriv->can_clk);
	else if (info->fcan_pclk)
		fcan_freq =3D clk_get_rate(gpriv->clkp);

	/* CANFD clock may be further divided within the IP */
	fcan_freq /=3D info->postdiv;
	...
}

If info->fcan_pclk is 0 (which is the case for Gen3/Gen4 platforms), does
this mean fcan_freq is used uninitialized when calculating the CAN bit timi=
ng?
Can this lead to unstable or non-functional CAN buses on those platforms?

> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D6
