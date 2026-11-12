Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499573;
	b=t+tkn25ty+FHKmSulg3P0H9JA0h01Lckf1Ndgpv8Vk98DcRwpBl25CAjJVmpuB5ddY2E
	 ZzoXrfDGsOYTbeXKOPf9Es0xNbXqMdaF3CdpgwbdwukgGIfjcVD8ZkarrLS5VS5H+cQwi
	 2CkrvY2FEzRcMk2Tq/XUIuuVDT0PNSolA9v/KqzGjI4QEzxJRzGtvNpZmJ5ntJc4N3ye6
	 r9jQ5xU09MRSFfYpxAABikc2Lu76NqgS+hP0J98zBs3cEpbelAq/GlpMDMQsuPquwF/qd
	 wTpLSLj2ha9sCEUiEfxQzMhdjsVphihfXt590aU2U1hF2Izw14CnPRrVympy4e8vdfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499573;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BW54H/tIq66HNt10goFmoDLmSFzUJN7adLDDoq1NiGY=;
	b=Jic848/JQse3Q/573ark6nBuXdpq/Ni7VzJmlLKWnruXXZLqcK1jMOcSunS7x4qLJhoB
	 rau9IQ0aeHpIXLN5fPZ+THCREzOIXdb4RcS3NUo/qQV6BJywqspsUbclD7CSpIemRzIoB
	 JXkCaszDevTzYeSoAA1qoeDg7W6umOyEcvrM7rTK72b3uebMr87C+4dlCFxD7ysB/1YG4
	 tyNJzoAetphIs3os48Y2+z7e9RPRhl07EyekP/iQ2vbP8keJJe2yJUsMomnDCOs2H1nGc
	 O6WuhrQ/FUPM5k6/3zIYM2eDUAjI24MASuCjb5GX5oRdWjkWv41lVZAMeyI9DsUDVeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PnZ+LYYz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F30606A31C;
	Thu, 12 Nov 2026 16:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72F30606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PnZ+LYYz
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 254FF2000E3;
	Thu, 12 Nov 2026 17:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794499566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW54H/tIq66HNt10goFmoDLmSFzUJN7adLDDoq1NiGY=;
	b=PnZ+LYYzScXD2F44VSWVnfRI3cXaz7sL8qW+9mJ2S86mVyHc2SIJ+OHWKPiHOVkkeA3mnY
	bzoq+YSr8Mo4q2C0QiK7B5JHcTUdvS3czveP1FDUCXbIWFDA8FxcZhc1J3Q9oqabCkswfi
	h0XoJO/j4w4/LMXl0IjwDjQ8zVMIpWiUobE2xJASpjcP/DNFPK2qoFELuH2SwiIytA3Gpm
	jwv/9B8Y1oopdJch9JcaNFPiXt/kRhXqgPRpJ/bncJyPt7kKADkkfj1IKT2TRQxWrS1D3B
	HLUdZcv02JEOik+H1pK8NqK4IWqQZ/m2uqR85UvtAOMwPA6wLh4X1E2rB15xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794499566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW54H/tIq66HNt10goFmoDLmSFzUJN7adLDDoq1NiGY=;
	b=EpneAu42DM1tpitoYTsQPfdUHZ2TaH8bczP5n3NyK2J9BywP5a8Nnz4onCOFvj/bbgMfsp
	ZoAe5HxpaFt8xJnaVJFgTkOeuOcOxpYV19tDxge8z5T6kPg7tk8gztOMrvNMqZfsjwm/e+
	J6NeZrCkTVqvA+UD5mwt2ZOMc3BzFtWKPCp4bbHDi4HxiGBzm0LH0D2KTKBvDy76MMejdM
	eHGd8aVSAgNgkZ26vSb/D9xU77S7gYcqZIOR9lLP1YUD6SYYX3ZxANgeQFKU+qc7XJqNvb
	W+LM1XLOp1tUDH8puZDb7iOBmvCmftpJBjmQ1GK/ELqeOi8yex4yPT32Cz6euQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794499566; a=rsa-sha256;
	cv=none;
	b=e8Teg8wu77pv0kCSyq2F7tavFJaxHZLjB9F4sclzU1lZBJv2AXhJvTZ4J9KPnKo++u0xo2
	VNF9ZsSIYpu22Y2qmqEbpSrTFUdj9azfxxF74jrmDSRoKyttHFSQu9tWRjE5+tdC2sb8HY
	bL0PsgqFQyEC2ZnbDugGF9HWfM4r9Da3nD09r8lat5iErV1p8lkUbwI0Z9uUO17maEZSDB
	TX899lAa0a+9lFnTRbvZJfsu9cc6sADOOzF8L4rp+Oc1nGQGXepLlU+T/+MunFB3u0RyQs
	GVf9pFI2SvFjjCo70oOYVZIx9gT478xyVMI+jXgyU2UuaDs2JkxjvqwvaXpL+Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRXJO-003rQi-0C;
	Thu, 12 Nov 2026 17:06:06 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 253A35E99E1;
	Thu, 12 Nov 2026 13:44:44 +0000 (UTC)
