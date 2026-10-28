Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793223105;
	b=GzA8KCvlEGxzNb1ilmePXDvVZBmOIVNNgn9Rk+1z6d602GdhTgwowVcsKoJsD8RP82On
	 D1F+sWAs5ctQF4l+nuM3MvJqws+VU74rBG9AW5GqDH0w6js6tKQZQCJC9ycXp0wgbh//G
	 VDn2rDubykW2ELBLsUZC1JNgZT8XGIktYnrK7/VUG+HWzJEMVBpQ8PCfsdZx9t5SXa8/9
	 q/w8haDBOduMm+2XR5+/BnKsms2uX4eg4L0w8Ojy9tKhsa4PVc0PDOGk1L7OOnpq+MY0Y
	 gcQweJ+DqB2suUJzIEPFuzGIROfcXwjwvNsRF/DK0jhVXEHthCJ3cCOBblROuN2F12g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223105;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Fr9aqDoha/2A/ZRZBTkknV7KcjqR+9bT5Er95EpXU5Q=;
	b=mrw5PQ6pwE8YBVL4K3Fxql6qgOudGCW5e6dLSnVqr3JXIgKfqOkbP6pPT8h15Y77axOX
	 MzAxA8Fuo81NiK3ghBy0ARdgtP0q+JWU1UpIZ3d16hnYG7V+tumlHANnyKf83Gsqb6gbU
	 rAXhREYfnuNnB91HpQSneo7ojze9dq7lX8kACNa7s4xSfFMAUG6iEgc0uhZmKBHesj75S
	 orynGcA0UzTyBvMniGEMm5A0+Vx8yiD0e7erV1aCs5keAyXx0eqEyKKRjnJEhlK2mlMmQ
	 8QZjbU3mOB07pKCKCZ4b6tzPW9mYo2yV3vx9TVHOiSavLNOAPGivQ8disxhLUkL4h5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="IcqAMeB/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D34606A31A
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 21:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IcqAMeB/
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 859D9201F03;
	Wed, 28 Oct 2026 22:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793223097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr9aqDoha/2A/ZRZBTkknV7KcjqR+9bT5Er95EpXU5Q=;
	b=IcqAMeB/+OmEd2Pqxkzi/dAVWTES5AL2iFRqgo9blB4xBwcL8vD92svYr0ArdSN6a8kKuZ
	WiUJ2JUuOFSsdMUr23HYVnThSXvTbqWvQFbrQX5MpRrRnfy8QrrUYTiXONbCVaKJOM3isy
	+YnzhCJtaSbqaOf8gHjh+Lt1sxOudr/MOyL6VHurkufSBV0Tu+Xx05NixfUOCxopLcv1ej
	qaCRctKc2a5wj1eWxNnJwpKF898nkoQwL341+ORdJOlP/L1ryMEjiTc2lWiDgsOFAtFOUR
	3fUoXa97dgGLEv1uURBnQ0iN0p8/gGXMipf3D8geGLexR4Pf5f6iSnHW9Y9oPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793223097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr9aqDoha/2A/ZRZBTkknV7KcjqR+9bT5Er95EpXU5Q=;
	b=LCYj8gqPW+c344yXPb+rN/+RWxnOXVtl8nSjpp0YihVj51inoRKGM331XgqESitsU8ur65
	DOV1HxXqoXRX162kDtm7aznWyo8wY0/fDbishxbxRYdIkidnfFsfbdYlhRzMDXTVmdd0J9
	Pmq7ElyO15iNkNs+sFe/jhSmNlrMx+bR7In3/NXqmPhLFc+lDVN5gZw2EuThQ9R6n1KV1l
	hj8pYUrfHuI0grGVAW+4fgxjVC+EOwq/Ocr8bRYbMzz6vXxpw8m+ULxNEtGSf+RntXTn7f
	k3wX1fKvFJGigMYi7jcVe6VrVWWyu4/OzpD7+hjEptc9OU81u2yrOUMGJUPE7A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793223097; a=rsa-sha256;
	cv=none;
	b=XrtaaTyZK0rPoFbMenI89pPIuMNs4tf9nUuKt/qOi+VUqAsEi9i+Z0zY7SjX7SqLYH00oC
	2+7mxuuf4PA15klKvSc8OE8VJVIJ+JZg+QADv7DV4y4xsEdCsu/KZf1Nv/LvfNaYZ/nYVE
	FzXNb83JHZfGLsp3rwhRBpvoTzYPLrek42kEW6i7JKZj9bxEDq4Um1jC8qptfs0nJ/jqBi
	YiiYEIaLep6cHeku6YS7Q0qsZj2djG1iJbaQNXKvNIAmGR/MEJ+TVdHw7IqTVO/AmI4MDT
	wsW8OObIJM2GnGlS5sBeei+0CJ6U17nlgds8XiTNj7eyFdd9K+cq1gYcqUTe4A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xMBFB-001d8X-1M;
	Wed, 28 Oct 2026 22:31:37 +0100
