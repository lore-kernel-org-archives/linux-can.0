Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14340D564
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755737; cv=none; b=U7uE5U8c8EqvnPD8xG+N9sZqO14rWNCONoAnXl/+5VBWqku0Rywgk+q4HsS4CJDKDCmUSgneTRAAXjsQ2mNfAMML1Ug5XBFOC8ByyiScW+0P/oZE38KIt7/n8qx4XXXYjMVhy3xlYxJMCg1LGHrRzXXrASz2n0Rk7p3/37yESzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755737; c=relaxed/simple;
	bh=N55I4BMbUuGcOMZZMXeZJ/DsSmROMz325Tbsde4+hVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuqO8nxsQ043Eu6pZ3KfLlfmDhGDj7VRhrTBdt7D5y+tJUYF2CnCYG0OuOmFTasbq2M7E8TR84E1D7oZJG6cUM0eRg1Ts/TKbcedLvmtI3LrRQ6b5bmTxLx45RVm52B9Fc9pzACSwhU/9CUlCl5N8IpvljOq1uw8teYF2MY4qIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 515EF200FEE;
	Wed, 26 Aug 2026 16:48:48 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzEvo-003SJb-0h;
	Wed, 26 Aug 2026 16:48:48 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E718958CF51;
	Wed, 26 Aug 2026 14:48:47 +0000 (UTC)
Date: Wed, 26 Aug 2026 16:48:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Message-ID: <20260826-hungry-audacious-cat-de184c-mkl@pengutronix.de>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260826-zealous-wandering-giraffe-3fb7ce-mkl@pengutronix.de>
 <45b82053-7f32-43fc-b37b-067058a72c98@I-love.SAKURA.ne.jp>
 <20260826-dangerous-keen-cuscus-c51817-mkl@pengutronix.de>
 <d2d59bcf-0c46-44f6-aafc-b5df22fb7b55@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ipjyuce3eruirlig"
Content-Disposition: inline
In-Reply-To: <d2d59bcf-0c46-44f6-aafc-b5df22fb7b55@I-love.SAKURA.ne.jp>


--ipjyuce3eruirlig
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
MIME-Version: 1.0

On 26.08.2026 23:39:56, Tetsuo Handa wrote:
> On 2026/08/26 23:26, Marc Kleine-Budde wrote:
> > - consider using "b4"
> >   You can use the b4 "web submission" instead of using Thunderbird.
> >   It bypasses all mail system completely.
> >   https://b4.docs.kernel.org/en/latest/contributor/send.html
>
> I have a question. I use Thunderbird over "git send-email" for later sear=
ching what I sent.
> How do developers archive what they sent in local environment when using =
b4? Do they Bcc: self?

With the "b4.send-series-cc" config option you can automatically add
yourself to Cc.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ipjyuce3eruirlig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCao78zQAKCRDMOmT6rpmt
0tV5AP9dpmX0FTMuAymKAPkXbxbrbYW6CdpO+UqtJQmx8iG+qQD/fkzjvbWOmkLg
Y5DKdyJL7ei5CzcUoNeoP3/s4HAvXwY=
=0ero
-----END PGP SIGNATURE-----

--ipjyuce3eruirlig--
