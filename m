Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84984347BD7;
	Thu, 30 Jul 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420826; cv=none; b=lwX9q8FCXh0wUHuL9AIgXkR0q/2E5RE4+l3SoOx75E+nAYrR774S7VDmAknVkXPbh7X/FThMKwegZznW6fTqBvKYqBbpQxgxG8nAq4AQkhX0hMMuaX1UNeYPYBa19iyr2bDhw0y7Thvfus48WrGXKnVAXDJDy7nPjm0ZEi2QJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420826; c=relaxed/simple;
	bh=Qt5v5eScGugBAy2bTkCt0TKGFCRXeunBCxBRNs9a/2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL+OOLZ4yvTUOkehA5NuC1Qybdn61QhevaSgA6gh5HUGThNz4WUHbm6g61YDA9g0S4kjGzc2+FUxwXrfvPECMGfFNNYew14RXw9IcJTpTFtW6mD7zPCPkONUSalcJfny4sTtpFZKfPNCssGX8NA7vG4EPR1hicfUtb1X+7GnjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DAD15202C77;
	Thu, 30 Jul 2026 16:13:37 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpRVx-0023ms-2a;
	Thu, 30 Jul 2026 16:13:37 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7902357706C;
	Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
Date: Thu, 30 Jul 2026 16:13:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
	kernel <kernel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	linux-can <linux-can@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip <linux-rockchip@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v5 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Message-ID: <20260730-defiant-mahogany-cow-60152b-mkl@pengutronix.de>
References: <tencent_BE229ADF4693078DBBCC6C02CC0855C01E06@qq.com>
 <2b7519cc-9e22-45de-940e-2996c2423de5@cherry.de>
 <tencent_415F4BD31A0D950C4202CC08424010A28106@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="acta2h3uc54gwlp3"
Content-Disposition: inline
In-Reply-To: <tencent_415F4BD31A0D950C4202CC08424010A28106@qq.com>


--acta2h3uc54gwlp3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
MIME-Version: 1.0

On 30.07.2026 22:03:15, Cunhao Lu wrote:
> Hi Quentin,
>
> > Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Jaguar
> >
> > where we have all three CAN controllers accessible (two via an adapter
> > board). See
> > https://lore.kernel.org/linux-rockchip/20260730-jaguar-can-v1-0-9b566bd=
785da@cherry.de/
> > for more info and the test setup.
>
> Thank you for testing all three CAN controllers on the RK3588 Jaguar.
>
> I will add your Tested-by tag to patch 3. I am preparing v6 now and will
> post it shortly with this update included.

Please put your S-o-b last.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--acta2h3uc54gwlp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamtcDgAKCRDMOmT6rpmt
0p1sAPUY4G1w3X2EqPgOZ9cXCnSglJTueBasAi2owfSEAwLgAQCzRXSnS1tT/dKq
jVnAyxj9YeLicq7OPQLH1eAL4l9VAA==
=/TNY
-----END PGP SIGNATURE-----

--acta2h3uc54gwlp3--