Received: from pengutronix.de (unknown [213.208.157.249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AE5CC5D9434;
	Wed, 28 Oct 2026 21:31:31 +0000 (UTC)
Date: Wed, 28 Oct 2026 22:31:24 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Norbert Szetei <norbert@doyensec.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
 <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
 <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="rzionsddff6np77h"
Content-Disposition: inline
In-Reply-To: <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>


--rzionsddff6np77h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 28.10.2026 21:55:02, Oliver Hartkopp wrote:
>
>
> On 28.10.26 21:51, Marc Kleine-Budde wrote:
> > On 28.10.2026 17:36:26, Oliver Hartkopp wrote:
> > > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-can-rx-l=
ock-v12-0-eb5afc2d8b9b%40hartkopp.net
> >
> > Seems clashiko doesn't post to the mailing list any more? Did the bot
> > reply only to you?
>
> No, I was polling the URL until the embargo ended.

Hmmm - maybe not message because it's only low?

BTW: There's a bug tracker (by a random .ai company) with a list of all
issues found by sashiko and clashiko (netdev's sashiko):

| https://bugtracker.nebusec.ai/

Use you email as listed in MAINTAINERS and use the password reset link.

> > > The remaining Sashiko findings on v12 are either issues that are fixe=
d by
> > > later patches of this series (as Sashiko notes itself o_O) or pre-exi=
sting
> > > issues that are not related to this series:
> > >
> > > - CAN_BCM and CAN_J1939 also copy user space data under lock_sock(),
> > >    while their netdev notifiers take lock_sock() under RTNL. This is =
not
> > >    a new problem introduced by this series. I will look into this lat=
er.
> > >    It does not affect this patch set.
> > >
> > > - The user_reset in net/can/proc.c is denoted as not network namespace
> > >    aware. This is on my list for a separate can-next patch too.
> > >
> > > The only new finding is that isotp_bind() keeps so->rxid/so->txid aft=
er
> > > a failed bind(), which is visible via getsockname(). This is intended:
> > > As so->ifindex is reset to 0, there is no interface and therefore no
> > > valid address. The remaining CAN IDs only show that a bind() has been
> > > attempted and failed. No need to reset these values.
> >
> > IMHO a failing syscall should not leave any half set option. You're
> > rolling back so->ifindex, why not roll back rxid and txid, too?
>
> To me it is not relevant. If you would prefer the cosmetical roll back I =
can
> send a new series.
>
> Do you?

no - it's only low, so fine with me.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rzionsddff6np77h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauJpqgAKCRDMOmT6rpmt
0onfAPoDhjCxIq/g+oOXaZbUOpjmcMls2QNsqwVrzNovVIB/vAEAgEG7RheF4QKn
CTFVqCVvqKBgXOOlsZIkg/nTlJ7X/wg=
=q0GR
-----END PGP SIGNATURE-----

--rzionsddff6np77h--
