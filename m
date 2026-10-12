Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54486477293
	for <linux-can@vger.kernel.org>; Mon, 12 Oct 2026 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807689; cv=pass; b=ewmc5CMoPYiF4g56+YTv3g34ZT5KD4gcQ+9S+N3MTjq/XBBWhL8zSNgqybk4wS7lUFN5lS422jhaB0fxRcaWr3cOxpa6hasoOz70SS8vKWIk0OrIz3NpqoOmasqDiomucSyhW0gIV127qY6qxl66Zs9Ep+zq4IfF+Ss+3INfdBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807689; c=relaxed/simple;
	bh=FQKnbRYUa++SOc+P4t3M9r0z2RSpEe89Pdwvc0+HBag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFBrOkkOtXQTWHDjjGKyTKKUABhgxbCycsxA8atOnrGragiEO5jj8tmiSj7TDuC6lxG7Nttrs3VkubSHk7sW6L+OPoPTziX3jXn0B7yPCo9rIyCMEnvJ3FB/JfCSEm8DGCLjZfBdB7G/cdx0GN4VpoNNR3Md+c/Rq2K7V0VDiUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZxYJD1Zu; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZxYJD1Zu"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 10E87200153;
	Mon, 12 Oct 2026 14:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791807684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXAldbxIyhG+3WZtLQf42ZTGbnb9GQrrDD4OxxQ2LuI=;
	b=ZxYJD1ZuBxu5yTRj2WzAwz0gc2mmTl+LWWELB07+A+9gHJgPghlaYR2Jaq828a1WAvVik+
	44t20MuBmclM55jsjBIaj76vt+jlmUSetq3ql8vSPWr4p5DJD6mEhoNQSyqfB9bFItL6uH
	PyBGGKgRNCXzDyTy8hRNuVy+lSduETFD1MGzsVqLCUr7Ubsothe15WQnUJsGSA3niHFP73
	dljui7zqD9qhseLwQb1T5kXTPVAsh/T7yE/+e0khLcoaoYLGLQkQkSk/7YFYJvW9ChrP5T
	yN8hSv1A1Uoc6w6Ts0EgLX4XoTq6Hk05ghyE3Rm/CJVMubed4lGM2ZG9+g8Alg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791807684; a=rsa-sha256;
	cv=none;
	b=HHtHEeOLMJRu73FR6xIDBsYpnLUREOqF7uIv3/0+OQuzlxhSpZGm2NXJwX23UgQyZ6yAua
	7sndvsS6kNNbSV/f5MnAp3C2dmtPjKn5NhkBwe56sZQ05qD8rZeFbWK+b7Qb+6emj9AJEP
	4H1Z7Bd+2weNooM7GrsAWEF+jTFAxSihKiopgkjr5KwUwpj19+hoiH2WnPC1Xxq6L7FZmQ
	NOf8oyZTCJR37AYtEex3JVMoo0I4xySN+H8JaBGgVV17R0Hwt1w5SUUn8+BXuXIQNR7FeU
	9NGcHQB7NqLLGCO2QrsNzE28BuWEpA5oFNndEcT9Wov5gh5H/JAo4c+XwIleZw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791807684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXAldbxIyhG+3WZtLQf42ZTGbnb9GQrrDD4OxxQ2LuI=;
	b=f4YtWuUcSY4i+lhA59sGqqxiokyY3NOBp5Qbv4kD/s16iDjxeEFrmxZ27n1FAjbUJhFzor
	66WZghth5s6dTL94zUfmkmT8/baNhIe8XZUPX3XhE1QdXp9DR974LwiBM5jTARisC2cUrJ
	/eF5FJswlR50myZVkkHlHczAYHE5z/oM1/XBDl/93C4AGsZMTRF3pvDHYZcdFoVXr4Q9K9
	3JiH1+H3zjQBvmrFs6aOKNXj3ohWHvMKwaGKC6xCnTAoQ1QrvEMTauMJKxXacSmH7fOT6C
	Ah23asoGsbW0mnXAyeLf8rK5ILioVGOi1oIKz7f06Wluw6VDbPGS26ez7pQMww==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGF1v-005WY4-2x;
	Mon, 12 Oct 2026 14:21:23 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A58765C2002;
	Mon, 12 Oct 2026 12:21:23 +0000 (UTC)
Date: Mon, 12 Oct 2026 14:21:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [can-next v2] can: proc: remove pointers from CAN specific proc
 output
Message-ID: <20261012-fresh-anteater-of-artistry-864958-mkl@pengutronix.de>
References: <20261012115851.3412-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7gmus2tq6y35f4dw"
Content-Disposition: inline
In-Reply-To: <20261012115851.3412-1-socketcan@hartkopp.net>


--7gmus2tq6y35f4dw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-next v2] can: proc: remove pointers from CAN specific proc
 output
MIME-Version: 1.0

On 12.10.2026 13:58:50, Oliver Hartkopp wrote:
> The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
> check the internal filter lists (af_can, can_raw) and the efficiency and
> functionality of can_bcm jobs. While exposing kernel addresses was
> acceptable when this code was written the times have changed and multiple
> attempts have been made to hash or remove such now sensitive data.
>
> This patch removes the disclosure of pointers and instead provides the
> function names and sock inode numbers when available. In the case of
> KALLSYMS=3Dn (EXPERT setting) the function names can not be resolved and
> (unknown) is printed instead. As there's no known tooling around the CAN
> specific proc output breaking the ABI with this rework creates no issue.
>
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I've replaced the v1.

Thanks,
Marc

pw-bot: accepted

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7gmus2tq6y35f4dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaszQwAAKCRDMOmT6rpmt
0uTLAP96D2J69pmRvJjCPNoUQhUVMEw5Z8bav4nThdwI2ssH5QD/W0SSD8ZZeSCl
vtKyNCZzUIw3HvaeXZVoQbSDBHingQo=
=Z0a5
-----END PGP SIGNATURE-----

--7gmus2tq6y35f4dw--
