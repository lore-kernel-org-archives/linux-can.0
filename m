Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F144CF5E
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032604; cv=none; b=KR2DArJLldQImFJMS75C57Nxx89GaZjBEM+uDW3ukV6eJ3TETHnGjzhg0NAYSt6hXab56qBbi+3m+cKlrX41ckggeiSU2Vk/FnJiSOOq0z84c4+5ze0MCSLbSF9My0YnkB0CS5NWXJdBaknU/WHOd+KydAFQCMwbxVis8UEdfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032604; c=relaxed/simple;
	bh=59A/mbNFkgMZ//Ee99OqM/8lY/bZ/UR4mO+gCYXm82s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1ynABNTJoIORXHc5Tb5oPnl62OVsAXkP4YOqagRcD2JExxzmGzDAZu9wYEDKIR8GUk2TxofkByjfPYdOMwZjLkOeUjbZjdowLQKxAE+jdUOQ2owVGYxnLoie4VSXfcFQSPv4qUtnqh2VpnF2K8RJweiehIsdhxJufZx6b2nlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9A9C620220C;
	Tue, 14 Jul 2026 14:36:37 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wjcNJ-001lzC-1c;
	Tue, 14 Jul 2026 14:36:37 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3AC56568B72;
	Tue, 14 Jul 2026 12:36:37 +0000 (UTC)
Date: Tue, 14 Jul 2026 14:36:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Message-ID: <20260714-vehement-native-jaguar-4f52dd-mkl@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
 <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
 <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
 <1a521f25-0aee-4eae-a0da-3eb7f0702e84@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbjteplsm6fwtseo"
Content-Disposition: inline
In-Reply-To: <1a521f25-0aee-4eae-a0da-3eb7f0702e84@hartkopp.net>


--nbjteplsm6fwtseo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
MIME-Version: 1.0

On 14.07.2026 13:47:35, Oliver Hartkopp wrote:
> > > > Pre-existing issues:
> > > > - [High] Unprotected concurrent access to op->rx_stamp and op->rx_i=
findex in bcm_rx_handler causes data races and torn 64-bit reads on 32-bit =
architectures.
> > >
> > > Fixed in patch 10
> >
> > Pre-existing issues are not a shot stopper, _new_ issues for a patch
> > series are...usually are.
> >
> > Hopefully upstream will accept that you fix issues in a later patch that
> > sashiko claim to be introduced by a patch in the series.

Sorry, let me clarify: This was a general statement.

I don't want to imply that _this_ patch introduces a new issue.

If you remove sashiko from this sentence it was valid before the LLM
review bots. Rule of thumb: You should not introduce "bad" code and fix
it later in a series. - As this is a huge amount of fixes that requires
a lot of code changes, I hope upstream doesn't insist.

> Is it?
>
> Patch 10 Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protoco=
l")
>
> not anything in patch 9.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nbjteplsm6fwtseo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCalYtTwAKCRDMOmT6rpmt
0gdeAQDYjOLvI8eCLsWleVqR1/NB9/G1AI4Axbw7U3/o3itihQEA8P8Mshu4pTuc
+MSrpmLOjU265qYJvnWKeSSBRN7HzQw=
=AuPW
-----END PGP SIGNATURE-----

--nbjteplsm6fwtseo--
