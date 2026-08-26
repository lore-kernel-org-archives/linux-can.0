Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC8266581
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787744640; cv=none; b=fQQXLe+voYE9ykMUCnPuCMCvXZ0rFmce6ud9+E4xIfdmr3FmdiUnsYZS7s2hwDNOe9aghYl59RpmBi1se/wz0bcSmk1ThOFcRwdbLO5MjlEF2iSBwGWVVha/Kg6pZkhuIHEr2vJFBPP0S7LKe2dx9fU/Pi+EXfwUSxIOU/p7DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787744640; c=relaxed/simple;
	bh=NkDu2DNncVkphh5qrrR3z7Jlxfbj8en/Gcb+RQirwlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdOxdeNXwLSMzoLXVqz1JNhRHvpm7aLz2Zdc7041XwwLIyEy1m166WDUrwUnSgX4FnFGJzeyzinrPheG2qcANTVwoqZx2Vv+DHkLuwt/EvvIk1HzszPlv95pTRHf8lNXs9rXrmxgA94Y+LPnWr4wa5zrhbwIRaf2JQLvQNLhPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 91827200F83;
	Wed, 26 Aug 2026 13:43:54 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzC2s-003Qqk-1b;
	Wed, 26 Aug 2026 13:43:54 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 367E058CCC5;
	Wed, 26 Aug 2026 11:43:54 +0000 (UTC)
Date: Wed, 26 Aug 2026 13:43:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
Message-ID: <20260826-loutish-cinnamon-macaw-e340a9-mkl@pengutronix.de>
References: <20260819160822.8256-1-socketcan@hartkopp.net>
 <c3fc21b4-db28-4323-b182-eeeb646e64da@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feoypbh5r5azmk3r"
Content-Disposition: inline
In-Reply-To: <c3fc21b4-db28-4323-b182-eeeb646e64da@hartkopp.net>


--feoypbh5r5azmk3r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
MIME-Version: 1.0

On 25.08.2026 16:55:39, Oliver Hartkopp wrote:
> as you are currently filling your linux-can git repo, please take care of
> this (stable) patch too.

done

> Do you think that these two patches below should be integrated into a net
> pull?

"net" or "net-next"?

> [can-next v2] can: proc: remove pointers from CAN specific proc output
> https://lore.kernel.org/linux-can/20260815103400.117175-1-socketcan@hartk=
opp.net/

I've replied to that mail with some formatting nitpicks.

> [can-next] can: remove Softing CANcard driver
> https://lore.kernel.org/linux-can/20260815103428.117201-1-socketcan@hartk=
opp.net/

-> net-next material.

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--feoypbh5r5azmk3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCao7ReAAKCRDMOmT6rpmt
0pCXAP9X7NQxQMm6W7Up1i+QQo/uHYl9yuvYO15mUwpM/ZzSAQD9E2bOTuJtuhsv
6NoRhj9EG0JudBMpM7GpB+/mRsQxGAY=
=g5Dc
-----END PGP SIGNATURE-----

--feoypbh5r5azmk3r--
