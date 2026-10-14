Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425D190462
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014389; cv=pass; b=Hi5ZjGgWTxIQDSSNKUTAtlG7z48dmFvVGwnEDC11bGVMO+UsNUCgg7uDDWAMbZwqdhxFDg4yV0VxHxgkDFzzuFofTdrcqUjjm5Rcz4wFAbODP6//yyxsdtCjZu3Ru0Y/YnMjLRrgOwWLKdYmaV5MayQGhIU3phUGBJeNR9NhO4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014389; c=relaxed/simple;
	bh=oA8cjc8E0RzHp7Shr8AML/RdVFX1HxOzhzSnXtsa3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZygrNw/TU/SidDmeTt5Cca4kP5PNH1BXodwouhbbTUI8vVK49VddvyZCT1ww82M57KydeNhDVE5wLyXO6wjhbIqdk5ydj4vjXQr1l4t0UasnVjQtNuDq3qqqppwoyXFn+cuPyiNFSklQwWUUYDwoAHWulsk3nYSOqCxROFdIUoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=BDKqubjZ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="BDKqubjZ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BAA182004FC;
	Wed, 14 Oct 2026 23:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ik+sSghX+ShUmNcQlZuXW1iKN4dIZiHF1I51MFZQs8=;
	b=BDKqubjZLtwFjMMqIlCyPmIPfnwx4PbcMwsWIxNvg7EdHVA6r0+iat4+ZC5iIbkLAti+fo
	gLRS/axnXvHAqG3Nes7ToQIS3g+XeAeL3Zl1ZoIZpauhP/Dxsq4L9o51PBnBazxhDEa9qK
	CTmFyjvlMMOj6jw/9eHPueovKr/ntkXPkmSdxtFXSWCwVFqpPNXdYhcqL/5OSLFzvEg0ut
	jOr1Z1CB5/VM8Wbic6xQHiPEvM9LTaY0TMhN4ihH6AJgsGBCxfijaX6ehQ2XIdQ0uvRaRM
	dQ+rIu9cfpyx8885QLdMuJ/t8Zjp1B9332kQmmyWuHengZQ21cliE5tPW9Z8hg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014380; a=rsa-sha256;
	cv=none;
	b=X25HyufB6rq2NBLsF4TtgVln5DeKAI2uIMWIGy0l15TrHkUThxkVdIthPV9JlSthzVPHGF
	7nWHQrfi2N3Th/Iyn3M+/taUlW8MFd63HAuq09aJrPzT1GjcKDjTKiynr+HrUJ7TI0vjgJ
	K5/nPgt8QRRp5Pmct+WTgO141ZYbFNUF0+joyK5C+/n92+G4y18PXMA1yOTh0oukyFNLMd
	zrfMUAOvgNkCz78PP4Opx+uX50oUhjGK4Xo9X3rFDzsM7hvGE5Ax5nhssHO4UfujNKWlcP
	P32RoJORkbgDyAo02V0UuXhalTy26iMWlmcEFyUMieS40tSesVrxLGWBOSf8Qg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ik+sSghX+ShUmNcQlZuXW1iKN4dIZiHF1I51MFZQs8=;
	b=E8Gbvv/1ZNNEjskNg9wrv4pNjzN0BdfJ2+Z75P1XVp5L9vHmusbGFirEjOPP88W1Zivz3r
	MC1RWSGNuTVCz37s1GAbhRNTRdBTLYXKeiXMa2uUPzPDdlba4K87vuiqp6A0eSm6oINeOM
	10BJMRCv+GYwIAxGS9a5yim5e2Y6C+0mRPABTxDWtNXRRIhquaHrEjuWOwQCVV3/5juUcW
	Yw6jTh8lN+LnVUv2c7g30bd/Dwj+sKX0Alpyxpgg21mu5LBtD6+ZckN+m0OJfofpsTSi/V
	PdSX6YAhVZf4FRL8DqM9AKd/Qir33ujRaW8wz1jdMXAsKQ5YS3afczPLl58ojA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6nk-005vAh-28;
	Wed, 14 Oct 2026 23:46:20 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 61C1A5C45CC;
	Wed, 14 Oct 2026 21:46:20 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:46:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH can-next v1 5/8] selftests: can: add J1939 wire-format
 tests against CAN_RAW
Message-ID: <20261014-tremendous-warm-scorpion-a9ce91-mkl@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
 <20261014154435.3577983-6-o.rempel@pengutronix.de>
 <sashiko-outbox-171497@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgnhxpi26mkmey64"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-171497@kernel.org>


--dgnhxpi26mkmey64
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v1 5/8] selftests: can: add J1939 wire-format
 tests against CAN_RAW
MIME-Version: 1.0

On 14.10.2026 15:52:47, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selftests/can: test_j1939_wire missing assertion for CAN_EFF_F=
LAG on transmitted J1939 frames
> --
>
> commit 19b14aab4922e084b42afa782b6d7a0743ee25d8
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
>
> selftests: can: add J1939 wire-format tests against CAN_RAW
>
> Add a test that pairs a J1939 socket with a CAN_RAW socket so the actual
> CAN frames on the wire are checked in both directions. Both PDU1 (destina=
tion
> specific) and PDU2 (broadcast) single frames are covered.
>
> > diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/=
testing/selftests/net/can/test_j1939_wire.c
> > new file mode 100644
> > index 0000000000000..8f5113394f990
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/can/test_j1939_wire.c
>
> [ ... ]
>
> > +/* J1939 TX -> CAN_RAW: destination-specific (PDU1) single frame. */
> > +TEST_F(j1939_wire, tx_pdu1_to_raw)
> > +{
> > +	uint8_t payload[8] =3D { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x=
88 };
> > +	struct can_frame frame;
> > +	canid_t id;
> > +
> > +	ASSERT_EQ(tx_to_raw_send_recv(self, false, PGN_PDU1, SA_PEER, payload,
> > +				      &frame), 0);
> > +	id =3D frame.can_id & CAN_EFF_MASK;
>
> [Severity: Medium]
> Does this code need to assert that CAN_EFF_FLAG is set before masking it =
out?
>
> By applying CAN_EFF_MASK, the extended frame flag is dropped. Should ther=
e be
> a check to verify that the transmitted J1939 frames are actually extended
> frames, rather than standard frames that happen to match the lower bits?

Sounds plausible to me.

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dgnhxpi26mkmey64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/4KQAKCRDMOmT6rpmt
0s6qAQCtbthReGhQHsfZGpfTc3uCy/WsMAI7a5LCm9tGOO0+CAD/dTP5efpoQIVp
j7HEepikx/ujKmRBm7uUk9v1HjCAUwA=
=cbdF
-----END PGP SIGNATURE-----

--dgnhxpi26mkmey64--
