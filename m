Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D157439F68
	for <linux-can@vger.kernel.org>; Tue,  4 Aug 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834904; cv=none; b=lpH38MCM77bEXgVBwn4nSiLOVhYP0lUO4oHpPx/vgrE99C/xjhcIvkRnW16Co8KuC2deJ2kcvRtU6pCEUSc5fRt2i2za3bwXRAhDxLKx/OQtIXUszxvavQUocdduEfHBEG+0Zdz60ShLNWNZcxFUMYL2W1jMLARdPiFcpqsbaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834904; c=relaxed/simple;
	bh=huTxS21pMk7tG+YqYPqKpBPbMIZAWy7vsSmDdEx3dmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l24CuzgR7JeZzjJ53b4vbYe1XB8+bHDHTjbCY3MoIZHz7fPX9E1TTcdL76+fRVAYmOm54A6plNkULqD/7jjAgf9Q0bEr9ogagvPYxUGVDhM678u5/hilA3p1f+IHGq4oGjyjmEOi5BF8YRTpxTUaoAnUIUDlx/dfXZUbgMD0+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2REy2TT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2REy2TT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40441F00A3A;
	Tue,  4 Aug 2026 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834903;
	bh=VucWOV0aXTOtRkf/0z1TUme+m8wGw/QJS7J0ayyztRk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2REy2TTiPU84Diepe8VmqVFZC2ILgXgKWY9qdAIWShhMnsNL1ALNkyntRLphv73Y
	 tfek3EkGpvEHrd4Thz3P3frdiKHHiJIsJWoO0D21MZYRmovGqV6HqOCEVFZ2DUXGHq
	 0IZLRW+raH+sQz/SENJDeGwNppT8RYPMhkPPXKCTE72d6g7UN79N18zjemsMMOJ2pX
	 5MBzVYkzj5CBle2NbVJ8hhDz6q7Sl5kCB6j9XR8fcDabWjiHgME6Vwa2QXZEGbyDS3
	 PnB4tTrP0Hl2AcdtM2/8A8e3KBGOJ0yxVh+EvF8WYTznoH7S6BCPq90blgw9dsAjpY
	 WaYLbHZJqSfug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] can: bittiming: fix divide-by-zero in
 can_calc_bittiming()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sureshkumar S" <ssureshmsd7@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260803091426.29050-2-ssureshmsd7@gmail.com>
References: <20260803091426.29050-1-ssureshmsd7@gmail.com>
 <20260803091426.29050-2-ssureshmsd7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 09:15:02 +0000
Message-Id: <20260804091502.A40441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for hardware-provided bit-timing constants `brp=
_inc` and `brp_min` allows malicious or misbehaving CAN devices to trigger =
divide-by-zero kernel panics.
- [High] A 32-bit integer overflow in the `brp * tsegall` calculation can w=
rap to zero, causing a divide-by-zero kernel panic.
--

--- Patch [1]: [PATCH net 1/2] can: bittiming: fix divide-by-zero in can_ca=
lc_bittiming() ---
commit 1d93cc0a0370ce5feb4636b0a8c6900dd609c628
Author: Sureshkumar S <ssureshmsd7@gmail.com>

can: bittiming: fix divide-by-zero in can_calc_bittiming()

This commit patches a potential divide-by-zero in can_calc_bittiming() when
calculating the prescaler. It uses 64-bit math to prevent the 32-bit integer
multiplication of tsegall and bitrate from wrapping to zero for large bitra=
tes.

> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 42498e9d3f38d..4809f5e0c96e9 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c
> @@ -119,8 +119,12 @@ int can_calc_bittiming(const struct net_device *dev,=
 struct can_bittiming *bt,
>  	     tseg >=3D (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
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
This is a pre-existing issue, but missing validation for hardware-provided
bit-timing constants might allow a divide-by-zero here.

If a misbehaving or malicious USB adapter (like gs_usb) provides 0 for
btc->brp_inc, won't this division directly panic the kernel when a user with
CAP_NET_ADMIN configures the interface?

>  		if (brp < btc->brp_min || brp > btc->brp_max)
>  			continue;
> =20
>  		bitrate =3D priv->clock.freq / (brp * tsegall);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't this calculation have
the exact same 32-bit overflow vulnerability that the patch fixes above?

Since both brp and tsegall are 32-bit unsigned integers, couldn't their pro=
duct
wrap to zero for large values derived from untrusted hardware limits, causi=
ng a
divide-by-zero panic on this line?

Additionally, if the hardware provides a btc->brp_min of 0, the bounds
check above allows brp to evaluate to 0. Wouldn't that also result in a
divide-by-zero here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803091426.2905=
0-1-ssureshmsd7@gmail.com?part=3D1
