Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792738133;
	b=lpVhDk4cGqGoW+lLiLiK/OnAs3x6fmCNmqakTximvjex34PsV9d1Y2YqAUshJd5cHU1Y
	 V7d69vP8ysk1y2a6gMoyJQgjpyonJTFqCIV42WkciJadCyOak1WrZTqRFsCU9Tx0s2bFc
	 E1r/rZOUNFIdlylpnbfUl1NH3739jTUi0EFN6HWij9nKoB9hK3VwCpAtYqARZnY084kuj
	 6YYAsuynGY2S48J3RabCS661fVtyeyJwIgxHSXeXUGneBp2KCyIfesN4DdCJmz4LB6EGG
	 qfszgsrI23AchyNelIkpJs0xTQTK93EW1veS8yHPlt1sQuKG1TZf2mWrgB03WZFg9Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=u3kU7+i1NKyI1hY3A73N7hAbDsSzflqLglmlkB1dqYo=;
	b=E6Qr6Ae7Su+CHEHoWe0TcybVyIdinmNJcZSn1CgIQFOd3XMlIcGJhOGH5wnTEGF1gdBg
	 w8CvX6EGpPt/gwU+AVylAiDBwoph1BdNse3HsksMnbwZdQx9TEeXTlbFyJo5H8+PyeGVl
	 kTtaq6n+LVwpWZeVlWF04UTSY46Wu3UvvTnQvDP/TpV2Ehu7uHRLT2bqwND8gwjamKLhT
	 1PNCyE6ou1ScBMvKsU6Fobg+smtQVh99yotsklxGuh3yJCn/mg25HFBJEcMzO17eolbuA
	 6qnf7/n/ISExNFtP0fo0KppGmtvb40fKytS7VNYgVIEmD2ASYGAfghAG0jmeIJDSOHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZALF1L7g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FC606A31A;
	Fri, 23 Oct 2026 06:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF3FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ZALF1L7g
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 36394201BAC;
	Fri, 23 Oct 2026 08:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792738124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3kU7+i1NKyI1hY3A73N7hAbDsSzflqLglmlkB1dqYo=;
	b=ZALF1L7gxBFn0WT4FDUvjdCZ47hY0qdiQPvkDDScMnEU1AyqASxWv+7GSizE/C+Dv6nXY7
	1fNra1SoLVOdFEW4lq6LUJALuBdHm/fKTqEmyqeqUAYuuAhhQasmmcX/UCtXSC54Jtv2bv
	6nYu8odB38Tr/X+DKnUgzhHLH86lE+zD9V9VQh5grgaRBTeSwR/bT9Ly50GTTPLPJy99dv
	0q9Jx3/73+g7vR9ioSoXKNTHPHxhoZawBNgV06ZwwOpAK9JcitEFuKvk2HdMKEvpb0va3n
	KTokDFS2DmLtIW/ExD7+Uwkov7xBFbczAYp0s8XvC4YdCSfoGFjOoF/Cf+e2uw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792738124; a=rsa-sha256;
	cv=none;
	b=HJkjbVFiHLbbSqdXOGESasBeI7ncpHgLAk5lURtEo77fG2NAjxCnPKm/xUPLUwBwooy2Eh
	pNlFhuRSlsuhtbciKwEbP42EJyuy6817xku3++JAk+xJkSyuSSH0zkCnkWqfR8tPwdS1b6
	BOTZDukiocvIWBDLM2aC2Le/M+J3qU+E8mow/P+HzLJCrSNOcz7UPG4DhXsHmAFqknxtO5
	MjI7UJk1urgfBKUsQU7eckJaZH2/pPgokbwrIx3TWT8Sb0AyQ3POUF2qONsJl89x1TMLDY
	RTzHzIK0+tpDueJzOjXx+3IC6NjzTgX2+i+ZrmbEDD0TlBsOT2A7otxS/6I/Sw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792738124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3kU7+i1NKyI1hY3A73N7hAbDsSzflqLglmlkB1dqYo=;
	b=VYAD/nUJD+XVoOBBanYARl+mkdRjlXbcuNg+Z7GZgsHA0+Q+WhKpxM8pgdQRkDEsDUVys2
	2fy+4Hd/LkA0zXkuYrXdHH+V3QiCo9OuQ7sfsHTa+Zm0svSed1ALL3Px17H4rDUBcKAPTO
	ElGMotSwui9JG0AOkWThI2qZospMMxR4ZmRg8k3/AJJpDh3KTwUqbOZ1iwX88JYc45Rd3H
	82K6jKKB12nLBws3TRHs0kt9Or3onggZolXQKSoOFgi0wYF9Wut7A+PcCR5jmF6qOwiA2x
	qfQdYqqjBDeUKgyNswvlg4KxujsszhpPcgjlA0XWN5raDTD9tMDf3jaFDZSm2g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xK952-000oXk-0F;
	Fri, 23 Oct 2026 08:48:44 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:90a8:bcd0:249b:2b36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 896295D1896;
	Fri, 23 Oct 2026 06:48:43 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:48:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, gehariprasath@ti.com, rcsekar@samsung.com, 
	mailhol.vincent@wanadoo.fr, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, msp@baylibre.com
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
Message-ID: <20261023-classy-cuscus-of-coffee-ec348f-mkl@pengutronix.de>
References: <20260514065511.3573223-1-a-dutta@ti.com>
 <20260514-tiny-koel-of-order-65ade7-mkl@pengutronix.de>
 <9787fdc5-8a51-4567-a576-a3b9f4fcc59d@ti.com>
 <20261022-spiked-pigeon-from-mars-3f2786-mkl@pengutronix.de>
 <5cddfb8a-8ffa-4578-b2f1-3e57e82b2c95@ti.com>
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
	protocol="application/pgp-signature"; boundary="2bdtf3tea7rpjkrd"
Content-Disposition: inline
In-Reply-To: <5cddfb8a-8ffa-4578-b2f1-3e57e82b2c95@ti.com>


--2bdtf3tea7rpjkrd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: Implement workaround for errata i2278 and
 i2279
MIME-Version: 1.0

On 22.10.2026 20:33:52, Kumar, Udit wrote:
> I believe the Bosch errata document is subject to selective disclosure.

Sigh. The VDHL code of the m_can core leaked, but they still keep the
errata closed :/

> However, the most relevant public documentation I can provide is the
> Bosch user manual [0], which states: 'The Tx FIFO enables transmission
> of messages with the same Message ID from different Tx Buffers in the
> order these messages have been written to the Tx FIFO.'
>
> For our public disclosure, we have the TI SoC errata [1].
>
> Regardless, I believe a v2 is necessary.
> What would you suggest as the best path forward:
>
> Apply this errata to the TI SoC where public disclosure is already
> available?
> Or
> apply it to the MCAN IP used within that SoC?"

The original patch [1] Anurag Dutta modified code paths that are only
active for the peripheral case, i.e. the tcan4x5x SPI/CAN chip. The code
path for the referenced TI SoC stays unchanged.

[1] https://lore.kernel.org/all/20260514065511.3573223-1-a-dutta@ti.com/

> Do you know if TI's
> > tcan4x5x is affected by the erratum?
>
> I am checking internally within TI.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2bdtf3tea7rpjkrd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatsDSAAKCRDMOmT6rpmt
0sEKAP9OSQuOjzj5VsA4JmF0dKbbd8FYZsO83xtNSh7TuRPbYgD/dDvVU7y2zdqX
AJIqud/qnUafn2y/HSDl5R/Ii+DJTgw=
=lojx
-----END PGP SIGNATURE-----

--2bdtf3tea7rpjkrd--
