Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794670262;
	b=nFrY+N+0Zh/3HtuKjX8RX+A3tSz6DnKZqd7ZTHg7LVt804KxQufNON8xV52cNcTmHtl9
	 xLA9wTb4RKJ12sT0RSXu7mi4dUykuUVe3AbEUc+X1cAppaarHSq3fw1dnELunyHIeOUF3
	 darQi0UCFD/00UEierzh8Dax+w1DpdjjiAlq7A6FhiCnMMjONOiz1J4hezD9ENNIFhSOP
	 iEQiIIPvrRvLY8jQ2SJvrgAEBX0ka/0oJKp0+JcSWkMBg9BS3suXwFnqvtmv2HniAEqXU
	 sgYmVvUh6L6hjU0EWCC68q3r3CY7RSNx7jrpBlHP5MOiQoPAaZfEw/mYdQ/sDzdePGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794670262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p8pk3IKMrgQIhiJnIARO6neTDVYJS0j5RkxfDqI29PI=;
	b=TkUhB7PstK+QUs8Hex4sfZD/7vqNrlgl73uI+S4vm6jLFbtsCxrcnUr69+P1u3IidLk7
	 YOhAp3psRnpL6F3AWy3+9V/C3oIXK9Ff26GryMsbICbXg3Xrc0YjornivJO2rCcwJ/its
	 RAWwUkJ/zVaGwUVgqTakDZA0wbIGpUnFgvrJcJtHHjMjk1U2JUXeNWXN4gzQyWhulcAj6
	 Vfai6+xH0EHGMuWaS5/hcMEo0/rNQFx4G0S+SVCQ0oFOQvzbGcQ0p6Tu35rjK82kh00e2
	 HVRwkoDIGHN/z8Rp4zycNRBSY67rXSbsYIxurgfP9YAV7vACEqWNPcQfjHjy6kad+rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsks1VCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E92606A323
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rsks1VCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503EC1F000C4;
	Sat, 14 Nov 2026 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794670262;
	bh=p8pk3IKMrgQIhiJnIARO6neTDVYJS0j5RkxfDqI29PI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rsks1VCPjZi5B4h2CHU5MRDQTe9C3hH1UNdk9DHPtYXfLIdDWWZDcBOYsGpKoDVSQ
	 qMIZ3NqnwS20cl/gCpv0KZmzkxzQDBlCKjtlBusPaYw3p+C9c8kyVRJI45BZ6xDSOJ
	 e0dqruYVuP3naqi3qZJ5lz73s2Qo2QtyAj9v9Pxd+KCGW5oznNp+Bn3S4gomXtYx6s
	 k+ld6DNfEcLioaeQmCzGWR6Q/aw9T+kEnpdBS8MDtEQZKB3WKZzZCuBIz2f0CRuzUb
	 /EooZJm2kcp7yBBzX4sjy7koMGbyjkz8Nq5qEk6TocT17KyDz3BrmqTVDa4gAdDXiM
	 ytztEc3Od17eg==
Message-ID: <sashiko-outbox-214713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v7 5/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
 <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 15:31:01 +0000
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
- [Low] can: gs_usb: invalid context-analysis lock annotations in
  timestamp helpers
--

commit ac918b2b251bb4e9c64c17ed5a99e1135d686016
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

can: gs_usb: fix hardware timestamp state for mixed channels

This commit initializes the hardware timestamping infrastructure during pro=
be
whenever any channel supports GS_CAN_FEATURE_HW_TIMESTAMP, and starts or st=
ops
it when the first or last channel is opened or closed.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 980c4a748c946..b7780a23eff3b 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -405,6 +411,7 @@ static int gs_cmd_reset(struct gs_can *dev)
> =20
>  static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
>  				       u32 *timestamp_p)
> +	__must_not_hold(parent->tc_lock)
>  {
>  	__le32 timestamp;
>  	int rc;
> @@ -423,7 +430,16 @@ static inline int gs_usb_get_timestamp(const struct =
gs_usb *parent,
>  	return 0;
>  }
> =20
> -static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&d=
ev->tc_lock)
> +static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
> +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
> +{
> +	const struct gs_usb *parent =3D container_of(cc, struct gs_usb, cc);
> +
> +	return parent->timestamp_initial;
> +}
> +
> +static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
> +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)

[Severity: Low]
Does building with CONFIG_WARN_CONTEXT_ANALYSIS_ALL=3Dy fail on these lock
annotations?

When WARN_CONTEXT_ANALYSIS is enabled, __must_hold() expands to a Clang
requires_capability attribute on the function declarator at file scope, whe=
re
the statement expression inside container_of() is rejected as a compile err=
or.
Calling lockdep_assert_held(&parent->tc_lock) inside the function body avoi=
ds
this, and gs_usb_get_timestamp() also needs a pointer
(__must_not_hold(&parent->tc_lock)) rather than passing parent->tc_lock by
value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-gs_usb-fix=
es-v7-0-58b6341b1c08@pengutronix.de?part=3D5
