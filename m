Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC93E0725
	for <linux-can@vger.kernel.org>; Sat, 17 Oct 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265125; cv=pass; b=qTqyzChwxpBrkjBw7RsPkwGpTP5wSlUCeZlDRSyuqxNa9YFyfWlY6RGVm/ca/vYbMEnCbPl24LFrfDa0mir9fvZSdNB85+/GhO3S74aeSC8iLM7YwhBoWadv0/8msrGVq2/kxiI0pJ1A//bNx9SvyrFmIoMSXFLDfghFgyme7pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265125; c=relaxed/simple;
	bh=p5hsZSUVQvyFz/Db0zpye9QMZ9iFq99QACjo/LBcW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+oByPLocB+iAx2e9tPwweorPurOwCx2pTSc3EcHfGY8hx6I0MaR+Sicwj8prSEyRpoV1CQeG6VZWI7a2GAH9KhieUQg1FaLZ0uHEtZ6vRpXueQZJ4pmkaXOAdK4FNpFz/ngzEX4IPwEU2MO+KI/gd2uZmUwAnBg15Nky+M3Eng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Lr9PBjBf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Lr9PBjBf"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 370512022D8;
	Sat, 17 Oct 2026 21:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792265112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpUBQn7R+ba4HbxKBHYpW/loFMEdRRnzpOJirxXrUso=;
	b=Lr9PBjBfy6LeW35tUgoqKatos7P7UhVPhhzMZI/We8qOYrZ5eLgFIqHZw5oTzeKIYdSrmQ
	2utBOiO9CbOPO3YhqdCAzUvxg0i1RDN3No6XN8OEeFgtFJ/PoDYENnkuWwYZjB9vVKME1m
	qL1kHZpLunay1/vk40aHbFdLH/sYJYbllybgImq/KKu8pdqF73CnscgjblSq8xUCjYpHAi
	hovu6u/1b8DwlLceFd3Im0yCQZNY6HbATomZPdbIcFw2LldSEdGsoa1iFCSfL+MunY4RD6
	0BlZZvenAwozzpe2OTgLz0HShZ2o/Oj10yqCyDX/F0OeNWI6DV2z14CDcygq9A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792265112; a=rsa-sha256;
	cv=none;
	b=BIccaqLe0M8Dg7NPtgN/sNqwHICLVmK20+IbM6zQHx62qhiSM4WxWN2ZGyONw3LdAQnOVu
	gcHi9u3iur9nYo6XKNJ3YUArJlYUM+QSj1DCi+ye+RkcRVRLI9ridSMRgyZ1pVSyfntR20
	qJsbS4F4456Hpkc8kTApie2NS9R/oVXSDeZvnKqyilr/1gMwgecHSq9+l8Y2guyvcWEvX2
	+KROkp9iVboQkyBE8qoNxUrTd/kZNueBTZG92v6MDSeT1S4EXTtz9fhQLuueX6S67v24NV
	LPehHWC97x/gBu3u113X1BxM5mv21sIn4yS2J+EeGb7IVTgyt1X/e3FxkZXa6Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792265112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpUBQn7R+ba4HbxKBHYpW/loFMEdRRnzpOJirxXrUso=;
	b=TT0NasdEFUeEnCz3/lzJS4zxZFgS0lpDcW/mxPZ1eM5uPWJKYp4CYKMDhxURg/7gFay1ut
	zYWA37qgLQ9GeWXfboKvD6A6Q+0wzna/TIsPrvYHsKq0YJ708I0fsn2arO3VoBSIMm+hfr
	nSzHoiJZEkWaWa7buy9tUh9NzxmcZJyFP2TyFZw8M+DJi96NgGAkBmnnnAF/E1hVqOTzQl
	ZT/wM01xRmQvd79eyaq4zXOrSke/r8fdHIQE5qbl/1Pry9+vmz8dOb7OybAMyE4Hwr1g1g
	Hbf3pYfmMotzjRUNQPhAPX4kWKz04nyJ5F6OxWGujG4e0OtBUjaYGnKvXzR7/w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIA1o-006Snq-0D;
	Sat, 17 Oct 2026 21:25:12 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2A5C95C6B3F;
	Sat, 17 Oct 2026 10:10:22 +0000 (UTC)
Date: Sat, 17 Oct 2026 12:10:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Filippo Storniolo <fstornio@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <20261017-delectable-mackerel-of-calibration-1fad6d-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
 <20260904142606.6FB371F00A3D@smtp.kernel.org>
 <atJHPuFD8dZyoDaj@storniolo-redhat>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuv6fqtoxa7xhyab"
Content-Disposition: inline
In-Reply-To: <atJHPuFD8dZyoDaj@storniolo-redhat>


--zuv6fqtoxa7xhyab
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
MIME-Version: 1.0

On 16.10.2026 18:00:36, Filippo Storniolo wrote:
> > [Severity: Medium]
> > Will this simple index-based resumption (num < s_num) cause skipped or
> > repeated sockets without notifying userspace if the list is modified be=
tween
> > dump iterations?
> >
> > A netlink dump of CAN sockets can require multiple messages, forcing
> > can_diag_dump() to return and resume later. If a concurrent thread crea=
tes
> > or destroys a CAN socket, altering the layout of net->can.sklist while =
the
> > mutex is dropped, iteration by index becomes inaccurate.
> >
> > According to the Netlink uAPI guidelines, if iteration during a dump ma=
y skip
> > or repeat objects, NLM_F_DUMP_INTR must be set on the affected messages=
=2E This
> > is normally implemented by maintaining a generation counter and recordi=
ng it
> > in cb->seq to detect list modifications.
> >
> > > +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
> > > +				 NETLINK_CB(cb->skb).portid,
> > > +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
> > > +				 sock_i_ino(sk)) < 0)
> > > +			goto done;
> > > +next:
> > > +		num++;
> > > +	}
> > > +done:
> > > +	unlock_can_diag_mutex(net);
> > > +	cb->args[0] =3D num;
> > > +
> > > +	return skb->len;
> > > +}
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-feat-c=
an-diag-v3-0-bdcebf07b373@redhat.com?part=3D3
>
> I understand the concern, but as far as I can tell no other diag
> handler implements this.  Does it make sense to add it only here rather
> than as a follow-up done uniformly across all the diag handlers?
>
> @Marc Kleine-Budde @Oliver Hartkopp what do you think about this?
> If you think it could be worth adding this feature, I can do a respin.

Let's ask Jakub (Cc'ed), who is the author of these 2 files:

| Documentation/userspace-api/netlink/intro.rst
| Documentation/core-api/netlink.rst

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zuv6fqtoxa7xhyab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatNJiwAKCRDMOmT6rpmt
0kdMAP0T6Qf4AY5HQFqLVk8IIZffTK7mBs3BUp8JxSpq1p/rpwD/WUBGOTZEHs2s
GaGQMarCOoh2KxhpdfCMUap4wyAUIw4=
=P53l
-----END PGP SIGNATURE-----

--zuv6fqtoxa7xhyab--
