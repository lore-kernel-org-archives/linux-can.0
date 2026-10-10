Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB656459AEB
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639840; cv=none; b=VqkoO0Bgx2UmW2AErnfu/cj+pNTQXnvKQaM6vsapO5Ps9kXQwsrOyF2A2SmKQn0FDbLcMz+5k+o3OPTi9q/rcXdVuxtLqJ+9XFjtn71ECqLwfNHl7CagM2J/kgx/9+alXTgEx6Eld7TLPkQbzo7S3KLwOeF0HPOJtlHAz2uk0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639840; c=relaxed/simple;
	bh=tMum/qmkRi4NlZd7iHm+DMSmLZrzibCyoVzV+0UqnQw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VDYVTFGjkRSQCVwdv5a85DkfGytXlJZgivruqsIHd3LSKr1G2xHkb9rxuflJX2qEjl2owA5wWplLzvU71DJicfEZUxKpQWbByGdIGsI37gIsIcH7gDLAnrEp9Xv6aRhXwfvTn3Y3B4eJi0m7zR3wMtV4NibbNazuzv4PC2kDkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1dO/LWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1dO/LWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9361F000FF;
	Sat, 10 Oct 2026 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639839;
	bh=hzgDi1dozKtVBSKVguVEIk32Cc5DZdNjl5/EG6rdXo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1dO/LWnLvc0YXTHemear3km0XqDceVTs808ORBy1/u8j9RXc/LEKUSYcnEq44y+E
	 M5GMCMHwZ+BBJcxQuPNl+T1bGDm4d80+fPLuqx0+RtIZq9/7430exaHxIuW2YNi64t
	 XUHjQZ2+KpA84mpBF3qVjFHjrKacNeV+89dxM70gpYdID/H74elk+OcWIRrzvCZwyz
	 /jVDvt4LSOTuqVegenrQWvkZFL+oK1oQTounVaypDz38YzPWsU+FidXs+KlI4mt7hA
	 6unpJjyYK3ipjeRJ3EyOINpyqcRNU7u1bTZ7jnixKmYK6TNZRqEGQRs+CaKJVvYr0B
	 +BjPrsBCvvGEQ==
Message-ID: <sashiko-outbox-166607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 17/37] can: rcar_canfd: Derive max_channels
 from the device tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20261009134323.64064-18-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-18-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:58 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: rcar_canfd: out-of-bounds MMIO and broken sparse DTs
--

commit a1d79c18cfbc6d4e1569e45058d228d182b10de9
Author: Biju Das <biju.das.jz@bp.renesas.com>
can: rcar_canfd: Derive max_channels from the device tree

This commit modifies the driver to obtain the maximum number of channels
dynamically from the device tree child count rather than hardcoding it
per SoC in struct rcar_canfd_hw_info.

Link: https://patch.msgid.link/20261001075742.21961-3-biju.das.jz@bp.renesa=
s.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 74c3c3f20991f..41c3951189490 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -436,7 +436,6 @@ struct rcar_canfd_hw_info {
>  	u8 rnc_field_width;
>  	u8 max_aflpn;
>  	u8 max_cftml;
> -	u8 max_channels;

[Severity: High]
Does removing the structural enforcement of the hardware capability limit
allow the device tree to dictate bounds for MMIO register access? The
driver should enforce physical hardware limits independently of the device
tree to prevent out-of-bounds access.

>  	u8 postdiv;
>  	/* hardware features */

[ ... ]

> @@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	bool fdmode =3D true;			/* CAN FD only mode - default */
>  	char name[9] =3D "channelX";
>  	u32 ch, fcan_freq;
> +	u8 max_channels;
>  	int i;
> =20
>  	info =3D of_device_get_match_data(dev);
> +	max_channels =3D of_get_child_count(dev->of_node);
> +	if (max_channels > RCANFD_NUM_CHANNELS)
> +		return -EINVAL;
> =20
>  	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
>  		fdmode =3D false;			/* Classical CAN only mode */
> =20
> -	for (i =3D 0; i < info->max_channels; ++i) {
> +	for (i =3D 0; i < max_channels; ++i) {

[Severity: High]
Is the child node count wrongly used as an absolute channel limit and
upper bound for iteration here?

Conflating the child population count with the maximum channel index
breaks sparse device trees. If a device tree explicitly omits an
intermediate channel (for example, via /delete-node/ channel1), the child
count shrinks. For a 3-channel SoC where channel1 is omitted, max_channels
becomes 2, causing this loop to terminate before discovering channel2.

Also, if a malformed device tree specifies more channels than the SoC
physically supports, the driver will attempt to configure non-existent
channels since the SoC-specific limit was removed. Accessing unmapped
or reserved MMIO registers for those extra channels could cause a
synchronous external abort.

>  		name[7] =3D '0' + i;
>  		of_child =3D of_get_available_child_by_name(dev->of_node, name);
>  		if (of_child) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D17
