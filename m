Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3B375F83
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835375; cv=none; b=M+TJKKSPmw7trOR1TG4KCPdaTfSOw0wU8+5zgJIUiW2AOb/BhyJDgqT52VpNDC4RRRdOc9kNwU/EWS6nZXcuCQ3YRcLFXfBJfAJ4B6CXscpyXJox/L/Ca/v+b88kEKGdPUM0mlaLVP/l0e0/tWm/EY311tEaAl68KDl3+qLfRHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835375; c=relaxed/simple;
	bh=WYpUFK3/fSFZIGQxm24gEI+GcjDoZvL+Gr3NheN//kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoalVHM4+g44wj3ocF4ApAlQQpTpV+4Y+zazilD5X3hrQYoVHtIpqFqcixhtlJcYT5iYmkNfNk144poZn2deiIfSlrotlOsQeSUmp5leGdZQ2KbsIi1+Wieh1KlHotrwOVWmRHNvxRajNPPkxt8zJd9j9PTQT23ZH1j/6bOwVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 20072200F1E;
	Thu, 27 Aug 2026 14:55:51 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzZe3-003ber-06;
	Thu, 27 Aug 2026 14:55:51 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BCAF658D8B9;
	Thu, 27 Aug 2026 12:55:50 +0000 (UTC)
Date: Thu, 27 Aug 2026 14:55:50 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org, fanwu01@zju.edu.cn
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec
 poll timer
Message-ID: <20260827-aspiring-centipede-of-expression-b2031f-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-12-mkl@pengutronix.de>
 <20260827121053.6D2671F000E9@smtp.kernel.org>
 <20260827-cocky-glistening-vulture-638685-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvby6nsoqarh2pgl"
Content-Disposition: inline
In-Reply-To: <20260827-cocky-glistening-vulture-638685-mkl@pengutronix.de>


--nvby6nsoqarh2pgl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec
 poll timer
MIME-Version: 1.0

On 27.08.2026 14:36:25, Marc Kleine-Budde wrote:
> Fan Wu,
>
> can you comment on this?

Doh, the patch is question is #12, not this one.

Sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nvby6nsoqarh2pgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCapAz1AAKCRDMOmT6rpmt
0m55AP97Wb/sDC6O5FrLXRJJG457BB5TvQn90rs6K1eNeQAUrQD+PsQdp5di7liF
WQpmdySCp4FnWQR8faz3Wfz3OcZ9yAo=
=TWrd
-----END PGP SIGNATURE-----

--nvby6nsoqarh2pgl--
