Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC1199FB0;
	Fri, 16 Oct 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158120; cv=pass; b=KqcdD+uudHeGoZQL977Np8hkdzSg+xQukm0cgtgwtysv9BmWZN4XLboMeBs/xcrDgLi86q1i3BXk17E9BDcZ1k9tHmalY3/O2ubgDJAMRDZtNA1Ia/un7/23+EbwaiWnCwM7K24xBKNFvNznG/BDZG2whpBXJhobwXudubkdVb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158120; c=relaxed/simple;
	bh=wQf8cBdLbkN+n13ETYe3Omp2nqOm8F5PkFiPvoKJxts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExyV7cjUzogU4NQA8PVd/7LEw7mbpSKJ1Da/JpQ5j2n4NiMi67+Iy561lO45GoAqVCltVJAXh2Qtc4XoXeEaepGsNy5c6S3S+6vBJ60/wVpeMrfNcY5r3tAES5Dpy/ynFvun8H5V14leUis5tj1sYL0LKzTAellKJxp51hh1qyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gLp1JjcF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gLp1JjcF"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3F3B620280F;
	Fri, 16 Oct 2026 15:41:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792158117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Vz0tiREf/olk0Bwh1RKgjnBEKu3DMA+zLtTJF4ZdFU=;
	b=gLp1JjcFOVnrKD2l6gSi5BlXpK1rFQfKERB4a5vAyWmiA4/EhiC3u/0P4B/bMtRMG6egfF
	6FkwLPlQLlpU1vsLgbu8z3GliT/IRGw87voRWCnHkVs+PqJanWbZpyXRy2JOhGSM/dvYS4
	nDci0hIyESh7kJoiHrUPPPW9yVMcSNQbvX7ZFSOBf4IUxNQEwsSVisYS+wjCMMwNHYhJuJ
	Cq5aVFjcg1U/vgfSU0kGg9FB6yoAeJ4jhFtegfEtpYeB9epfsDyDnn+glvbQqAk59cwjZy
	Mj1bVP1QvXsJUsy7zLyjhFDR6CH8vrS5/G6jKTbWIvOaSPAdb8AuRWw8eWRrZQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792158117; a=rsa-sha256;
	cv=none;
	b=M3PMs0EQd9s6ArX+KsHhEUdY7MRgXBNlXI3F194nIEC5iSsC5fIJKd2uCwIzNLBcEX8Ag+
	GufKjbRW079YLVq40+iZ9NH8wgtIMOGPyTsG+BCVWSALAPXMomNWlcKFbPpxesyxBAqaiv
	Sb4F5knyuAvSojyft2AA9F6CFhXSzE5gxwY0XRREHVLt9ffvStQtVDpnrsTWQEJ2ApaDkz
	aZrngjtZ6MfMmmHhD6b++aCnV58zMcRjz0g2RCmEK0umg7lu0Mch4TmWx5I5cpmRK7zIJt
	ts6Hb3dj74UrMFw6HCptXyhWk2uZROAxfxlXBkg+QXOjW0CeLM+p23b9tOZP/g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792158117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Vz0tiREf/olk0Bwh1RKgjnBEKu3DMA+zLtTJF4ZdFU=;
	b=gjoVss/Lfo31jmzBBRs0T7zlSmKfe4O4VDEBW6kH8PgdZ0FmWIUj3i+vR8/C5HwvoZavMl
	QiZZajy0v6+hj7DfD9cPMwIye2U/7o8Qtxk4TBgGLqwNnYOZpxWbsqZ6T7Vk9pHVQgCTIq
	GDaps0FMGSWixIsOIroMmbtR2Sv5o9g03M8Z2uUXrmiA66zUXp5nm8dxW295mcYMIrmJ2B
	JkBKfKF2OlpweX98nd44BimQ+3QpUO/uzQjuQ6otWIWJBPGSOW4+ISrszz0X8Hgk3r0S8s
	igmCI456MXiyWEu3DcHLdl4HRq876uCtiHRsj9AfFqrfDisOxfC8W1yX/n83UA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHiC5-006C3W-0W;
	Fri, 16 Oct 2026 15:41:57 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E46485C6273;
	Fri, 16 Oct 2026 13:41:56 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:41:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
Message-ID: <20261016-frisky-warping-swallow-f816c1-mkl@pengutronix.de>
References: <20261015015336.816543-16-mkl@pengutronix.de>
 <179211822725.434549.10997986390340946212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y66ab3bfamycz25c"
Content-Disposition: inline
In-Reply-To: <179211822725.434549.10997986390340946212@kernel.org>


--y66ab3bfamycz25c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 15/37] can: rcar_canfd: Allow the CAN FD clock
 to be sourced from fck
MIME-Version: 1.0

On 16.10.2026 02:37:07, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The patch adds a third fCAN source (fck/pclk, used when
>   `info->fcan_pclk` is set), but the clock comments and the boot banner=
=E2=80=A6
>
> --
>
> can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
>
> This commit adds an fcan_pclk hardware info flag. With it set, the fCAN
> clock falls back to the peripheral clock (fck) when the external can_clk
> is unavailable, the rate is divided by info->postdiv and can_clk is set
> to NULL. All existing rcar_canfd_hw_info instances now set fcan_pclk =3D 0
> explicitly.
>
> Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wa=
nadoo.fr
> Link: https://patch.msgid.link/20260902141544.565763-4-claudiu.beznea+ren=
esas@tuxon.dev
>
> > diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/r=
car_canfd.c
> > index b7c4fe3477ac..f9173774387f 100644
> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
>
> [ ... ]
>
> > @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_dev=
ice *pdev)
> >  	 */
> >  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
> >  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)=
) {
> > -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> > -		if (IS_ERR(gpriv->can_clk))
> > -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> > -					     "cannot get canfd clock\n");
> > +		if (info->fcan_pclk) {
> > +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> > +			gpriv->can_clk =3D NULL;
> > +		} else {
>
> [Severity: Low]
> Should the clock comments and the probe banner be updated for this new
> fck source? Several places still describe only the external and canfd
> clocks.

valid issue.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--y66ab3bfamycz25c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIpogAKCRDMOmT6rpmt
0n7NAQDigPYzJZkKbyLKO5SXiJhg1rLBK3NSCUWYvWbKYDpS4QD/QyjgV7cF1Ia8
NuScr3wX1A0Uhrn/GJ1yIyXwjJuy4Aw=
=vyHM
-----END PGP SIGNATURE-----

--y66ab3bfamycz25c--
