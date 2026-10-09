Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566337E2E9;
	Fri,  9 Oct 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548617; cv=pass; b=IgAToC4TOFSiqTcOjHY0g+pAh1akU5Sa9LdBd+9AqgG2x/go7ueiU/JEat+esI++KXL66tCGbEJ7BiOF9ycHG7v8rjtQ5P9AP/ZfQ44k7nAyOP6qcmOXNb7X2+/OBBmsw/XX5AnYWWSORTxU6RJtykdUCroKnTp9410Jju3yq0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548617; c=relaxed/simple;
	bh=bDjswRz2nKNZEO15TWlHQ2LQc2x4BOd4bIxtqUgNqWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql+s8Ng8rbSs1oPlfw6QoGxMdqnoOITPV3DSQU5gdWDAgoOndDFXmQ80M2fcr9LMijWsDBSc0AuzPljxj+ZR0Q4Aqs4gHnIr4ZP53BsG8cT+FtuyokxdNgvNsBc23OotzUYs9/HToEMsCC9i24lGbsS/85o8jkrkGr/R88SVX48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cQWk8JMO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cQWk8JMO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E3B9A202342;
	Fri, 09 Oct 2026 14:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJFlkRJZ93HR5PSvJ5lzD+Fgi1OrHX7JBTtx7M9wPWs=;
	b=cQWk8JMO2YDk0rjRcgLB2H86KNKaswTIGSvTajLEYNw3WFkWQNfPBS6ik0IzfWqnO1LNzR
	roiyq23LH2UpdXn+jnkCyoyw6J8iLL4G4bdgRUWmiS3x6oRKAE1mYGZi6qZpgpSlrgw7wP
	ZTskseTf51v9QDn/lZCSR6bV0l1G8GKFkXb5IQ0RiIhwxcK+vvzSiBTSqK1V7fHDwRbrin
	8wyHt6Jrg/L8q3RCGFXPaeYxBvkM22Zi59NsIBY8JR82e+b68DExJFZwQxFUs5zdriBIcS
	1HaRmwG0nPbXkx5zGw8Q+BOtGCcS6o5m2hJUmWKGMOw+0Rv/LUDkzsUsoRIdGw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791548610; a=rsa-sha256;
	cv=none;
	b=IhAwq4oMN38sDId5oupwkri7G+6MGT6f7YiwWzKji6k7TYOeUerfmowGhGeOu0u1QS6Kri
	Hz1S32wqQtVrWp3mYESbyKs3XnmVoULbbco6vUZ9urL3p/r65jCkbCQx65uYskMLEdJ+mH
	jSK18/zR10or2kInLmVSZG5QhEYo4i+nR9xJJtLW0SZYnudZbgooqJ24qLJhXRZsCvwjVz
	Y1uhjy0Cx7tGGaDIe95Cp+gmnTx+3u+YixfnnrJkkB4UmFDLb8AqbKOA/bcRQrOSGCZNgL
	HKxGPhRhZGGauF8EzAsfXaub08znJH7FXMkFPk7NKaf238qQjGOTsdc7Yp8HYg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJFlkRJZ93HR5PSvJ5lzD+Fgi1OrHX7JBTtx7M9wPWs=;
	b=I8EbBTfQ84KLIA7dKxphNv/PAAZeBhfZDkRHwVyKm/1BTaYXvxh3UYu1URw3cjDuu5TH7C
	zVvWqeBWlHU2Kgkt0uNDLG/qz0IZX/3aiz/Wc15arwyxqr8rtnxvExB1LpJPeP60jFTyCX
	rw4GGByPAAwAKBpjKzy+CsEQFhN3DmcMlHo/0DmPzfiMx93izRO+OpFPhtqtjyitW136EC
	nAgP5S8EoF+I96f8SWCT/KqM7Mbx5/nEurBe9nwln8bEgwL/RkmvQPDysQlsugcK9g+5eJ
	vavGr71kA6ZWKH3lSRel0XJZoVvBKQyP/GgK7CnuY7MEoWIoqwsnzmrOzJqNMQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9dK-0052mJ-2g;
	Fri, 09 Oct 2026 14:23:30 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 404C95BD767;
	Fri, 09 Oct 2026 12:23:30 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:23:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in
 top-level
Message-ID: <20261009-holistic-warping-puffin-3b92fe-mkl@pengutronix.de>
References: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iisb6fhlj2ggl6pj"
Content-Disposition: inline
In-Reply-To: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>


--iisb6fhlj2ggl6pj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in
 top-level
MIME-Version: 1.0

On 01.10.2026 08:08:26, Krzysztof Kozlowski wrote:
> Properties varying per variant of the device should still have the
> broadest constraints set in the top level, so add such for the "resets".
> Since top-level part says "reset-names" cannot accept one item, disallow
> it for the two variants which do not use it in practice.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iisb6fhlj2ggl6pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjcvwAKCRDMOmT6rpmt
0pG1APwPttD1RcoVGSyWM1sNX7bucXyxzpxQdlZFDug/BFTkIwEAv11b5f8V9HEj
FQAl1XBOu9750fpX58+T0JO/xaWgfgQ=
=LcM7
-----END PGP SIGNATURE-----

--iisb6fhlj2ggl6pj--
