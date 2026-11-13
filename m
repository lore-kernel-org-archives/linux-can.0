Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794590502;
	b=p7x/2l8LnVDX+bdfx80wRamU13axEE3Cerig04gSYz7A6psvcCgGx93qtPbq1vjozHsI
	 LLtW66BfV2FRJcgqcTYTgNghIArb0PzQiYEjGRsSaj3zduAEdF0vW+eXzUPwgJz3brHGP
	 CziUoaolLEtop4eXpDpo81UmvrzvovftuAsPBSHkOzgKf6TNZHE/xv9A8ItjGKA7MoAS7
	 DiRnzfn9u2ixFHaHM1oF+Nrxj36f712+d9iPdKPbDHUGGyaPRc8d2m619A1mPTdDzj9K0
	 88uVkZ1nNj0f/wWP7RxmTG8bKS3gYlDqJNQWqD/AQs3PcueDWIRTvIAup8nIMgFRR+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IYAcHmucbjNit+nwVeZq9uGapEQZWJK5/NA2Z98+w8E=;
	b=ILzuVBV9dJxofBJnPxaacmZda5gJivArPSP7aeBlUAB6P2filyZQ5VibJH05xpyTzBd5
	 47pUa/kTAYzyMCnd3wUBqu5r7UT52Fx1Eb0pnT2IIE1mzhhAgP5yGZOYPAfcEkbStHiWr
	 bNilKdZHfGYeoRb6+1PJLHaZm7MaVfIC0vtbQi5zb6PJ89JccIaL10aORttABQD9E9U4p
	 VjzYLYo2RGerRNnEZWpxBUwRKknVkc2MRlOO0LXDsHRHjkZD3WZ2EzMsxf8KozXsegNm/
	 Z9pXoA7CyVfl4rO7COTFFXLv4G1gBJCd4IjXOhNfb10P9volCmt30dOTNyHWfY9+e4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a8YPFIja;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF86073206
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65DF86073206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=a8YPFIja
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6E386205A05;
	Fri, 13 Nov 2026 18:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794590495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYAcHmucbjNit+nwVeZq9uGapEQZWJK5/NA2Z98+w8E=;
	b=a8YPFIjad4QNmad9ri/vLbZUAD5gsi7hqELkmvarhGblzsgnMBQjbzZZT3tAl3bUEIT9Jh
	i5zgEW/PhghB+g1nKTC5AZ/EYRqNE6OepcQqjEY8S2G6McJ8ZPR9jo1NTT1PmyGafvw37d
	S8TwFWDQOhHODd4yTB/MfT5pqP+6irYQdnbTbhE32ihly9i46+6zEgfFHXQjKCnod9NBAD
	7jkt75gcLOlIoldYEkV9F5vkW8OfJ/YMF58pPvqk0oo7s2zQJnN9oLFfDAZQRtqK9Hr9Wm
	S8H0Y9PnkkT26KMg8PrrSltpTFj8MjhfMqNdAZzJXXZR/B5bfJKbvFwxI+j/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794590495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYAcHmucbjNit+nwVeZq9uGapEQZWJK5/NA2Z98+w8E=;
	b=bll0SMbiJEYqN+Z1v3fA31wha5ts15L7qW35TelLfw7GwB9o90F5by8sEqmhFgPFIC2A0W
	dyM0laWf/h9seOXZJPcJsS6XgJSnEktXZjn7J1uEbIqovoyhHObZYJSUjPfKixritVc1Fo
	uu3cW4Xvs4cIyTJua0FEswaIiAAR0NTS3z/E9SOm0b4zejAfX27/i2pFRIJErDgQUuDPQF
	rWP04wyYrKfu8X1je2xt/FNNRLKDpRFWXT7gVkzVk/dGEILRKW+ErXfBl1PSPXN9dgTA3q
	y/bFhlxHHJnNXFOwx6Z6kwmv2wagNtkU9z4/K3wBfGOFdB1tbmcmO39fkwlo7A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794590495; a=rsa-sha256;
	cv=none;
	b=M9DF5nZoTsxNbays6yhHdNbTMp9n9tkKrI6DLNjz534KlboZnoEelmY1isF8/lDpyXFHH2
	5MDMpQy7ZfwOd5tIC/kixFiH4JWZ+tFoiPaVoEQ1SCBGFouD+SvUn3EiZ4+Cf5rLVIa5dj
	0BRHcpy504svQvYlHUrGqr6kDesTJtTbcMcA3zwRryXEwu/aCZEiqf2oDdkSFYNjdXI4kc
	HT0rUzK1r86YXdgBt86nn2oEDfVD0IDbYYf4dSdTGnn5IVci34mbKpyW10DojbeZpNfwhY
	Rts5+6ktJCP7d4RU9oCrbTlXGSHytMWN5Jg26zo0PXNVXfrd3pDY0SXdMN4EKQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRuxz-0041aH-18;
	Fri, 13 Nov 2026 18:21:35 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0E9425EAED1;
	Fri, 13 Nov 2026 17:21:35 +0000 (UTC)
Date: Fri, 13 Nov 2026 18:21:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
Message-ID: <20261113-raspberry-wyvern-of-greatness-248341-mkl@pengutronix.de>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
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
	protocol="application/pgp-signature"; boundary="ns4hv32xp6bhxsf5"
Content-Disposition: inline
In-Reply-To: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>


--ns4hv32xp6bhxsf5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
MIME-Version: 1.0

On 14.11.2026 02:13:05, Tetsuo Handa wrote:
> Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
> without priv->lock held for write, list corruption and/or UAF might happen
> if the last user called j1939_ecu_put() without priv->lock held for write.

Your series should include a cover letter. It should provide a brief,
informative overview of the series. In addition, a brief, concise change
log in the form of a bulleted list should be included in the cover
letter.

All patches should be a reply to the cover letter.

Consider using "b4" [1] to send the patches, there is even a web-hook to
avoid local smtp servers.

[1] https://b4.docs.kernel.org/en/latest/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ns4hv32xp6bhxsf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavdHHAAKCRDMOmT6rpmt
0oNkAQC4rCIYCus08KJA3EoF/q8mdnqVV58+O6KcZetfo2siZQD9FGLuQMHFUdPf
5AuTCwiVUGJ4afAXp50bmH8xT0ncLA0=
=WZUT
-----END PGP SIGNATURE-----

--ns4hv32xp6bhxsf5--