Date: Thu, 12 Nov 2026 14:44:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
Message-ID: <20261112-private-tangible-dragonfly-3de373-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-8-mkl@pengutronix.de>
 <20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
 <7c5f9cc9-8e3a-4f3d-b9a5-b5b0462833af@tuxon.dev>
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
	protocol="application/pgp-signature"; boundary="akelckda7ijpga4b"
Content-Disposition: inline
In-Reply-To: <7c5f9cc9-8e3a-4f3d-b9a5-b5b0462833af@tuxon.dev>


--akelckda7ijpga4b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
MIME-Version: 1.0

On 12.11.2026 15:39:39, claudiu beznea wrote:
> > > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar=
/rcar_canfd.c
> > > index bb2d03b75142a..4f5cdfa8211da 100644
> > > --- a/drivers/net/can/rcar/rcar_canfd.c
> > > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > > @@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_dev=
ice *pdev)
> > >
> > >   	platform_set_drvdata(pdev, gpriv);
> > >   	dev_info(dev, "global operational state (%s clk, %s mode)\n",
> > > -		 gpriv->extclk ? "ext" : "canfd",
> > > +		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),
> >
> > Is the right name printed when can_clk is in use on hardware where
> > external_clk is 0?
> >
> > gpriv->extclk does not record which DT clock was picked. In the branch
> > that uses "can_clk", it is copied from the hw_info flag that controls
> > the GCFG DCS bit:
> >
> > drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
> >      ...
> > 	} else {
> > 		fcan_freq =3D clk_get_rate(gpriv->can_clk);
> > 		gpriv->extclk =3D gpriv->info->external_clk;
> > 	}
> >      ...
> > }
> >
> > r9a09g047_hw_info has:
> >
> > 	.external_clk =3D 0,
> > 	.fcan_pclk =3D 0,
> >
> > RZ/G3E uses this hw_info, and so do RZ/V2N and RZ/V2H through the
> > r9a09g047 fallback compatible. Their device trees (r9a09g047.dtsi,
> > r9a09g056.dtsi and r9a09g057.dtsi) only list:
> >
> > 	clock-names =3D "fck", "ram_clk", "can_clk";
> >
> > On these SoCs, devm_clk_get_optional(dev, "can_clk") returns a clock
> > with a non-zero rate, so the else branch runs. extclk then ends up
> > false, and the message prints "canfd clk".
> >
> > None of those device trees has a "canfd" clock, so a successful probe on
> > these SoCs can only have used "can_clk".
>
> RZ/G3E, RZ/V2H, RZ/V2N have input clocks named in the HW manual as pclk,
> clk_ram and canfd. These are described in [1] page 3365, [2] page 3286, [=
3]
> page 3160.
>
> All these have external_clk =3D 0, fcan_pclk =3D 0 and the patch here wil=
l print
> "canfd clk" for them, as it is actually defined in HW, and as the previous
> code did.
>
> It is true the commit message mentions it uses DT binding clock names. Ma=
ybe
> that should be amended.
>
> With the current binding names and various usage of it across different S=
oCs
> I'm not sure we can use binding names for all the cases.
>
> Please let me know how would you like me to proceed.

I think it's fine. Let's see what the netdev people say :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--akelckda7ijpga4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavXCyQAKCRDMOmT6rpmt
0ivrAQDaGjOFJSef3DVl1L7QOJUbB2TV1TvOirww3G5QE7BbUQEA0DLAehY6XfA7
ImNBWKm57KtvhixSfhCZgWLkTNFyXQU=
=t6cy
-----END PGP SIGNATURE-----

--akelckda7ijpga4b--
