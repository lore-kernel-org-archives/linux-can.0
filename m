Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792672709;
	b=qjr2JL/NrBlq2FZTQk/Rjl48Wa62miASAW8B3bAGtWqlsRIFuD9DfyMzl/cvfP4hn3WL
	 +FY7JvSMiooBIeLiIt9ORYjtrsy25EUEOrrrA/4Hkfv6QI9zVYDUGpT1itocJOgzKLO1k
	 YNprHHIISEk1BNl0gSm2igvFIkMNk+iTWNUo7A6vTLDbvWsZ1k6gFIBGJCfu/h+rnSOyt
	 JJ8ikyykeOWiGe/enM6Mb92K3pQnFEF9DGKjvunFZhdGdw2CERgy5pWOYA9aK9dtjbvIl
	 zjt6nNh59mvC2ns+StDUF4dLXzCaAQH1lVb91QpLkcr9wQKfqhSsBqBSemqa+L34uGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672709;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t62x5thVOdG9tagFku8ZhmFLcDt/lobzXAw4Hk+Jgcc=;
	b=ry04TvqTvzmdg2XYWY+81sFRZaItU3CGSj7M6ddsDi5GMnzk/fnNUQdedadlMjEvieF7
	 T0z2fvZowsTpYWrm3EyNnm62Whd0Oinr8fbyK0J1fq6gXEIkqkFyg1IHmgYl4Feak72ST
	 SQII0ZZPQnZ6AkonvXxLJkwgXF/Rrw9prJwZEoEcMpXcNyicfQM4YZP3UzhQqMXvtaaxG
	 4GHI7lLryl2P2wpUxNY1Tl2jeioKzbViMDDZLP6bMwo7Woxx21jN0O2A9nL3UsDgZ+9G0
	 aLxWmSumihgSzFiKFyIJVqNCI5cqyFDBTi1KFcv/kpDeu/iEief6aMECBR2gKix0btw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IkTrUO2w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6541606A319
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 12:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6541606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=IkTrUO2w
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2FE482009B1;
	Thu, 22 Oct 2026 14:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792672706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t62x5thVOdG9tagFku8ZhmFLcDt/lobzXAw4Hk+Jgcc=;
	b=IkTrUO2wYJ3UDbQO/FZO/gq9xRjAEZLtckLJjDyjRmLEiXLIGMoGST2v8E1AQvx4Zh7eed
	NW580wFqa5xoqEd8eeUXYAeoNhjAb35CVO4RiMsR3dt4AfU4g0G2UL/8xGGfiFe6WB7Te5
	qPEA3fR/n/SggbK/bi1B3X0oUSZnuHIoe0eA2KN/L06G/ZMJNF/dfEZa+PanEgTriyswc7
	2OSeC7ljbRtxLVEtISvUpYWKMM2o8gvmtjavFCz0ajkxxbk935JFLrBNXNWmst1Cm8RCmA
	qqRHRXLhGlwG17wWiV181U86yOqnEyV/+GWmng7smUWAooONsYTPHinYixqEJA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792672706; a=rsa-sha256;
	cv=none;
	b=BHeS6Y47oc8DnLhC63vS9MGLpTSwOkI6vfw3c8i+RcFZJAKjcg514JZjcm9RCBi591XJaA
	bZZ9nO88gVepdkTJNfnd8gtRVnlwDXKHe0zov+aryYy0fekS5SqqRRF1lap91p4eCyF5Fb
	3PdQLECoKjy4pF0e3qhV0WageYWFUOrmpc/kuhcjprYkNYIrmPaMIoD7zUmGvCmdkT7WHl
	V1SueTMryGRp2/e7Td+d7E++TRg+6G7JRBbRVI91Xw8ukEZGBTMq4/t/hnHtBT2KVfZgTC
	HWeTMk5AFudWnY2fC34G9EurGTWheAyKG7FxF7fXvWbsZ6nra8Z+XqkH1un9dA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792672706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t62x5thVOdG9tagFku8ZhmFLcDt/lobzXAw4Hk+Jgcc=;
	b=SfX6ChAFdkrpFiVuZLyLNOIcw6HkFNqPDlpI7UT1+c0BPn2EjJI40j0DG1IOxuSKMRSdq3
	fXFnTUU85CgvyJJXJdhVGMvy1m4bfpVnNWMa1ZTXLsMKtbIkGQaSaEVyXsnftoPihJxFIf
	wj6fSipsb9/ZAO3HIxlflBN5/bTYRmQebtEoox+l+UN5bS695YfoGADxTWdq2QhELtoWGR
	j6UL/AF4F/PAqoZe/xmCRAUsuQb/DY2SWYpqxZTTJ4LnDQ4KSbhrXUtMWTEpPFcXhq8oZz
	6iW/qj7ogXuROzW3mK7LLBP/d2HbmPM0BFgqp1M0it5NWLxMoKc0EXc0ojK2ig==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJs3u-000hzW-0H;
	Thu, 22 Oct 2026 14:38:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:46a6:1197:ccb4:99ca])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C24245D0E7A;
	Thu, 22 Oct 2026 12:38:25 +0000 (UTC)
Date: Thu, 22 Oct 2026 14:38:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v7 0/5] can: protect the receive lists with a
 per-device lock
Message-ID: <20261022-angelic-valiant-honeybee-049092-mkl@pengutronix.de>
References: <20261022114202.180023-1-socketcan@hartkopp.net>
 <8c4ef118-520a-419d-9f8c-28026d1cde09@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="5ub6xv2pa2ijumv5"
Content-Disposition: inline
In-Reply-To: <8c4ef118-520a-419d-9f8c-28026d1cde09@hartkopp.net>


--5ub6xv2pa2ijumv5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v7 0/5] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 22.10.2026 14:08:43, Oliver Hartkopp wrote:
> as the pull-request: can-next 2026-10-22 will be processed after the merge
> into Linus' tree we get some more time. Sorry for the nightly stress.

:)

> In this v7 update some release_sock() calls have been moved down behind
> sk_error_report(sk) as suggested by sachiko-bot.
>
> So this patch set can hang around to be cross reviewed once more with less
> pressure.
>
> There are two things that always have been remarked by sashiko:
>
> 1. the missing -ENOMEM handling for can_rx_register() in isptp_bind()
> 2. copying user-space data in raw.c and isotp.c under lock_sock() which c=
an
> block rtnl in the notifiers
>
> Would it make sense to you that I provide some patches/fixes to address
> these two points so that they can additionally go upstream when Paolo ope=
ns
> the fixes-phase?

Yes, please. Please include the new patches in the vN+1 and adjust your
cover letter.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5ub6xv2pa2ijumv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatoDvwAKCRDMOmT6rpmt
0rAHAQCXm/eb/IuDvOH3oALjfYdi7PBHaI8zHWDLn/3nPVA45QEAgZqCGX8MRnwo
2mvJjhac/+VUaE05voqs7RNlwLndNQY=
=izIT
-----END PGP SIGNATURE-----

--5ub6xv2pa2ijumv5--
