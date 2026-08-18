Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C0447807;
	Tue, 18 Aug 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045262; cv=none; b=B42gNkG1wxYJr5dj+ZygLAx3NWYK/BK5EIVN3S/ECTi7xNcZ3sUE+3xwFOisC0jRCBcJn/6NDnC+kOBogKOqnCoQ5p9C9FFRdE7/vxBsqvlkS1eeRvrTXBRv2qCIMxgqAeierQzuN67HVeAuqU3Ho9aNJ4iPDSlm+5Ac7EscA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045262; c=relaxed/simple;
	bh=hsOQC4Q1/r4WoaGNiYkDWZY1RVdWmGnmDWpP96qDmE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ1W0c4ksbqQGu91nr83h5NQM5bGNEkslujJevNsv2gcQMUEZZ6vom5j+pR1CQzGxHLN+6MJ7F2Ar6Vg04MvTVRdj/B+rt4snyAaAapKg5FKOcHrAIwQpx8iIlQxJCI4CIzbozioOkngpbnSX2+5hOHx9Qi1IczyWoP0hEL5FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 27ABA20102E;
	Tue, 18 Aug 2026 11:27:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwG6d-0026HA-0C;
	Tue, 18 Aug 2026 11:27:39 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BE1F05856B0;
	Tue, 18 Aug 2026 09:27:38 +0000 (UTC)
Date: Tue, 18 Aug 2026 11:27:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Aswath Govindraju <a-govindraju@ti.com>, Christoph Stoidner <c.stoidner@phytec.de>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 3/4] phy: phy-can-transceiver: Add support for
 Microchip MCP2542
Message-ID: <20260818-ecstatic-dramatic-seriema-a47a03-mkl@pengutronix.de>
References: <20260818091701.6441-1-wahrenst@gmx.net>
 <20260818091701.6441-4-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhkvwj7aw6aqqwwz"
Content-Disposition: inline
In-Reply-To: <20260818091701.6441-4-wahrenst@gmx.net>


--vhkvwj7aw6aqqwwz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 3/4] phy: phy-can-transceiver: Add support for
 Microchip MCP2542
MIME-Version: 1.0

On 18.08.2026 11:17:00, Stefan Wahren wrote:
> The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1042.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Not needed, if the binding requires "ti,tcan1042" as fallback.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vhkvwj7aw6aqqwwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoQliAAKCRDMOmT6rpmt
0s6SAP9y/ZhB2uWlfb1xwXd3OrPUFqZ9apBkJg0zY+7wsWRdnAEA5eLe8dAjkqeK
qejdqTHiVpbeJ0q8tsDvDFVyIV/5Sgo=
=pNvf
-----END PGP SIGNATURE-----

--vhkvwj7aw6aqqwwz--
