Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE238DC5E;
	Thu, 30 Jul 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414876; cv=none; b=X0MfSL//XWsnX3vWJtx+YlW+ZbWnjqeGRCLmTJdHCD/OMpt4dR0oNwPXoaQto6gZbOSi6VaY0d43KkPKzAsZOCh6/ySsRas/8SlklPQBGy0q7vIaP+VScLgOw4iepKMn24zt2+KxGJWiF42JLHPGP1LSDzGTGg/1QHiijbCi2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414876; c=relaxed/simple;
	bh=RFrp0RayYwYqGCQBvirrb0HTb8/I5e+z34dfu08+4Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZB0JZ2ZgLbDp4JC/jYCtws/avIfMey93dUY8EU7Thu3Ocx/tdSwzNgvoQOUsdulXJhtIgyiUqUY4aElKtgSJKl+HKSLd/xbRhIGpOzwuxjEC72LAlxZsDJJyrsRbzAhrsXq84NEMIP5F9MJPyEJNE7vjGOxkZ2C8oSHZOa7i8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 256F52028A8;
	Thu, 30 Jul 2026 14:34:30 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpPy2-00232R-07;
	Thu, 30 Jul 2026 14:34:30 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C48E5576F25;
	Thu, 30 Jul 2026 12:34:29 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:34:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "mailhol@kernel.org" <mailhol@kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: flexcan: honor Device Tree alias for CAN netdev
 index
Message-ID: <20260730-black-rat-of-tempest-408383-mkl@pengutronix.de>
References: <PR3P250MB0308352F7BC03C6D0AC7E7E6A9C92@PR3P250MB0308.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ph4iustrdthgx54c"
Content-Disposition: inline
In-Reply-To: <PR3P250MB0308352F7BC03C6D0AC7E7E6A9C92@PR3P250MB0308.EURP250.PROD.OUTLOOK.COM>


--ph4iustrdthgx54c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: honor Device Tree alias for CAN netdev
 index
MIME-Version: 1.0

On 30.07.2026 14:24:16, Michel Alex wrote:
> The FlexCAN driver currently relies on dynamic netdev numbering when
> registering CAN interfaces. This makes board-level name assignment
> difficult when users want stable or swapped interface names (for example,
> mapping physical CAN1 to can0 and CAN0 to can1).
>
> Read the DT alias ID with of_alias_get_id(np, "can") during probe and,
> when present, pre-set the netdev name to can%d before
> register_candev(). This lets the existing Linux alias mechanism drive
> the final interface name.
>
> With this change, systems can control naming from DT aliases, while
> keeping existing behavior unchanged when no CAN alias is provided.

NAK, please use udev/systemd/... to give networking devices stables names.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ph4iustrdthgx54c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamtE0wAKCRDMOmT6rpmt
0m6VAPoDOxPQYxt1IPpOtFea13IpYnLmMUQ0q6pIQRNmQx7sVgD9Hs5sr8Pc/gmR
mBaoIw9aNaQ3pMqq0QunXsYX6n/BgwQ=
=+8Ll
-----END PGP SIGNATURE-----

--ph4iustrdthgx54c--
