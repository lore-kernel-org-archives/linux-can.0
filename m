Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82B4FECEC
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421537; cv=pass; b=a0UFLX4wJrpkFQR+xP+PMh37bcy+VBRINkQAiKRciL6XxulsQ8Va8g6OHH/jYH8NEyAM8jb2h+W6r1f3RMiOvTKEUYrjlKhaQg2LaCC81Y8mddbRTBIZS6hiFvQwXBquZez4Axsk3kVdMFvWB2cEhar2FYFlMkVOzFxMZHYbTWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421537; c=relaxed/simple;
	bh=tMl995VrPMs4KtzJU05l9iWmkiHj2S1Jnzjnn5i6XcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9GCL+L8aOeUtxnjI0H1E+yuViJqe/+r6/jPw/M/kVORyHXZR4yngYBKsuYZyteMYHqhOR9r010kh3DiPOiCMjFYeYz0BLJ9bk6iRSJ0WRdf15lOStFaBi9iqIB9Jf94AI6PKmc+2UVrT2sGvI8YMpjM6gKjNBC61bbgdZbqbzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=V+nbdH1f; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="V+nbdH1f"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0F2C32017C1;
	Mon, 19 Oct 2026 16:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792421533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EaSb3fn8XqYtNZfDA46RMAU+pzHANGdttASkadefJG4=;
	b=V+nbdH1fyX60snyars0kOHkfXwLGvliHIdkChpqYazS7f5dAg8tDXaEZRxRMt+yuRHTPXW
	kM4Xj/IEBuUz3Y8EAOHeMASG0iTLBVcXE1wUV5vz6doD0eP3AQVv8SIGbk9J+26h/H53cI
	hyZgCDieBmkIIqhp1J7Ze17aJAlhLlP8FD+pZDgKgi81+bNF6CmrCty89ofDFnJspnmjY3
	g/1XeTbemPjWqSrKWl3LY0w88ST1mWcV5L8qID2+HnCuy48X96kzYDE47vlY48tRHRZFIM
	W0YL4ziMnwUGYA6NWcfu1sSlddr9P5kHQ1yioPiQhGJJORFofPN9RzVGKvvyWA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792421533; a=rsa-sha256;
	cv=none;
	b=bjYHCHOcKs5eDi30kzeQ9vzZPELzFR3RRncwij3xW8N/DA0sL1jSV4ECXykDLKdVRoCwvr
	9xft3pfXlsM/dZQSnkgzfJHhivjolVrT76qe2Mp37S71blZRYVpxcxC1LTHv9JXLuju7kl
	eO5MWK2qj6YBW+mBbRmuIopgZNGUg3VXLHnYIjAP2mXN4Lu+VqI1pfs1lbqnLUV+CdjOdj
	jMXdiDepy7jLdfrgfZiR7w8WSBdelpXJxFkp9M+LPWsi4Y7Lk/eMZdZwedSlym0h2WjtHJ
	RaLeq8ZaGvFylCfVb12mkbar3rZosrkMQXAzQG+JyM87foFMPrPZmJA0V2Ugng==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792421533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EaSb3fn8XqYtNZfDA46RMAU+pzHANGdttASkadefJG4=;
	b=TUfOukARLZDdjjGw/oS6R+LDToioAG76+Q1WzfJlSLw4KpLPHj3bIboZ2tlLlDTcygmCav
	bFSX6u48WIh+G9LYNswtND+13QeknStmF7vL/aU/R4rBdrJPJUwwe1kKf6swSZeZOUSJ5s
	sNQRayCNPimzrVyQq9HgERczqhaMDFwkEtgqSsm510p7dDDd0g5QGK/GIe5Q1ATqDzxLyC
	xt9FcYotFZZT9UmycFbwU+zy3crfqujfUohKCLtqWLyQY/rHS1fdm6P12zp/HQmaGmwg9y
	DPd2mQFKoYAzIL95cGPuBDkLtFMXSm2Ggp+xEHO5vvAz7zdZ3Ww87jyPJvN08A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIoii-000ErR-37;
	Mon, 19 Oct 2026 16:52:12 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B12135C9343;
	Mon, 19 Oct 2026 14:52:12 +0000 (UTC)
Date: Mon, 19 Oct 2026 16:52:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
Message-ID: <20261019-gigantic-humble-aardvark-4273f1-mkl@pengutronix.de>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
 <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
 <4c81a8e3-431b-4d18-814b-e09cdcff0b18@hartkopp.net>
 <20261019-supportive-coyote-of-efficiency-797bb1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cue6b2hvbm7yldhh"
Content-Disposition: inline
In-Reply-To: <20261019-supportive-coyote-of-efficiency-797bb1-mkl@pengutronix.de>


