Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301D3DDAFC
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410304; cv=none; b=U0rNYFLd0x5+UW11G5BG2wFDJ+lO86rHltQgrMRtPJ0104cgzvzn+bYsRsj3++Z/fyRkqX5+qj0Y6FZ84+qORlN/wj3JR/kBNDQrLhpzMf9S+uP6nRjzeQ4euw7dA0CpIJgXdnib/bR1RAfnsiX2JqcYoByAa+OQADQLuYGeFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410304; c=relaxed/simple;
	bh=2BLr6CPn2guxnV3cWMXLxlEHnII2xJkI2tpv+9GoM5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAmi0WgYwb10hTH4VLCnJX57C/0Nb2JrOp7y6WMIUw7ZzH5aPvd4b2wr0D7GvFJ46SjV5CsWFfE7/ch+rM7hh8VM0raM4i9TZ3JCZWtKPcU4QeUiPi7IzG+8JLMYhiAQgiPLx/0OBJXU0hne7K8IgCW0w2EvoQMWDagu6KHc5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AE85B202C5E;
	Thu, 30 Jul 2026 13:18:19 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpOmJ-0022Nj-1s;
	Thu, 30 Jul 2026 13:18:19 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 52A81576E74;
	Thu, 30 Jul 2026 11:18:19 +0000 (UTC)
Date: Thu, 30 Jul 2026 13:18:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 07/20] can: ctucanfd: handle bus error interrupts
Message-ID: <20260730-rugged-easygoing-chupacabra-7f59f6-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-8-mkl@pengutronix.de>
 <20260730102950.38E651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xdm6vs3qfzng6gh"
Content-Disposition: inline
In-Reply-To: <20260730102950.38E651F00A3A@smtp.kernel.org>


--4xdm6vs3qfzng6gh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 07/20] can: ctucanfd: handle bus error interrupts
MIME-Version: 1.0

On 30.07.2026 10:29:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing bounds check on hardware-provided word count can lea=
d to a severe heap buffer overflow.

The hardware is trusted at this point in the driver.

> - [High] Missing rate-limiting on bus error log messages causes a
> kernel log flood and system lockup.

I'll send a follow up patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4xdm6vs3qfzng6gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamsy+AAKCRDMOmT6rpmt
0tgWAP9X9e66vxDhZMhYY9CzfQ3zNptffDgRTTP9y13GKmm7qAEAtWAP/LCAsnzT
lHFHvN1RQfCxD2fhrso1MRH452Z9hAE=
=oa3O
-----END PGP SIGNATURE-----

--4xdm6vs3qfzng6gh--
