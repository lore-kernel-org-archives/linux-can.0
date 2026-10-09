Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA14D6C55
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549183; cv=pass; b=iFEYPagxd/pLkQZIHg763XhxIgawg7lafOaz3zHdjpryK4Eb9DRm1mOBKkfENrbN6qe5Mq7XG5xwRcH8+O0FfCLG97vbRtIv7gyTTldUsg3OgxOnjx+ztJnyB6a4elufSVrzQIYJVpwkIBYIL7tPEIFT1YRkMofCXwJa4eUkGHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549183; c=relaxed/simple;
	bh=bbFAEwWzVuBVTbr0kr/P/BFK+WrT8EiZ/qYcI74e04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKc9o7UBwc7bMyMKfgxB8Gcghw1Tdql8Ys4/VjrY2N49H4ea6n0NaL1vE/eeGrCUXwvAtyV2jy3CXJKrS3j09AGg3Dm3sVlHHxMtFnm0I4SZDQqYG2GB75KjczjBJp+1rxdUbEWTXdsoI3fRh3jyVMfUjfE0GIZq2VLW8/y6tpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XAPnNN4F; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XAPnNN4F"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0056A2004FC;
	Fri, 09 Oct 2026 14:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791549175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgxhIZXV0lwDllZMq7dFa4EviNL2yK/8CgnfvbXSJcM=;
	b=XAPnNN4FIjpl0c3vMBcN1TSdzpJelsWbTDyNVLK4wXKOS6r+iHL1rCnIUjQBDwbWhhwKSe
	PIESWpM9heD/C34ZdguVecxWEt/qxZirTE0F1PrINBxELSUgiPSTwfYfs/Omn//heVEaKQ
	ILlDX3c28D/TUM/8L14ICwDYjap5Eazjjkzzg3DQmbh3XyDpt6je08x8olUve/U3uWtZmM
	VmxNM1gatFoOEe2xPrrznmfpQIkIuKbnVk6FVnuud9MNqQITF8kE1ELgumphgP/UWLlTzl
	5uWlLc/qSgOQQ5KNJSoF62noNfcjNR3SuF/FvuHxGWafNq3NdLogNg/hB+VKnA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791549175; a=rsa-sha256;
	cv=none;
	b=M30QN0Q4tdnG0BigsIk0sLqPYyd4T59QeMriipeCOIUcWFgFZY+oHQ6v+iatjODkBl1ALv
	0g3aNwbq9V/VV55OWEPgxeo5dB5HN8KbkwnmgpU56VgmRiALYDZp1aRnOMKvCfsVtYzmWX
	Fqh80uqK2DV0mxaHIbvcA9R2xZz8g9eIsIXr19mvw33eqEZmg/U7laGJpOJ4VpZeOLX2j/
	MvKp/eOciGoiZwkiVMsagEK9YAqXzgmL3y5PI6JwMM3c/MIQQmiakwiIcNEC+UnWFUf6Pc
	YkSV6+EkdvbazVgeLQ4dHLjbDE3pK1hkY3ROl6TilNeUZprY+ibaCRbD6ud9Tg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791549174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgxhIZXV0lwDllZMq7dFa4EviNL2yK/8CgnfvbXSJcM=;
	b=csTfOJ8eD4VtKR630qz2rcz0t0X3cRC9g44uZDAT9LgIIg3qownIsbYe7mZH4R7G2Icjnu
	nCSfS069LLgaWHnxl75MRQxICHIFQpPTiD/2M5kAXJ8l4UblxZvdKgeGsRC0LK5r3ui7WW
	ZAg0pGh61NzVo0n42U0O7uFDmIDnrSSq/nBtL/u9aXyp4hrHl75MKa+V0WLN5nxiYbQl57
	v7awSGsUa+JJF1xNcpBkcakZy8RAYrRsWj7F2ObRLQLOklS8jh1deRQBPwrgCHfbBmwmbA
	1aNpidRiKy5igfYmLmONIporUOezVhFwWxrElhKk2G8UQq52Pycza0j4DUs8Dw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9mQ-0052my-2u;
	Fri, 09 Oct 2026 14:32:54 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 929625BD793;
	Fri, 09 Oct 2026 12:32:54 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:32:54 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
Message-ID: <20261009-furry-coucal-of-rain-04a98c-mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
 <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
 <df3da1ab-9a03-4720-9486-f5c5902cb9b6@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34ikefx5oyrtf5w6"
Content-Disposition: inline
In-Reply-To: <df3da1ab-9a03-4720-9486-f5c5902cb9b6@hartkopp.net>


--34ikefx5oyrtf5w6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
MIME-Version: 1.0

On 09.10.2026 14:19:37, Oliver Hartkopp wrote:
>
>
> On 09.10.26 14:17, Marc Kleine-Budde wrote:
> > On 09.10.2026 14:03:19, Oliver Hartkopp wrote:
> > > > I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
> > > > there has been no response from Kurt regarding:
> > > >
> > > > https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartk=
opp.net/
> > >
> > > No, answer is ok.
> > > Let's remove it!
> >
> > Done
> >
> > > Do you want to apply my ml_priv patch - or do you want it me to do th=
e next
> > > 5 minutes bevore the PR?
> >
> > I think it's already queued in can-next/testing. Please have a look.
>
> I did. It was not there.

ACK - my mistake

> I created to patch based on Linus' tree to be faster.
> It should apply anyway:
>
> https://lore.kernel.org/linux-can/20261009121115.61012-1-socketcan@hartko=
pp.net/

done

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--34ikefx5oyrtf5w6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasje8wAKCRDMOmT6rpmt
0rmwAP9H2Gsg+q3qFoAumeYR4jC0zA0IMAz5eM4599xXckSE+QD/YqOFD0WgoCyj
7E0fDfqNbIPVhZVICjeGrtAr8H8XkwE=
=FQVp
-----END PGP SIGNATURE-----

--34ikefx5oyrtf5w6--
