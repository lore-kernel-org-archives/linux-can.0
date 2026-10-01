Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDC3FFACC;
	Thu,  1 Oct 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852276; cv=pass; b=D5KBChVu1j5XqZh/0DeXBjJf5/jTSi5bRfYMFQRjqBAdOlc+s0jK6EVCaFeR+D2c1s79GOWsXbKDs4bbzg+BloZN4CAsqr1B3VInEe69O+yFkl0n7CNg/qt1ahYmu2yvlJ5zBppzh/adR8C/Y9OAGGOwmMcY2R9vLdb8BvvGlLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852276; c=relaxed/simple;
	bh=r2UIWqu3Rvrp7TK4awHW7ExwY+T6TrTQEKwuy24qD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyhqEtyqkZWcQJL+9fhXvr50vXttaLGtP/gRO/CK5d4ifyNSmKJjq3pvS9hDRr0iuXynLd+NzLvUxVl2HB+FVc6lhzAcw4oSXwU+RRTxISmHSObQE+5AypFHiaV1gNQK/OdzhEIg8A+LKI8xN8SBJYrgZeNyKMF9tqGp7Ef2B4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=FopP+QUw; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="FopP+QUw"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A09D52007F9;
	Thu, 01 Oct 2026 12:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790852272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XepF0kfdzjqF3Od/k2Viu6cVNNCOfsolTVfBQBVPZY=;
	b=FopP+QUw2Bnfn2/BOJWNeu76eUlzSRZNCplU8huqpIYX3+URJDVjXfoNpBPufrvS5hhb0x
	30rDeZldWd0c0rsNhngqdrYA2s6yUc3vHTv1Tx4py11k3+8XC7Xm/bNvFv8sESctGV7j2b
	6IfSHnSCRtu4cqJOiV1nPjObZsGYtquAVKpdWso6FWH+p6zHX4cURVLzsc/a+ROQBMPWBP
	Ya/l8GIU6noeGUZSwhk8Ji8HRQ/IcoQAjTiXPOLuLTvq1akIq1i1SHKNRtPD3MXxEqIO4z
	mjv5LTTHFI4hoSdCGW146f0InT6mFhjSu/lutbTafDmLV57l3Upw0e2PHtrhXw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790852272; a=rsa-sha256;
	cv=none;
	b=JTgWRVL1pllMkIrKQs/IeJ1JA/ie4ohc2kOGTK82V7hmO2P+YjWLZ/U8yzoKfDUBP6YoPP
	0PsSggB60+VSE8ForLnHRzhAbRijp2FHAG1EsQbhABqP+LuHCMKuaaV5LaPFs9l+DI7Xnl
	kDADovuX9Z2j5LDQbt485M2PxR0SHfXcIu0+VD9V81/s6WcKNdPvaVwgOLKWjDMmjcON6U
	C0B/N7fyV8srBBCO6zYiusX1EPQ0zjBJ6iAAouB3oVIUEA2sMuPPVsqt4wX0y4+cHxHod8
	Km8zD4NYF/brwnFnEZigHaNN8oGWTfdqexC5aJKHnYB36yGVWTkfLNVl+6YKhg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790852272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XepF0kfdzjqF3Od/k2Viu6cVNNCOfsolTVfBQBVPZY=;
	b=IQZPOpYcfAP1bZB0slak5Z3UGX1jGq8Qtp2xN5MtOOejgviEW93vwIViCjsWsQcsiFw/hj
	plemvRHwmIYeFS0qZC8xXBLZD+dc/ONryWh4noZfi1DRVlAUGS9qAgzy5PjqxGGQSEdWdm
	Cy9UatwsBehKHORB72rhGXTvO3E5JGu83VQCPLJ1v83fdSK/2qfWp2YRTZAyZgc/V5h9Cg
	JA8bHucBsHoUZNpgyPPt9KxaJO7t1UT37aQV3hS5Zrx4ec04RpaDco9Phwl78vjIQFltYN
	NIGqEjOjr3X9gyBuFMIk0iOSOuyxW1HDEOQ9ay5FSgfmJGwTdz/L1QYxz4wVQA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCEU4-003iDz-1l;
	Thu, 01 Oct 2026 12:57:52 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 428C85B75FE;
	Thu, 01 Oct 2026 10:57:52 +0000 (UTC)
Date: Thu, 1 Oct 2026 12:57:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Koeniger <markus.koeniger87@gmail.com>
Cc: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>, 
	o.rempel@pengutronix.de, robin@protonic.nl, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
Message-ID: <20261001-bison-of-undeniable-art-5bcb84-mkl@pengutronix.de>
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
 <ar45DX0aPoWBvA_-@LEGNB0874>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nscrp6syvj54kngt"
Content-Disposition: inline
In-Reply-To: <ar45DX0aPoWBvA_-@LEGNB0874>


--nscrp6syvj54kngt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
MIME-Version: 1.0

On 01.10.2026 12:42:21, Markus Koeniger wrote:
> I really appreciate your solution to schedule the TX timer for a BAM
> transfer after receiving the looped-back frame.

> We use external CAN controllers in our system, which introduce some
> jitter into the transmit path. As a result, messages were sent from
> time to time too quickly and violated the 50 ms minimum interval. Your
> patch solves this problem.
>
> Tested-by: Markus Koeniger markus.koeniger@liebherr.com

Thanks for testing, however I'm not sure if we can get this patch
upstream if sashiko complains about it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nscrp6syvj54kngt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar48rQAKCRDMOmT6rpmt
0qBQAP9sH9Zwj/G6iVNCdCqnEMBLNjFmcX5B9qOgRRr01I1yOgEA82Nmt8HK9pIR
AxJHPeXlsWXuJx7BtxG3vYWhGa3Xxw0=
=p40A
-----END PGP SIGNATURE-----

--nscrp6syvj54kngt--
