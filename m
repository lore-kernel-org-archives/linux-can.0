Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCD3BFE38
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410086; cv=none; b=ZbBVpIEBOY+Fur3k6NNVXuwglVfFPY/VsCnOCO5R7TKaIDSX6sOSw7cqS3Q9tSMtTg1K+8HObDDMVpRjUYusL2AJR8ACOsh2eTExaVNTqPV18KKFNAFm1kOJn/EJ/t5WZgtW6AkbtbToklXUxwruRXm4G/PEeoktOsYqTxoFQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410086; c=relaxed/simple;
	bh=ylEXoY5GLnNJHB+LMNVV7olKIWSFwkH5bTi1WM7YQ+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJmRrOqU+VSqzD/WiR3KHozCwEPqKfMk7K4Do6h8PmGaoaMTNOYAGi5rzI6GnGTC/Zp8jHAiuUkjFKBAhp6xvPNmNSGCZ6wvQS3dcqkxyf5bP8vzs2WXYxSiumcLF70xmrth10szEhjQ/PqDV58NapyTOT1b+dGXEVwzT+524Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9085B2021B6;
	Thu, 30 Jul 2026 13:14:34 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpOig-0022NS-1Q;
	Thu, 30 Jul 2026 13:14:34 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2D3E6576E6A;
	Thu, 30 Jul 2026 11:14:34 +0000 (UTC)
Date: Thu, 30 Jul 2026 13:14:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 06/20] can: ctucanfd: mark error-active controller
 status valid
Message-ID: <20260730-defiant-diligent-hornet-7dad11-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-7-mkl@pengutronix.de>
 <20260730102949.50D741F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gmffwaq2dewro3h"
Content-Disposition: inline
In-Reply-To: <20260730102949.50D741F00A3E@smtp.kernel.org>


--6gmffwaq2dewro3h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 06/20] can: ctucanfd: mark error-active controller
 status valid
MIME-Version: 1.0

On 30.07.2026 10:29:48, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The `REG_INT_STAT_BEI` (Bus Error) interrupt is enabled when `CA=
N_CTRLMODE_BERR_REPORTING` is requested, but it is never checked or cleared=
 in the main `ctucan_interrupt()` ISR loop, resulting in an unhandled inter=
rupt storm and device shutdown.

This is fixed with "[PATCH net 07/20] can: ctucanfd: handle bus error
interrupts"

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6gmffwaq2dewro3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamsyFwAKCRDMOmT6rpmt
0km5AP9SmsvSkPoGG4YUu6zdpqc8sXVBvBy8A3oRqj2Xh3E5egEAoUExRYwhE/Yg
22gOWT88SwcKmI69jHKiGTo2vZQnAAY=
=IUrW
-----END PGP SIGNATURE-----

--6gmffwaq2dewro3h--
