Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2334CDDEB;
	Tue, 29 Sep 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691849; cv=pass; b=JJ8Junsn8LErCMcdi6Q6TtyU4nHE0lIq5fJ3ubfzl+rRsglhRoMaWJ6vw8UEuxAdMMZHKZWCNYeB89ZUSQWtpa5f5l7e5ZsFnMo3YK5E71DXCdwclSwvrfluj6Tt/MyxIRjyFYfPKJMJfCJudyT/ScKeqFWn/Z757pD/NCSZiTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691849; c=relaxed/simple;
	bh=/gz8p++0rDsFYfBQB6Zkbd58nMP8ob1MYF0FDnA1Po4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0vJbbn+3qxvRTlUQgwLsEmD4EHqSqxtLjVYs5IaGYsv2Rk8iMpzvH2DM4U6FP6nISZUWqVFQfLiqe4Lx3qCcBQ0gjv8Jk9ZfbI13V651MqUmxvvQTJegXwNg0cgnnAmMpDFUoRzNOYabHr1jaExET71BI+gROZyf3HxLTjN/Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=eoQBYdiD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="eoQBYdiD"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DA8242007E1;
	Tue, 29 Sep 2026 16:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790691834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTXCD45VRQzTSaaL7wEDr5ldOWZD3NScPPdM8EDrDeU=;
	b=eoQBYdiDSJS/RmtbTiYhe3HZzungi4RZXbGC0XM5hT74FjyX7c707QT8p5CWGOU3GB1IzL
	O1moRRoV3cuM12FPHq28Pnwad3g2LX6faepGp+4yxDjj3QkqHUYHeb4UoDAzYIOW2O9Jjx
	PG/BQh96GUP+pYgVDVNg3mh4jZibSLSBnfwsV1BhGn+TSKuLWzGUNyc33OUhzzzcjJIma4
	XEYOv12lrD/q9UldYdGp3TMWwe2blNnktjGA6ppvybw5oTKKmDSxuSkZCCCSa0nIBXpoiu
	yPLFITu0TDU/SG41OP07X0hqcowUCCC5EEgpLr2FQX+gum9rowBNMbcIO1+6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790691834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTXCD45VRQzTSaaL7wEDr5ldOWZD3NScPPdM8EDrDeU=;
	b=W5YEzt1rMPIUtQ4BlGYJ8Ryjd2j6FRVZTJoNBqBvQ8d4+bdchXPCnSbyp4K579PyRqpZru
	5G72qfbyVQhRcWC2I3UMDhESpxINSj5ZjLhhgGmxnQSPo297hC/9uvbfuXZy+O5cm8yORV
	o3yJWp6cB2dMxPO+fM6RoS1pt78V7Cn2qWQ0JsbpJ89s8kNFTqKDgvzVJ1yV0U6TUPVRrY
	xUkskHtG6erwRSLl9T3C0waAdwKqoBXWEF9nUnl49Pz9JgkPXq2YYBWFkSIxBDUbA4M+Eo
	wG9qsXClAU2JCD7xj0Ogt/CtuLYUcnWh45bVEdY6L0ofSM1NlWHRR9XR8BjJ6w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790691834; a=rsa-sha256;
	cv=none;
	b=djqkeOHoh8lSG2iAmhF5pU1ra9IGfnsJKGpfAJ5Fu8gesAEx0mIiPI08twspoIoQTIutYT
	z0KUGclrfeE0SmwJ0MgDWsGHTK050Mi4XNmoqSd10f1t6Yy3UNupjGlmbKFNMTGbZWaVRt
	QKjWGIUYFBvqedOyKHiIa0RZpC2vthLXDK6bWCBoX+WCXl/8ul4q+sWuWizz22zjuUQO7m
	untQTPs64soHT2vEb209T7eFaefv5xFMqxRptvpdVp6wGwWFTw35NwtLBl5JYozu7aDJlr
	12qwpp4QTLmW/sWB+/Rq+QJEbknVomRRXFcAyM6Y3mERByBiUkQ3Y6hi6c4+cw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBYkM-003PGv-2Y;
	Tue, 29 Sep 2026 16:23:54 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 74BA55B4943;
	Tue, 29 Sep 2026 14:23:54 +0000 (UTC)
Date: Tue, 29 Sep 2026 16:23:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/3] Add support for Renesas RZ/G3L CANFD
Message-ID: <20260929-friendly-magic-grasshopper-1c11ac-mkl@pengutronix.de>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxsl5wb24kge4vdi"
Content-Disposition: inline
In-Reply-To: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>


--dxsl5wb24kge4vdi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/3] Add support for Renesas RZ/G3L CANFD
MIME-Version: 1.0

On 25.09.2026 09:21:27, Biju Das wrote:
> Add support for Renesas RZ/G3L CANFD.
> The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 channe=
ls
> and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 192
> buffers on RZ/G3S SoC.
>
> This patch series depend upon [1]
> [1] https://lore.kernel.org/all/20260902141544.565763-1-claudiu.beznea+re=
nesas@tuxon.dev/

Is the DT bindings update (#1/3) going through the Renesas tree?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dxsl5wb24kge4vdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarvJ9AAKCRDMOmT6rpmt
0iK9AP0W+lcVJnHJUCp0sdPV3nlTv2sH2cx6MMC4m4zruAK8DQD+JveywB+eCtwM
QiMEv7bY1Apw8MNmG4th8ZJY9B31pwM=
=gXnq
-----END PGP SIGNATURE-----

--dxsl5wb24kge4vdi--
