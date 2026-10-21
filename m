Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600215;
	b=y9MbtqWhYD8/RmzCoZgpw40YTu6DE80vWz3XF8yHWAJe3ooi22aztFb67Xg2mqhvp6aI
	 zVKelj8xoY8hiyw62D09OWHv2SW/kZP2OmlqZeCi27BhrEo/tIv7cOdF7AlZgXQ1Q5Qeh
	 bxBv6hjdUWqID1rWo18GNk2bbBw0c2b1BPP6umzniydhybcx/sMpFU2ERVoHeQVqua+Av
	 7h4ugRUw4yeq4qXkCAEnqv0XBy2Prjt8l5EDp6yxwDOFsQUBLnckmHmM+Gb4IFORMgc8r
	 Gdgb5z8Osjj0VWfxE+OoLh5dQCtL78BRPMgl3nTR9jic44Vh3j/vGPDFrFaR/BUMWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600215;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Sq1GMRHQ/TLvlwjyyTPVb8IVgJu2rafyM/d39zbVB0U=;
	b=1Mk0HM+JKQlNBBSZ+nkI+BtGsZGE0Brvr7HhmiJ/7tbvYRjW7cKH/VInZMDgQRbOT+3s
	 DjpF51cLjV1I+9Hqq83GGTn8qlga6neYsKw2pG0fZ+17DWX+q2cCgVPHH7+5EWH4CBpfv
	 LR61sYnpC937KbghbnPyrh+rPydPqBs/JY9utvMdvmtKMctwOeM76/t02+JWgDuA6cGQ6
	 eHH4jSKpQPNZnrcQuPx2mhCUiTt5ckS2bclL18+0ePKWoBuTKc7f1erXa4ggfCta+hnm4
	 /bBtn1+URkw86Ax27bQW1qdz8TmwrSdEXoOd7D365BQbFRi2k+7dxizLH35liGrUgGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHpX6OzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F585606A31B;
	Wed, 21 Oct 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHpX6OzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038CA1F000C2;
	Wed, 21 Oct 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600214;
	bh=Sq1GMRHQ/TLvlwjyyTPVb8IVgJu2rafyM/d39zbVB0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OHpX6OzBNu82w+azgJNdcST5K7cXo1Va2OKFluwdybTQ2V1N2sPO47wg+wkBhuaLM
	 hq0jihigoQodw+2nTOw7Eb0IBATR60XLHhvaXd6CopDreeKbgUTDBtBQ/gfYm1AtvM
	 mD7WOnb726W86UBufZKZOB5E5ZUu0oNZyZFRdtbcwkMoLRG7WfFmKNmkU6Z/Fi+/HS
	 hP7y81l6UxjwGrGDUfCr1lptSwt02zAv+zHOf1MNTEdJHyzCmR/X3TrMGfZlJ7dlyK
	 4tTfbuLyT4DYb0hPpgHMgOcl6PprfljjXJaEftgnOQ6oLPlyZBYCPhiYrXKfl3/qcj
	 FWi0+Yh+idklA==
Date: Wed, 21 Oct 2026 17:30:10 +0100
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
Subject: Re: [PATCH v6 3/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Message-ID: <20261021-uneasy-tactless-3c9969a68fcc@spud>
References: <20261021-canfd_rzg3l-v6-0-b4abfdba8e70@bp.renesas.com>
 <20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.renesas.com>
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
	protocol="application/pgp-signature"; boundary="Z3QL3jXAbMGZMSEI"
Content-Disposition: inline
In-Reply-To: <20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.renesas.com>

--Z3QL3jXAbMGZMSEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Z3QL3jXAbMGZMSEI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatjokQAKCRB4tDGHoIJi
0oUOAQDznDmqSk17mN8OijXoHA9LeSJDLTbGjpLf530JLOaCsQD+PtMz37NZ0aeh
KXTjX1/lDaxJCnJ6ZL5i1JeYkAwc3g0=
=cwTD
-----END PGP SIGNATURE-----

--Z3QL3jXAbMGZMSEI--
