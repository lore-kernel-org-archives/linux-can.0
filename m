Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC38237B
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619507; cv=pass; b=aXmtPLm91YkTRBhKuggI5rrUCCBAN+WUrFS31HUw/ARovTVBIbnExVJdq2yl/YNetyCqJMjzFMbvvCjpFvZFs2pWELPAz6seRJnkrHhb57QzX3j6rSMocSkiFcr8EvVSpqkmWR8J6/cqSMz+7ENVIKDzOCA9Mu/mDGE8/9Cdutk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619507; c=relaxed/simple;
	bh=lhWIbemGWVXpFi/p0lfzIbA0oGMNwDhmiyNlts5eex8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Z1P74DRv7ppkKK6OZDndhL+0nHp9UTIxA3Og831xdcYzD90MkbJkG5QYoT2j44Gqt/tjQ6y48BXY6JD7VH6cP0GmRL5Xi4mkRHsPCsAtR51IdQCz06oEcfxIQKRPswYH1s3fPoRR30KMiPoMz0wPb9u3N5iJmc2AIM3qkQnhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Uug0TfbF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Uug0TfbF"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 513D92008EB;
	Mon, 28 Sep 2026 20:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790619498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QV4GUxOYKvU5JbF616H7VXtu5Mbkv2prjTyKqOWEtg=;
	b=Uug0TfbFDypxeETWrFYdVeg7jSIB5ZZ+cDrzvcwBcHLWD0p9B76beDomyQrv1wklzd2vh3
	gIhofJOoqqoe42oXg77Lq9Pu2e/N2MHvvtnG+PgU5GnVjzDe5Qv8Q43iaEvBXso4mE/jPB
	o5/L/MFFEdU1JBuPp3k49IdCJPqH98yf41lU6+KB2LUTAzwik9IrqR9YZRbl1o8lKkMYwf
	QUw9f4kiW8Pzk9g+Cs1rfvdzBdMaWbAgyi/fai7SSslWOR/F0bXBncfWXJRIHsOtyqE/oj
	Yi5Gqt1Il0mrM+4vm87/HZn8tXqH620m1WqvzS9jfzhSbTW6jkFuoglgSz3EEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790619498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QV4GUxOYKvU5JbF616H7VXtu5Mbkv2prjTyKqOWEtg=;
	b=CX5l2+ckio2W9DTLPeKHyEJZWkZcC9rKkNg1c1jX001Tx2OHPgyJV1UrMIsazsbJ0SpSCn
	Zj2yj3Ivt0et1qf11l4Qwbztubo9NcgsFJakFbKOrub+eC7oEgX2WuMIYi3c1+YmAb0Cdu
	nybwwdGUPswvxhe8v5kfod6zCOOezE++eBJWIHjnpnr80Yav8TuzSdnRpJZDt3nbfMblS0
	6dgyA4id4yPnaeTHx093RGGdpy3SaPy2ojH/LF/67PPGKMjrIB6bfsJ9SbNYwCr9yyYYy7
	pc6YWvKpYQu+Si0TbNk39YGbCkfft046lKWLdBSYxqOYVQ/swevKqHMkPKCATg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790619498; a=rsa-sha256;
	cv=none;
	b=XGxqwVO6tQMzw0mCSrRLFpXmTjHB5rXrrl19PYrf5+RlCMikVY+T/x79AP/h43EW+CgElZ
	EBHyIjQd7ZxQBFh7UWq7jwChdTCi4uMT+ycaFFvLH24boz6cpowGexuKaSLDiFpYE+sdnQ
	7Y3pBQpw2uaN2pSDHikmXdRemCZP1FSluEQxxU2tO0CC0HEWj45D0lJ8lPwj8gF6+JbvYM
	XfgzGP5NtZcdLOZJd4vYdfZtxVys2h9epgQuZaWtQmE+clkJrXYtMc8hkSiGvjAlRNct8I
	IRu/Fpf/Xx9ksgNy0vctckTDsvqTFFbJKYc3/7I5sULZLILoLL9rjl86xWmqpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBFve-003Gg5-0d;
	Mon, 28 Sep 2026 20:18:18 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E16825B1451;
	Mon, 28 Sep 2026 18:18:17 +0000 (UTC)
Date: Mon, 28 Sep 2026 20:18:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Quchaosheng <quchaosheng000406@163.com>, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH] net: can: grcan: update the binding file reference in
 the driver comment
Message-ID: <20260928-didactic-armored-hawk-8530fa-mkl@pengutronix.de>
References: <20260928112658.2119678-1-quchaosheng000406@163.com>
 <20260928112658.2119678-2-quchaosheng000406@163.com>
 <20260928113107.290801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtatn5hpckwjoqot"
Content-Disposition: inline
In-Reply-To: <20260928113107.290801F00893@smtp.kernel.org>


--gtatn5hpckwjoqot
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: grcan: update the binding file reference in
 the driver comment
MIME-Version: 1.0

On 28.09.2026 11:31:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] doc: dangling reference to missing yaml binding file

I think you should send these 2 patches as a series.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gtatn5hpckwjoqot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarqvZwAKCRDMOmT6rpmt
0hNSAQCS2rb1mMiFv8wMJWOCk5eQzet7G4fD6vPKlxENUgGTXgEA8COZchlFCPFn
W2tqNG3MRWkNkSrpGfGTvDTdn7ifFwA=
=ek1u
-----END PGP SIGNATURE-----

--gtatn5hpckwjoqot--
