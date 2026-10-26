Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793011900;
	b=RLCPUEaRs5M0u12Q6NrlaDASnFvgax5h0XRaIEa6aduNZdTP83Mc4TwwfonZ33AQgdUZ
	 Q2RLIcKi0omN1hD+IMAafEmgbyBaasuwejYKBamBDqbQYrEq+GNIo/XC2m+4rKweSFN+S
	 Y0M+bOat782WTvQ1TSYn57EnanGZ5DCyDPhGYRxYL+ueA5M+NOF/3Xg4uqGp9v3gtOn/7
	 Htp8SRXVdVmrjymyJ8Spm7Fv0xLXLsUTeRjbxJhzQ64W3O5MskfRmyvAwnv5p5qVMsVzJ
	 Na49HnbBWBFMf0UIZ+w4vW2P5prDBvU+2x4E4w1pFNm7AX8lD6snMi0SeHtOqEnMP/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011900;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9C1jzy0Jl1SbDDx89yYc5aUl9Knggx/PDZGr+xGgpg4=;
	b=Vl64Xn1EJIhkjVtqbB0qfll5xQn+VRhYVL3lIAhIKBDNywkH1VZOPspHLPskggg5BM9G
	 rBv8v285pWF3qcIo/mD67IeyGJ9X75Ad2EBRV0wEte1X1JU8ALx5v9AUp3XJzNWKmgSlq
	 H3zGFN8BK4mTM4lPLKzrNFJBUR4FDBALvP4FrA+qXRiqCXcNvzFJoo3frPExB2HBe5kpy
	 jKb8jk79fM+7rl9QJlx56H9GPv3hlSk+rrIdYYsm4LdayC7IIChquT85PYUv5RETni9B5
	 5ZLP8clzegJ8ZZp0tkJoGx2W+dDimAeklmvZaqL28iQn7W4CJZV2sI3NS9wWn4PWk2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Tkyn4r/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D22606A31B
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 10:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D22606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Tkyn4r/d
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 749CF20233A;
	Mon, 26 Oct 2026 11:51:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793011897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C1jzy0Jl1SbDDx89yYc5aUl9Knggx/PDZGr+xGgpg4=;
	b=Tkyn4r/dyVisxXqL699JxDeUGtetwsJ6bmvU+e0qc8kDSwc2T1b6Wj/Dt7N8YsxF3vQAJF
	sGmeKXJB4E8VuANeWcEX3kL2Yb1FmZTdw9M+/hOOGczeHiyXETOTDMJ2OhynTKZEqFMrTp
	RRN+yIUFCnjSc6dcQQ3PtrVjZjdeJ0vuFc9DQapgSDl9oNW8B44/c3VAA9ttePT6cg4p3V
	k+0yQaM8uDg5tssNaUoq52dDX2Y3LM8CIE9sBUjbeoMScXIuzV7lNWwl0vlurZSXjn2bSU
	OHWTzKGNksuPtCW/nFjXIayhOpMKoOwPkg563DbEWMsXdOxZ5rMdvX85Fuohuw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793011897; a=rsa-sha256;
	cv=none;
	b=MI+kEizquvIwlgcdvV6HsupBwWlC6W+NmFRs8g9BNkDqXmjFqVzH1CV9oIKadrwt94+HVo
	fqkMHyroxyjFJUsyB9RBK8AfcdmGNGc6438Ovxj2OogTtX4W8xmt0JacqUA1moWcV5s0ve
	TDP2ezDk8yDFwlc9rESDYRISoSoCdWfoj4RJHSZEKOBz5D1zUOGvOH66h2IrPt9S8RrUs/
	FM02k+KsuhoI7euLwEfNWuc+nWJPVrnOJ/hQWh+570uvLPufO4Sq+s4rdUcHn/jIlT0mR9
	GSwKgWy1MMateT0DMiM/fia1ta66FkV5WyAZ9/g5ZELix62Nosa9X3TT2RFXTg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793011897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C1jzy0Jl1SbDDx89yYc5aUl9Knggx/PDZGr+xGgpg4=;
	b=Z9G9x9cEAPue4PRm/Dxd9GUjKfD0FIEr2PBh5X8Zs9s8mVtODcec4+zV/VldBDjwz04GXq
	ROx3omgbn3K7ggYaI4YnKxWzZ8RG7HUWKA+7+7osKbyUxcdEXvmh5ZIeSNFfQYgdJGyiI/
	H0SsNTgp1d3TEFLZayRKSm8MhiP2035JXyKaHGg0K+1u3gsNVAhib72D9Qx8bGrm22JyDw
	pqCnb/pX4U7SeCw1aqhHZQh+XpybzK9fvXeV2m6uneKoDci9lz1fZNMA6fWHSOBDyIiGi2
	vE3DkTaj/SHRih0Qi6VWuktaAO9ZGAtepcl/nf9JfJJWqhYxVtjbmF/rwAzyNw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLIIj-001Gim-17;
	Mon, 26 Oct 2026 11:51:37 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 032995D6B9B;
	Mon, 26 Oct 2026 10:51:36 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:51:36 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zihan xi <zihanx@nebusec.ai>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer
 restart
Message-ID: <20261026-deft-radical-wallaby-52a9f6-mkl@pengutronix.de>
References: <cover.1792979091.git.zihanx@nebusec.ai>
 <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
 <sashiko-outbox-184711@kernel.org>
 <CAANe3eQrZjWanuiFgNjhsoQb7W5fRm+JVFjnGOtD03Z3aNyTCQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="ryiybeakn34fgftr"
Content-Disposition: inline
In-Reply-To: <CAANe3eQrZjWanuiFgNjhsoQb7W5fRm+JVFjnGOtD03Z3aNyTCQ@mail.gmail.com>


--ryiybeakn34fgftr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer
 restart
MIME-Version: 1.0

On 26.10.2026 18:10:09, zihan xi wrote:
> The refcount race is valid: the queued-state check is not atomic with
> callback completion, expiry, or cancellation. I=E2=80=99ll rework the
> timer-reference ownership protocol before resubmitting.

pw-bot: cr

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ryiybeakn34fgftr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat8wtgAKCRDMOmT6rpmt
0gwSAQD+kzZMgey7lY2qoLF6TW6p9/4v+W6mdcqoHWz9TpKPhQEAn/2M4G5YlBK5
Gv7TwWfosBEF1Vkeh1NhVxmtH9rAVQ0=
=yqMx
-----END PGP SIGNATURE-----

--ryiybeakn34fgftr--
