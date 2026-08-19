Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07583CA49C;
	Wed, 19 Aug 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120639; cv=none; b=mahsRZFqQJSf9PqH7efSH59iVR9U0cvaOGHuAmuraHqCJDb9UK1jpt0NYYF5e5k2XZtuMu4tQIRYlih+dmBQTeug0HL6vHGoPZVj5Vo66zfCGg33YNZlngA1MUwjIBJz8ocfcsaBbwVEQEzGC9ekoP/7V0jpqONkgGxqR9lyL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120639; c=relaxed/simple;
	bh=/wp2jrG17RCfDv0H/ExV145gCguKYlA4T8nytaqOPcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDqUpmvjp0vEYexcawwKrkL0zjobetdR3ZDgyy6fJ5gWugDDe6fRh1p8558YHxOQoV3SDijssY9CdghveuTLiLynIVa4KzWSMrqo8asw+UkPD8BONDFSX9UNBBZ8ip1Uz5E884PYbtfqXDDu/cplz7gSCxb/0ojr2vecsVmfs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 91CB82010D6;
	Wed, 19 Aug 2026 08:23:53 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwZiL-002FUC-1c;
	Wed, 19 Aug 2026 08:23:53 +0200
Received: from pengutronix.de (unknown [89.207.172.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A533E5860D9;
	Wed, 19 Aug 2026 06:23:52 +0000 (UTC)
Date: Wed, 19 Aug 2026 08:23:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: max@enpas.org, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net] can: can327: Fix stack out-of-bounds write in
 can327_handle_prompt()
Message-ID: <20260819-unbiased-impossible-foxhound-c525da-mkl@pengutronix.de>
References: <20260819054201.67294-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uz32m3vh3qb3xjw4"
Content-Disposition: inline
In-Reply-To: <20260819054201.67294-1-baul.lee@xbow.com>


--uz32m3vh3qb3xjw4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: can327: Fix stack out-of-bounds write in
 can327_handle_prompt()
MIME-Version: 1.0

On 19.08.2026 14:42:01, Baul Lee wrote:
> can327_handle_prompt() hexdumps the frame queued for transmission, two
> hex characters per payload byte, into an 18-byte on-stack buffer sized
> for a classical 8-byte payload. The loop runs frame->len times without a
> clamp, and frame is a struct can_frame copied verbatim from the skb
> passed to can327_netdev_start_xmit().
>
> A CAN XL frame aliases struct can_frame such that canxl_frame.flags,

I've a patch pending, that drops CAN_XL frames on non CAN_XL interfaces:

https://lore.kernel.org/all/20260731-drop_canxl_frames-v1-1-7387b70353b3@ke=
rnel.org/

So I think this patch is not needed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uz32m3vh3qb3xjw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoVL9AAKCRDMOmT6rpmt
0j/9AP9hTXKmBlXXGCGMwMkqM/q08jtmDereev4CL4UKd8OU7wD+JEywOWofuBeh
fb+rnujBnFkMFQ21JTvlA6srPIZ9GgU=
=FS/h
-----END PGP SIGNATURE-----

--uz32m3vh3qb3xjw4--
