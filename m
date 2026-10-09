Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB73E7635
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548263; cv=pass; b=eib7u+G2QlkbRbAyN+M4USHQ+y4/X31VctdFqGX8iLeqHKsnJe/jM9x3vHKIaL8NWct+ydp96boMKpPiuOZVgmhjwkhKYxjb768cQMZ48l990nNF3QsGdaR3WXuGPE1jpZb39aWOtaScqdmytwYB7pflmCIR84Is+HaQTYwqNLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548263; c=relaxed/simple;
	bh=GLFcb5BohioUbrpkcnTGmaJhfQ6ptmgWYBP5dCMyORE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Geb9I/FlPdp1zGQJBjs+JDChiNr58cmESqjQLs8K//9S+dohSufJ1tlYl5MTZG5c/Di/HneBqlWNc5E7WHrdIbDAPhB42MSCtAutZEFLBt2m0UyyqWiuspJEkuZY6xfFoJUjbhnlnEexzUvN+xqiyMQq7YROxqVgtT69+fgL9pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Renbb8qt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Renbb8qt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 88639201BC6;
	Fri, 09 Oct 2026 14:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgY+G+bv0p5pdZWvT2RpjJeWHK1n0T0G9nPwLbs9jYE=;
	b=Renbb8qtmdxwfqvWMwOvIFRN0N/t/9eyjr6whomazNUpaIKU/8Fk1NpwUTLMHho6fGcyL7
	rL/oZqRLo+G+/QMga/EpyCgIg/HarfgM7oJAkQsC+WG/Am+/LQBpawEHyhXhO8C8msSAMY
	7p6feugzN7rhpq1Q6VbCuNorWfScRFLya4zbnQ9xhBC5vBt+jU86k4wHqudtgCKdcj1rPy
	WVvr+fhdUWWZpS4zZ8vMDnLE97PgFbyKyZLDsjNDh33GMA7COv6rqaXTyMlPDQaeR5Tbr5
	4YlWrK7z+oK39fHPstKeDw3qNBHDTnasWRoF0ytFfIAuZmB1fUedGCLLPZYVuQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791548254; a=rsa-sha256;
	cv=none;
	b=Q0Iu14PyQOHL+5MztEIO/nASR85WiO2JVW3fBB39ATYXW/KpJFxBz/wR/95dboUpFQrraP
	GQC8fFfhseKyh6ZOvK9Qw0YnYdkEnnCbu7hd6ROKbAfqs2Xu0ATXy8BB2ZHN0SzT6q9QU1
	q4j1eyjb59bug3rFUHBfzUguR00PluVFIBtChJdH7N11Q4Cl+E93fO6/7Ve77HwvWRv1gQ
	uqlv+eSsxNRFOV26ssd9fZPVb2NnObtysE6RMot8PaEhvBBPM+Kd7QgGwOnpYvYOAIt2my
	0+4jPgtnBukSXa5+VAgxJ0VeuERULep8L80jBPoPnHIUHXu0qGW18RXFaN9V0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgY+G+bv0p5pdZWvT2RpjJeWHK1n0T0G9nPwLbs9jYE=;
	b=Jz0iFcLdeb/IBwrQ8w2i0wdwUMSI39DRRJYY5+c7dGRtXX7UCjYGY6sY3Obu4Ph/pKBal5
	6RayMq/bf7lv1BwQjfDRQ2x/OS98aR1Z/3WQxb22fLm4rSW3xGOh55YQPEghQsydwzXCfi
	LnkAK17WAclVmrA8szwe5XRr7wgGvDMBQUdNlVTb9bNhVOl3TujveZiFAxwU6i0tTstBuU
	BBWNX00bMkG3AknlxaksBikkHK+qAoWYUIV1EWRDH2i0IHa2hStb4L4yP+GhPsrPKvKsIH
	Drf2KGUIP0++alim6PTUgsjaEbMpIsoFXhi3AWfm1WkJDRq5ozSfcpsOaRHsmg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9Xa-0052lf-1T;
	Fri, 09 Oct 2026 14:17:34 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 236B35BD744;
	Fri, 09 Oct 2026 12:17:34 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:17:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
Message-ID: <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7o3xxskf5nwfrg7d"
Content-Disposition: inline
In-Reply-To: <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>


--7o3xxskf5nwfrg7d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
MIME-Version: 1.0

On 09.10.2026 14:03:19, Oliver Hartkopp wrote:
> > I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
> > there has been no response from Kurt regarding:
> >
> > https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.=
net/
>
> No, answer is ok.
> Let's remove it!

Done

> Do you want to apply my ml_priv patch - or do you want it me to do the ne=
xt
> 5 minutes bevore the PR?

I think it's already queued in can-next/testing. Please have a look.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7o3xxskf5nwfrg7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjbWwAKCRDMOmT6rpmt
0msNAP0dBvLvcXvdPg+IFbQ5aZx5VeJjIQQAVE0XO8x+oJLEUAEAwkkTnu5iXXNs
FjFWvzAIMcOlUneq5A0hutxO+SBD2go=
=1NIR
-----END PGP SIGNATURE-----

--7o3xxskf5nwfrg7d--
