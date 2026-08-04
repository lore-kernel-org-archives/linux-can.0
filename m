Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C49429CF0
	for <linux-can@vger.kernel.org>; Tue,  4 Aug 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834903; cv=none; b=bXNN5Jdjp6Nt1SgV83qcCwnOFW3tpULID/R3w4Tk+LrBKGTNIGdWfIYapYYDdzXpWtUwlbjVXU5B6OBDPE3EWyAoqxGAWq+DDSkY9L0KnKTFK0+XSZxFiUE4J9MeCN4AoH29sPHtLecUf/lVBl4c6R2A6tz7lMsKWnT3Dx2izLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834903; c=relaxed/simple;
	bh=NiK1b4ZGtuIUcV74adI9PJqhdtn7KVKezlCuitsyVzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cvgs1eTNU5iWEVR3OJfw93CXfy2ugzkeRVnobQpuhmnucUwHgQa08+A/IWMeYWCv64RicRgNspezAAjHafzR1HzRE5uUhjp2QmCqgLL9RtzmwNX93bDrHOG0v9uWkPJxqwIIT70w3RaY5aQDI14tCvvwaB9UoDBpXgicK40/YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my4J/aAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my4J/aAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767961F000E9;
	Tue,  4 Aug 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785834901;
	bh=6v3J02GtFRvqNbA2px4b7bwnFB8z/UC5w9VKO7nqCfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=my4J/aAluFR1DgtM5F19Dkq4dDWnee/GuwG3TFoWATxQXfjySnUV7WypWUWpB+noX
	 jWwVBUkolQYI1FyHJbVum+jiB/GU89fkrze3JQIGyZYmjC4PNUGNrk5uctnDKSucLH
	 CdMwdCrg/Zh+r2/MVU6FLd4tROGPdLh3uFXYYFJ/1Xi0JUjSEaKrBZVT7aVbl1cDOR
	 Be7e/spK+oW+n128yuNT5LSEHus0l6/MHX1ruu2i5xwHtqVdhvgLuBNKFoMcR7inqv
	 a//dRXwv92d16p0i0XprlW7DPdb3dt9h0WXzd4mHeI2xrGzj5lpnabmyb5pq/6ZOyr
	 HwK+duv1WT21A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] can: bittiming: fix bitrate error calculation
 on unsigned operands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sureshkumar S" <ssureshmsd7@gmail.com>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260803091426.29050-3-ssureshmsd7@gmail.com>
References: <20260803091426.29050-1-ssureshmsd7@gmail.com>
 <20260803091426.29050-3-ssureshmsd7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 09:15:00 +0000
Message-Id: <20260804091501.767961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked bit-timing hardware constraints from USB devices can cau=
se kernel panics due to division by zero in can_calc_bittiming().
- [High] An unchecked minimum time segment configuration from a malicious U=
SB CAN device leads to an infinite loop, hanging the kernel.
--

--- Patch [2]: [PATCH net 2/2] can: bittiming: fix bitrate error calculatio=
n on unsigned operands ---
commit 93441c10d7d0dd29814ef57910bbfdffcd4e5112
Author: Sureshkumar S <ssureshmsd7@gmail.com>

can: bittiming: fix bitrate error calculation on unsigned operands

This patch fixes a wrap-around issue in can_calc_bittiming() caused by
subtracting unsigned operands when rating candidate bitrates. It updates
the code to use abs_diff() so that large bitrate errors are correctly
identified rather than being misinterpreted as small errors.

> diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/c=
alc_bittiming.c
> index 4809f5e0c96e9..2789b99ab6a83 100644
> --- a/drivers/net/can/dev/calc_bittiming.c
> +++ b/drivers/net/can/dev/calc_bittiming.c

[Severity: High]
This isn't a bug introduced by this patch, but could a malicious USB CAN
device cause an infinite loop in this function?

Looking at can_calc_bittiming(), if a device advertises tseg1_min =3D 0 and
tseg2_min =3D 0:

	for (tseg =3D (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
	     tseg >=3D (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {

Since tseg is an unsigned int, the loop condition tseg >=3D 0 becomes a
tautology. This would cause tseg to wrap around to UINT_MAX, resulting in
an infinite loop that hangs the kernel.

> @@ -132,7 +132,7 @@ int can_calc_bittiming(const struct net_device *dev, =
struct can_bittiming *bt,
>  			continue;
> =20
>  		bitrate =3D priv->clock.freq / (brp * tsegall);

[Severity: High]
This is also a pre-existing issue not introduced by this patch, but is it
possible for this division to cause a kernel panic?

If a malicious USB device provides unvalidated values, could brp evaluate
to 0 if btc->brp_min =3D=3D 0 or priv->clock.freq =3D=3D 0?

Also, earlier in the same function there is another division:

		brp =3D (brp / btc->brp_inc) * btc->brp_inc;

Could this divide by zero if btc->brp_inc is provided as 0 by the hardware?

> -		bitrate_error =3D abs(bt->bitrate - bitrate);
> +		bitrate_error =3D abs_diff(bt->bitrate, bitrate);
> =20
>  		/* tseg brp biterror */
>  		if (bitrate_error > best_bitrate_error)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803091426.2905=
0-1-ssureshmsd7@gmail.com?part=3D2
