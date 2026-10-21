Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792573029;
	b=CoWno6n/Z4fS1HJMSTJU7zSewxe4/0X3DGIRz6kVjJ2tQ/Xd82g+x5paP4wOuSZEYgyF
	 CoB6cgY92QORZhCIDMqyLhUXjzwYPtASvtQvmPVVKyDpuQIo8a4D5POyqOhO0mo+dGedS
	 Z2t58DN2vA7W4cp2zFzkachGapHA09lKqjEKJPMXds5yo2ImzkR1kC7S4Bd99u5UDNu9/
	 5hmhY0VIrIKOwKUrcrZIfNU1ErFyFWVUNhhfEfPZGpLd2S51tTHdEK5RI0Ym20x1Y8gAY
	 Wjxyhe29jeZ1vEptp4ko6nBjGYidPzqNxHsDwhZKMJRazAYSS3b29LvxvCxxyftzuuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=a29QTm/vvALl9tPzTuAcUlJf2PkBAXh1BTGBXFINjM8=;
	b=1DYOsqlQTVN7A9csqY2b7wm8wFTLqDOKikFEO0sdFPYPGZZh0zJYOFThKkBcSuUFm8wo
	 HVIzb0i/RM3mbeNO03q6Z3UcJOM/CQl1gPMpGwdYHmNRbi/QKjAiBbwWIsPmxUoucZFmH
	 4hfZBgJFnsgO29i9tF/RiWVyFtfevcM4Ez4OazpTQx/iqay5P9ptIK/gvctHaIRNT6KE2
	 F1f9hb+SsPDHx68GtNPgbbiLzfOFv+ywWoEGAOXJMtYsrzdm7ceMKfOngfojRkGOKAYo2
	 nIzn9tc8ENjreMUWpdep0g/d/rcTxCg9qVHHI8EAg/M72ReUZ3huup9VFB8Aqty1XEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A3juYy8M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BA606A324
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 779BA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=A3juYy8M
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 115A7202354;
	Wed, 21 Oct 2026 10:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29QTm/vvALl9tPzTuAcUlJf2PkBAXh1BTGBXFINjM8=;
	b=A3juYy8M/kI+SacrAhhTm1/PuagV/e3yotpAWRAYJ4Qgyk25z6kHfyVLb5zdY1ZdfLk8MZ
	XsZ56puQ4X0lru37cPSvAmb3C0KgBZCkxiocv7z55k/TZaVtYRbcnAlxCVCl/PzNjcGtry
	sxuW0bfPIxBJv9POmTF7OKE302d2NN83TI0iMLo44MblpJQOHUTgHrmABLFG40cJ26fG2k
	Xba1EtbyasSrZ37eJp2nE+iqJ2nO1dCIT5jc2GvTAJLRfZN17Tki6CvhXpv5V4s9iQODl9
	cbH9nNRnxfRgI9K84gbrnzp8ny/kC6Mo9oQxzuJ1IHZ8S1USYoefsN8dsQqbPQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792573025; a=rsa-sha256;
	cv=none;
	b=e7VhcaJGPIGwVXo9KwytrBTST//vFwikNDSO8y+lHVggzgnH+VUv9xMTws+CdFgvGuHfJA
	L3ov8GOm83m1aeSUUxmPLimopxCYBmuC3pDAwGsatxUOcgFTIs9FMK8FEBByKKY2b0p8Qk
	pJJ9iJ0084pUFisaE/CjZ8gOWhoZOK3wQEHfUh1FKb+5MFaZDZAnw/btIfi9oVw2noLitF
	NTrab0rmUxSe5lMtL7NnyXqj6jb1RnzHDyeVINi60qMo/+bFERFIz8ewfudHP3u1zuYvei
	QtRqm8kqjFEVxBXuJIj2YVOo/Oi+G2eIDaOvMfqxukVpPOBWCUoHAR/ENSjPeQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a29QTm/vvALl9tPzTuAcUlJf2PkBAXh1BTGBXFINjM8=;
	b=bU1gFd9K/9Sa9GIk5R57PstPpdyLZdH73G890U32TvKBJ3CLmcWEIW5GXIBRR11ZJWGEzi
	Z8ELobfHBk9J1DdarZE24WdyPia6uT57b3aN/+fZ7nFVPwcfWK6H5tIjam6ZCWfttx0yn0
	vWoGFy5rNHrUcXQs+OJ4+NfZ+/mdl1l+qDA40Ub/Ekz2QTT5n5qfEk8o8II/C7S6wdYzAl
	0chD/hbjwU2wy91rERu7Qx6tW7kni5zq1MLKU3D7VNEo9ofNl8NLC0UGfeaG5uwQVgzCEL
	Ajy9YPCe82kOrKBNNlt8Jr+0K9k6cYxaCTe6Uc7A1uNmePw4waGWSke4vLwmqw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJS88-000X1H-37;
	Wed, 21 Oct 2026 10:57:04 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B17D35CAE6C;
	Wed, 21 Oct 2026 08:57:04 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:57:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
Message-ID: <20261021-amazing-kangaroo-of-sorcery-5a92bc-mkl@pengutronix.de>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
 <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
 <edf7c988-4e58-4a9f-aad1-b5103bf235ae@hartkopp.net>
 <20261021-humble-hospitable-malamute-c41ebb-mkl@pengutronix.de>
 <be2bd2c3-884d-4206-a395-a767f26ace11@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="2i6ciewqbjszecu4"
Content-Disposition: inline
In-Reply-To: <be2bd2c3-884d-4206-a395-a767f26ace11@hartkopp.net>


--2i6ciewqbjszecu4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 21.10.2026 10:04:28, Oliver Hartkopp wrote:
> https://lore.kernel.org/linux-can/20261021080231.16408-1-socketcan@hartko=
pp.net/

Thanks. I've updated the testing branch.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2i6ciewqbjszecu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCath+XgAKCRDMOmT6rpmt
0uv6AP48wp4CUAS1aqMMeJ5avNC4JU/LA4ZCyBhgvRmy08KDQgEAxKdFF+lxZrR9
R26l9u4tWcKLRhu+oUOtokAKEkb8ngY=
=suII
-----END PGP SIGNATURE-----

--2i6ciewqbjszecu4--
