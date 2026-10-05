Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E235E92F;
	Mon,  5 Oct 2026 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192109; cv=pass; b=q0b1Pe+b9onEOcIxTPKvLDxVL5u8entHgHGFQdmYzeiBuiSCXrVWUWEliaFUtcLxVCi3VPTrtd8lteWU4wt8qtztlRw/9cGyT+aYPeW10+qcxNPcTQSh2yElE0n1s4X1SF85DOcfBdACMLQLzCZbtVUwctFv9GjGUlCQV+vCWLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192109; c=relaxed/simple;
	bh=f/IDcpC4X8nE/JuBIata09YP6FxteM3CpJwO2ppWvKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyy9SkPdcJAZxR1U9JYVG45ix37y6+Ey/4RM9q5mAXFus34Bx/CDGRx0VeAzhjQXXdWvc7RQ4f82b6NEx0Cih2KAx2hS9BUuPv8s69nKgWJwzG2DF0HapAKW+t52hpbfLy0B4EMvv09izuYXIZC4gXORhiMetzVC34msrGsL574=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=bhNChIeS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="bhNChIeS"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF2302012A4;
	Mon, 05 Oct 2026 11:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ9EsnkNdBCvlu/NJAhMt52IFqd74dmsb6hgt9Ok/Kg=;
	b=bhNChIeSjF9nEvAmwfjcPbshkwepRTF9IzlXyNHIhpAbs2erwykKpnDV+0plNCJBzt4gvD
	i1pw1ixg/c5Gko+IbNrW87VnOU/5jV0gH9uZ0i9Fro4T4o695kUs7fvKtACrn3DlqR9+1d
	p6oxh8yru5LspV4Opsx4BUF5JKs9zzvIGW9MXGruFdZachd9BCYF9IU9UxawxrDeXNG6Vv
	/hqKoxgiMK2R1/jEe7JA+dlRd942BXChA1fqmNsGJSmpuJRz7rOtTjVfVylCAeKbsZ4fpN
	RJ5UBxpO549DQty7DOu03RELEnW/a5Dh9Mav2u2D0D/qKtHt/dNnDb9L74gPEA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791192104; a=rsa-sha256;
	cv=none;
	b=F6imI8AIflxt7k/M4yQE6QF8zEo3B1mLO4MLGozAfEjvPLqG0xS0gBzQqED0DlhmawUBEV
	azk9YrqpDdsFCy52WKmN5Jy0hls8fot9MN9IlSou1cTkNNIpaEezAPswUlu6OAsu5HJgB8
	Eqq8lCYmtpEd9GO4m5A9bTtXq0zADCedIThnnvcHki/fDsCk0Vvdda45FGfm2E5AuSEam7
	/AkQ1iCpEAoq7kLfUwpg1+UgHplxOdg8PUCauCi/w1q0hQaJfvTh1eICeqwpioHd1EU+Ol
	dKvB3/a9IIgH8VmDwWskh9nuDwtEMSFHuESHkuAJGdnDywxf6EP6ZVCsrsi4SQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791192104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ9EsnkNdBCvlu/NJAhMt52IFqd74dmsb6hgt9Ok/Kg=;
	b=L2L0oBa7z1WNYWM/k5LZ63yclk0jNUlcYhXZG4RgL4x9z+dJp56GnDAr+8yJdJCaoQAeSn
	fTnevXFDW3gnhmywG1iMr5wAP4cH4WQO7Ct/D41lKeLk9EA8DHQ0CvyrCWx0a+ZaahfCZJ
	sE41gCNNfwGGBRGD8j9f4y6CkDYaPxxTdrPUZHOxMwXuVdXhTL5S5JtY7ba1FPZctSfR6s
	KBwufEouToJFasuCsqyiiSTFWDTJJbV1snW+/WWx2LFKAcr7tA8JJpzyMhbArLNlkMevpk
	MGJtj1NDwz4kwEyET359+e1+g0VxNYmzmV1cDSNAt6vBAqzcM6jkMlxLxh5Hqw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDetE-004MRh-1v;
	Mon, 05 Oct 2026 11:21:44 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD9665B9FE7;
	Mon, 05 Oct 2026 09:20:15 +0000 (UTC)
Date: Mon, 5 Oct 2026 11:20:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, ore@pengutronix.de, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261005-prophetic-civet-of-faith-08ea65-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
 <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
 <20261001082552.514c54fd@kernel.org>
 <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
 <20261001111954.2ebaf14c@kernel.org>
 <57de2511-fb5a-4689-bc21-2a9fe25761fc@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4hqp64zmqojmuhs2"
Content-Disposition: inline
In-Reply-To: <57de2511-fb5a-4689-bc21-2a9fe25761fc@hartkopp.net>


--4hqp64zmqojmuhs2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
MIME-Version: 1.0

On 05.10.2026 09:28:13, Oliver Hartkopp wrote:
> Hello Jakub,
>
> On 01.10.26 20:19, Jakub Kicinski wrote:
> > On Thu, 1 Oct 2026 17:38:17 +0200 Marc Kleine-Budde wrote:
> > > On 01.10.2026 08:25:52, Jakub Kicinski wrote:
> > > > > Don't know Oleksij has done the sashiko.dev integraton.
> > > >
> > > > Let me try to plug you into netdev-ai one for now.
> > >
> > > Thanks, do you need anything from us?
> >
> > I don't think so, we already had the setup for the old AIR system.
> > The emails should start flowing in a day or two. Please let me know
> > if you don't see any review out by Monday!
> >
>
> The new netdev-ai picked some older can-ML patches for an additional revi=
ew
> but not the important latest "[PATCH net 0/3] pull-request: can 2026-10-0=
1"
> which is still only reviewed by gemini-3.1-pro-preview :
>
> https://sashiko.dev/#/patchset/20261001151905.1556270-1-mkl%40pengutronix=
=2Ede
>
> Should Marc resend the PR or can you trigger its review manually?

=F0=9F=91=80
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001151905.1556270-=
1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4hqp64zmqojmuhs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasNrzAAKCRDMOmT6rpmt
0rrdAP9+kAcDrblkDIoA6udlYTww7GHndeTvBXzWecd5bgaunwD/WDw0eFRvHyVh
MQlYAAw5z91KM2Vd9aT73Memg6UCUgo=
=Dw85
-----END PGP SIGNATURE-----

--4hqp64zmqojmuhs2--
