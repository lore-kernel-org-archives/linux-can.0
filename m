Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907E4B384E;
	Mon, 31 Aug 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191951; cv=none; b=up/IBREBHRG3aDqFNoOr8BYZ2CHUJgTgWrCsyFOu25rFG8Z7qLvtu8FBSZOflt0o2yJhcsR27Nkd1vxF7Ha/dk25sqEsIHO3oQ3okeu3uhd1xtSF5aOmKFqDhGyM3kzFfCMY56XsvnkLs5SC19UpSsnO+nAI5m0xmiLffWayEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191951; c=relaxed/simple;
	bh=t+8HoUkz9G82V4jQ+DaIiv9d3bOgj4uA+TE0NgshO+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb3PaHwmc5q+Y507sg81jJdi07b21bCC9FdL57XGPMhsLbAcz38ve9TI1PXTRqtn7cnYYd/9TF7DcyuPV3/kIdmRtD3uYU1jxFEj0Z2VtskfFlfW03/lmTkhmLj4j76xCUIDL8xvhvC6M4cWYAIr7wjZE1t+07tVM7HqBL0aeaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAJorh9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAJorh9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1696C1F000E9;
	Mon, 31 Aug 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788191950;
	bh=t+8HoUkz9G82V4jQ+DaIiv9d3bOgj4uA+TE0NgshO+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jAJorh9JGk4NHESZaqmEpvsdsZsNnOeQiWO1260ZH/bSld6JqKT84OndNcTD/2qSR
	 90vnK9KHzQliV7MuQZ9VQ2DRGV40rnL2HNg7fiqGXX6GP4+TtJ0dmNBOLOX6xN+kW+
	 6EQQup4U3mY7tdgqRF3P/Pj20UJyqicmGH0RSzzewJnLAemOixc3lAtYUvvnvyfYS1
	 HW4nVxxkZDGVrYZa3Q19M9x5jCOL5qEdsmIX69lT6+VLIqulWFYHnUB6rPzVPnGeIR
	 EfjALFrOq7VFdez/wmtGRhVPetQEppnDztzalI4oXg4DrejdLZvC1oqo8svk7Mxe0j
	 3umilPcWaz3pQ==
Date: Mon, 31 Aug 2026 16:59:05 +0100
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
Subject: Re: [PATCH V2 2/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2542
Message-ID: <20260831-antsy-overvalue-1c0ec9958150@spud>
References: <20260831083539.8287-1-wahrenst@gmx.net>
 <20260831083539.8287-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zyheSK6oF5LRCWm2"
Content-Disposition: inline
In-Reply-To: <20260831083539.8287-3-wahrenst@gmx.net>

--zyheSK6oF5LRCWm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--zyheSK6oF5LRCWm2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWkyQAKCRB4tDGHoIJi
0r4aAQC9EDu/AQSzbOQ9QTh4vH6D6b45raCehSLJh7D7pXfgZAD/WqlyiRPXSwfD
c4NBif2qSlu3akulOaZWRf8K1l2J4g4=
=/REW
-----END PGP SIGNATURE-----

--zyheSK6oF5LRCWm2--