--cue6b2hvbm7yldhh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 19.10.2026 16:49:52, Marc Kleine-Budde wrote:
> On 19.10.2026 16:46:20, Oliver Hartkopp wrote:
> >
> >
> > On 19.10.26 16:12, Marc Kleine-Budde wrote:
> > > On 19.10.2026 09:42:39, Oliver Hartkopp wrote:
> > > > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that ca=
n be
> > > > triggered when a CAN device is moved to another network namespace w=
hile
> > > > a socket bound to this device is released [1].
> > > >
> > > > Only patch 4 is new. Patches 1-3 are already on their way to net-ne=
xt
> >
> > As these three patches "1-3" are not in your current tree anymore you c=
an
> > simply apply this complete series as-is.
> >
> > And on top if this series you can also apply this
> >
> > https://lore.kernel.org/linux-can/20261019115231.93550-1-socketcan@hart=
kopp.net/
> >
> > to fix this sashiko-bot remark:
> >
> > https://lore.kernel.org/linux-can/sashiko-outbox-176764@kernel.org/
>
> It doesn't work for me. Please send a _single_ series on top of the
> testing branch, which includes _all_ patches.
>
> regards,
> Marc
>
> | $ b4 shazam -s -k -l -H --merge-base=3D@ https://lore.kernel.org/linux-=
can/20261019115231.93550-1-socketcan@hartkopp.net/

Ok, that was the wrong series, but
20261019074244.50391-1-socketcan@hartkopp.net doesn't work either.

Marc

| $ b4 shazam -s -k -l -H --merge-base=3D@ 20261019074244.50391-1-socketcan=
@hartkopp.net
| Looking up 20261019074244.50391-1-socketcan@hartkopp.net
| Checking for newer revisions
| Grabbing search results from lore.kernel.org
| Analyzing 11 messages in the thread
| Looking for additional code-review trailers on lore.kernel.org
| Analyzing 19 code-review messages
| Checking attestation on all messages, may take a moment...
| Retrieving patchwork CI status, may take a moment...
| ---
|   =E2=9C=93 [PATCH v3 1/4] can: proc: reset pkg_stats atomics individually
|     + Link: https://patch.msgid.link/20261019074244.50391-2-socketcan@har=
tkopp.net
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|     =E2=97=8F checkpatch.pl: passed all checks
|   =E2=9C=93 [PATCH v3 2/4] can: proc: remove pointers from CAN specific p=
roc output
|     + Link: https://patch.msgid.link/20261019074244.50391-3-socketcan@har=
tkopp.net
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|     =E2=97=8F checkpatch.pl: passed all checks
|   =E2=9C=93 [PATCH v3 3/4] can: replace ARPHRD_CAN type checks with can_g=
et_ml_priv()
|     + Link: https://patch.msgid.link/20261019074244.50391-4-socketcan@har=
tkopp.net
|     =E2=97=8F checkpatch.pl: passed all checks
|   =E2=9C=93 [PATCH v3 4/4] can: protect the receive lists with a per-devi=
ce lock
|     + Link: https://patch.msgid.link/20261019074244.50391-5-socketcan@har=
tkopp.net
|     + Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
|     =E2=97=8F checkpatch.pl: passed all checks
|   ---
|   =E2=9C=93 Signed: DKIM/hartkopp.net
| ---
| Total patches: 4
| ---
|  Base: @
| Magic: Preparing a sparse worktree
| Unable to cleanly apply series, see failure log below
| ---
| Applying: can: proc: reset pkg_stats atomics individually
| Applying: can: proc: remove pointers from CAN specific proc output
| Applying: can: replace ARPHRD_CAN type checks with can_get_ml_priv()
| Applying: can: protect the receive lists with a per-device lock
| Using index info to reconstruct a base tree...
| M       net/can/isotp.c
| M       net/can/raw.c
| Falling back to patching base and 3-way merge...
| Auto-merging net/can/isotp.c
| Auto-merging net/can/raw.c
| CONFLICT (content): Merge conflict in net/can/raw.c
| Patch failed at 0004 can: protect the receive lists with a per-device lock
| Resolved 'net/can/raw.c' using previous resolution.
| error: Failed to merge in the changes.
| hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
| ---
| Not fetching into FETCH_HEAD
| Use --resolve to enable conflict resolution

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cue6b2hvbm7yldhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatYumgAKCRDMOmT6rpmt
0ngeAP9qUorleghpXKXpUZ7FcQ04pa6g+f+PA70RaVo9EMzP1AD/Z1ZrEjmJjajp
oa8T43zuTU6+m3N8L1fWds2I/NaVQAs=
=1G9O
-----END PGP SIGNATURE-----

--cue6b2hvbm7yldhh--
