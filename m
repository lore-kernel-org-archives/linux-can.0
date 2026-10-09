Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227174E1C9F;
	Fri,  9 Oct 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554236; cv=pass; b=s/x7uluNp5/RRpAmQXSwnI+z36g6nnp2fZMqHw6E2BdD2t0I3NhjacLw8wRsojMrGZSn8t5WBdc9zEV0ziTUpgswDQX54xZMgxyWNo+zr9ts5UpvLNCFTxI6MYek2x0K+GS76RIpxHYKoSNfEc/q1BaPMaJDG5+Dl1ATw9Qd4zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554236; c=relaxed/simple;
	bh=lNDGyTfrrnJ0x2m9dKKbNPplOipBxIEnC6Np47T/Of0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjMunkNExpXhSBNu+DzeWDS+WZSwES5zLD9t5QOI4oJd0+oCEzLGBi6Vv56DtEYjdq1gZNFeQrGu435ZlG6a5MiVwOC7KUlIvUAu+Acj1qSSyey5FDf8fuqHetQsAW5YTbv+39sgK12ctGK4ozYekFSh8q8HE5f/rL+yF7yCghg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=e8hc6kIn; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="e8hc6kIn"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 16AAE201E76;
	Fri, 09 Oct 2026 15:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791554231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd1eM6OXjuYgZF7XvaqwP06zILMcJcYbULAXdug83vw=;
	b=e8hc6kInbqE3bPjn8MwZO/Nz926s6rik+J/Q79DbCVaF7Ek2wIAG3SWW4VkoeLHRiofCcc
	E+1YHj9yxWVroG+bPOwGdMBOKKXQTxK6k7yj5k1zz3jB6RxwCUqXl+DozGA3kN+UNRXZ1p
	W7yrwFhhIfKKHhG8PvRSUEptdBNK+DlWOXO13O6GY8eMl35amwjz16kN7Nd4WTS2MEibJR
	WgR2TDYyFN6veI9HGGJZF9s6kSlQTQCqOcUoTLXdUpjGwvI+WEfKLTppnd13QaXm25t0oZ
	+kWDa4pqX+OXt+JX5XHL8c3oVj4mIfupTe4RLu/4SKIxJfxPQ3qoO3xXlTN39Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791554231; a=rsa-sha256;
	cv=none;
	b=QI/On6wTiTJn+XIoFlSPBI+CQKb42mJhAn1ElyJz9IUr1Z1U5gzXf/GSTCxquLr1cAddGd
	sck9TI49onNjJeU/7sOKTv680czNF7+FQz/chjD6dRXsUY2zJ+VNb0fcXwacDBSI2lqf1N
	OJoAv5jzB/DwNqeMESiWBjvGkgTGglqfMM+zbjw+9AlZlnDFLfVwj76GXo30F9IsVA6hsZ
	zQdMKtDku2LGMoD9aBjNac/jeDJw/MJ7KC6DG3OIqNImUg+OXG4Z5FLsIsUNFhxLc6wjeP
	0NigpjrjJgk48PyWARSgekxgyDCDvv7aGxdilpb2zxDU1FPPOLe6Ivt/KGt8HQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791554231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd1eM6OXjuYgZF7XvaqwP06zILMcJcYbULAXdug83vw=;
	b=a4hPJ2n68t00k4SIV9yMmhY2qF3TIIWx9MX3Orw8jAdIydAvCfOtzAMPFD7Kf6HbcTSIo3
	qRLfCp8/3Lj1TRJKNmjlAJTRKzJ7DtLEWVv3pQD8O1S59w9XgcW+W0JIfjZ/3sLFGIPOhi
	OZ6z1FUWWzXlz6ut2PPrIOS41xME8lZ0jpgFGEJDWPlBQJ1ONuYLztoX4ESRwUGq1iBxln
	tl+rM0DAkD2UeVA7N9LkhXOM7CD3i+lCLNJcTBLiLX+0rF2UBzmS5dWEL1+IXKTvX3T2DG
	9DVjtPLqL1mk3Nz8cCs1AEWjEaUvy9hEnyn4SWEzFK8NjO1R7qrCsb4X+A2rUg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFB5y-0053Uu-3A;
	Fri, 09 Oct 2026 15:57:11 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9248A5BDA05;
	Fri, 09 Oct 2026 13:57:10 +0000 (UTC)
Date: Fri, 9 Oct 2026 15:57:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
Message-ID: <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4k55vn7oeozm4vs"
Content-Disposition: inline
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>


--g4k55vn7oeozm4vs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
MIME-Version: 1.0

On 09.10.2026 15:27:32, Marc Kleine-Budde wrote:
> Hello netdev-team,
>
> this is a pull request of 37 patches for net-next/main.
>
> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
> CAN-XL devices.
>
> A patch by Sang-Heon Jeon removes a redundant NULL check before
> netdev_hold() in the CAN RAW protocol.
>
> Oliver Hartkopp's patch converts the unreliable ARPHRD_CAN type check
> to the robust can_get_ml_priv().
>
> A patch by Runyu Xiao for CAN proc resets the pkg_stats using atomics
> individually. Oliver Hartkopp also contributes a patch for the CAN
> proc to remove kernel pointers from the output.
>
> Tetsuo Handa's patch cancels pending address claim timers in
> j1939_ecu_unmap_all().
>
> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
> for the correct CAN CC/FD frames.
>
> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
> any context in several CAN helper functions.
>
> Claudiu Beznea contributes 5 patches for the rcar_canfd driver to add
> support for Renesas RZ/G3S.
>
> Krzysztof Kozlowski's patch updates the renesas,rcar-canfd DT bindings
> to restrict the resets in top-level.
>
> Biju Das's series of 3 patches add support for Renesas RZ/G3L CANFD to
> the rcar_canfd driver.
>
> Quchaosheng contributes 2 patches to convert the gr_can DR bindings to
> DT schema.

Forgot to mention, that a patch by Oliver Hartkopp removes the Softing
CANcard driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g4k55vn7oeozm4vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjyswAKCRDMOmT6rpmt
0sfMAQDANJouw1Q9NOFpDhsQwUQMnkRtB6CUB6/zojtAeypk7AD/Vdv1sIW6Adk0
9qlhfxlMlfQ0GGLRRGkJVkA9mV00yA8=
=ZxKe
-----END PGP SIGNATURE-----

--g4k55vn7oeozm4vs--
