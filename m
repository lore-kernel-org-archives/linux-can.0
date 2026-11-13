Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794567427;
	b=5CNhEuAxAdwuDc1qGAI11EMeH+y9qX4qQlVcvUkEz1wHvNEqYeNcI5wuGsIYO45b3fot
	 h9uynPP21dIHbmR64THANAahI65z70SwTCybIyjHLio9v5VONFGAxvkLI/VfVsjuAYbip
	 Hx/Sno8FwbRzSICLcWQqDxazYIsXB6jeoBe2Aw9hlDW6r0Hh0zELJParjyKl0Q3jZjX1V
	 gCWRUMbx7EOySmYT6zzKNk1+U5uSX7m6XZZ3rljRI1N5zBDjAGXlK5rs+fbcXaDDB2DiG
	 VAlE8jrRQeURiNEFUnYAtQPKxrV6BCeUN4RUzdfYyk8mJGmxmLIsGrfYUB22S6i7HRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567427;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ycvLse+FP8TWamlh8krhHEzHeHwcnVe7go+3NOjq9mg=;
	b=3ub0QH/cVgC/AKfgkYGtWkddo/IhAAg1jilscNMiut9+QZ5FbGKrPbXcQSWmGO2/I+FG
	 7yydszvYV+TbdM2f3iKb1imGBQg//zl6y4fE6q/QR6pZJzklXLf325+bMoT+a0/cZtck/
	 KFl8QgNAwEFDGx4ceqs8Z6w+yuVQTnfU4FWUrPjkZKqG793KX/k4u7+VD9y+HjFKFGt8R
	 Mkzk30vricaxdH7LeZ3qL98nZYzBShvVj9G4cmStZcyi98k3duphjl0YtrLERN+XIRJO8
	 TBzC6yc+fb6Vy6jGyv2HBcI+07X5uOnLioct6LnnYkcdlKBA7gvGLBCle4pYiP8TU7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RyxiPDqJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E8606A8A6
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA1E8606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RyxiPDqJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 08545201BFB;
	Fri, 13 Nov 2026 11:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794567424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycvLse+FP8TWamlh8krhHEzHeHwcnVe7go+3NOjq9mg=;
	b=RyxiPDqJ0gI1YrhnNLd81wcD16BS7XMTPgW4cYsTZs63Yex3PzIavKocZ6bF6K+R1hfbFu
	Q7I/nIhn0pqGLGEWbEyt7YN6OGjgEt+Qe2+CmUXmPa2ckktvbOWA0K7RzOnSqgRPjLiOvF
	qxm+MUZwUEg2SMWNA1vmXFA3LvMYlH84qfFXHRLzerTtMcWu8M2bsgGH7/STotCCbi+TO6
	pwHR/acL3FgpM5/ZBala6C63KC/RGYP9NyU/8nEyUEwXSGHYsViQi4G1UUdK3Uw75Ybwqg
	XZyr/adLfyE3mX//25jzMENr9VEWEzkztSiohYb360yZybHOJaXuARHchiqjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794567424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycvLse+FP8TWamlh8krhHEzHeHwcnVe7go+3NOjq9mg=;
	b=Z6SDt27Nl8T2gYY9Y7lW1h+IrVRBab1NWXhOaUlTDef0cuwoz7FRrfEt1d7yfLaKsH+wav
	YI54za7adP1hcAKq3gjtAbTiSoYvvYX/C8smlL2bfZmoMQGEKaHoC2NbTiAy+RJcULJrYK
	FohC8egpyY+EAgKzFIy9C5T1ZvqMOhPVNdRWim9SZ/GgugK/sL79/WvTP/4beaV7rBvZDU
	an5dsLvXHfNA/a14+Sg+4mSy5tO3kYp/PLj6/wzNcZoyAioHHzhkicm/D5c2jrJeClbjit
	iAKEes0oq14QJv6kbnlWvqoV92+aC6ZmXRiuQkzcEaFs9hiqOh+tnM/wWRR9DA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794567424; a=rsa-sha256;
	cv=none;
	b=AezjN/3cuvb8c/TRnzjhDeiGNm/XmNiAt6scyb3ceAbp2QKb+hCrylHEE5prP9MrjmIMiy
	9XUctPBFzpZQfxKtsb49kbFxzt2xEyjs+zEjGbXYkB9nt5OGuxQKXNCWawzffvwTNmaC0u
	nZN5j1Ees2G0oPnPlm6ghGIuWYWql398hNjUmIzQvlxB9vZVPUbVm/8fJyypVeUOX5tXBX
	7JEYkXWGscBLFzyle0X/vaX1vDQQjLdpf4mCb9BA8YWaaHdCXig7BJHnCJbiH03QgRtpha
	8KfMK49RYjyi06Kp018JLmgn9YMcoNSkaONhtEwTDbnbgWAvSFj17F4CUGms2w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoxr-003yaF-32;
	Fri, 13 Nov 2026 11:57:03 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9FB8D5EA8EC;
	Fri, 13 Nov 2026 10:57:03 +0000 (UTC)
