Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568215;
	b=DEWFv4oEDktGdvcD7RW5d+Qr8UPBwiiT9Kq4CZtClOr0bRCoAoZdM5auBrHeYROe2Kh8
	 CKHTKkG48V3+Hgzw2/twPrFkJk6CMYhOAqanVSIsP1MFiT6nDRVCZAz3HC3fA+bxFq7gK
	 sKYrAhnhSYdpojg1nhWaotyt547ApWyUntndjb7ZmC8XvgnyQCR4xEejhSyIi8geqxndM
	 m3MCeMl7TevNG4/hxRDNtm7Yi4bDnfARmpvbxuroQk38+P1cEMWyyb0o5zAh18L1ZriGI
	 T3V4kIH69Juiqb9bIxP4/9eNRRgboantMjQvUpyIfdDaa6hmWsdhCkpRHlsc5gwfwkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568215;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0xxqoXf1/Boul2Ez92/44Gob0gkkH3CamzOh1sFVZGM=;
	b=Fp1U/vTHDchdsCQ5Ym2H53qAz1k2Ln3gYIJ3y2/JgO03sT0ugYsKwgbPANoLUncSEFiU
	 UWpEwiTy/ajW/Q5f8Nl/AKaOuoREx7ibriFTUKof/l4EbFILf1/1HTiLeyAQDsn0+uM+h
	 KBdwPvPk9ZrT9HPz0VK9zPIORGqM509aFvtT73l7ESFrUrfH+eue+c8EeFgm9VSas/MlT
	 lqmjzVoIFZ/CI8AzlLhmL5t1uJkmR7rLdZSBSNTfMcOtmyYAxJ+RjmonrU6A/bL5qPZ5b
	 GrShullIvaHxd3K5h++go62WdnciuyveugrXMceVBOdLHiJ7ctifSk89SF2TEcju8kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NQs1IzQm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DF606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 07:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5DF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NQs1IzQm
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ABF1C200F60;
	Wed, 21 Oct 2026 09:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792568211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xxqoXf1/Boul2Ez92/44Gob0gkkH3CamzOh1sFVZGM=;
	b=NQs1IzQmO0PopboblBMdLKMGS1cuxEQeAlSTDt7kcvQh9aOBJOJNMrD6WtplAlwcxdXlw+
	marInLmsTBodht5vAeegInDuppwjr6MU+dzCqtsz0yb6DyC3DiehGnpakU6PzYR1affBvI
	V9eu2nB629BcsZXaeMJoM5AlHGYt3mYRp2eMbu0gr15T4ISeW8rYzECFWR5G7ioRRR8I2J
	Y8zjg0q8BJvupitdO3Tr2Mlc0I1CjWRZ9ExoB7Ro6sCglytkP3sDKn7Mi009tldoJ95/TI
	8W6AMv3ttfuMSdJxXTfE20onhSYiNTmuOn0eE9xcvz7z2R4O8LIs+rrypzA0+w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792568211; a=rsa-sha256;
	cv=none;
	b=WUO8LLRLL9T8eLlN+bYbL4CQNXJH+RniuBZQn0qDEzluBaTHeYj8o/VcMqgXIgq31+KB0P
	Cy8ipo5qiWdZwvfUUlstcSV+bwquNKNJ5X6CR/dKLIwgpdA0J1iWWVD+G5bbk8Ubyo1phs
	rP1Zd3av9rdrnI6862Rh1foZN0JCqOXX/6cn00cZN6jxl1RWgHZ+yqROKk1IlEY/kklAAy
	X+/eXBrenGGxNcroQCOc0Qr4UEk4JpnIkguhv74IRFzEZoRUz71Tr05e4a4MVFnpH4cSWY
	QiSWPor8qRg60jPZZgs+FREjoUF5oBfQbomQhetmhu3rUTLYNGmH9pIrwuWExg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792568211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xxqoXf1/Boul2Ez92/44Gob0gkkH3CamzOh1sFVZGM=;
	b=MME1UHZ9q791JbP5JzVy3OkMxC4s493Y8tWAjWb6t1XwrXVyYYICV/0/p6+KekEXB/fMf9
	8SYblNB9skKVZKWVAY6i4eSdg+xYrIuiCEaus5VqeBWV6YOTcp6sIGUo1y5WdlcIpl5wft
	/pwUD6fUOmjlssZKwqcozggfiGmRokJ1SjhpGOSO4S9xpMMPVaRhop+sHtGrnOmSlY4ZQt
	VWiI5qwoIz1ydmtCI/PhDqtm61K3W4IE6QHP9FzqIj+fwHjSuEzQc6+czvsG+OOdRmssZt
	WRTkWvoX3N/36EK+9wXCxK5BiwGKF9jhC05OrelfjvqxwtV6Y7bc0vg07EPRiA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQsV-000WbJ-1y;
	Wed, 21 Oct 2026 09:36:51 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5ACD35CACF8;
	Wed, 21 Oct 2026 07:36:51 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:36:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
Message-ID: <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="2r5tum67bacvwcmr"
Content-Disposition: inline
In-Reply-To: <20261020203257.230955-1-socketcan@hartkopp.net>


--2r5tum67bacvwcmr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 20.10.2026 22:32:52, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].
>
> Only patch 5 is new. Patches 1-4 are already applied to the testing
> branch of linux-can-next, and patches 1, 3 and 4 are on their way to
> net-next with the linux-can-next pull request [2]. They are included
> only to provide a sequence on which the sashiko bot is able to build and
> review patch 5. Please do not apply patches 1-4 from this series.

Can you adjust the patch description?

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2r5tum67bacvwcmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathrkAAKCRDMOmT6rpmt
0l0VAQD3pYmq8kH8uiyXzX+3yOhGHiL2DZwrYdoN2TF3DTByiwD/cuFUZlBgrgx9
u4/Ib16jcp1BL08XxnIdhqJ+ylGDXgs=
=XAZQ
-----END PGP SIGNATURE-----

--2r5tum67bacvwcmr--
