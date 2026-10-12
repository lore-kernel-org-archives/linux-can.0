Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA19548C8AF;
	Mon, 12 Oct 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808616; cv=pass; b=bo60pd7myyYFSfUanWb106enPSsQqyRyt02bnxXPO/i94+QfpFNUKzFBOUgftxVJnd3Ko4dB3n+DigSie1B5xEYGWoDNMJPpyNhWBF9inJHwQV5P3pNv0UBqjZaYXv9JVRBtSKqi6pomHiOJ/RqEHKhiFC+Rqxu4nTa4M+24F+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808616; c=relaxed/simple;
	bh=xbdHCsSR/jfqdsmzOWKXAtsihWjKuz4PYRbA+SLtwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhR0LH/d5bTIPXTuRooJJ7W6Eh4+4ST6QVyoXWQNW94NI1YQN4iY89L93Nl0sjuRi/bLM88KDa+M4AIAN4E4B01fwWxEFmX3rMG1YbE6+iYx4Qm9j8dPdyIKW+myzLWaAwv17IuSuWr3Uh+hycnVoQItEm1QERDr0Yn3l2OrRS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=U4W9SJIb; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="U4W9SJIb"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 98505201D58;
	Mon, 12 Oct 2026 14:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791808610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hScsVQub6oY1eDD6leZvG4OOnEcXhYrnFJoEhxLydnI=;
	b=U4W9SJIbxJpfQmvovE9d3RNJANw7lGUGR1vuUDDNHPeSPVzalGH5w9OhM44VoOlmWJGBj6
	SgRsV1qHxgM1Ph/Z1UTbmK85qCoi0qiWTkDbkzokpRVd7XGsaEE8taxPMntJRSi2AalZkD
	PxbMmOp+T0nypMeFHU1TNSr4hxiTjgHBreRwciNpiRMNykxjaVxt8DwKjFZ7cKYbcP1n99
	mAjmnCJlNIklxsvO81VFVIUyBTIQotiD6DXBp8+9H5TXM+OmesCTTflpurCujhAuEQlvMP
	9Xqi5nIRKyWLOxmYAarOLp104uZ/RQGxzYrivmQYrW5lZC8Q+66aloG4Y8hFpg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791808610; a=rsa-sha256;
	cv=none;
	b=PRFV7zR+xJznq7DWn0P17kbS4W+YrCfgOmhtodyHsCXlR5MgOz4KqRn+RM8Bw5cwjAQ7Bd
	ICk9ieNEW7//ssMtf4pTUKICsxynXrkimdswPdQal2uhq86l8kpHDKt4FbRw2I9PjW0sgi
	6deDA87DC5XLCly6Axj2YAlrlDRZmISiZryJVjs2O6ulTtSMdbC1ZulLcXHJ65cj2spufc
	LLlZ+6I1kfu0MaYYGHFsoWsHZY+/fK7nrhWUrwTVAOpEB69xo2zQRV7FhhySwz9Wyf7ElH
	w8O2L+mxq1pz7HCyY9HWgFNuWYXSOXT5yKIwmLSKHc+L6j3IghnJ414sX4/h6g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791808610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hScsVQub6oY1eDD6leZvG4OOnEcXhYrnFJoEhxLydnI=;
	b=DLFPYxUFW9mEtdZkM3Ddr2+AsU6si4Ijx6FSIOE3SsyaevKFJ5ABfQ0VG2cE1gvcD+5r+t
	GmY+eMnrRzGZtXw720hlVaVeF5piE9Am+Ui2k8EDHCnw1Gqv0cQU00h0xhHwnfPB0/6u04
	qCxXu0phb+FexO2I+8B18UWNKfq+C17+ZB54XnvgE0Y1uTp7Jkk+iOv81Wk+t6m1jR9m7t
	ngpvaUXWNlktEa2SZyaRln+c0jpPadhj0RmJG+WNKwcgAETuBWZtU1gTgeSdrz/8MlCS5y
	34DY6H9uubJJtdrCBLeogXfaH5+XXC6Vzei+PNIADfwRB04wn/Mdl5XrBpOqsA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGFGs-005Wmo-1g;
	Mon, 12 Oct 2026 14:36:50 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 37F895C2036;
	Mon, 12 Oct 2026 12:36:50 +0000 (UTC)
Date: Mon, 12 Oct 2026 14:36:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: mailhol@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: Fwd: [PATCH 4/5] can: peak_usb: validate channel numbers in
 PCAN-USB FD
Message-ID: <20261012-rare-pigeon-of-elegance-6014fe-mkl@pengutronix.de>
References: <179161489475.1406898.15730503460636169751@kernel.org>
 <1269621857.1047936901.1791795896395.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yy23c3ytqbqc7xqc"
Content-Disposition: inline
In-Reply-To: <1269621857.1047936901.1791795896395.JavaMail.root@zimbra65-e11.priv.proxad.net>


--yy23c3ytqbqc7xqc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Fwd: [PATCH 4/5] can: peak_usb: validate channel numbers in
 PCAN-USB FD
MIME-Version: 1.0

On 12.10.2026 11:04:56, St=C3=A9phane Grosjean wrote:
> I need help (or training) to figure out how to deal with these AI bots:
>
> - How many of them are there before the changes are accepted? It seems
>   that even if a patch has passed the Sashiko filter, we should still
>   expect feedback from other bots...

There's https://sashiko.dev/ , which replies within minutes (as long as
you don't include the netdev mailing list).

And there's https://netdev-ai.bots.linux.dev/, which embargoes the
review for ~24h, but runs several LLMs with better models.

> - The fact that there are multiple levels of bots isn=E2=80=99t a problem=
 in
>   itself, and is understandable. That feedback arrives on v1 even though
>   v2 has already been analysed is also something I=E2=80=99m just learnin=
g: so
>   when can we consider it safe to push a new version without fear of
>   receiving comments on the previous one?

Maybe you can mark the v1 as obsolete yourself with replying "pw-bot: cr".
On a new line, without quotation marks, see:

https://github.com/linux-netdev/nipa/blob/main/mailbot.rst
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updatin=
g-patch-status
https://github.com/linux-netdev/nipa/blob/e03d912ce66fd5d427cb9cf900409e1ab=
c6eeba2/mailbot.py#L52-L81

> - And finally, providing more explicit comments on our changes is also
>   a good thing. But when those comments themselves become a source of
>   problems and rejections=E2=80=94due to an overly nitpicky interpretatio=
n by a
>   bot=E2=80=94it becomes far too time-consuming:

yes known problem :/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yy23c3ytqbqc7xqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaszUXwAKCRDMOmT6rpmt
0pGLAQDrnEIx8COiMSG2t2RBbn1yRS2lT/v6F6paBEOAonc+ugEA3PvAj+R2I55I
1j6o9iv21Yj+Fm860aIzajIx80asXAg=
=NBtL
-----END PGP SIGNATURE-----

--yy23c3ytqbqc7xqc--
