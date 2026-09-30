Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC193BB100;
	Wed, 30 Sep 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779419; cv=pass; b=kSXrkwB4TalObbc7PMZSA26j/TjR4maBx4x8W3i8oNl0yHeDYBXD/aVudO45TuIfNF4aK3eo/jt8WZjbXSiaXLHU6kmehbOKYfNRkc+jo35GhyDJDr7w3aAROM2aujUuJvpjyfrH3oOiiH5WqVOJQtW1W15C6ZMJlRIgmwD2k9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779419; c=relaxed/simple;
	bh=gC7bpeQrVK6RffxYDNTJcPCmIsY/6t9K5aytChggGtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0JF4KJCJgl1JOrHPqHLpYjfWpOtSZ//EeMyV8dct7vQAb0kFm57Gj+sdlMsBy/uXNuMO3fbB0YUjaHI1TOUiAiaTtN/fLOMDlHO8LUX9bmmOOUZ0frOTLilCvylrF1lMG7z5zzVtkBAE9vj93yKLeihMEQRL6z1SoA9c4JORTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NVUPza3t; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NVUPza3t"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C1C21200231;
	Wed, 30 Sep 2026 16:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790779402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEqHtFaJO4nw86i8yHOaN/JJX2yBOSoK7qzYEsHVB64=;
	b=NVUPza3tyZMTAEzr/P8mralKyZddeyWHNamKBUytzlmCcYTOWb9mMVMyJuHeh1C0E1Zc0D
	tCBA8vW2L+0XdXRfAz1rrjbJ1WUMEib3HqriXdldtDpK44xUInBiCwzlssjsUDMHH+JYiw
	xaofKNN9fDDsD2vjLdjRVDTjlRBsTyiBeMic/VnQVwfchip1wVXPsSj8MX7Sqgo8oyjTKt
	xkXmspaW+CZGScsIF+XKiPlnz0oCJgxJk3+PmAQA2D5watqmajo8aLb4tozfe0I0rK04KF
	P0lm2EBzz1DoUdmR0o2tNS/5wC3RN7lPum2yUXPaJebMGzcOX4INsqyyJ2VreQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790779402; a=rsa-sha256;
	cv=none;
	b=NNX8dqf7yVWKH7YlK2br5mEthnV6sioFGNIqfKc33uJRn7kIyg11gbsTlBKh+q+XcMonFh
	NIbVi4Db4mhvzmczXnrsVMzFNLZRbnRGGD0wDpi/knDGi6eTVDvnImiyJMg4dv6GFDzmF5
	nHxwUvwZCdrAyd8xE4eK+3hWr+/vWYzZ5/zHoM41zWk7+Xkw/Z8+5RLYdnAYTZOHF7BVT4
	9RKpaC8nHT8Mg+H1wt9UB5Z/eCPof+qBreAHLzVzi5ZDBNiADs2pfeNqC4mtvF8Sam5P6k
	5rFpueGnLCo+4jhM37BfHfuO9xcaEsEqtvzIWdGULNUmSMj2Mm8WVo/TxoWzBA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790779402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WEqHtFaJO4nw86i8yHOaN/JJX2yBOSoK7qzYEsHVB64=;
	b=NVAIy5bAKYhDsufPN94AKPUyLHG2284mVMdupkhr8dNz34Nv8x3f0nwBPDWk8wIM5rfi4Z
	lhTsj+w/BRh1K7q/gXrO9pX/hvISmnfChO2W6DxrHPxTJvgJOw9wuteXJIGfa+aV36UfNa
	UGAxbdP4No7BJpYAPtftMME58mJhwia2wYieSNMSNgfJwcUMqocimPg10UaQpxGllr7lYa
	zONkx5WdnOzpgsPuzL4S4BxKjwLBXvm1cZpM3vEJGoPoqSqnkZnI39HhR0D8wgSbgNh44x
	jSlM+zwRsD5yQIHis1wwkTupWyVSoW/Fd4FVPrORK39IoqoXpvAYx1O02NWw4Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBvWk-003ZhC-29;
	Wed, 30 Sep 2026 16:43:22 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 56B7E5B58C9;
	Wed, 30 Sep 2026 14:43:22 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:43:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>
Subject: Re: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
Message-ID: <20260930-thundering-smart-slug-8228c9-mkl@pengutronix.de>
References: <20260930-foamy-nostalgic-elk-30d429-mkl@pengutronix.de>
 <700277696.812114266.1790778284780.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nuunprnzwglxz7y4"
Content-Disposition: inline
In-Reply-To: <700277696.812114266.1790778284780.JavaMail.root@zimbra65-e11.priv.proxad.net>


--nuunprnzwglxz7y4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: peak_usb: Add support of loopback mode to the
 PCAN-USB FD family
MIME-Version: 1.0

On 30.09.2026 16:24:44, St=C3=A9phane Grosjean wrote:
> > > @@ -1266,7 +1272,7 @@ const struct peak_usb_adapter pcan_usb_fd =3D {
> > >  	.ctrlmode_supported =3D CAN_CTRLMODE_FD |
> > >  			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
> > >  			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
> > > -			CAN_CTRLMODE_BERR_REPORTING,
> > > +			CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_LOOPBACK,
> >
> > Can you keep the CAN_CTRLMODE sorted by their value?
> >
> > Please make an incremental patch for the CAN_CTRLMODE_BERR_REPORTING,
> > I'll squash that...and add CAN_CTRLMODE_LOOPBACK in the appropriate
> > place.
>
> Do you want me to post a v2 of this patch with the CAN_CTRLMODE flags
> sorted by value, or do you prefer a separate incremental patch on top
> of the bus error reporting series?

Sorry for being unclear. :)

Please a separate incremental patch on top of the bus error reporting
series.

Then post a v2 of the loopback patch on top of the incremental patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nuunprnzwglxz7y4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar0gBwAKCRDMOmT6rpmt
0p/+AP94uIUP1E2uO3a16DvFTBRV8VvxlsxsgRp6N6hJ8s6vGAEAuuALZ2LU4+D3
R2s6d5WClGB3E+GqaFnIfGnI/ksf6gw=
=mSOX
-----END PGP SIGNATURE-----

--nuunprnzwglxz7y4--
