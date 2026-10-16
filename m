Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEB374192;
	Fri, 16 Oct 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160127; cv=pass; b=W5EtoMylSHTCRX2xtX4WrfM7Uw/GXFecK7lsI9ZcL4QkO189gt/Qqyuk1qbVvkK5pcwVkgO8v9XiQWRJy1pxUmQUApDGM8HNwLfGplFdM54pX//MVPWBFNGeDzws9AFes9k3wrxiNvTyLmaEOQROAJC9nBk5+DfwRKWXYo3TNtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160127; c=relaxed/simple;
	bh=jjJPz3+489+7IQh3RdiXrv2/rXkqUyJKQJus1lGc0Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKQYtnm0Z2qJWA+5BWQaY71mVARjodZdPvNwkdOawpv3ekO6lFjqpRc5iXfaZ3p2g0JY755EItyQWxD4loCfkVN/OgwGq34YQFkZnWPCp12lcAjJdxTldSz7tivvUV2x+QDMnzBfjekTEN2m+yt5fpyqlYS1kZ7e7zac5f11AqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Sn4F7pXk; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Sn4F7pXk"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E8975202284;
	Fri, 16 Oct 2026 16:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPVQ8QIXyyphvxxQwT35j/SZZ7TT1XX4/ZWAtSfN3oo=;
	b=Sn4F7pXkqear69ZVyxlqnadeeOPfZan77XW2K9YW6bBfvU/rG7MXaZhVcvPBaQLdZ3Auff
	N7bwM/6ysCtl5r0Y4HcwlDRkVyKt7BrM8VayN/kH1VWllg0r/47KPijrDjTAlmyk/R6oRm
	jeS0SBOjcUBqSdJvQyqbu0JC5JAvqbyBTbnhUhNQLhYcofoo986eyBLeBEZblVcz5NgjQd
	i/lPsed73ZJjL0Blnl1KhOxFJjPYc5DKrdIO7lAIpcT8Vmbjg7tDQ4eIoMY4MarML9f3b/
	QzEMPqTm6OFuRBJQDlNO8cuPNdKuyzKVmymIa0nlZdhqCAdnmCePuQ/ZzkDR8Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792160118; a=rsa-sha256;
	cv=none;
	b=fa2J3k4StVj29pCKb8qKwn/aCXz3OqWCX2Zhd74vnUDvHf26CyjOdXmf2KNfwIOIxB3VDC
	8UtEa1rt//+rOS3VHe+0Dmb4IrChaVYISVziRJ2Byfgv/bWx5D73n0EOMSb/Awv4a0TGYg
	zYUAT+TyQ/UI7w7jl7rYhLWdP/rVhgpJqvSUFn2tqbXYNqEL7mkTRyoQSyQ03UH1MbCJF6
	gnOaA9PHfYnGWGE8PWjJXXLRFOWOtx/ixSQ9J06T1/HH6JvkIBD+CRnBw319v0ujUwNbhq
	H6wp7g9K/HEGaelNfp+iutaqOTEUxB8enS9oF63M+tKQBJDYf5vXP4RAf2X0Yw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dPVQ8QIXyyphvxxQwT35j/SZZ7TT1XX4/ZWAtSfN3oo=;
	b=YyJq1Aolo+jRwmX753uleWclhb6FmaHaPOq2XPRA8HLK1nUKfQu5S4ShGaIN7loBIwtUzU
	vAColr0zJgprij0WOfWEMPC0tVuT1r31a7ys9BYp8IIUq9bjtPkr1HBmUDHFKZbianw775
	0P/sJSlwFs+lbdzhIs2Elgyez0ORm1VwctbrnOYs2etxnfUGHDRFZjE1D9ZM64hnaSOkUz
	uCgk8fRDYhXFQwIb7WHJdB+ihEROk2+L1SsmSTJ/SrlnXA3w6Vbz60wx1ZGviahXNwyvjt
	Ek7bW+LhYsXJvgU0cIoOUpR3/GA0kcTIa3yHMPrgUhlZ2EN5Hk4UEkP/wWDVcQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHiiM-006CMU-2k;
	Fri, 16 Oct 2026 16:15:18 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8DBC45C62C5;
	Fri, 16 Oct 2026 14:15:18 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:15:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 20/37] can: rcar_canfd: Derive max_channels from
 the device tree
Message-ID: <20261016-hissing-sidewinder-of-atheism-1a8fcb-mkl@pengutronix.de>
References: <20261015015336.816543-21-mkl@pengutronix.de>
 <179211823132.434549.18097465547112673284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="viz3g6brm3oozelt"
Content-Disposition: inline
In-Reply-To: <179211823132.434549.18097465547112673284@kernel.org>


--viz3g6brm3oozelt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 20/37] can: rcar_canfd: Derive max_channels from
 the device tree
MIME-Version: 1.0

On 16.10.2026 02:37:11, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 (2) =C2=B7 Medium: 1 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] rcar_canfd_probe() now takes the channel bound from
>   of_get_child_count(dev->of_node).
> - [Low] The patch removes the per-SoC channel limit
>   (rcar_canfd_hw_info.max_channels).
> - [Low] In rcar_canfd_probe(), the int returned by of_get_child_count()
>   is stored in `u8 max_channels` before the `> RCANFD_NUM_CHANNELS`=E2=80=
=A6

looks like a valid issue

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--viz3g6brm3oozelt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIxcwAKCRDMOmT6rpmt
0nVvAQDBP6kSA+jy0MtiV5WwtKq7wrBodupjp3rEmb+3CQA8SwD+IIyUTkkAoAH9
InkTpqokiBUu/lENmxzIrKBNppehPww=
=C/2P
-----END PGP SIGNATURE-----

--viz3g6brm3oozelt--
