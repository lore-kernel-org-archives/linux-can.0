Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458D2E7F29
	for <linux-can@vger.kernel.org>; Thu, 29 Jan 2026 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700519; cv=none; b=ZB1scPLTt8YT8Wnz730BUfBRjirz9NGsg+YAWsDdkggaVhbjsA6fcHytCfhgTnU6isN5J7sjjtTyrvn28X5hN/qVJOGvr9xoB0ZOEWOz/qkSw91KumdCgl1rGvl8U+tWOVrgtgMHrV0BbPtllw4MFT9YFn3Xm0qI2Sw2bMxNU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700519; c=relaxed/simple;
	bh=p2IA4ldw8jdu/z3fq9qwiG9pvRY93a8SLGooqZTOYPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXG2bMHzCUQ+Tgz8xc3VRP4P7PhU0Z9ICjw1FrQtkIIlYH4cm9RuiDZDBbbm1DDClQ4OeKhmTJqsKI1Mka7Gf9/+Oq9TDC8yNH14DWXPmfKItGd5KvFYTtZXsfcNrK76LYevifKeZSZeA5YPjY5PW0xTyxz+7e3CHhToMLmIhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlTwa-0003yi-Bc; Thu, 29 Jan 2026 16:28:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vlTwa-0036df-1w;
	Thu, 29 Jan 2026 16:28:27 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 992F04DB377;
	Thu, 29 Jan 2026 15:28:27 +0000 (UTC)
Date: Thu, 29 Jan 2026 16:28:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, tools@kernel.org, users@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
Message-ID: <20260129-arcane-nocturnal-snake-b4f2ca-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
 <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
 <20260129-fortunate-pompous-chinchilla-dcb99f-mkl@pengutronix.de>
 <c5e95a45-9aac-4a67-82b5-ac4ed8ae2844@hartkopp.net>
 <20260129-skilled-placid-lori-f58fb9-mkl@pengutronix.de>
 <1d9966d9-877f-46d4-a2a8-56b6d621bb36@hartkopp.net>
 <20260129-savvy-vicugna-of-drama-aeefac-mkl@pengutronix.de>
 <437408f7-95b6-472c-9a30-7a3ad647eced@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgaeu7ghloy2trt5"
Content-Disposition: inline
In-Reply-To: <437408f7-95b6-472c-9a30-7a3ad647eced@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kgaeu7ghloy2trt5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: b4 prep --auto-to-cc fails with 'NoneType' object is not
 subscriptable
MIME-Version: 1.0

On 29.01.2026 15:22:47, Oliver Hartkopp wrote:
> > Hmm, I cannot reproduce the problem with b4.git, maybe you can try
> > bisecting:
> >
> > | git bisect start $(git merge-base origin/master v0.14.3) origin/master
> >
> > then
> >
> > | b4 prep --auto-to-cc
> >
> > followed by:
> >
> > | git bisect good
> > or
> > | git bisect bad
> >
> > depending if auto-to-cc works or not. Then try "b4 prep --auto-to-cc"
> > again...
>
> Maybe that was a misunderstanding. It works well with b4 git.
>
> Only the original Debian b4 packages (apt install b4) do not work.

The question is:

Is the debian-package v0.14.2 broken, or is b4.bit v0.14.2 broken, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kgaeu7ghloy2trt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml7fJgACgkQDHRl3/mQ
kZzPcQf+NTgHrj4PhhJGyDZQbzn0Rqx4qKGDpVGZt983IPHymE1+F1qxvchNFv5H
nl7u2zLLXjQchA68a6DVo+p5snkf8SM6ioCJ0JDuy4VS6Blsn1OkxGRwSlpFZFEp
xgmGDjNPWtAe7KLMIy3ST1Bc8+BrtOWrPdkW/enNn7fq0x6HW34ajq/adAph8Odt
9tlIddWtQJT9YjtNLd3QhLUBmi/k3em45hPAY4wF1ULVQLn4a4yfaDfWKIWLobOW
7MBO5zSVI1tw+YaEDTg1WF1KeBCK/bMmwGhm4Y96qOGyP0Jup+PHDk9TjYlj+hyq
SXVsEhrMXCEjkuWP5AZxhOtKCS7XFA==
=9c7h
-----END PGP SIGNATURE-----

--kgaeu7ghloy2trt5--
