Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792569597;
	b=FbZAb9kD0ttKi0MCpz4aqeBrmRfp1Tss+6mAD6Yg2n3tCfMcexiVEGXik2RUflrIGeJ0
	 xeqcISdUPdHeDX5NDC0UJt+Vl6h7xaj25eGRL9ebYg6y1TVb1G2YWOAy6TDU433QR63Vg
	 2+vMP4zhpJsbHoarylREqY4K2siUCNwkmMcJX5DJjWxEOxJcy019hzCVpnnqR5JS36iPE
	 UednHtEu21bFQJoHTlXe0OtelNoEIY9ii7Bfhuo9zLjt8CtAJEU8F0BpqV+1eCQS3yJpP
	 f/U7SjW9rmRz5CWmnEejFs52xrbFu+SfrqjB+zRUROs7yKhQqwiUcH/QP0c4mvpq5YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569597;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bD8qXe7+YZGbdHyfVey15EVf3ObTYNGC5hxXkqHwpIk=;
	b=1/yCmBvX1r3gjxi9bJx8OVxWG3Mfm0hLQSFwZgDYAmexOcJUImYhuhSaTXeS49aP22rR
	 AXtIu5FxoXVSUXp1IzmJYQdJyKiqsf+WwGijYRI2uMr73t1lJSyc1FhKkGxfjNnr/SMQ9
	 8NmXtc8CQZakmcKBaHJlrxALu5TeZAYgo+CtcecLjNInjQYk5jSKD1fz6Kqt8XIBXnA1j
	 rSPKZ+sXUzRxfgli08er1MMC0Hp123Ll1vcDnDjSGc+xzW8Pwr7/UNDRdXOluF0VsSiVH
	 jtghHM0N9GX0MpmZzNilT3M8DSAbr9bBX0si2oNIOQrd02N7leSffrLd9470yaAkDwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YZJ1GYEF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E34606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 07:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E34606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YZJ1GYEF
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 80A27201E7D;
	Wed, 21 Oct 2026 09:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792569594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8qXe7+YZGbdHyfVey15EVf3ObTYNGC5hxXkqHwpIk=;
	b=YZJ1GYEFikNDEAUNl8NBewWTADOqIhvkIk/7399eFF3X6uNpcCxN9Dd4FIfGxjKJWkwYZl
	i5AhItMF1wCur4rAcAkTSTgz1QxucLtuEEDAfHp2KCzFvau+VbaNjVzdTdAyhqvr0wutKK
	X8dKdG+tdi3OuBqzHjPY661HzB6UEdB1eyElQMdoxC2PAx9XPcbQkwA59v5k5ghRoqjEod
	2tHaz6AeRxMw2WT3g1Wy7idheoElEh3vdtAp9aWJj5HcIEzRfNliWVOAVayDx4T+9Y/+eW
	/rFckx+jmlgbNEqAWaTo730o4TRUWgYv/nvK49OhzWiAU2Qc7F/iQ57bllJO6g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792569594; a=rsa-sha256;
	cv=none;
	b=Ir/k/7FrA5XPDjo4Z6nQ7ac21zlVW6VFDNULK3FTUG3ydwdEP+A8cUIgubeIdtsluDpT5p
	P6UHrNuvODv0UrL9JdVMExUc/sT4tEAlogPa5phvt9XQzEnK/oqzUKPv4jRkk2l5szRiTl
	4caOzt3dQ7dk+4VmEpVVNi8RJ6zZSbvWwLnqQAzi+pJHFTSx8uyJHQlMI90z1K1E6DB37m
	OuL8J5+XxBtdYE4dx7X1jf1TXYVa6SbgGhxf2HeJmHvKdz9LJyhc+pS2qqMeEYKTU/P7D3
	b9/7JCmRjejezBUCEPEQWPeVJKUx0mtlCVkcRQQWbPLPMPW9CyrTiz4iIOXDEA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792569594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD8qXe7+YZGbdHyfVey15EVf3ObTYNGC5hxXkqHwpIk=;
	b=Er4OviZRcV5OFSs1lYyeOwXGbPRExWnAx9pxQdnAzfyUM7loAlSKJG8HdcUSb58qGIzi0n
	Kdg/K1/xv39r6DJVlpf0IXxGGxYUbb9ocrTdGOq/zrhvn1CWYhJ8rEIFgakKIEQSOA26KY
	i+/inl1WliItL1wzCKwj4Y78KYzeh1PCUFFfP34g9JE//rXKqq85xrCfp4PbvFsLb9QcMo
	SfpAJCetxolT+/7DgEd6RB0jqR1sdPzMqVCWWPlRiZW+OErOt/iPuxU0YI2vAzDwWaYKHX
	3oBuqAOhEewxQCFd1r27YnLatgZmu4cZlHjVVUJtrQGZrlMEByEgl4pZVpfgUg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJREo-000Wd7-1O;
	Wed, 21 Oct 2026 09:59:54 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2A8085CAD54;
	Wed, 21 Oct 2026 07:59:54 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:59:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
Message-ID: <20261021-humble-hospitable-malamute-c41ebb-mkl@pengutronix.de>
References: <20261020203257.230955-1-socketcan@hartkopp.net>
 <20261021-infrared-mouflon-of-elevation-04cc4b-mkl@pengutronix.de>
 <edf7c988-4e58-4a9f-aad1-b5103bf235ae@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="vhilsg3vg6aonotn"
Content-Disposition: inline
In-Reply-To: <edf7c988-4e58-4a9f-aad1-b5103bf235ae@hartkopp.net>


--vhilsg3vg6aonotn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v5 0/5] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 21.10.2026 09:50:15, Oliver Hartkopp wrote:
>
>
> On 21.10.26 09:36, Marc Kleine-Budde wrote:
> > On 20.10.2026 22:32:52, Oliver Hartkopp wrote:
> > > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can =
be
> > > triggered when a CAN device is moved to another network namespace whi=
le
> > > a socket bound to this device is released [1].
> > >
> > > Only patch 5 is new. Patches 1-4 are already applied to the testing
> > > branch of linux-can-next, and patches 1, 3 and 4 are on their way to
> > > net-next with the linux-can-next pull request [2]. They are included
> > > only to provide a sequence on which the sashiko bot is able to build =
and
> > > review patch 5. Please do not apply patches 1-4 from this series.
> >
> > Can you adjust the patch description?
> >
> > Marc
> >
> > pw-bot: cr
> >
>
> The second section in the cover-letter (which does not land in the kernel=
 or
> anywhere else) became obsolete.
>
> Do you really want a v6 respin for that nitpick?

You can add an updated cover letter for this series as a reply here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vhilsg3vg6aonotn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathw9wAKCRDMOmT6rpmt
0odZAP4o1D1lqydXKm7U1yNY2nfCdV+hSRXq9PRYCcooV0UGtQD/WEEevbK/yJzh
fp1JqpzCJF860+unzwe62m/HJPx3vAE=
=BFCP
-----END PGP SIGNATURE-----

--vhilsg3vg6aonotn--
