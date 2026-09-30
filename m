Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9444F571;
	Wed, 30 Sep 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759425; cv=pass; b=nua3cW2eftFMaT1tsVH0NBjCg4tvnU3CONnzGD6Cw5VxyH5OC3Bab3ezeLqmsYD0FMgHQhADXTMGxlXDL4bDMu84o5NE4sHNRA1Ej4ewNAhSK/uTFy73eGuxlEfDWkMLpACBPQ8BzThNDlssP7rPiIxlhWRerEPuEsv4bUnqbUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759425; c=relaxed/simple;
	bh=nct9/Nx3C+4l0oA0T/6l4uV8s71nB+zp1yop0l+kc3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhUkwxmv6MeRX3CSdgv3BTu9KQ23gTJUPa6Q6NPTwZnANH4DcWmCyOczIzVhFuGjf1ft90zRCFq9bWZpS5Sbv0vTLKRWQ9/9sESiZG6GcH7nNrKe+vCBqIX+BK9s+eaDSsebneAlAxDbbAkujWVqzohYabanx6CP26Nd65ZpRcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=cMeI52cv; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="cMeI52cv"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2A5A82009BC;
	Wed, 30 Sep 2026 11:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790759420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U36sbeeGfRxFYHE2IN2SCF0g/Itq/Yc3Bj3U3Ma2AUc=;
	b=cMeI52cvgsV+VA3hv9iMfUyxx+9Nsndlrgw0c2VvCXaHPIiGcuAnNlOVKmzPrEbQV5ku9V
	1gcz+8fFLXOIpfjpbYeiZbvrrzVWae/jTbkBcNQ/sMFCYrRK5VNURR6MlTgRGz+1+E6Da2
	Qg3oNOvdFQYRG7ixiPFWB1DZDGrh9UpHsQwU+emCq4f2HrKnFN8pA+qT/929esSsOCNIJW
	nArANbHyHDEekvCS9bpTIwlQwjl6RJ8l44p59iHhMBJHHl3b2uiFJuN1pfNLT9drJrWsK/
	L4Ckk/jEfRIVtMtQH1l1S0fNDFOO0dol1aZUZwpa4NJG2z8BEZFXTDovkeTscQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790759420; a=rsa-sha256;
	cv=none;
	b=hBOaKd42hgjnuC4gTa83r4fxvUjqL5p1MTdBZg2vQjl2OglPg1PIrmNf+buIQqw2BpmK6J
	d++lkndOjrav9PfV6b1Uw3EYeoce/yaantuMv1++iduGoBLo7lb3gpLuDrKQgqYaDTZ2ii
	ntDBAeWSGmJ/j24cKy66if1jgS3RMenwf/1L5F5H5SR6chrIoEZA52cFnbc0IgdfCePWpZ
	9mQUK6bECeF8o34tMfuRX+zQlTKbuRwxWyzP+ajxPQZN9t/fffLoiyWp79lhOZKsLTte/i
	IgnK/+IAZil40NWLibaV6e3OePdu1NThX1vNbSoeAWtFoS9zNr39s4h7qwVSAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790759420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U36sbeeGfRxFYHE2IN2SCF0g/Itq/Yc3Bj3U3Ma2AUc=;
	b=dxpap2QFY4IySUOOIPP5t6BLDVYAPplCsNbXxIivXJFjBlutC0oGOHLjfoj5IBhxxzgzNQ
	jA8IYbyrJdc9C/sb+sBktCYYjFPeOVSY1ZRcEzzoGkI/uSYLqr261DpOqeOwNiaCcIL8KK
	NXuq8JHeT6r5WAvfbGLRgf7iiuOd2IzXU2dOitm5vegOWV3s9mrSx/T27AYQlz6vA0Klt/
	uRGJRpIH0bTW0XzRx5Qh3FLXp0iZ3jDXPO+Wnq/pIduZqP/sTl7sR3HaMIgD5TCYI1Lcrd
	UK6KrQhnNE0iA2HrMXA0RU5ILfSghwiR6ZYKMbFVmYohgQcVkEbyLuIibbTpHQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBqKS-003XEm-0D;
	Wed, 30 Sep 2026 11:10:20 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B9FC65B54CB;
	Wed, 30 Sep 2026 09:10:19 +0000 (UTC)
Date: Wed, 30 Sep 2026 11:10:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH v3] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
Message-ID: <20260930-wondrous-unbeatable-guan-f7b2e1-mkl@pengutronix.de>
References: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6skv3plv2o2ydxmp"
Content-Disposition: inline
In-Reply-To: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>


--6skv3plv2o2ydxmp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
MIME-Version: 1.0

On 30.09.2026 10:44:33, St=C3=A9phane Grosjean wrote:
> From: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
>
> CAN bus error reporting is currently missing for all PEAK-System
> USB-to-CAN FD devices. Add support for reporting bus errors by enabling
> bus error notifications in the firmware for each CAN channel. Parsing of
> the entire URB is aborted if the firmware reports an invalid channel.
>
> Signed-off-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

Good work. Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6skv3plv2o2ydxmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarzR9wAKCRDMOmT6rpmt
0tCfAP0Uc+FvLrMIlMTyyTKmRQ0PFk8wsDZEuLE0IJ2TjmtVCwEA6UcKFKIWjR7O
xb/5/v1NLEx0NC/aal2vwCp7F7sTxAU=
=mdLW
-----END PGP SIGNATURE-----

--6skv3plv2o2ydxmp--
