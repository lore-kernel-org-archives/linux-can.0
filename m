Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA614B3846;
	Mon, 31 Aug 2026 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191938; cv=none; b=tmN01uoohvqEtBaFHtjMWPWQ4FU3Koi6MnM8AzU5+9+czFDHRqeYKVErbA4dL6hkaTwzh+3WgNrYZIocB9cJg5/eWLIeqYaxO14A3aOOhE0v7jkwSgpw05nBCFTn4CHPTlcdeOvYoFBYeiuBh1/oFIw8r9WnG6RCVPrMdFsHlVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191938; c=relaxed/simple;
	bh=P0/EzNc24k0FPGXZh2wP6bXyySaUTKcUDkG6YVIgpCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9ai3grs4ybbLy3Zb2uX0uTxbEudlN9go/iBQS756xp+MMzqkDezq1Mb/OoJKoJfaiuLicxUHBogy4dbL0wilPPByijPKDAfcxILX/TlksVeVu+xCMg2aCdO0O0LEZb6SE+eUVdKGJQchXm4N2urn2D4cIaxZGWQu5M1TR2dYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd7MM/zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd7MM/zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9951F000E9;
	Mon, 31 Aug 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788191936;
	bh=P0/EzNc24k0FPGXZh2wP6bXyySaUTKcUDkG6YVIgpCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cd7MM/zQYveHyQqVYKUktY3J1MVyV3Iyn3XX6lJojgiiQtQjvDoPgL9SZGe5Kk/bZ
	 V9huyylDsXMyAltIRzSgwoHHHvNfo12lnzTB4nu2bqCuOgadviQUQQARyvqKTg7xOC
	 xFutPuMGQba8pLyuxKoYhnLanXhG7mffI77HKiEy/GM30PzDuvehol1Y68dUsm/KsQ
	 fn60gFmjLuvLr5TmLViuQQqmQG96VxqZz7C8fC2DSBcDNxRx1UNXIwKVF1coG418JJ
	 rf8QGlkjYVOZ0XgNVYHK1CV30RtDXkwuLyXdhiLjYGj3n53sWz3X1pEqUiuxuXWIs5
	 c9UDksM2gIp6A==
Date: Mon, 31 Aug 2026 16:58:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: fsl: Add chargebyte Charge
 Control Y
Message-ID: <20260831-dowry-exclusion-fbe150f9492e@spud>
References: <20260831083539.8287-1-wahrenst@gmx.net>
 <20260831083539.8287-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2RoMLv77VPgiR655"
Content-Disposition: inline
In-Reply-To: <20260831083539.8287-2-wahrenst@gmx.net>

--2RoMLv77VPgiR655
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--2RoMLv77VPgiR655
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWkugAKCRB4tDGHoIJi
0uPHAQCrUnKkXv7duRq+Ukt/YSX6sDem3/+5IwjpAAV+lOf+YwEAm8PQWdIEaMHw
ka2QFhvf28afPnyTjj9WTv+mIlHI4gU=
=axxB
-----END PGP SIGNATURE-----

--2RoMLv77VPgiR655--
