Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795164046;
	b=YqpYCoGLab8jFRyaacG4/xRw2koeAa3HTo1g+QaJHySoM2o4vLwpuzwBmbA5VEHtapkc
	 +NJY2uag/N5YxAmBWZpxMKXjugtpLyOMjB+TwxfY1JIH3kde1K3Dttp9fKnurmuMvEokI
	 o/ZAGV/+EW+ZCQRK64CbdB+srv0NTrFW0l839lJXHbmC/f9WQt53s77jon5pPj9Rl7PdY
	 YhLr04vnaWIJv5fsKaS2bDDWc+L+ks400G7+KqbMISdH5nPFkqu66JjSEZjzdHkB0RBuB
	 TJHjzGTFvrjLYR4U8qdf7iDOd7jnvUGGKtOKoTCezAHoo+JLZ4XSK69aA9NJbFI9/ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164046;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=G7/+dGXKwxvm7pBwkPBiroDwyoNH1aExmeBxownU6dw=;
	b=Rxs/yJ8NfKfl1iSfogSevatudiKFpJiX5MXD/cDYvrLxh4wtTJTjpqs75NB+Iv2LuPzu
	 BgAJTec0Dhv0UhDOmHIERUapZaqxg4hMft24H9Sry1MBc7qkeNBQZgl60fEPJbx+If26+
	 tdXyyUnB81Fw5+vHIh5FB3zP2UFc6xpiedwYH+jYkzlARmtRK7qvQDxvXn6LuksdQyka7
	 ao24QfiMAc70GPNnHtnApzvrUkkv+o/7xuERoJtFW42X6VUaflPtddi6sxB6jYVuhFxf/
	 K6vrL2EeG2td7JTjIQr74Tn/pgUq7fHY2TDOUVG5URhZK29l2sV7p9Wt9eZsS+hOPmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=M2IAcv3I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82C606A320;
	Fri, 20 Nov 2026 08:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B82C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=M2IAcv3I
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 51464200EDB;
	Fri, 20 Nov 2026 09:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795164043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7/+dGXKwxvm7pBwkPBiroDwyoNH1aExmeBxownU6dw=;
	b=M2IAcv3IpuDfrtikPy85aXva05WT/WH2l4cmpvqo773VNtLObicj2+no9WFrOOqRFTu9Hu
	ne/uqyFj0oYO7GH3wgpz7ekNcWa6p5aZR1s27/CxhYrOTITEcNnIFV5PEEY96xPaVTfzEo
	n/XkHJqw86s6wO3M7MVtaMDaQAOwOlu/W+F5NqXG29WR/2+eWNFlBzUBSrJzYXptMpLOIY
	H9FVeASwGsGWfOXJtSM89ZSePf+9BRKGvA59So4sCHXR+z/Rf6LfYHfRXofRGEWnh+LcA7
	/0G2Y52rXpGi7lpMxNDLhgXGzMcPzqJXkUV9uv1oZH0S1XyZODiRLRKaUJTE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795164043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7/+dGXKwxvm7pBwkPBiroDwyoNH1aExmeBxownU6dw=;
	b=BbAeXrs/KuMdUGU1d4FDIY08+wqouL0AbfAPie3JfzGkD9lpRY6epTg98KYpbce3N4dzRf
	+BV3Lk32Mu/JDEZsu2Tqo0C+4d0Tu1EqHyK34ml8Sx04N29Hy6ej/CtB+7ydUDyZI9t1po
	RfqTG7GgfMLXTbljqTtZqvcSITM0DENXZV79zPYh4ommnXro0CRKFNN8U266XmhPKidYzH
	y0DhyWm6dD55a/OQvQwDQzw+2+LGZ4nkQAastY6Pm3f7cJOr70EMWAAyfpPSrRTKFO97dt
	9bfjVVu4ErU8WN2TRDZ21UjjspBh89T2np3BpckTtZnypeqz4oMVArw3oJusHQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795164043; a=rsa-sha256;
	cv=none;
	b=K6jKO5GhZrnSpLLluIb2ZGgb1vR5o050DKauUlziUFm7+q+HsL84pOstb564awBMmx8q9J
	4s329jeeTGlifXizLE5MaTcdjOhg2GuqdJ5INm0EJbXzML3JSuDtOf3Kwrc5Bo5lH281eL
	TW7tfr3ITkxeMBj6KIKOzwOdGDJiY4r7A+PTbANlaM+yYnl8b7zXS3M/I0FFl+kgVDy562
	iFPXJQVacKOnkIIb8RtHzkzYddM/NFGSqqSjf7d06nuSZ80Hptu5eRM+J7D1bwTS0XQv/e
	WGcqmxy52bnlX25Rokh2UQesEGD9bOY2yx7GAzZ+lKTK0nz6ZYX9GKBpUfukVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Fri, 20 Nov 2026 09:40:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zelong dong <zelong.dong@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 0/3] can: amlogic: add support for Amlogic A9 CAN-FD
 controller
Message-ID: <20261120-axiomatic-foamy-bull-1684b6-mkl@pengutronix.de>
References: <20261120080820.3340646-1-zelong.dong@amlogic.com>
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
	protocol="application/pgp-signature"; boundary="ykqib6zwogi4cpur"
Content-Disposition: inline
In-Reply-To: <20261120080820.3340646-1-zelong.dong@amlogic.com>


--ykqib6zwogi4cpur
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] can: amlogic: add support for Amlogic A9 CAN-FD
 controller
MIME-Version: 1.0

On 20.11.2026 16:08:17, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
>
> This series adds support for the CAN-FD controller found on the
> Amlogic A9 SoC family.
>
> The controller supports classic CAN and CAN-FD. The
> driver uses the generic RX offload infrastructure with hardware
> timestamps, reports bus errors through the CAN berr counter, and
> implements suspend/resume support.

Please base your driver on current net-next/main.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ykqib6zwogi4cpur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawAHiAAKCRDMOmT6rpmt
0hXwAP4zJqk4wGxBgVH4cMhr3pYMTQuYMY2xDeJZLBZfXu1yAAD9GPkpGaY5WQTS
IB5FYNdxEh/e3sY5WcLMgvSFudZ62gE=
=yGhO
-----END PGP SIGNATURE-----

--ykqib6zwogi4cpur--
