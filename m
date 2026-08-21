Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B237BE71;
	Fri, 21 Aug 2026 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330731; cv=none; b=XZcx/wdqGxpG99iurAjNV4sWQZNK+WvcR8Gud3vRv2zxl6Niw8LyFcalrX6s+L7FHoetL9FII/NW6GB/0TuwYEIhH79ocqSAZa5cz2nrrVI6RPxO9xVjTjnK6Jyta6kjIoN3yQK9aIFavCGgQos//w8QN8DtBdwsfuHZUt7QMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330731; c=relaxed/simple;
	bh=OQZ6NvUfK7Ub1DNbEn2GFSp8Ke8ANc2BlrTsOuuKBu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkjxo+GLhNBUcAstQEQk2CscBhx9vQC2Onn+Bkz6WfTHS3Z+Ezw9NLFA505XonbXYzemtHXyqCJenBEEg/TZ8bzrEp4Lr4eiWYp/JnjPt4XpzENVkL11HfU7YutvNUwcataVhubGhxrCiLjuT/z4f/HBcCg+sQ98JicVcLUHoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGAlahPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGAlahPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C0F1F00ADB;
	Fri, 21 Aug 2026 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787330727;
	bh=6CUhItp/kUpcDUQo6B+Jp1Sj+y5MGfT77waR4zZurLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TGAlahPrn85I378qSTdZQAw4+mQ29XfipBOLBx+Vwf89gCct/Nygcy0m4JKQeC0G8
	 qVmuVWadL0aL7LIeKagdAKV3VPD4imQKTVpbgR8wGi+1ZHuVr735fJ0rEL2d5IMRqE
	 r0R3MfqtuO4D0CD+RhlPyb2P/Yv5+ZZgup9VQ5LVZ38+vrMtiYbLbtYCrQSSJPNlq8
	 L3wJw8O68tSEFk/V814EtiH6GSGdGSDgxrUfs+5yUBAPG6ptbZfFnLz4rqFPlCP6dH
	 Ze2NCIGJJon/h0wW8NuoJXYS6kDHB6evbU0HGTPcCVJb+u89gfm50ceMxJc5y583iJ
	 T2h/Kr1RK6XNg==
Date: Fri, 21 Aug 2026 17:45:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com,
	vishalm@ti.com, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Message-ID: <20260821-regulate-recharger-2e984e9591ef@spud>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MU+/7W0WN0xdu7PV"
Content-Disposition: inline
In-Reply-To: <20260821-temp-v3-1-9ac1f8806929@ti.com>

--MU+/7W0WN0xdu7PV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> Add the out-band-wakeup property as a possible property. The property
> indicates that the device can wakeup the system even when its power
> domain is off.
>=20
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b=
/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6ad01=
520a4dfea294d0c 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -150,6 +150,8 @@ properties:
>      description:
>        List of phandles to system idle states in which mcan can wakeup th=
e system.
> =20
> +  out-band-wakeup: true

Where is "-wakeup" defined genericly, or out-band-wakeup defined that
you're getting the property definition from?

> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.34.1
>=20

--MU+/7W0WN0xdu7PV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoiAogAKCRB4tDGHoIJi
0pQdAP0WMgmRD+2ASbLmf+lRKTuvZQZuDJsXz86JWLl22vfCTwEA7zCgFqxNHLz1
RA41m088LSNgS/YFzyE/510YEVg1EgA=
=yjJK
-----END PGP SIGNATURE-----

--MU+/7W0WN0xdu7PV--
