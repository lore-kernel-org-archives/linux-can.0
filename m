Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68547F3B3;
	Fri, 16 Oct 2026 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156125; cv=pass; b=jLnOgu/SmGZ3t/eaoL3WARnk8tW+iT/pUrC90J3irFa0vO8PYCfuUKmhE0PQ5qZblA3C46PO9dhctqoQ3cHQeTr0UKJ+QM8Ak9PHQEspNPbJMC/EiHrbbmdvGOG44EcJor1O0Gd20wjIVJ73dxO9iy1UFQztXimrDrs4evsdzKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156125; c=relaxed/simple;
	bh=l8OPRfOyTUjhA8e+Owq9WybJJ6X+xrMWvll0MdyXk8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbmYE/e6sGjCFyZv162Zrrgfby8mKoosaP8CQj5TuyiRFjx+uRNTsP6JUf3bTf1tmN8ajv5FMYHOj1k0i41e7SNzWGZOum409nK5LRCAYxvL287ssNn+WxaUDsTU/Q3DlleEnuikzAEGBuYPtY2OurM89oRZfE7ES+n8NrVWzTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LfyPZvVc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LfyPZvVc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D69D120191D;
	Fri, 16 Oct 2026 15:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792156121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsuiChFjwGDyB7+l/bqzFLHTc+3rZpy+97B9UadVP7Q=;
	b=LfyPZvVcAs1BCR3gNa9d6PcD92MABr4FESSyrdgDMs9Z2Hq2XIM3Ntknx/HVTd1B0Jf4T7
	1P/nn+Hk1AAwApLchIN/5/DGkxW6ugGp6S99pFj/Nbp03+Xgvxb4kii9KCrEfanGRFnmzT
	aIIyxRc6eOhMCl9Hh4KFPOxMY6FI2rgFYYlGAj5mkYQVw2q9n53mKvrz9KSHgqMPpxETZq
	yacj+mmW/KDYnjvH7pEeHtjeaO5v1mDf78wQNW3lYogJoZa3sVExsBFtgB7N1GePDfUHaV
	z/rhb+AiAO8+iqupIfDDDzMSA8zee+4DB8G+tj9cuYfvNPfry5rKKAE1/o/5rA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792156121; a=rsa-sha256;
	cv=none;
	b=Xy2eHUNIAkXkSLuzV5NkySBWfS3gRrMre+MsoqE1bUDCMUTHLXkdcv0KRDMma38+6aezso
	qS0rfrlmw6RfIQ08aPC7J+2hgZBfRvAe+j3kJfExZMiskTo32FHnR/lD9v29Dbs0fsN2Jn
	BNVsr7hcHcoAJ93EsBSJwRSHJ1nWW+UPVZFfKdjiEY3BA5FKjlQ8t/F0C9xQz1qzEHYgqn
	dJwV4Qa8pQ6YgRao28AcMtZ9BMwyjgshr505Oq6xLsZ7GB6KmJsyFzHdxOnVrilp+ojNjY
	7BfoNOwIBci5fBHMWOY8S5PL3iUlZEuL0YUXEF6Cv2lLKnCl6ZFB2CWVaG6roQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792156121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsuiChFjwGDyB7+l/bqzFLHTc+3rZpy+97B9UadVP7Q=;
	b=V+mzmuvpQPpmNlKD715SvDkJjEh7QXb3Ks4TmA+WlxNdrcd7UfTGC8HilkSGPWYJIXeQx0
	Rg/fscWIKPyIthyRCOAC4ZsN02OKgVpiwH7Imx3tVtffAkLB82DPFVEnczCBrmD31hVdec
	5z7Uzxy6bJz7rRAz1vqGqlwyHOQNKnm5u8AUTzs52rY7J24MD5CwndLfh0Vrt3X9AqujFj
	0rMzQ8loEnEeiwJrtTFYfSApPNUWG6uClB8gRbrrfyuPPDxsBTxSUdMjCTs7xNTkR8fk69
	8+gAoayksLTYis/F/6lNG7sjDjFJvMjuDWnBhj0+Odn3FgNdXGA/Mir0nk11pg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHhft-006Bjv-2R;
	Fri, 16 Oct 2026 15:08:41 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 831E65C61DF;
	Fri, 16 Oct 2026 13:08:41 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:08:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 08/37] can: bcm: fix filter removal race between
 release and netns change
Message-ID: <20261016-sensible-evasive-hippo-c04bdd-mkl@pengutronix.de>
References: <20261015015336.816543-9-mkl@pengutronix.de>
 <179211822523.434549.241636889494644724@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lj43sgrs57t64oxo"
Content-Disposition: inline
In-Reply-To: <179211822523.434549.241636889494644724@kernel.org>


--lj43sgrs57t64oxo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 08/37] can: bcm: fix filter removal race between
 release and netns change
MIME-Version: 1.0

On 16.10.2026 02:37:05, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The commit moves remove_proc_entry() ahead of rtnl_lock() so
>   that procfs readers cannot stall RTNL from close().
> - [Medium] bcm_release() now holds the global rtnl_mutex across the whole
>   rx_ops unregistration loop (rtnl_lock() at net/can/bcm.c:1951,=E2=80=A6
> - [Low] Stale comment in bcm_release().

Valid issues, should be fixed.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lj43sgrs57t64oxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIh1wAKCRDMOmT6rpmt
0gjzAP0cV/5V2h+5w1oyBAgtVl97rchjVhFfsdOT2DsNd9Uf+AEAmQ25kdaCl6lE
2nkIWE4m7hio4p4ePDN0MxuuZSd/HQ0=
=D597
-----END PGP SIGNATURE-----

--lj43sgrs57t64oxo--
