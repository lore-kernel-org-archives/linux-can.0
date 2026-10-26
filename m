Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033188;
	b=OC0XPGm7aUmDnGe+wC85AfDue15kX+TYJ6rE64YqMqLXqmH3OoNIo4ukTF8/2ofbt+dJ
	 OgzC68QvwE5cLzGH+m/fjn5EnQixSkjE2sip6Okyzcr+PE0DTyBIBy9zIntxMXIj8ZSnp
	 JdCOkmWMhzNuAYYyHRlvVuN383HGxlV3uYWjjP55aYh7yROrdnnOrPqdyf+kDUhulJxfs
	 rN0bSi4IdqznayGpIYuJp622ncSoUAsqWhKHc2rD1iqtAqdQj3ACuxWaP8Ce9B7ZhSRhB
	 Xrcn5iVlJkofivtfMsC8E9btA7u1U9cKKAeG+Ldxd60eo9ivSsKj6F1xM4HlSktF+pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033188;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+p47MTVijNqkPJtG4hO8kTDa2i9cNy2SWh7Gktqo/oE=;
	b=FTisHlLvuNAJ1TPal3PpI4LdnaCvvF/YXjYArQ9xYPC0FaL1frTDUayGRUU4r7/Qlfcn
	 GeB75ZUpbuPGFqGjHeljpkSsdJTzbdNfZVwLsZo5FfGXvmzgsQzGS+mmg34NJrTQ7gugC
	 DJQ19kfeHrEAw1wzfV10rmpur8FtbWmkvJ5j9HtG/dk9fiXxjrEZckoEurW5AzKcXzwXw
	 doIlPCZPhvr4ggBqdBmYnr5IqRew2SmyKlshxMiXlQsRmrtyasaHP7TQ8TpHIWxNQILTj
	 hdE3Lm8fpDcvLMz8lT+ksiaSQBD8TUEo3KBclMhjzvJ37WMsoL/dRBHrt+2+fqOgjZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Yt4y+evQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917B606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 16:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E917B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Yt4y+evQ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 334DB202292;
	Mon, 26 Oct 2026 17:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p47MTVijNqkPJtG4hO8kTDa2i9cNy2SWh7Gktqo/oE=;
	b=Yt4y+evQn6OHR6quv0ZGa0y/caPbnAy3YWAKQVOfY1rCNEBq4hB1YWvcIHjVb6FtB4pgp3
	YC5bU6b+J7bqJEv1zlz+RqW8IK3p036Ma0yGemJr4ky/0yPv+zPp+VXwaCp5Uoa+sb4wRK
	sXGX44lZm7+dBtud0UlXLtHbF4OYLpWT7NttcS5uyAOj41mJsWTzywU2U5iLOYgWRGwc+S
	DA7Sy4iTo7wK/laHYlC/qn90X7fMWsabjUu9YxeOINKNRNzJc9G4Dls7FW05jeB7bv5+gR
	BfeWGtlRJc78im+PEY1dsBa07NyxgpS11Hw6cEmXoUQU1a2nMTQdxamf3Qv40A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793033182; a=rsa-sha256;
	cv=none;
	b=CUecyS6uKg+cx24oMJJ1JPDfj+63Vbt1uEVoGXQewc4DP9DJ7e3zBb+Rc08ckAc+L8eizL
	6knREVXBa4RUbfmzdA0Z7aceSMa7cTEP91Umst8CwRWLwiPiUT6HW+pUCmrqsDb5Y2SO7B
	tOVLIm7DS0yivmHriyJaDKwU2zi//QNS25F3VGoGbmNf6hU2X8COQfx/WuLeoYg1vR8bDk
	kKmCjveimjxDZf5f3f8r/OcORLrKejOgXiWDfCivVdRRxfUtcD4Vp3lmGV/UPt7162j+rL
	te758uq72fbxQ1lbDmVil0WoRPt88R+wIjWblffV0QjB5IE3xo6U1SbAarDfqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793033182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p47MTVijNqkPJtG4hO8kTDa2i9cNy2SWh7Gktqo/oE=;
	b=ggeirHnHXmqmYRQqrggwOCpHkw6NXB4C6UnxGmMv1wEgWAVzvb6E8qdIONNS7ruQYw37sM
	BGA7TwMsJcDyXmXqNHnkdDsJnHGyN+BoSXVBjJb8x5Hq6bI1CCHIUsE0yJfYjhJJExGN29
	HNIgPs3VLpCViiiFn400YWF3gkc90+30LjjON9J0dDZQlt+y8al3fCnIDuTW6tL0hJbw9B
	OaHzjLea2uiR8jolbOhlm4wX0sM4OyRjbhmNv/b8XH+FjWxziwHLDbG5s1cSiO4tBjnrPx
	KwvRe4LQWhJCkXDhnD7PXUWBk2qe5w1NMZhaSRrPSmao9u5pyYQx8jMjzS8fhQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLNq2-001JFt-0N;
	Mon, 26 Oct 2026 17:46:22 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DBCCB5D7186;
	Mon, 26 Oct 2026 16:46:21 +0000 (UTC)
