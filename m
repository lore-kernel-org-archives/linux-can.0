Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC139DBD1
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932514; cv=none; b=H9r4AK1IMQ3r9KrkpVZbT0NjQUvkX7flbfXWn1wvl+p+do/y1E2P+JsMtcZvlEwZfxtVPIcULFIw8orwCOQyEjPCdjejxPrKuYKvCj/oBPOCQP3nYsGM9rZ8CMZf/qAN4N0gUMqZr0vJInVZNjcXyJOXLJpH4p10USOiDtYXf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932514; c=relaxed/simple;
	bh=uGpvmzmWORCrE6zmd67T5fS8yuXOFrM8GIbC9Uh9YY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIONI4PN7OdtUvOV8BmNz2ixBFCILWm+sWQdW2sbuulOSy0geRjTCs1FYV5yYOS0zGa/M4ddR8jq/ppvxF3r8RxyNce0n4bI+6YhJI0B75TMhq82PpPDmg2moS7+H8WiuxB8zBKPeIzsw9/RKhPjU7OM7f88r5bWqtSpYt14DbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Esf-0003mp-8V; Thu, 19 Mar 2026 16:01:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Esf-00161J-05;
	Thu, 19 Mar 2026 16:01:49 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B685E5085F6;
	Thu, 19 Mar 2026 15:01:48 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:01:48 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: statistics: add missing atomic access in hot path
Message-ID: <20260319-gleaming-ethereal-impala-4d6d9f-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318173413.28235-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5bhx664k25mzm44"
Content-Disposition: inline
In-Reply-To: <20260318173413.28235-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--d5bhx664k25mzm44
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: statistics: add missing atomic access in hot path
MIME-Version: 1.0

On 18.03.2026 18:34:13, Oliver Hartkopp wrote:
> Commit 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> fixed a KCSAN issue in can_receive() but missed to convert the 'matches'
> variable used in can_rcv_filter().
>
> Fixes: 80b5f90158d1 ("can: statistics: use atomic access in hot path")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d5bhx664k25mzm44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabwP2QAKCRDMOmT6rpmt
0uGzAP0VX1QaSb+0Ag7pPmEmPASsYPGhfwcJKtQZXCaNbitTIQD9EK/A00frkT1U
R79uNawz5w2Ja22cCXqb6bq9c80UJwU=
=9PPA
-----END PGP SIGNATURE-----

--d5bhx664k25mzm44--
