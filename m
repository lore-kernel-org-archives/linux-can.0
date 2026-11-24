Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510571;
	b=q5vYzi+TFho2Gh6ffYXxFW/Iy+7+HiIMqqEydQeHjqj4Fr2QDrs6vFhjWGmeNYVYTdTl
	 bV0ZZvoZ+Bpfjm983iIWWj8XvP0ZwY9Trm7+Xje9P4jHgW6WFZRvpJhSxvhVfUhkxByAy
	 xJGajtSzzB5rRhSOX/pGJWSqW5GO/mBuoePL7Yw8OAzgmiSt3h8kpnjwCbDV8jskYoVyw
	 VmW1eUahYxzUYQnLNj960KoLQoeAjv4EJOd4QNTKty4qjEIseycDG5+BoLtfXtP2fnV78
	 oDuWVLdhBNylW+2zu5nB8mD4NHjsaae7wf0FrIkQvPI3C7r9KxXVPo1OdV2ymZAq1Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510571;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=SxlfCHNWvAAq7S9xZKu6jqg0lSAcBds85hY+rySU/rw=;
	b=cvtB0E9oCjskoHkIvUXs30aTu/ayrhxVpyAwffwFGEpDx9vNLIu9WsomjrXXzEH0orX/
	 0BZR8yk6LWimp42uymOGGb3IMGNDA0UzQ712rvve31+Xq0PK8AW9mtzX9kepwxWktiaNj
	 uAtasVxMW0ma1vK8ZzXWFtEFSzszQy4+qKqICDZld1norCOg2Bg3Ep9m15UHet84HopXp
	 OmrTzbqb0dY2ok1wf1VjNadhfRB123+l6AaMXvC+ZZzgf7dvODFrMf2DgL3Vlf0ximUIN
	 dheqrzSlGddGSWfnissY5bmkUrqWzZSfrYXhh1HK6w038GBDzNlB1lFO3j77My0jkUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=diK5UnCw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6B606A327
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 08:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A6B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=diK5UnCw
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 207CE200037;
	Tue, 24 Nov 2026 09:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxlfCHNWvAAq7S9xZKu6jqg0lSAcBds85hY+rySU/rw=;
	b=diK5UnCw7BsdwiAPWRx7muv03cHfxcw968kNLW8ZX8ft8ROEUHw3UpBclr2OSD+6LK1v5i
	5rD9B9rF94MDTuJKVMJgkQ5nBH92mCnpcOy2qHeenVNKnLQOpr8kbNSAoknXDzGHAE66OT
	vvqJhnQJu69d0z8D1vcp3x0xYVXjqFzQafQxN6p9MU1AS0GfrBQpn1/kr5NB48xihpVXtw
	XT3ex3zhYbIXOdPFTGo0r4+sFusK52BjxaSvozzMvvTb5yqXcEoV3GoxiJyeKwwtVY6k52
	BKyU7kvdNuuifxEddaPMy7kyCGGQzEGcGCWYfK1jMItsz1dD3wZ08JuyP2ceNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SxlfCHNWvAAq7S9xZKu6jqg0lSAcBds85hY+rySU/rw=;
	b=EjJ7MsCFk+rS43yYSmcYx6yO6Yc1ebyrNcTDrkuqg5oW6TFH5thRLV7qZjmNqo62uf7icJ
	BSSwPwIEoKHYJmLxH9abGbqqvrcBmDPRE+xo1/fRIY/cD6ArQgM/VvBpTJGhZXOfTAdIZA
	pIiVGFRRkCw1Gv+b4rhyE59F9U6ri9KYtLwxKFwosLt/DLkJnsqq2UccvaMo/Ze9bPjtyG
	7fpIrd88F1aHqPC760RtFrLdjxdxl9XYPse+4vqScmc7mPP6gW8ob6/h4k5fyt9IJCcLLC
	r8OvEUJ16sU3N5QRoG7PdxCuI7GQB15lBI++/nV8YPFRezmbrBMX6rEGJxOBhA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510568; a=rsa-sha256;
	cv=none;
	b=MtIr91ZJsTPJZCzqbFcKuS7WaEN8Hk67iDu3A7+mRKArH+KrXJkNAKluEtfoOH2PyFH1Ij
	qeH+wXKnuP/Mj35Sojt/JhTz+UVCpcpXiygeDKXBWQZftG/I3OXuENGVrJDfP415/pYDKr
	bAEuDCo79gLuztiHoG2pCqPhtceLosOhJzJmO/Rndn++XsJN9lzCnjqiiwUhdQa8L2QNIx
	e9F/qIjvNzJFglNktysWuJxEMnKqfS6OgCN3/BqB56lAFC3tqpnAXUTL697DN3ay+y4uRB
	T579UGieH5CjJsl+NyrYXo9F4ySkbWPKjX60hATUvEufOL7RsLRamI3l9WaFJg==
Date: Tue, 24 Nov 2026 09:56:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
Message-ID: <20261124-armored-mindful-kingfisher-b20baf-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>
 <20261119-gifted-tapir-of-courtesy-408880-mkl@pengutronix.de>
 <f0270895-8e97-4d6a-b5cb-6da6ab5c1ac5@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="pckmg73u4yljhyrn"
Content-Disposition: inline
In-Reply-To: <f0270895-8e97-4d6a-b5cb-6da6ab5c1ac5@hartkopp.net>


--pckmg73u4yljhyrn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
MIME-Version: 1.0

On 24.11.2026 09:54:08, Oliver Hartkopp wrote:
> > make it so
> >
> If it works for you, I would appreciate it if you could send the updated
> pull request today, so that I can address the feedback expected from the
> sashiko-bot.

tags/linux-can-fixes-for-7.4-20261124 is already pushed, just writing
the summary.

> My updated patches have been already reviewed and answered here:
>
> https://lore.kernel.org/linux-can/20261120-can-bcmlock-memcg-v7-0-f6b84f5=
257b1@hartkopp.net/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--pckmg73u4yljhyrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawVRJQAKCRDMOmT6rpmt
0owLAP0e2Lk11PxSdbJmuY+JWcesa41zRyswKz8A5pPE/AglLwD8CNJiwEAU8h7g
jGX1Ezxq6/x7J/sUwtXKGFnMwh3hhAg=
=QLTP
-----END PGP SIGNATURE-----

--pckmg73u4yljhyrn--