Date: Mon, 26 Oct 2026 17:46:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
Message-ID: <20261026-snobbish-corgi-of-memory-1c377b-mkl@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
 <20261025-gs_usb-fixes-v2-2-535d45097f72@pengutronix.de>
 <sashiko-outbox-184402@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74mfndbqlxmuqoqw"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-184402@kernel.org>


--74mfndbqlxmuqoqw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
MIME-Version: 1.0

On 25.10.2026 20:03:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] can: gs_usb: use-after-free and leak in gs_usb_probe() error cle=
anup
> --
>
> commit 28ced4be5f6d6693ec0ba1f04a6e081bef998aec
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> can: gs_usb: gs_usb_probe(): init netdev completely before register_cande=
v()
>
> This patch moves register_candev() out of gs_make_candev() into a second =
loop
> in gs_usb_probe() so that all CAN interfaces are completely initialized b=
efore
> registration.
>
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index 15f28833f2deb..2564c16727935 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
>
> [ ... ]
>
> > @@ -1621,7 +1612,36 @@ static int gs_usb_probe(struct usb_interface *in=
tf,
> >  		parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);
> >  	}
> >
> > +	for (i =3D 0; i < icount; i++) {
> > +		struct gs_can *dev =3D parent->canch[i];
> > +
> > +		rc =3D register_candev(dev->netdev);
> > +		if (rc) {
> > +			const unsigned int cur =3D i;
> > +
> > +			dev_err(&intf->dev,
> > +				"Couldn't register candev for channel %d (%pe)\n",
> > +				i, ERR_PTR(rc));
> > +
> > +			for (i =3D 0; i < cur; i++)
> > +				gs_destroy_candev(dev);
> > +
> > +			for (; i < parent->channel_cnt; i++) {
> > +				can_rx_offload_del(&dev->offload);
> > +				free_candev(dev->netdev);
> > +			}
>
> [Severity: High]
> In gs_usb_probe() in drivers/net/can/usb/gs_usb.c, dev is initialized to
> parent->canch[cur] where register_candev() failed. Should both error clea=
nup
> loops index parent->canch[i] instead of using dev?
>
> As written, if register_candev() fails on channel cur, both loops repeate=
dly
> operate on parent->canch[cur]. When cur > 0, the first loop calls
> gs_destroy_candev() on the unregistered parent->canch[cur] cur times, lea=
ving
> parent->canch[0 .. cur - 1] registered with dangling parent pointers after
> kfree(parent). The second loop then calls can_rx_offload_del() and
> free_candev() on the same dev pointer for each remaining channel, causing=
 a
> use-after-free and double-free on dev->netdev while leaking the remaining
> parent->canch[cur + 1 .. parent->channel_cnt - 1] net_device allocations.

I'll fix this isssue.

pw-bot: cr

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--74mfndbqlxmuqoqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat+D2wAKCRDMOmT6rpmt
0sYHAQCz8kDM2VZKYkv0GK9WRWrCqAD6SoU6tc399ZAFaIbmOwD/Z0SOR9n417W1
KLH05Tv2q/cnr7+Wke4/JyvOLYaLuwY=
=8cG9
-----END PGP SIGNATURE-----

--74mfndbqlxmuqoqw--
