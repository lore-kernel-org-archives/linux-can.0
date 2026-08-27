Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09280438036
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832656; cv=none; b=q+bU5JagCbM5zN2JYKpXIYbDa9h1x836l0u5iTEWQoJeTfafRNgQpm2vp3LUXQpF88FHLXdFmPj8SgzzKS7A8YckC2L//II1i+CJDzkiZ8H677LIw/auf5tauLG+vYi1bfkf4R6tm55hfpSOlkskIXTMxEQgtLfFm4dlZcVf3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832656; c=relaxed/simple;
	bh=xP1DuxjFpH4SO7k5r8lW+nvHNWddTo48ajK6mj6EYyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxEVgjfopPM9Au06izPQnXbHy/f3VCyDkrw44KSNGF1i5wX485qbZhcXU2oACGvwG+Na9E/ezbu3Q6R/Hm17otiY/rlhFSBn/OwWZlDlWpOVzSv0vxK58s2oO+Pqjos3Zl/e1fkKud/uh3+gTPUwMtwjbqHjUs01EkjfyK2XuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsDadxzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsDadxzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448991F00A3E;
	Thu, 27 Aug 2026 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832654;
	bh=fxfz/SQypvV1qejI41KGUuvR3uagOhiLa+kuiSVapDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsDadxzx7DB/o4OGcUIbe/woBYi0J19C0Dl1YSHgXH0VUXMX5Tb+n+sMF2jNpCong
	 oTDVEb+02Ai2O92jvzmEioSj3Vu/IbS27Z2A72OiiI8HZVUhs8cozh50MiflFaDCWy
	 Ko8IdS4HoMMb2mmyuCeRXDPakh3mCaXulaPmQi3o/EjLbU0vh51w4RbeDegF8kopct
	 MdjWaKhh0P9WpV/248oeTmF2o6MGZeCU2/vrWS6XyQM0Is49ItiVr7tsCwIZuYVsGw
	 cRXF9Bn9SQ1WPFBOp8zWIyEEnp1zo2IKqc+mxU6coehmsEwCvJSLPmhDZUErZmNUD/
	 PHNhQ7YVQXVqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 03/14] can: bittiming: fix divide-by-zero in
 can_calc_bittiming()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260826121036.2706424-4-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:53 +0000
Message-Id: <20260827121054.448991F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checking on `bittiming_const` parameters allows mal=
icious USB devices to trigger divide-by-zero crashes or infinite loops in `=
can_calc_bittiming()`.
--

commit 0fc6576c2e9b35990a8bf86f43e72c0d477992ea
Author: Sureshkumar S <ssureshmsd7@gmail.com>

can: bittiming: fix divide-by-zero in can_calc_bittiming()

This commit prevents a divide-by-zero panic in can_calc_bittiming() when
evaluating prescalers for large bitrates. It does this by computing the
product of tsegall and bt->bitrate in 64 bits to avoid wrap-around.

Link: https://patch.msgid.link/20260803091426.29050-2-ssureshmsd7@gmail.com

> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 42498e9d3f38d..4809f5e0c96e9 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -119,8 +119,12 @@ int can_calc_bittiming(const struct net_device *dev,=
 struct can_bittiming *bt,
>  	     tseg >=3D (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {

[Severity: High]
This is a pre-existing issue, but if a malicious CAN USB device (such as one
using the gs_usb driver) provides a USB descriptor where btc->tseg1_min and
btc->tseg2_min are both 0, the unsigned loop condition (tseg >=3D 0) becomes
always true.

Could this result in an integer wrap-around and billions of loop iterations,
leading to a system freeze (soft lockup)?

Since can_bittiming_const_valid() in drivers/net/can/dev/dev.c validates th=
ese
constants, should it be updated to verify that tseg1_min and tseg2_min are
non-zero?

>  		tsegall =3D CAN_SYNC_SEG + tseg / 2;
> =20
> -		/* Compute all possible tseg choices (tseg=3Dtseg1+tseg2) */
> -		brp =3D priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
> +		/* Compute all possible tseg choices (tseg=3Dtseg1+tseg2).
> +		 * A 32 bit tsegall * bt->bitrate can wrap to zero for large
> +		 * userspace bitrates, so compute the product in 64 bit.
> +		 */
> +		brp =3D div64_u64(priv->clock.freq,
> +				mul_u32_u32(tsegall, bt->bitrate)) + tseg % 2;
> =20
>  		/* choose brp step which is possible in system */
>  		brp =3D (brp / btc->brp_inc) * btc->brp_inc;

[Severity: High]
This isn't a bug introduced by this patch, but if btc->brp_inc is 0 due to =
an
unvalidated value from the USB device, would this calculation cause an
immediate divide-by-zero panic?

Additionally, if btc->brp_min is 0, brp can evaluate to 0 in some loop
iterations. Looking further down in can_calc_bittiming():

		bitrate =3D priv->clock.freq / (brp * tsegall);

Can this lead to another divide-by-zero in the same loop?

Similarly, if fclk_can (mapped to priv->clock.freq) is provided as 0 by the
device, would the following call near the end of can_calc_bittiming() also
result in a divide-by-zero panic?

	do_div(v64, priv->clock.freq);

Would it make sense to enhance can_bittiming_const_valid() to ensure that
parameters like brp_inc, brp_min, and clock.freq are strictly greater than
zero before they are used here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D3
