Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244221;
	b=1qF8UbDvTLPjZOmnB+AK9gHXzTxhKQFsA45hrfGQ/fiuVqYgx3W0+DdnNR31URzlf/MM
	 dGuPrDpm8YGmhvtet7SdTaeSf29YwWESTenVaAWc1fa132LleQf45XSZMtulcWVSEwymO
	 hf3Mfazo3Cmxbj6hj5mTvp0yvXuTk1oSDEvxsk6xFkcs9Gp93Zr32eD4JjA/4jVdTmoz4
	 quZEsGdZESnDwl66lFnj5UlryaOiP0ejgx/zr81T8OyRupm5LDkxItXZ/uGjvCP50UxAf
	 1KbmvzC6ZQXGJN7Rp8tgz6grVHBNKFsMW0+k+MeSD076/+vX1oBm6LON7fZuC2kdUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5onwHSb6zZ1UoUUg7nvwkRb+Yqcp27hS0pI9Bpyqxwg=;
	b=uEwI+dlQ8Ci908HXz0MJ94wJRppjicU8MoOO01nGxlSfTlO3IHhxncvLdFh69Slt/4Uy
	 08qF++urq3dMlaLCLWZ8y+HoT1dxfb2mRvQnEUu7S0002mc6D0c2vTQS0uC2blk9pPPnA
	 CA07zzn1b7XgkuC+n4YQGgh1OUj7RuR1SPva/RGRSLZYwPXU5f7w00LOEsxftmzQE/4BQ
	 1M9PT9nqMgMuZvz8+IIuk7N9c3LdARu6o5brRp6SNHFWA+3aFSq+g/wiyF50TVywDCmQp
	 HpY7kJ+W/zC0EFkPByE4vQ77hyCXmfoRBh8AbZN3V8hUtXqOwgP9FXEeU4LlyoNJP7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3WG52kD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED36606A320
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3WG52kD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3CA1F000C4;
	Sat, 21 Nov 2026 06:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795244220;
	bh=5onwHSb6zZ1UoUUg7nvwkRb+Yqcp27hS0pI9Bpyqxwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3WG52kDvt2D+/pk80YfZTyBVn8JA+CfqFx2BMbIU5XKil3tYrgDzPEo+AsNFVJ9r
	 dLx+5u1C8vsm4hIi0UCL2w1dK0vXwpe4jp/3iZJPjivoOJSUxZd0eAtSk+/dEE+nuH
	 vKrT/Khq8Lb4XWtDdUbNrpZ/zVg9qZVIC+jaFw52lN5rGa8btXaDSvhIGSwDFhiQgF
	 mDHZNQy8szKKdI01IMSe9Uo2T3Bvd1eg6tAMGXT6SJZBd4QMXqFMoZwdQefHNjFomj
	 TJ53Z/gq+4S0/yzsIR7ZAKDVvpwyF4JfZB7dI0hyjdy3YtC9JVkRHaaM0/snSbJpXl
	 hj73GBZh1KgUg==
Message-ID: <sashiko-outbox-226709@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: dev: reject unusable bit-timing constants
Reply-To: sashiko-reviews@lists.linux.dev
To: "YuanZhe Liu" <25031212351@stu.xidian.edu.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261121064449.9706-1-25031212351@stu.xidian.edu.cn>
References: <20261121064449.9706-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 06:57:00 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: dev: missing bounds and overflow checks in
  can_bittiming_const_valid()
--

commit f158049438435e605692c8782ad6a1d7e1d750b7
Author: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

can: dev: reject unusable bit-timing constants

This commit adds checks to can_bittiming_const_valid() to reject bit-timing
constants with zero brp_min, brp_inc, tseg1_min, or tseg2_min during
register_candev().

> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 769745e22a3c7..749da996331a4 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -601,6 +601,20 @@ can_bittiming_const_valid(const struct can_bittiming=
_const *btc)
>  	if (!btc)
>  		return true;
> =20
> +	/* can_calc_bittiming() rounds the bit-rate prescaler to a multiple of
> +	 * brp_inc and divides priv->clock.freq by brp. A zero brp_inc divides
> +	 * by zero directly, a zero brp_min lets brp become zero.
> +	 */
> +	if (!btc->brp_min || !btc->brp_inc)
> +		return false;
> +
> +	/* The time segment loop counts down to tseg1_min + tseg2_min. If both
> +	 * are zero the unsigned loop counter wraps around and the loop does
> +	 * not terminate.
> +	 */
> +	if (!btc->tseg1_min || !btc->tseg2_min)
> +		return false;

[Severity: Medium]
Can large non-zero 32-bit bit-timing constants from a USB device still over=
flow
unsigned arithmetic in can_calc_bittiming() and wrap the loop counter or di=
vide
by zero?

drivers/net/can/dev/calc_bittiming.c:can_calc_bittiming() {
	...
	for (tseg =3D (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
	     tseg >=3D (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
		tsegall =3D CAN_SYNC_SEG + tseg / 2;

		/* Compute all possible tseg choices (tseg=3Dtseg1+tseg2) */
		brp =3D priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
	...
}

If a gs_usb device reports tseg1_min =3D 0x40000000 and tseg2_min =3D 0x400=
00000,
both are non-zero, but (btc->tseg1_min + btc->tseg2_min) * 2 still overflows
32-bit unsigned int to 0, so tseg >=3D 0 never terminates.

Likewise, because tseg1_max, tseg2_max, and brp_max are not bounded or chec=
ked
against the minima, large maxima allow tsegall * bt->bitrate in
can_calc_bittiming() (or bt->brp * can_bit_time(bt) in can_fixup_bittiming(=
))
to overflow 32-bit unsigned int to 0 and divide by zero, or stall the CPU f=
or
billions of loop iterations under rtnl_lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121064449.9706=
-1-25031212351@stu.xidian.edu.cn?part=3D1
