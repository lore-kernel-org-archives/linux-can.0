Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794738471;
	b=lv7mbRhluG1AjiFTImQeee8L2aR/+Plb02ni0DBWg+ci5MUs0J6dJGVLjBhoKYnWkGE5
	 1Tb9/xZ04cXE6f7kwp5+YGGFLv3BE587AStJjXHiJvCCthKaa1V6GDdMXY/d75Zx1AE5p
	 8t1wqvtN1VwiS7QcA+keo+AzGRsjm/haZH64evMd1DruStz2a5Y/evufo50vukH4hv802
	 IPRq4Vds9gfAwblIpcHpPX1OJ4ZVZvy9ssdT3enwmpvkrkh6TktMchjnC1pQcGo1+ifl3
	 3CtqU9R6HRyDPcokTf+964ubdGSSzEqUO+cTCzd99ZDSx25LqF+hNTE7ShSECjD8Bxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9oeVVm+rH4jbuuo3F3H9iuFUlt2J0AfYtk5WJvihWgY=;
	b=0NoiIvj/gBvV9TPxLfDFE3uiJH7pDqugGcnmz5xsWCWqISttWrn0EcSA4KqxMuOymGm/
	 iZdCJ4Onlqi0lpbToStsSOjNnFjnb402cvRLaDJYY2o91JZ963+5RNOu7geZSIXtZPBvR
	 1uLkEdtXsq30LGU0krdb0LxMRDQ71nCdyQRFVF30aJHSph4h5q1U5LY0YkBHi9pItDw09
	 AvcrI+y+z50jYgypb5rmZUf76MhtS4yfxvJuQI9uIYM9T1/S9tiV7gJxlFoMTZAuKw2Df
	 EnVJ4p4E3wQv/hUoQA/oRQDDuT55yt2X9uoFg4GT20Li1uv/JtEyyN2NlY9QpDApcPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G2KaDe6+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26573606A31F
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 10:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26573606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G2KaDe6+
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1EF5B201CE0;
	Sun, 15 Nov 2026 11:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794738468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oeVVm+rH4jbuuo3F3H9iuFUlt2J0AfYtk5WJvihWgY=;
	b=G2KaDe6+fJWWNXfhJpGDWr5J8kuOFBN+LdugAnuNClIeurM29k615s4fS2Jnpjdme26RPk
	iuMSnTa1aZi1YNKxpAmYRj5XTSCbiD4ZY5IOiYtHuJI79WilQjZZU3Oqs1rZQZPtlC8HDZ
	0y9NQXwXC8+B2yrawMGPDZETGOJk2SrvvJhZNVe36zQm0WHnwtEGPldbiy65KvP+bb6HWX
	8iPur+HA5nqRlvJOmOFf3Ta+cKmoUEvUlO3R5hSdsPhV2huu4MUn/jAN3lupqd5nrTlDvR
	lO1ZASMXq7fAi1ljcuI/giil/QMaF3U93Fa0FkHTlQ+DMg77IomDqj8E8pkfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794738468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9oeVVm+rH4jbuuo3F3H9iuFUlt2J0AfYtk5WJvihWgY=;
	b=T/9dQUvvqzkPNoSL00OBJln2j/ud+46pi6SzjEV7Be0wJi1ZZqvrt3XiKdAwBilh+4TkJP
	cjzZ+bxMZ2lJ3IrMouQXZcZXm2NIUQdJqBRQ3fu3u2tlTUeV8hu8FVOCjHwtwapdKlDUAU
	LSR0vyjjKjsPiERf5lJXMOORzPdUlk4rzkJ4ml839uhjLDM3x3SK4NeQH7UAnjiudv9Ig1
	D8iZ3w6yehhlWn+OmVSETGmUsnxwjyHWp6awAcY28BS6okRRaYynMAOgzgYnh1hpj2f2Em
	dGmffkcjJnfc+5t1Zus00hDUkY2QTR9tRUkbdueJUNMZBxY5fuu5krRzUICnog==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794738468; a=rsa-sha256;
	cv=none;
	b=XD+HlmX8AeBYIwOOaVYcMz1csX8onSFrUW5x0xIg33zzSflfgzihGQCCvxCqECJfzX3cOF
	QX0Raus42FPSux6/Fdx03phRTIOkYIEDDGPWDdkBiKFkTOpjREmw1TKCIWB3V7sNH3BcRD
	nzyAxPa2OgRU+a+49H4+zLTBUG5fwQY9yB08XlcLw/k34LFR3wTubLZEp35omgfDfmkDLW
	LKgYvphg/KQt56UJc9Mx66o99fGmcvO0O91/MUKrQ+eiMy7OUbMmtnYIfbRf5apEuvlKd9
	c0SvP9G0iTzL5XWmYR4euHuecMsQnS3a+atAjMhCSYdxjUSZgzzR8Qhe2qrS/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSXSe-004Gnl-01;
	Sun, 15 Nov 2026 11:27:48 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B471B5EC302;
	Sun, 15 Nov 2026 10:27:47 +0000 (UTC)
Date: Sun, 15 Nov 2026 11:27:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev-bot+sashiko@kernel.org, linux-can@vger.kernel.org, 
	o.rempel@pengutronix.de, sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
Message-ID: <20261115-wakeful-true-seal-1950b7-mkl@pengutronix.de>
References: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
 <179454426541.488853.15379643605511531742@kernel.org>
 <5b2f1dcd-292e-42fe-91f7-fe0255e830ab@hartkopp.net>
 <20261113-cooperative-capybara-of-persistence-52ed5c-mkl@pengutronix.de>
 <1b782cac-cb24-4f9d-9a28-aa5e5cbf94db@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="z25otl4fxdqpml4q"
Content-Disposition: inline
In-Reply-To: <1b782cac-cb24-4f9d-9a28-aa5e5cbf94db@hartkopp.net>


--z25otl4fxdqpml4q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
MIME-Version: 1.0

On 14.11.2026 07:56:07, Oliver Hartkopp wrote:
> > I think the bot doesn't include the cover letter. To add additional
> > information to single patch, I add them with "git notes edit".
>
> Thanks for the helpful information about git notes!
>
> But it does not solve my rant.
>
> The AI bots are really eager to check every single word in the commit
> message whether the patch below fits the announced functionality.
>
> When there is a series of 5 patches that are explicitly not related to J1=
939
> it can not be the solution to place this information into the notes of ev=
ery
> single patch.

sashiko.dev seems to take the cover letter and later patches more into
account when reviewing...

> That's like humans spending manual effort to satisfy the AI bot.
> I've seen that in dystopian SciFi movies and it didn't end well :-D

:/

> > Add this to your ~/.gitconfig:
> >
> > [notes "rewrite"]
> > 	amend =3D true
> > 	rebase =3D true
> >
> > [notes]
> > 	rewriteRef =3D refs/notes/commits
> >
> > [format]
> > 	notes =3D refs/notes/commits
> >
> > It will keep the notes during git rebase and amend and include then
> > while sending patche (even with b4) after the first "---".

FYI: notes are not working with b4, I've send a feature request to
Konstantin:

https://lore.kernel.org/all/20261114-rapid-diamond-skylark-6d6cc6-mkl@pengu=
tronix.de/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z25otl4fxdqpml4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavmJIQAKCRDMOmT6rpmt
0oUcAP9fhIeEN/kSkd2siUAoJFe+c7C5xo8eacmdZPlGUYCmyAEAxUORy1DBICED
/2Cl7ZuZbjSiAIg/qZFbV/1+MJMZAgI=
=AQ8f
-----END PGP SIGNATURE-----

--z25otl4fxdqpml4q--
