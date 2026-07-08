Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF43CF047
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545820; cv=none; b=uYJ8/kJo0unwFX5+ORMwZdnrD5vUe80E4v8VbMb2R98PH9CiyEFsS42yP2TKafxo076Xdsi+iUkeey1z9aalC28YK0xkNOgN8OUIjx9aCI2ZxDauNZqjnT7r9wgWnDXObSj2DPIhT2i+oV1SS4xYXlcaeK0Vzt66VEX4wk46tfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545820; c=relaxed/simple;
	bh=eu5r14aI1UZ0FL/xOs/wfwgC18msXYaO7E/szCnC6+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVCXIux8SVKH9wNmW3+rJb1I3nx6MiGuFqC1WegM90y/fK5U5fT1WYtT9lRI/dNhowf1MiJJ2sVh0DA/E3wmnOVho9d8/fsHOTSw1ZbcBx2PlETBXrUZ8UPtkFQFrAOwh6cB58fYcWTLkOYMZWOuWb+aoimhz8No6yayqAAlrbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9BA5A202752;
	Wed, 08 Jul 2026 23:23:29 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1whZjt-000oRJ-1i;
	Wed, 08 Jul 2026 23:23:29 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 40769563784;
	Wed, 08 Jul 2026 21:23:29 +0000 (UTC)
Date: Wed, 8 Jul 2026 23:23:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Lee Jones <lee@kernel.org>, Feng Xue <feng.xue@outlook.com>, 
	Ginger <ginger.jzllee@gmail.com>, syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
	sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 00/10] can: bcm: collected fixes - final3 :-/
Message-ID: <20260708-beige-tarsier-of-mastery-b73d0d-mkl@pengutronix.de>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxrwfzzced3a2duc"
Content-Disposition: inline
In-Reply-To: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>


--mxrwfzzced3a2duc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 00/10] can: bcm: collected fixes - final3 :-/
MIME-Version: 1.0

On 08.07.2026 19:26:57, Oliver Hartkopp via B4 Relay wrote:
> Hi Marc,
>
> as there were different patches flying arround to fix CAN_BCM issues and
> AI assisted stuff pop's up again and again, I've created this collection
> to be applied.
>
> The patch series fixes ALL issues reported by ALL kind of AI bots involved
> and the fixes were assisted by claude code and later rephrased and shorte=
ned
> by myself.
>
> Inserted a new patch 9 that addresses a late sashiko-bot report fixing so=
me
> stale rx/tx ops behaviour after device removal.
>
> Btw. I added a bug when reworking the patch that sashiko-bot found.
>
> So the potential new AI reports on this patch set report problems that are
> solved later in the series. This can not be resolved.

What about the issues that, according to the Sashiko bot, are supposed
to occur in Patch 4:

New issues:
- [Medium] `bcm_update_stats()` can be executed concurrently from
  different lock domains, contradicting the commit's claim of preventing
  races during counter reset.
- [Medium] TX operations incorrectly inherit the RX-specific statistics
  cap, causing premature zeroing of the TX frame counter.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mxrwfzzced3a2duc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCak6/zgAKCRDMOmT6rpmt
0sg6AP4/LU6iPtFDPllxsNJgGXD21yfW+9YLFCJ0F6d426SDTAD+IEjwRD2/9o2j
81pw+2DRq6tyIhAtKlAAdJ2GQFQnlw8=
=8IOm
-----END PGP SIGNATURE-----

--mxrwfzzced3a2duc--
