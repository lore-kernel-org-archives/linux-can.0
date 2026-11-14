Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794688212;
	b=0OzFHnK+XqcWf2hPmTAQb8IIfEoSzEtARAfVuqGGb7w0imj7Th6JvSK+4ReY4gFHC8Lz
	 aLQiV7ykCCx7pn8MKQiJYwXXqe/WBdKsADP92ySTkbmo1Bjb3fr/TLCD7g99VUiul9b9r
	 KSW/hqqk5iNx2hoPO2VdOosiida376mRLgJcMefMbEFdOyjW3K+CLxLbHgjSKF26qNVqY
	 S9db+AoFISYe0i0O7O3T1HR5/o3iMU9dQOhUAsqPVaZpsS9/Vi+0RUU5iYXCRF8BsdLnC
	 h7NxF2XL+B0bnLTEwfdXnnPAtO2hkgi9JpQzNt2o7mEPwW34h/sTxXCqINSb8goEr5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688212;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bz0m9hWfqe0UzPMhwYB0xZqiClphnqwGphNZhgyWxac=;
	b=LnSeY6Q022FNKUD0QVY2lmWD3JJ6zNloM8AOIT31YpssK3TZ9LSOgRXhVPJpnMan8cmW
	 zzggL1WNZl7CsF7Z/+IgqNAh5CQZ3Tl1S26s1LvYebjzbWuGtpytA2y0h9+99Twhqj8dA
	 /6GrhjXALtFDvY8zsbGqvRta3S4h5sqxIxhoxK8o+9nWWyKIhWfBYU14k3QHDEwSxpQM5
	 UONcFaNRSd60AVMQukJMQc1RWQx6PipJ2X+hT9IqujHEcMOTS/707ApdqdmCt+1w3qf79
	 ChzzsgLuKc79rdXPZNH5TLv7mdmPJoBYGp9KDvoaCTUHgybTA9iWM1v9vIQiv/pqzOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CVUvQlBN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F1606A327
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 20:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 813F1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CVUvQlBN
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2A08C201E6B;
	Sat, 14 Nov 2026 21:30:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794688204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bz0m9hWfqe0UzPMhwYB0xZqiClphnqwGphNZhgyWxac=;
	b=CVUvQlBNPxKEV0a3oeIOh1VKKRFMfFTPfkFp9p7t5uvhFMuwN7noecuJlpUkqC3KYmh45C
	0zyhzkOaB1CdPiHrGYZZT88zrQ3B/7XZFBywpffHE9cgE5jXsm3/1WcKETNXo4biPKucxp
	vL/Z0mkUL+wvdAnWPTFMGEX9Q2IP6GkP8kjg1T2MGXMCMEcRg+/VZpi26tx/M3lzch68zk
	8bKv2nbSId7LenGPdHi5G6Eteb37r55DGptdhCNTJqeIgvds/RBhXV6DFeqSKTMxSwDXYw
	LxXLjM04u2LITE3kp2eBkNDqpNn+NpYsy0+L1c3Rzl0Ln4qlrrxS5sBO7Hy6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794688204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bz0m9hWfqe0UzPMhwYB0xZqiClphnqwGphNZhgyWxac=;
	b=YKHjVRs83H5lvPIschIC8qpwuCxDJG/ZPIefQE1pw4V6wRfqzE0i5Ff41/RUF+8XkydXxJ
	1pe/afALnvVG+8cciMjw6XUjUP276Ho4vok0o4OdvZwGOHZf4Z07ORbfFOY3SuUdc/oHza
	SpAPLlIyL7UpVleshYaqirGbxOJk24R89fUnG6+yobOTDzU3hsgcaJoB9gzCbjWchG9ZXh
	eLvLvusRvty5gyeFNg0V3cFMthmxp4kTxJtqorbngHSKThp4E7JAlVGLo0lxN87QomcKeZ
	tOCOmt61sXAiX1ORi94Mixx91/3OTTqMyMW9jRZLuxR5idSg7TwFT5DmibgOCQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794688204; a=rsa-sha256;
	cv=none;
	b=VMzsKgb+/piN03aXEcSn+PoIh5ct7fFth/v2ITLeFNzWh4/EhSnZzQCYWQc+KNCz85KJht
	j9qBq6riT6yHzkwuAFeYRpSLwm2keyOWzMwBXzYCyxxJ7OtPf8yP5i0jRd/P32W650R1nl
	p5EZrwm3sqSxt8tCdzKe3Egvscq10oNeRjQ7/SZDFi7jKgwtqLsaR3uY0EWzbkTEWq6UxI
	C5bfS/oMQAlzEGMudU9eq5OKlNXXzTtwGkgYNapLK86ezUmnEINSD6JCczXR2IlgHdxIu2
	GysoQXrJPe941bwpBz/hBfHlRkzZ+bXpdfrVaTTSzx84QUxnV2iN+E1O1UeE0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSKNw-004BaA-0A;
	Sat, 14 Nov 2026 21:30:04 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF65B5EBD4F;
	Sat, 14 Nov 2026 20:30:03 +0000 (UTC)
Date: Sat, 14 Nov 2026 21:30:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH can-next v7 5/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Message-ID: <20261114-romantic-centipede-of-chivalry-ef599f-mkl@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
 <20261114-gs_usb-fixes-v7-5-58b6341b1c08@pengutronix.de>
 <sashiko-outbox-214713@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4gpqpnslnhjtnqt5"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214713@kernel.org>


--4gpqpnslnhjtnqt5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v7 5/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
MIME-Version: 1.0

On 14.11.2026 15:31:01, sashiko-bot@kernel.org wrote:
> > -static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(=
&dev->tc_lock)
> > +static u64 gs_usb_timestamp_read_initial(struct cyclecounter *cc)
> > +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
> > +{
> > +	const struct gs_usb *parent =3D container_of(cc, struct gs_usb, cc);
> > +
> > +	return parent->timestamp_initial;
> > +}
> > +
> > +static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
> > +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
>
> [Severity: Low]
> Does building with CONFIG_WARN_CONTEXT_ANALYSIS_ALL=3Dy fail on these lock
> annotations?

Nope - it has been tested on Debian with clang-23 and clang-24.

> When WARN_CONTEXT_ANALYSIS is enabled, __must_hold() expands to a Clang
> requires_capability attribute on the function declarator at file scope, w=
here
> the statement expression inside container_of() is rejected as a compile e=
rror.
> Calling lockdep_assert_held(&parent->tc_lock) inside the function body av=
oids
> this, and gs_usb_get_timestamp() also needs a pointer
> (__must_not_hold(&parent->tc_lock)) rather than passing parent->tc_lock by
> value.

Bad bot! This is hallucination, I've tested the it. I'll move this into
a separate patch and give some more context on my testing.

Marc

pr-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4gpqpnslnhjtnqt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavjEyQAKCRDMOmT6rpmt
0vVmAP0eVPPo/Hxip1rgSsjCo4/VPr0haJYTcIMGMuJ3Yv242gEAren84Z31w/24
YcEZ7hpgFDMwiLq1/EmS6BLGDrKD6gg=
=R268
-----END PGP SIGNATURE-----

--4gpqpnslnhjtnqt5--
