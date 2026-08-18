Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CC30B517;
	Tue, 18 Aug 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045189; cv=none; b=a2fdzBSqL67mkNWVwep+kCxXEX2nrAUDJ/AQWi9y5dJu4hg3EFm0UsZasgOz04oj1lKmpHBLSFUY6C8ET46YbQg5Jey96MAOAo+Z+SmQuFIHp2s6RcQWEqBt0emgm8sD9j/xWK/vAwU7epU/DWhsb7gCmVBS71Dr2u6rMRVUCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045189; c=relaxed/simple;
	bh=ZgxiCIjVkREjWSYTy6XYBaGacgOUySLiTR833/Rbh0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWxNTFoKn7GvkOF491qzMRFRQMMXdclkXsWNVZMZxN1NuVzxIIIFF7TCaOWJiSNuJz4u5SkFMOEix+e6fENWpplhMv3qKnaLquOIMCWnFonEh+XhvgBQ1FcLYQUCFLebwWay/ysjwsyeQJUbm1wtDBig9jiGwd4j37H+YuCAsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8B3B72010D6;
	Tue, 18 Aug 2026 11:26:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwG5Q-0026Gf-1O;
	Tue, 18 Aug 2026 11:26:24 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1345F5856A3;
	Tue, 18 Aug 2026 09:26:24 +0000 (UTC)
Date: Tue, 18 Aug 2026 11:26:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Aswath Govindraju <a-govindraju@ti.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	Christoph Stoidner <c.stoidner@phytec.de>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 2/4] dt-bindings: phy: ti, tcan104x-can: Document
 Microchip MCP2542
Message-ID: <20260818-vivacious-dodo-of-piety-b0a59b-mkl@pengutronix.de>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6i7fq3cui44vk3ry"
Content-Disposition: inline
In-Reply-To: <20260818091701.6441-3-wahrenst@gmx.net>


--6i7fq3cui44vk3ry
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/4] dt-bindings: phy: ti, tcan104x-can: Document
 Microchip MCP2542
MIME-Version: 1.0

On 18.08.2026 11:16:59, Stefan Wahren wrote:
> The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1042.

If it's compatible with the TCAN1042, why don't you add it with the
ti,tcan1042 as required fallback?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6i7fq3cui44vk3ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoQlMQAKCRDMOmT6rpmt
0slMAP9l7TVeexZCcKdt+RpN+BZvAFifxtKNWE3G0YvngbwCpwD5ATMKyiyaGA6X
nIUiXcCBKPn+JgKvp8D/hjUI2hlOEQ4=
=emA7
-----END PGP SIGNATURE-----

--6i7fq3cui44vk3ry--
