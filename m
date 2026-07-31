Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35788386553
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482041; cv=none; b=YMoCUnInMhEd8G94rPYnnMTYnc3Tvz0O6A7RcKLxcHgG8yC1tvRQmODIJ/rMGL6irUbXdF6mNaWkZ30/JGEB13+z7sg1dI7uIQLF5rMT/fuTDtIRYf6C+0ItAJuQCOKzvCtMa3zbEao6u3yk9O848DZRjXhF4R9DfczQ5fCPj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482041; c=relaxed/simple;
	bh=5VmY39LeX9j6+al1EOdMuQuZTaFwbhHG8LUWbSXUzPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqlbVRDCqzFTNomDf6HBotsflkPmp0iCbwEr98Cs+GwpZqnS/00m52EalAolv9Fx7CDXZB3gSO3TfJnDYh97TzP3EacerKeMuLoW062laId+dhGQyPGFeMqV4tutEg2ZfAGSvMg0pW+iP17+kuALyYxLFiTTV4evwJROtbaQInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C050720299C;
	Fri, 31 Jul 2026 09:13:56 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wphRM-002AXZ-2D;
	Fri, 31 Jul 2026 09:13:56 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0EA5F577B8E;
	Fri, 31 Jul 2026 06:32:40 +0000 (UTC)
Date: Fri, 31 Jul 2026 08:32:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Cunhao Lu <1579567540@qq.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH v4 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Message-ID: <20260731-fair-singing-crow-8cc1f3-mkl@pengutronix.de>
References: <tencent_BD7611A1FCC89A34685A64621292464E0209@qq.com>
 <20260730161220.A4CB11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inw735pmpylshlmb"
Content-Disposition: inline
In-Reply-To: <20260730161220.A4CB11F00A3A@smtp.kernel.org>


--inw735pmpylshlmb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
MIME-Version: 1.0

On 30.07.2026 16:12:20, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but does the hardware configuration here br=
eak the TX completion logic?
>
> drivers/net/can/rockchip/rockchip_canfd-core.c:rkcanfd_chip_start() {
> ...
> 	priv->reg_mode_default =3D reg |
> 		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
> 		RKCANFD_REG_MODE_AUTO_RETX_MODE |
> 		RKCANFD_REG_MODE_COVER_MODE |
> 		RKCANFD_REG_MODE_RXSTX_MODE |
> 		RKCANFD_REG_MODE_WORK_MODE;
> ...
> }
>
> Without RKCANFD_REG_MODE_TXORDER_MODE to enforce strict FIFO order,
> could the controller arbitrate pending TX buffers based on CAN ID
> priority instead?

Bad Bot! Read the data sheet, don't hallucinate meaning of the bit based
on it's name. The name is copied from the data sheet, it switches
between little and big endian for the TX data.

Marc

> If a higher-priority frame is queued after a lower-priority frame when
> TXFIFO_DEPTH > 1, the hardware would send the higher-priority frame
> first.
>
> Since the self-reception handler (rkcanfd_rxstx_filter) assumes strict
> FIFO order and compares the received echo against the oldest pending
> TX frame, would this out-of-order transmission fail the comparison?
> This seems like it would leave tx_tail unadvanced and eventually stall
> the TX queue permanently.

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--inw735pmpylshlmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamxBfgAKCRDMOmT6rpmt
0kmtAP9m4GTnpbyDL68PPZUob0eqOnqpP2OU6hpgPvI+963PSAEAsMEPb/yjA2FD
Gi/dyScehn7rhzbjXZWvkfSjQxb0gwk=
=5qdN
-----END PGP SIGNATURE-----

--inw735pmpylshlmb--
