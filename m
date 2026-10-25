Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957405;
	b=LqROHOO+0i3Hswz8uJwCHy+NTP5LMgzCM1wr8P2lFqciTKS3OO7HHR/abCKZKu65UQok
	 TUvUQbKmOu5Jsd6wSOpBDSYbZY2erX9fASOnQ+9Ebn4KTUiA3r/X/BhgToMKJkoqka7/o
	 RHeIddpXRysHNsdpXMD10iW07/LL+5CXLNYpRXvbvJsVnw+7KAFDIGM9FrRQK0G1sGxTh
	 gh9vkaaLpO7B4AVXcJLwvrxK6eQUBKpzG5niYT43Kn7DX/eSbMGcI+dTaR3c7AYEMCFnl
	 BU5Vb0moVU/UOmA3+PR8Lw3/TTE6yrUdXV3Ud+mu1/sLBhw1hmTRBj3q8q7yXUvDonw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Pb/H5eBBifmVJM++eOlgPuRGH5aLQrG64qWSl0DFRd0=;
	b=YtYXkkvYYad1J5jBvtiOnHEUnidPIf4X0x/4TnqR6HFxF7Gu/PkCv8sSRvk6a+zuRKoq
	 TiLriDHinJ2APxSC5G97hxP0L2h6iIl0HootUz6TW7XLov38Sgoal6jrx/v0Q8pP9x7y9
	 I9pO8K9PGgnmLJF3HgOsi7vEDAE49THKrX595qpxcXohkbyrFaEp5khTfXp2JLGqA2j9A
	 CZa+PJVGvAqHqs/biBiFEPB6B6mG3EK1fEPvRDzreDCIO3oz78cG/he2KWdoMGRPDGahK
	 JJKE9Lk65uc+A9sDjrt2ZwAAXLGl4M1bJQyvuy61UyilVc6xP8/branqiVzseLWqqDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GhZcnI9b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D7606A31B
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403D7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GhZcnI9b
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 62E372005A6;
	Sun, 25 Oct 2026 20:43:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pb/H5eBBifmVJM++eOlgPuRGH5aLQrG64qWSl0DFRd0=;
	b=GhZcnI9b8CEOBK9ltwyBjvPcgSYMOaoynv0h4T1T/zCKCb4tWNIbf8iy8u73o3gteXhA6N
	bfs12AVVD3tanw3G+IZOVY21zOxK1dPo4TLUO0qErhCqG0AmqMwijiZknFbaVEbxmD+D9j
	AtUj/iIYnti7V46Ay9uEFwInnqgg4Vr6nc2yXuyPDTTmCCu5ARF58DPks8UlT+XJOZYpdJ
	ga6mMaXB474jbqasJf8G/xm8WJg9Ry1+ib3xj2rtbpuqZ2DYln0U9r0a5/qIF2pbEN1+Dm
	VACHhzCWaRw/Xn4grkQsscG1WEvCSbsNUynisg8qNgn6KxRuDz96BSxdf+5YLA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957402; a=rsa-sha256;
	cv=none;
	b=CWxJx7t0VS2CRZXQ48FqF6VjAbCqrwQybttLgO5FpgVoXA0OfO2Nxs1s66TQNVSDnK6rRc
	5YwYlzuprb8g/IJe9kBC4YGlMMrqdjnAcGBwXHOFVQD1N+ZPkCz0cAWmMROAmxl0kdtLuV
	eu8tOKUtTrd1nLferKmb1uqhey7P37AET8n19SxH6quGHmtJQyUj62MRrKCJVvjY7/icOO
	7068g4DCokgvhFwvKQASjxNRBS+f/8swtebIrd0DMTd/u2cZBn0r3VEzJ6Zb9Lbuq+F/6T
	aYlFnZTpgmVAWGJwjyqdYxPxq5OwXEONuSUJ4Siy4bCKdReBwE1b9bYU7AFw4A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pb/H5eBBifmVJM++eOlgPuRGH5aLQrG64qWSl0DFRd0=;
	b=NLHjiAPZF+6uMy4o0V+AvGuzddkXImtyVqaRrvdZLBQ007AKuSMpnzzNiU0L2eNHnW97AC
	VrgG7UIcYZz1n166TO7Ip6mf081BYbeK+sO9XJxUoqDxRnqQzx3ZZxbQwn6ltPEhXNVPB+
	spF2TVGzBHlVBa2bISg1ZROYsEkU8iDFJHlwRUU1/VGU4ehg2pERZpXIVgva/3gv9kqP1M
	YYnJQEotPZXoOcq9A/Tqf99KwoNrfZ0K4meg1F+CZBJRWVj8yLFpl7wOHRo7Xh5KSUn15t
	dkdl0GNEozC6LQMEzlUVxoVcaJsY6cDJaMhuWncGuo8DMfmPyvcX2Ae8hRDB7g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL47m-001Aw4-11;
	Sun, 25 Oct 2026 20:43:22 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 138DC5D41E4;
	Sun, 25 Oct 2026 19:43:22 +0000 (UTC)
Date: Sun, 25 Oct 2026 20:43:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-eccentric-sweet-hedgehog-ff4c6b-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
 <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
 <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
 <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
 <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="25qjr3j2f2i4n5hb"
Content-Disposition: inline
In-Reply-To: <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>


--25qjr3j2f2i4n5hb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 25.10.2026 20:22:30, Oliver Hartkopp wrote:
> > > base-commit: linux-can-next/main
>                 ^^^^^^^^^^^^^^^^^^^
> My question was about the tree!

linux-can-next/main is an older version of net-next/main, so this
doesn't matter. Both don't have "can: raw: remove redundant NULL check
before netdev_hold()" applied.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--25qjr3j2f2i4n5hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat5b1gAKCRDMOmT6rpmt
0v9/AQDcfHD4C6kKG5AIoiMgWuTsGuGfc4tbzZBrTZ1JHXlnfQD/dfHuj1zt1w18
+bNKej5KayW8F2bqfSxKmgxG+e4T3AE=
=eqUg
-----END PGP SIGNATURE-----

--25qjr3j2f2i4n5hb--
