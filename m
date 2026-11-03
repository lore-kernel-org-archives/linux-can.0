Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738902;
	b=nYdtrO3AWTRuwt5ug1qqVE/dAO+bJaiRjGmCww9oeBjOa+BnS5FbBF7OYRBXEFbfX0WX
	 V0xRGRko42kLWOiPojpis+RoKtBIssMV5s3zqT3hKmfwHpQdptitg5n1XhmsTxp4Bxnmv
	 N0jy5auCNNWCzRkiSiRgDBckqwjhT+Y7hE5hFZV8SRmR8AQZZWPeiiGAtQ9I6iViMRAYG
	 0EA2f3RyCw4h7p/3wC4s/3xeKCgDnVXtvOv9JLqr2pqq6MHBhFEyyjIvpTEY1uS4w9tYe
	 9to1o+uQIDJeGkbiEd1we+sziXzj6toGifpkNTt7nl/2FicNFPjTzrzAhJHyfQu7YOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738902;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=diX24vdF8dcfN1Xj1w4MKeDwqMW85T+/jeOu05kxMJI=;
	b=yJDA8/BpxPWBBdUpAALTdtABlCkhJJblYcfXSsyoT4z2vFOCgWsEPZfXa8IkDrvYzjFW
	 qKD0TEhI5UGuuj8BRwZUF0BbZ1hpsCCrlP6PXIfpJ6lyE+DJj7PhqxVD1kaFxqlEmrOHz
	 HwIQsI4rKRL6T3149GmA1e8CwdGKIb6kV7twpVOGIOHNkfwHqLaC7LXklMp6C7aBh/gYA
	 2OdhpRkAG88Z2B0nOxNOJ/4VNDauSyGyBC6U8wMwiuoiq/Rmj6D45mL4RR/0D9TFnZBbo
	 ib7EU6eNWk2oSuCYf7qlhBoPBp9G4BIs38o1m7LkL6ItqMoXUY3yJ9UMJLSIIhYJcTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YZTbzDtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C706606A31B
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 20:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C706606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YZTbzDtj
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CBC562010E2;
	Tue, 03 Nov 2026 21:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diX24vdF8dcfN1Xj1w4MKeDwqMW85T+/jeOu05kxMJI=;
	b=YZTbzDtjos8Jjbsqz0qRjDOYhcmvezKHj8/j3PiHufM3FbyojC/mav8z1KZCF6qRNX2cEw
	b9ntW8m9TX1NKJlU4I1Pve90LorW3NIwCKJB2VzBMUWMR3oVF1Iuf3+2qFzsgIQ2cvNyhe
	qKWHa34Izba+Aj0dobIMsqSGCcmUdHU1mzpLM6estxT4vKICpOLLIRE41CrhJugMmE/zsn
	zJ23RopfRPeHjtdd3+c8t/R3iSpKyAoKHfWH6dk+pDf8B8bC0j9zXvH/4b+HdfkI8Nli0B
	vijhKMhbFFdb6SjnjrIxRvXl+lUL/v3sKUifJ3ugmIcpdj/oPV/8lJfFdiJpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diX24vdF8dcfN1Xj1w4MKeDwqMW85T+/jeOu05kxMJI=;
	b=LNJ+XIVFEDP0ISLII6HKG2qnZpV0+rWYEecydZH6/h7YJCbLEkEepDwXWvGk6rBpF8Hwt+
	BWXPHJEylDEwDPe5+FEhKW4iuD5cM17aKMUBXz+JXQVGd6teHzpLsGw5jgd1KL20XQP1Ki
	mkSowMS6NIQguvLVQ8QB3Rl3D+hZZE/95kY2vN7/QUHJJc+Ih4tgWpKANRFscmyWI72tCg
	e1oTyHAe6Wu0ZEqxpOOZRtYszIO0BF5iU28nO75B1+JuyrkIP6JUpFUqMxNpPR0QhbjeJQ
	9JyA8bOT/qdl9nxbY03ltzq23oPnwws8FNo5jae60uKU5RGtgAM0FlaiZswj6w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738894; a=rsa-sha256;
	cv=none;
	b=AnB8cxnY3MOHALGJWtIT7Fi4JJ/pUUveJ4FfNrIO4li3eojiYGdE6rut5N50JQpnAUNhrA
	/HVwO201IERed9S/JI3F9IvcBKj/A9i/G7nEt98BjNBngtPBOXBt8/YCCrWqcx2qVFyGpF
	YpZ5sO0ZOMCL6KPfzcD/RCNvXD7b8odQfVnHOVYnGCiZkTs1PrRFK6fOIs0HgG2pYyaIP4
	GBOMmysYhlhuHLXI+b/jkphT/Bu4Y5oB3RLBnxx9mxElkef4Qxg/hPNwezHozda+NmFeAp
	ec4aszT/5olan6CMRlEB82oOv8qbAc+/ln9lzuLrWDziVPBKW0HW3ya0j/6a1Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLQU-002V9I-2G;
	Tue, 03 Nov 2026 21:48:14 +0100
Received: from pengutronix.de (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A56345DDF47;
	Tue, 03 Nov 2026 20:48:13 +0000 (UTC)
Date: Tue, 3 Nov 2026 21:48:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261103-misty-quantum-lionfish-d6d102-mkl@pengutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
 <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
 <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
 <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
 <d87ad286-dcf7-47b6-9612-e8c2c547805d@hartkopp.net>
 <20261102-cuscus-of-exotic-atheism-400de6-mkl@pengutronix.de>
 <d28e6983-e1be-42fa-943f-6de6f7429b54@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="gvtwmonsw2ivxlfb"
Content-Disposition: inline
In-Reply-To: <d28e6983-e1be-42fa-943f-6de6f7429b54@hartkopp.net>


--gvtwmonsw2ivxlfb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 03.11.2026 08:43:08, Oliver Hartkopp wrote:
> > > If we would like to meet this Thursdays netdev PR and want to answer =
the
> > > sashiko feedback before, when do you plan to send a net PR including =
the
> > > other patches then?
> >
> > Hopefully I'll find time in my vacation (which is this week) to do so :)
>
> I feel you as I'm quasi on vacation for two years now :-D

Good point, but my vacation won't last that long.

> It would be good to get the PR out so that we can at least catch the -rc2
> train on Thursday as we did not get any fixes in for a month now.

Let's see what clashiko says:

https://lore.kernel.org/all/20261103204305.3211144-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gvtwmonsw2ivxlfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaupIiAAKCRDMOmT6rpmt
0ptyAPwL9rolYh0B0QQJ7PbW2BSrkyTqPuR3qVUUr/ktwP6DnAEA8JWKSmguUpmT
zsOjYCLr6X9Dq4b0Uq6ZxTPEXj4PnQg=
=Jymy
-----END PGP SIGNATURE-----

--gvtwmonsw2ivxlfb--
