Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600041;
	b=Lhlh+qhBbdw2uFs4P4NRbcT60CvTrqpXRCqYETbKdJvXCz5iMZOf67X3rnAAenD93Nqr
	 CxnQW2R/CL0rR40jOs3+2X3tG+wmNv0d0+YycEZSKIczq2SCYL95XD6eUcz4zlSzFU8HA
	 y0YkLvdMEB24iLTegIK9Xaezi2KN4jo0NsXYoiZckobqSd6OnQolGWMxrJWqPDyBYpEkR
	 iH73GxH/TyI+Upibzp2yA1h47IRD/wWkV6Kkbz83WXYbArLFq8R3tr2n2KKEzymZpV12Y
	 MVjx8GNqWToqy6AvxC/+lSUwHF+JuTGk5IP/CG4M+Dp2L1XMjD47NxNj/xmQj9JMA9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600041;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y/oVdg7vopgiY5vXtSGAsHRlIKLkmlS9xCpZPebK/j4=;
	b=tCns9k6P/izkmcFWIncIFAHkiDi6sRICsklB17MohYAWVJD8KzwuY1hDi1MpTsCVpeK5
	 N1tszdSWziAK/QUrT23G1S+fm4LKHJLvZMatM82tdS4ZJoENluUf3untq4zDU2Mcje50v
	 D5tf/e9nOJGQt4ENHgV22gh/EbhJqYJa8HYdYtR3NBDIC8KElQ7wueC9TOE2/jhoFaaRd
	 5i5baovO+32c81WR89jLeVQW/RCz9iB3OAtct/ql1IkZaWHMlmEmich+riv2WM/0MwP0i
	 EtA1UF/aLqe/K3WndW91qeT0WqJHF/HAILE7br4RXezzKxQOccBdYzoCeLevRtoNXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePFJmWzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A890606A319;
	Wed, 21 Oct 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePFJmWzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365371F000C1;
	Wed, 21 Oct 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600040;
	bh=Y/oVdg7vopgiY5vXtSGAsHRlIKLkmlS9xCpZPebK/j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ePFJmWzPyT8o0Ff/coMIPnRYJuca3H0O3OPFXPJzlkEqW9BkCCZgbOgeQB1OJ1gtb
	 AZfmXQN9+3734OhN60qPpeYubFe2j05pE+MJokxdFBYPgxIn9JFmuPbF0PAJ0TG31H
	 7Rikdu7qU6qDEFfHWHtc7XeYJxPeMS4xOXJeb2ObhQC45d0yVmHDqJUhrffpdPuKkD
	 i4gBbhwpXA3OQwnN9X5uI9sxIbqQkXYM7Lf9BKEE5osUO7lLOCbPluWogLpePVCHEX
	 X9lbIzt9gkmxvFIFwOI7Ti7gIM0JTtgYoKHx5IV4OOqexjmwzbdiVeonW5EJck4NFG
	 m05xx0/RzAuHA==
Date: Wed, 21 Oct 2026 17:27:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Biju Das <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: can: renesas,rcar-canfd: Simplify
 renesas,no-can-fd description
Message-ID: <20261021-starved-denture-d7d4df4d1e86@spud>
References: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
 <20261021-canfd_rzg3l-v6-1-b4abfdba8e70@bp.renesas.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U25fMsftRXBYR8jT"
Content-Disposition: inline
In-Reply-To: <20261021-canfd_rzg3l-v6-1-b4abfdba8e70@bp.renesas.com>

--U25fMsftRXBYR8jT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--U25fMsftRXBYR8jT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatjn4wAKCRB4tDGHoIJi
0pXGAQDdgzJ3NtkY+PX1nyesgxnPN9+f0U48anOEOooa5j7osgEA1toD4tH5rbPp
cBkKqbYi+tpghfaYl3fsKgtI1trQuQg=
=0gl/
-----END PGP SIGNATURE-----

--U25fMsftRXBYR8jT--
