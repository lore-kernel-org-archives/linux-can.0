Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792955990;
	b=5PERt33DR8HBdCBD1fxKmyRUW02hWAF2FfTasCSkDCZqhKOxhLg/oitbG6bGTcy9VsJ+
	 ZWC6Zfu83c88/QUYu9GmMCajUQdzM+ueruMFjMWaoF3rlykedYQIfBCo8zr7euT0fxxR/
	 Lx2JV0hddLiaW8kel1Bp7fYW2Qead6+wa0BudiDDfT4JafS7tAFlAy6IhJn0OKr+Sx20c
	 8ejE6O008VT4X25O/YuIJyNcPy8r1o2WQFkEL6KsTryO8dIUM2SHC8Y0pnAtKg4rfIc5M
	 lTfBk/Mx+YPOM25iJBeG3ZHtntYzXdvxZgefQ+7AdUjd7VCikh/Z9uzeqYhTqTY/yzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DolZ26GlhGWTCNpkXgfG5Zg2Yj1NiKu0pb50Y9UbIrM=;
	b=eeHqkPm/IY70ujXm6plUYVvJZTqIa5dJQ1taKGYEdBVHITofyH4uHMJxG8pI4NziS7Fk
	 amEnaXXsgNF0FA4z6bF5r5j99ywM/Q4loiP5T3Xf3HYq35wiK/gZyqUK2PcBb6FlMwa5+
	 fu4FpPdMu1eNPsW8mZ762vmY5AmZeNYY1dFTKbtvy8vjaGocIiWUjCuLyEiDlkpxhsn0w
	 rg/JSUm/k189vN/CWi9ebEllAl3lMDLrfazs3d1WIXA9mM3BCbV0h0gk8j2KnoxqkUaCM
	 q68sjIeyo/gr6sNWRPa9ESHCwYalW3/vEVYj6X98FYgIHXDvwxrr17Fg6Ys/iLUe2KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QSK4selS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B680606A325
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B680606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QSK4selS
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CBD4F200F61;
	Sun, 25 Oct 2026 20:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792955986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DolZ26GlhGWTCNpkXgfG5Zg2Yj1NiKu0pb50Y9UbIrM=;
	b=QSK4selSHz5rCHqGLk4zTaZV0eE+TpHL2P9UWbIddv3cqFo+e5BjJhFm5V9m0eyPiOknhw
	NL5ivc5ZMcJNOTdv0f9avqDiAsvTNN652Bd5jPsRyH5rcEcTai5NKxMdgDafoFNS1sh7P5
	GnfFmqMNSmJAor06xqlzpBj7fJxiHtOToVgXSLgwpZOSJ975DfE8Qz0M12tCWSu1QI1I3y
	gxIjqeHOYy7xxAPdx7gvQXKVvYD4xU3A97f+b4Mehks5ou1cdaIXA5r7AoKyYN7YnPhU3L
	vS9i92UAzsgi9xF/U6ysNi9SYOVs78t29O0YWcpgNRC9dBwGUWyJDWDbTHiK+Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792955986; a=rsa-sha256;
	cv=none;
	b=fqCpay08YR4i0Uv/q3K3oUm8H4kP9kybWGRqZgN+JOkIYsJnCS5sTwUlucU6vkrAsSyQZK
	lgYIpEmypC2GHFWYdDHdpllm003NW76k9DZe7l87doOfeEhaGyGYJi/2seGkAQw/fhFwp7
	9LozDNduHqMZlqMNhpkEtDQjunFyW33h4JRkdQkDjMjjWbkf7ehsAljpvn8qPCR3HeqHbp
	31v+ZVUhLs9moBkdCnOsxpCFgeTtkgZ6aBaDerKBjpQ59NEq9keNvB0CbvJ8QHCuTwtFzx
	1afRz6vYr60axnSCZ1ODxy4m+ZKr7SjJ7IUll1oXgZ61wMmBI1ulICBHWJ5rPg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792955986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DolZ26GlhGWTCNpkXgfG5Zg2Yj1NiKu0pb50Y9UbIrM=;
	b=RCklMW1UaQnH+6qS6GlWYiAGa7LB8hdtGdDucbmbr+NeJiuFusA5vtaL00XZzr5ppLUFWW
	oFUOouG9Ckm1WOn9vlJKXW/0AnvHpriRrTesHt5LCKmBZgXOx0cdXL14N03+oALasHTSUw
	sE1q87oGUM1gJ84ygfaP5ExYg8XLjoTn0hxpsNUxlITisi6qnzaxFwBGnXzP8IwFnSNKuZ
	9vn8iDchWAixq3EpbE0KkjdZONMLp2lCCkyLmET0mycDAcfCEcBGKCB6NcMFMb0xNnztEL
	zGkdFmGfmRmnp/sN9eX0M0cLM0UWieZgYcswWJgFUh0C+tEZvQjgWtXgzLesug==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL3kw-001Aqu-2H;
	Sun, 25 Oct 2026 20:19:46 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7032B5D41A8;
	Sun, 25 Oct 2026 19:19:46 +0000 (UTC)
Date: Sun, 25 Oct 2026 20:19:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
 <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
 <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="brtosshlcsvtctm4"
Content-Disposition: inline
In-Reply-To: <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>


--brtosshlcsvtctm4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 25.10.2026 20:16:58, Oliver Hartkopp wrote:
>
>
> On 25.10.26 20:06, Marc Kleine-Budde wrote:
> > On 25.10.2026 19:55:11, Oliver Hartkopp wrote:
> > >
> > >
> > > On 25.10.26 12:28, Marc Kleine-Budde wrote:
> > > > On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
> > > > > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that =
can be
> > > > > triggered when a CAN device is moved to another network namespace=
 while
> > > > > a socket bound to this device is released [1].
> > > >
> > > > This series doesn't apply to net-next/main, probably as it's based =
on
> > > > https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gma=
il.com/
> > > > Sashiko fails and you'll get no review feedback.
> > > >
> > > > "b4" has a feature to track dependencies and put annotations into t=
he
> > > > series. Please consider switching to b4 and use "b4 prep --edit-dep=
s" to
> > > > track dependencies.
> > >
> > > Good idea. But it does not help for my current problem:
> > >
> > > https://lore.kernel.org/linux-can/bd31fd1b-1fe7-44a5-99ee-635262a1ed3=
3@hartkopp.net/
> > >
> > > Against which tree should I post the patches?
> >
> > Does this work?
> >
> > base-commit: net-next/main
> > message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>
> Ah, I see what you are aiming for.
>
> But net-next does not have the required "can: raw: remove redundant NULL
> check before netdev_hold()" commit.

ACK

> Or did you intend
>
> base-commit: linux-can-next/main
> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That is "can: raw: remove redundant NULL check before netdev_hold()" and
should add it.

You can test with "b4 prep --check-deps".

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--brtosshlcsvtctm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat5WTgAKCRDMOmT6rpmt
0togAP9WMVNdPjA1Zl5DbUxqec2/tlTvmHioilltAfG1vS5W+wD/e1bN9gWJshm8
DFlQsTEKbefAl/P0yMpLYPu6JLT2NQs=
=n4I/
-----END PGP SIGNATURE-----

--brtosshlcsvtctm4--
