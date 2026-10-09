Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF9283FE5
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548362; cv=pass; b=Qqzcc5u3Se+WaDDHCvPI6u2xfDnFMZwQdwiq/oQLQ7wvzYShWiAfdVYu31Rmeoq26OQBZ0PqydOetpfWryRWbq4cOuocNv7uC7PPK5PHTAFBaq8Rt8r+97oBHEmsop+T590PYgXGU3wYUo+Dmkran+mwfrsx4q24vIwsqQkenwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548362; c=relaxed/simple;
	bh=uNdEQFDSKwHuI8UdIpuRTYKEeLtXkStYP1Bm8JXa2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbe/AnJl4AlziPuzRO4z+zr6XgEkZ7hvYPhq/2x9/8hB467O7jzP1kfU2/QnRNbapRI91o6HRyfDgUQ4j5dDXLjxyS2bhwKJ+h03AYzhVIgKl+YnCPus1Xont4ZHz2VRPgNDQwP5xgON39KVmWJR//Nhr9HMBxo3Fp5gWy4Q3FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OZRVNGvI; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OZRVNGvI"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 33BBD201BC6;
	Fri, 09 Oct 2026 14:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyqAAlNgI9B0hnTFtCCm+jA/RV9bzMcC6sDGpEXpuPA=;
	b=OZRVNGvIqQt/SWuUaSiHkU4FVnLc5oWoqqZ9I17y6o+33GGNzCKaqYjPmsDug7gZHImSZe
	pcT2EI4SA6HfeDsojiIQI3QhqQFQsFuedLog7z7Aujse9cskb61fFv0nFL/mumwGPuBXUX
	BUUE8rWV6s+UodynpgvyCp4sHaE8tXAipiCNeQv7tTLUnU8Un8brWHDsU7gRzO1jLPoupg
	Bq8hjR2lNAzfyMZMzO91NXmmtp5h/8ewY1J1x5Kje8s3wGOyCeofz3b3JXGvclqAJu9i55
	5znhMblhtKSE0m7GmlLkwbLmz6agm6M+XLnWP0+ZKK/2QG9potYaUSKSWMaMiQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791548356; a=rsa-sha256;
	cv=none;
	b=Rx26jB1dvvBR+KzlPIDAeEMc0BWooOOgnyE07H+DefSecbhLqiyhYnl8hE/Ig92463yqms
	IoIA8PXa1lPAGQyOKHpIEjJmA8MLfsLuWyhmNGcqeyaNjZDY3x9VF1miu956qk1tzCw3Dy
	pIh+je5s9Z+1uEtAYCpctQYUIulrFVd0MGfoJRuSk/lfdij4CqcDkTwc316m39uS+rp6E9
	gPG2isgNGd2xvZWP6Od0CYjiO4XVK0Hbzh8iRic7FkaG/HJp+EV2RaOPGAGdyF6mA4aUst
	2/ZRb249X/GDZCwC8Xs5sBwm9Q87i73WcxDHCr/8XyBsxEi7DJctA8UW55/tGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791548356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EyqAAlNgI9B0hnTFtCCm+jA/RV9bzMcC6sDGpEXpuPA=;
	b=cu7CW+47PcqLFfkK8WvyRK/hSwWJ/2q5REDC8q/Iv/JPwQDE/xgA2fc7R02GZvm41jexNk
	Lfu8VDXFyb/8ZYJ2EcC5mmitgwS6cEN9i6EIwLT7yBwa18Ezcp2J7qnZ7iQa9rSYd831qp
	hNB9jssZ0yoprrds6D2JsKheF1ZnAKQhD3x3xxzOqk0kMw/5iTnGHJS8KINn47ASrNcm0I
	rATv2Pr2jvCp+6TU4SUBx/6rf9vvVXNpKghEX21uShNNUYk9hHMD3qe7N07eoviX9au6in
	F4X2/goj0xY4fUsUvmchwNdvvalw2fRsdqYjFnS6x8Ldqn6aYZPkQAlBJzRU1Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9ZE-0052lr-0I;
	Fri, 09 Oct 2026 14:19:16 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C02685BD751;
	Fri, 09 Oct 2026 12:19:15 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:19:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
Message-ID: <20261009-beige-goshawk-of-aurora-884f4f-mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
 <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcsglxchw54smjum"
Content-Disposition: inline
In-Reply-To: <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>


--lcsglxchw54smjum
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
MIME-Version: 1.0

On 09.10.2026 14:17:34, Marc Kleine-Budde wrote:
> On 09.10.2026 14:03:19, Oliver Hartkopp wrote:
> > > I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
> > > there has been no response from Kurt regarding:
> > >
> > > https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkop=
p.net/
> >
> > No, answer is ok.
> > Let's remove it!
>
> Done
>
> > Do you want to apply my ml_priv patch - or do you want it me to do the =
next
> > 5 minutes bevore the PR?
>
> I think it's already queued in can-next/testing. Please have a look.

No it isn't - I had to remove it, because the series was split.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lcsglxchw54smjum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjbwAAKCRDMOmT6rpmt
0infAQC7hNy2gjAfKEuFpzPbbW1Q/qs3joaG9Wgxg/0kS4xlegEA3poKa9unv4BU
L3/AbgTWc/68pkBnH3ws65vuWzkeuAM=
=Fyxh
-----END PGP SIGNATURE-----

--lcsglxchw54smjum--
