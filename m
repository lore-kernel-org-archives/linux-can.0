Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802221E9919
	for <linux-can@vger.kernel.org>; Thu, 19 Feb 2026 12:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771504469; cv=none; b=jJatxNvaO9IcDXDlc/PQl1qutdxSCNRZ3txXW793Q0qD/6DAgLnWIgQ4tpJXvPhtF0p++zLHWNZhbQBCjowyq/XYtcL3LBqSVyzbUiiXUyXxc7PvIGgfW0Esob5LPA4fogoDAUnrSHKDg4nlC2XXgz47ublOiarvzNfDb/h+M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771504469; c=relaxed/simple;
	bh=mJJwAThG+7AI+AOHPe5iJw61hiv+pfC5CK80/Lzvh4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl6Yfs+9I4zMWgf2s9Zc7gIMDVM+Q6WF55BgPtc9lOFStJoF5jsXHlf+CM0MynPUXu1KGzw6ZX9ku41Nn36Zf6iI/qMvMcsd+EPOt4R6aovnpFsuy3LTFejOJBWtyaC7h3eyZu4Z0U6Xrb6jLU6b1dRa9W3GCzXOvw0MIptawVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3Ef-0006vZ-Gi; Thu, 19 Feb 2026 13:34:25 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3Ed-001Zxy-2x;
	Thu, 19 Feb 2026 13:34:25 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9843A4EC2CF;
	Thu, 19 Feb 2026 12:34:17 +0000 (UTC)
Date: Thu, 19 Feb 2026 13:34:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
Message-ID: <20260219-dancing-waxbill-of-purring-f94271-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260218-bcm_spin_lock_init-v1-1-592634c8a5b5@hartkopp.net>
 <bd8fa6fc-3858-4b55-b186-aa5c773e19fa@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7uf6ijmneq4gbcc"
Content-Disposition: inline
In-Reply-To: <bd8fa6fc-3858-4b55-b186-aa5c773e19fa@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--e7uf6ijmneq4gbcc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: bcm: fix locking for bcm_op runtime updates
MIME-Version: 1.0

On 19.02.2026 13:22:29, Oliver Hartkopp wrote:
> I have an updated patch for the bcm_rx_setup() issue using spin_lock_bh()
> too.

Ok - Please test your with LOCKDEP enabled.

> So this patch
> https://lore.kernel.org/linux-can/20260126161711.2374-1-socketcan@hartkop=
p.net/
> will be superseded too.

Waiting for your v2 :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e7uf6ijmneq4gbcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaZcDQgAKCRDMOmT6rpmt
0i/8AQCFmU4pvm7Mdal/qzQZZdKnsQts9vJaTv9oKfHldb8BngD7BLcng/qRTetK
KfPvWw2cFIH0JpNEehPry7DdNo4pXAU=
=1sFS
-----END PGP SIGNATURE-----

--e7uf6ijmneq4gbcc--
