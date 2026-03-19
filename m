Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3F3B19A9
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927229; cv=none; b=mC1ZuTbyp7y2a63YC5ThQ9uTAoJ8lA6E7Rel0oJGcF1tdmmf+OZWhghwwyaEPaAFCH0ncAvu+QYK7Zq2WyPklU3GseNKRtSvEnQN5oBFuOWzrymJ6iMXVXen70oLKr/7fpm5vSyOK+MnV0GcbLYwrJrhIGAW7miJICE/eP6bCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927229; c=relaxed/simple;
	bh=me4ew3vYP1Km2HJVGkhLV8WqvOHHmLBARh6rdtyaeHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7EhoHrlcaN7BRCX7o2oQTtpb8axd0N4CVSzLWgj6LBXGS9tbzY+4kCRnMOD1cglb0405x6EGEBK6+flIblSPDAVpxLZKt8nbZA/IoGfpOVrm5xzyLpOpuWWJXCyvlkYOgNJTynrqYHWicde4G1aoE1JHfFrHlJzrLlHku0SR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3DVR-0007dZ-7g; Thu, 19 Mar 2026 14:33:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3DVQ-0015Gq-1c;
	Thu, 19 Mar 2026 14:33:44 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3C1275084D9;
	Thu, 19 Mar 2026 13:33:44 +0000 (UTC)
Date: Thu, 19 Mar 2026 14:33:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org, Ali Norouzi <ali.norouzi@keysight.com>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260319-polar-affable-dolphin-db10fa-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <c6bb76ce-0f3c-4775-beaf-174e281f991f@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pxovnihxj4xs53bw"
Content-Disposition: inline
In-Reply-To: <c6bb76ce-0f3c-4775-beaf-174e281f991f@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--pxovnihxj4xs53bw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
MIME-Version: 1.0

On 19.03.2026 14:13:55, Oliver Hartkopp wrote:
> Hallo Marc,
>
> the AI bot correctly remarked that the Fixes tag points to the wrong comm=
it
> I took from Alis original patch.
>
> Indeed it has to be
>
> Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu
> size")
>
> Can you correct that while applying the patch or should I resend it?

I'll do it. Please ignore my mail stating the same send 10 Minutes after
yours :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pxovnihxj4xs53bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabv7NQAKCRDMOmT6rpmt
0uM6AP9AoSb6cqJ8XKS9yIyFiUYNB9PdYm2Nfvfkd5y6yTZM3AEAuh209Ioombxd
79m6087FCqNGvDu4VRT32LJ6tl1fewo=
=wslf
-----END PGP SIGNATURE-----

--pxovnihxj4xs53bw--
