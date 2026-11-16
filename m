Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794820822;
	b=bev1AaC9NIEqKt3dqVe4qc+U4LKgwY/BsVv8KRdLjjwGq0uGnst2vzF6wjNHc7jI/qKF
	 GVpwXIryFFAwbS/LhiFtQoXh1BtIPOooU0MoGDcH+f0haOuvG1DzUdCFMpCZolL38FB3a
	 6uLQFDFiy/iURvCttRDfTE/+g+BPvh5sq3HYm9Tu1iQZS9Z0OQ3/SRnK84Jbq+GrtS1VD
	 3+vC2SRICujm9PVn/YnGrV9iitB5Me88Ec8KQrHd8Pya3zHHyjsS+/PTMkRsQhmQ7+lno
	 qhS7nbCHbH45ywv1QKtjBwfNh+xXRFffkNjCBrBWDj7581jFFkc5HK3pls2xZPbLx5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820822;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qasYIWxkmoq5mRF2ENr+HXhZWEX0pISvU4gUa+W+zyw=;
	b=mzU8Mwdhe4eKFM7t7rqxREUfzauNTNk/gZBrAFGNd0BIQBuynvraPYhTEqzGlG9+QYak
	 DYswXVFbx7u/8CF/AHv1b8FfW4JuMXxSfLRYd0UXjYa3xcmr3EiPp72y2fKPNCK9sDsKZ
	 ebHcj0FYOU3QnzjpUdm7/sxB2KUgJfkMQqArAQnx7r+CNrGGXYwZRuzPcgJp1XvSe5IwX
	 jNlr4wqNxQ/PbA0NaVOWC6N2zWUvvaHoVdhAJ3afv5XSR87FxmGroGMfp9gNMP7/+rGaR
	 aEWpM6+bWu92jyX1/+6opvORZ256xH6LW5A7faSqxm8AzsPLm2d6jJjBWTAUl8K8S2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gYGbfRuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1D606A334;
	Mon, 16 Nov 2026 09:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A1D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gYGbfRuA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B604201578;
	Mon, 16 Nov 2026 10:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794820818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qasYIWxkmoq5mRF2ENr+HXhZWEX0pISvU4gUa+W+zyw=;
	b=gYGbfRuAqF69PBMw7kwNBh5WSABiONyvAt9Ws/rCU/ITvprXFhoaetjGIJjcj/jCMMSS+q
	3VF2DKro3L2d/A+UyvttnTR/YJGhNBU94Gqqlb4sih6DJrhu8REG4tBLmJ5AJG3/3l9+q+
	O4W1qkbvMxjr3XCqYjSa2yJYvzq6XmoFKFmRDF5ZkKcwLeJKpMhZbA8eGIvVQz0dGBYmnt
	Mfu9RYVSyQZIFjCXCnS2n08Kncc7z8GIKv+QT7sxbLnPB6m7a96xjh3UgUeyF4KYedFmTc
	63CVJBRyMi1/NAJI9fzVEa4HUt5egBpHstBHiaFO7Vn0q4NLxy0Y3hvscWubnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794820818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qasYIWxkmoq5mRF2ENr+HXhZWEX0pISvU4gUa+W+zyw=;
	b=U/C98LT0LRbp/f6w3leKXIvfSv2rjagmhq5nywzUTlYVI5vQU/sm0c17Chl5hOz7zP75ty
	heuJCZHGDURmt9cQsb5CDfKlrDhQyPAThlDm9yS38/DOjta+17JEUBdJbC41x1M4Jy3gs8
	d/5NDA7tYZHibCOidKVykludHLYJzs24N11iI0wJb3fcLzsp9Vp3x2tK7SxIIjSdnfs2Ip
	cU8/Ha/XqP1vhw1x/VOZ0VJSXRYZYk2BZNxE+PfFF1lOQVaegtOUVxttTqP02jYGNMYCJ8
	VbzfYQccKYK5Qzeg4raGaWdVYCNtD+pI/bxSaJsEVZ72Estr5bdBhnAdKNDWyw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794820818; a=rsa-sha256;
	cv=none;
	b=c6rRiCNxc9OCconJd8jd48OoBjIDRycdSqFfLcJzdM1OfGx47kexJvdna2+7v7SaPs1alg
	cWGWU4F2xbabaCR3QcfNG1J4EQqHvXuScWhAmXXRjHeZ3Ezbc5/UcLKxEmexRsH3VvlRiC
	K+WdErBdLe+j1rjKc1OT4x/ySHUYF89hXDLV43BJgyets2Rc3+h2LT5iEirKGKD8PDJRBH
	iplRl8XRFee8HUL6WD722uMaKC7LU7I+aqAEzSLWKAwJPHp2zEVx+2hLkYOb6x36zqsrrI
	y/6Uj6xwcIOxvw5FOq1wINcgiBnvsr8jSg7Ir0m4XSDI4DgkrBsAHpIbeATfPg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSsss-00013E-04;
	Mon, 16 Nov 2026 10:20:18 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D62095ED13C;
	Mon, 16 Nov 2026 09:20:17 +0000 (UTC)
Date: Mon, 16 Nov 2026 10:20:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: RE: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe():
 reject devices without match data
Message-ID: <20261116-passionate-vulture-of-potency-331d64-mkl@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
 <TYYPR01MB660340F5E219C29045BF61F9867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
 <20261116-cream-hornet-from-lemuria-703c6b-mkl@pengutronix.de>
 <TYYPR01MB660333DE58031D8231CD1B3B867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="oayapvf2wmwdvepi"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB660333DE58031D8231CD1B3B867C2@TYYPR01MB6603.jpnprd01.prod.outlook.com>


--oayapvf2wmwdvepi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: RE: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe():
 reject devices without match data
MIME-Version: 1.0

On 16.11.2026 09:12:13, Biju Das wrote:
> > Thanks, I wasn't aware of this series. I tested the driver_override on =
the flexcan driver with latest
> > net/main, fixed it, and applied the fix to all affected CAN drivers.
> >
> > Should I drop the driver_override related null pointer checks from this=
 series?
>
> I think so, currently only few drivers are using driver_override feature =
and
> majority don't. There is a work in progress to disable this feature by
> default. The driver needs driver_override will adjust the probe() to make=
 it
> functional, so it won't fail at all in probe().
>
> But here we are making probe to fail,

Without my patch, using driver_override the info pointer is NULL and it
will crash 5 lines later with a NULL pointer dereference.

> in case someone wants to
> test the driver using bus_override.
                        ^^^^^^^^^^^^
What's bus_override?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oayapvf2wmwdvepi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavrKzwAKCRDMOmT6rpmt
0rovAQCEIJAMETd7tNyk2R/k715jbympLZH7eJQMURDgqksApQD/a5uzKGahBuW5
XA8bORFBLc4olbS/6V89C8PXQPoDjQM=
=Bz3f
-----END PGP SIGNATURE-----

--oayapvf2wmwdvepi--