Date: Fri, 13 Nov 2026 11:57:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev-bot+sashiko@kernel.org, linux-can@vger.kernel.org, 
	o.rempel@pengutronix.de, sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
Message-ID: <20261113-cooperative-capybara-of-persistence-52ed5c-mkl@pengutronix.de>
References: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
 <179454426541.488853.15379643605511531742@kernel.org>
 <5b2f1dcd-292e-42fe-91f7-fe0255e830ab@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="2ljaw5gtz3e4fmqb"
Content-Disposition: inline
In-Reply-To: <5b2f1dcd-292e-42fe-91f7-fe0255e830ab@hartkopp.net>


--2ljaw5gtz3e4fmqb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
MIME-Version: 1.0

On 13.11.2026 11:51:55, Oliver Hartkopp wrote:
>
>
> On 13.11.26 05:31, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found more severe
> > issue(s) in other patches of this series. This mail is only an FYI, in =
case
> > you want to address the nit picks below when you respin.
> >
> > Low priority / nit picks for your consideration:
> >
> > - [Low] The comment this patch adds to struct raw_sock, 'struct mutex
> >    conf_lock; /* protects bind, filters and sockopts */'=E2=80=A6
>
> Changed comment and commit message in v5:
>
> struct mutex conf_lock; /* protects bind, filters and setsockopt */
>
> https://lore.kernel.org/linux-can/20261113-can-bcmlock-memcg-v5-3-634c0e0=
4bc72@hartkopp.net/
>
> Especially:
>
> Sashiko suggested to hold not only the filter copy in raw_getsockopt()
> under the new conf_lock mutex but to also protect ro->raw_vcid_opts.
> This change will be addressed in a follow-up patch as it goes beyond a
> simple lock replacement intended for stable.
> >
> > Pre-existing issues:
> > - [High] This problem wasn't introduced by this patch, but the bug class
> >    the series is fixing is still reachable through CAN J1939 at the end=
=E2=80=A6
>
> Read the f*cking cover letter before tagging things to be [High]!
>
> "CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
> has the same issue with the generic socket options. This is not
> addressed by this series and will be handled separately once the
> currently discussed j1939 patches have been merged."

I think the bot doesn't include the cover letter. To add additional
information to single patch, I add them with "git notes edit".

Add this to your ~/.gitconfig:

[notes "rewrite"]
	amend =3D true
	rebase =3D true

[notes]
	rewriteRef =3D refs/notes/commits

[format]
	notes =3D refs/notes/commits

It will keep the notes during git rebase and amend and include then
while sending patche (even with b4) after the first "---".

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ljaw5gtz3e4fmqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavbs/AAKCRDMOmT6rpmt
0q6DAQCDPw28hY/+73/hlvLz3ihplEMjk6sFndlF/J++rzkuhwD8DQRE3LR+Mu2l
A3ptijUwxfZhu3FPYjjlz1hJpSxswQ4=
=MHdE
-----END PGP SIGNATURE-----

--2ljaw5gtz3e4fmqb--
