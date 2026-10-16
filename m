Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BA4AC153;
	Fri, 16 Oct 2026 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156071; cv=pass; b=c0DqBnGit0EAbXE7GKo69sH9IIDzKcn7VUHEabvFQlYmR7EL/KwSh0b0IfqKg+6tzfr9W3o48WZmYULzzbwYaXxSGpxL+7CTTA0pGbBrNilaqZRU6bt1ttgB36fGQqqPgZx0FYn9euoS3wGcNDyZaUUGow2uzo92LK7/zKumr/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156071; c=relaxed/simple;
	bh=G5PewHa1kGUtmPzvpl0umIc2YyN/m22bpuMOB9b2pTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHM/aLdDBpevZQplFOBlJ/gL6Go2pREx8li0oItdyPG/+2yWhFxr0LW4/jdhBKa62RWU3ZIR1aBvjvBPadJ/Xr8rF3TWzFDJw7HIn28F6k2rEEqJMNRU6rlc9CtWTZ0jWfq5Q4Q+mxUhsuH6yKUB7zHLGMUv2zxX16UNwYs+3Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=IabUxbFP; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="IabUxbFP"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4CFC4202381;
	Fri, 16 Oct 2026 15:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792156067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ye1AL/hVroUhmHjg/xlGGb1OMIXRdg354muAkQrn+A=;
	b=IabUxbFP1gFyQPaKp38N0VLevSXzFuwSf9bAeSLPJebQz19pG8bc1G8sRQVBkyHIF8nYkW
	DGraihJeP2xKyHmiS1lZMWL3md38tkmF0EKoykRM2Za+/rgG1GpN8F7nqEZJjHw8eOQSup
	0vGJidm+bQR4ohtjISkASN/DDXqcJMcab4PCbgJ6+e8stwLvY4G70mn/3GRkBMzT1rcZIz
	HM0sr1fpq2NlMWiwKzOhz+QHeLZdEcYb09AJonx+4UWTaD7KUVCaplJ1L7DENCWubL2vw8
	lVWzaXXDnvjcX6hS3UEY5AhRZ4IPks8U2OKkwIboprDfcGaSTjF8td3Olz7pyw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792156067; a=rsa-sha256;
	cv=none;
	b=TzXDU70kB4iR4CIWNeEaRDhLKEenWM/TzgagacvrSLgCP/bGYdCYcnleZBDNdxLmV6/OB1
	jr+9lw1p3ICvexzHRgoNTBkcixK1xqri34uRC25na7Zboi1ckFkyKufVjwt5204AtplvC3
	u7EmZP5t8PLZPyElHLav5S6TrGsl2CEx+qWMbiYVn1djjf3+BpOaf2YzaU7uqZQV6EY66y
	6tgbM9H5Rw7S+T7CvkkRMwNg9ZcJo3WC6pI2bdSz+rkezoBzgXD4BZ2fR+0uStrXDuH99J
	A75ftdDJGSQm0+11dJ6vPRfAcJFzc3dzb0odp9d7vEVKkMM/mwzyjvx1YZSCBg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792156067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ye1AL/hVroUhmHjg/xlGGb1OMIXRdg354muAkQrn+A=;
	b=GvQ9AXJOM+xxaagl3YM/asVycCY6t7vRK6HqsKSsmUwM7owsqd0Cn4gM8sInkNKAgQEVVd
	wYIxOpbR2G7qvinyh9n3DmdY11b/nq5IEVhWFf/k7MpCVMISJqv9zDgXHTUJK4A1uag8Rn
	9M6Ao64n6tJBUgH+mvz9K0rItmhuX1x1Cp1FRbx4dYkwEZIDOyv6CVRf8ZGHhRUHIpbudQ
	E3dhOGYS85AdFPM1DWd8X7b4cfVNmMv6ExV7GSpLZmpJcGhM6tQePNRYiRtF//W1t7jzgM
	JdMe8zXcD2GUgBhpeoYqcFeOmxN/5pZKGl9kh0e+224ONyqvUBMEhM2xRYSt8Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHhf1-006Bjf-0c;
	Fri, 16 Oct 2026 15:07:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DBC2C5C61D8;
	Fri, 16 Oct 2026 13:07:46 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:07:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 05/37] can: proc: remove pointers from CAN
 specific proc output
Message-ID: <20261016-impossible-lucky-reindeer-d50334-mkl@pengutronix.de>
References: <20261015015336.816543-6-mkl@pengutronix.de>
 <179211822419.434549.2749733586204077125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h7qmez3iajpnxox7"
Content-Disposition: inline
In-Reply-To: <179211822419.434549.2749733586204077125@kernel.org>


--h7qmez3iajpnxox7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 05/37] can: proc: remove pointers from CAN
 specific proc output
MIME-Version: 1.0

On 16.10.2026 02:37:04, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The new CONFIG_KALLSYMS guard in can_print_rcvlist()
>   (net/can/proc.c) does not stop the receiver callback address from=E2=80=
=A6
> - [Low] The updated text in Documentation/networking/can.rst says every
>   rcvlist entry contains 'the CAN network device and the subscribed=E2=80=
=A6

FTR: The found issue look valid and should be fixed.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h7qmez3iajpnxox7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIhoAAKCRDMOmT6rpmt
0o1rAQCqH3pHLDq5D3zgaIazlZ97zqnJexsWupsCL2LpDpKT7QD/X0MH9H1cDhIm
04iz6AnmwlFPOF9FWE4GzuIKy/bWagY=
=oIOO
-----END PGP SIGNATURE-----

--h7qmez3iajpnxox7--
