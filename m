Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794310097;
	b=pflqn+2WQmQw8pVJHu5K5QdyGlghTdVz2Ke1dnrYDQ1iv2yD9RnQ2MIytkYyk9vH795r
	 3We+eT+MkB0MJ5h4FEOjLfr0h9s8lCqBGZ84MqptdmWdE/D/YnEzwe2ajCfC00z+VjpZa
	 RJGDeYjbqeui0nX/bHeXhyOHXZl/x7XIDsDCvxoED5QDgaNLJ6rzMP6iTx2snlsTqexPx
	 r1F2UrSclEsKzNl6ajqUcKyyLGCWEn0KbokoBveaaUqEJXfcM8XyJrBQslislfc636GUA
	 SDW5Wc1CyeqYC9cNBZUzQmwDD5tlcfiaeATgy7Q21Zs40hzfbOd6WM25xONMpaM7H/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=I7+FoXiAXnYTR4FAAqnJM6g7iMricC9HMOscVkZdRQc=;
	b=1rvWaPa1xpGJkcSbzQp3cYxeSWXnGUOXXm1+evn7fDBkBsV51gM+OcrqX5FtUt3dvqkg
	 vgOYCtSXuqNeyb8a5k2/4dZZsyj34r+i7xMfkuaylabpYC1KR9/oLlhEpHG95Z9t3Zx0a
	 h2DQWldHTuPdLxmTXBz5zD5bby1y8O1Ez2RzrfpSlifX/Avs55fbExOmtRB+FRF2qP1/0
	 2+TDQXFmHFQ5cVtbfXTbQq0q8Ohwz4HlQwIP+Hc04x78cMnihNA6wQeELk+D6t7LzeG8g
	 ZWU2LBoxEoIOiX1zVGhwtMke4ZGszNEAwnSY03rYGlsuX1CJAhfAY7hEi+yxmrFPKog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="VS14/sgM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30902606A326;
	Tue, 10 Nov 2026 11:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30902606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VS14/sgM
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8FB08200912;
	Tue, 10 Nov 2026 12:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794310092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7+FoXiAXnYTR4FAAqnJM6g7iMricC9HMOscVkZdRQc=;
	b=VS14/sgMg/EYq6G24pQt/Pao9HVnMwghNqa1Dni6A/dK1E19pU7pZ04wct5qp4gzCeZwk+
	vGNmhlwTX54nysNcrmLdZ2TpjxeAr4w5SiVrnnBJMb/27kcoGefB+JKnr0EayXZ8MTcnHc
	B/qozjgTIubEFtYhVFOdlo7gnYf6dKnuUXBg0ibCw5Fo8yQSYA+sC1+TRmPlGGc6Vp5uPm
	z1bizqYI4MzFIFV42rlrMGY7HjsG2Zd5GteBrCHFSDSZQCGuZyT5u0JzV5tJTG9dSdJkYZ
	yfjv9iC9rM6fXE0PkLBLKhnJx6JFOqTQ5CWxhJdGR3P8djYQXwA9GZdowhLSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794310092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7+FoXiAXnYTR4FAAqnJM6g7iMricC9HMOscVkZdRQc=;
	b=I/ukohcz4i1+JrRf0PdAf8d5BG3fHPakwR9eNQFX4FdxA7eH1qvi2Tbn7o7xSt1w35VnNR
	c3F3qD6fDinoOjEksWh4b4llcrWhghjG+UGkLXrY9FOGyJLzdi+agOlhrqoEsP21RaY6F/
	0H5sexRB/ANtxhh2TdRg5m0N7ZItiTSHVQb1S1S+qFZMbWA8yYHFsnqy4Jti7UAj3Zc3eT
	09A0aR3HIKf8XUlVT/hnXMg35LKAd/plKbfckNSNc6vbQ8jDp8bExcvqKYhpteWCJN5v01
	7cnihzmAh6jhiCnrXO3dcwBZG2lT/jPC59yADaa4EHpbfPM4LwG7fwoaCm8hBg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794310092; a=rsa-sha256;
	cv=none;
	b=UJyK30gDMGm7X8N5rL4e0HNcjvoM9kmujer9PjzU0GHslB3wCzfwAqHnbF0EfsZUqwTBwi
	929b7zK7aJXr6QZ1qENHT8FdtIdp//MFg3SMTwazhj8nZr9FVKDacJs6JbqxtW/4D8UX0y
	kLrnH5yrg+W8Uk4hFU4q9ba4mY18aTgbkVEHuTlqejuia2nMckn6QJxy/T8ysuci+oyDAW
	VmMcyOta+A5Gh/h1CKEkp3/hFCn/FDJfoV56e4qpxwa9l4qe58Z2ExotEnUVBnHVFox7zb
	/G2ZIBBCdxVmBdE9eEP+NA9d6QYR7EU6P48P/I8lv+/ysh5ivFu+mJd+bxduWg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQk1M-003U7r-1Y;
	Tue, 10 Nov 2026 12:28:12 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 192D95E6817;
	Tue, 10 Nov 2026 11:28:12 +0000 (UTC)
Date: Tue, 10 Nov 2026 12:28:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mailhol@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
Message-ID: <20261110-urban-bald-mastiff-d3cc34-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
 <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="ubmc5fnivmtvuzul"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>


--ubmc5fnivmtvuzul
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
MIME-Version: 1.0

On 10.11.2026 12:08:49, Geert Uytterhoeven wrote:
> On Tue, 29 Sept 2026 at 16:19, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > On 02.09.2026 17:15:37, Claudiu Beznea wrote:
> > > Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a t=
ypo
> > > fix patch was added on the CAN driver.
> > >
> > > Merge strategy:
> > > - patches 1-5/7 should go though the CAN tree
> >
> > Applied 1...5 to the linux-can-next tree.
>
> Thanks, but six weeks later they are still not visible?
> Same for " [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict
> resets in top-level"
> https://lore.kernel.org/20261009-holistic-warping-puffin-3b92fe-mkl@pengu=
tronix.de
>
> Am I looking at the wrong tree?

I tried to get stuff into the last merge window. For various reasons it
didn't happen. Anyways - I've pushed all queued Renesas related patches
to the can-next/testing branch. I hope I've collected all the latest
series. Can you have a look?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ubmc5fnivmtvuzul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavL/yQAKCRDMOmT6rpmt
0qs4APwLy9Cwk00kuD3KSZmcaeZ7HE18HtTzyb0RIv91mTY89gD+Ob7LZZP5DT9B
rWbIbde/9R5JHVC2ElHyP0lIP2mtIgc=
=7Ee6
-----END PGP SIGNATURE-----

--ubmc5fnivmtvuzul--
