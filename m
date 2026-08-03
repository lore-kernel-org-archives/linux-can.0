Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A3BB672
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766320; cv=none; b=ODEyUmSSMHtO1a/DkDizVyNuOZQNfo0GPQ4r5W0YWBZB/cyYN27SFSx/L28sFkixCKGjvPPM3N3QZ9rPwaPjtgE7lUpkKUY0Y2vcHPpOZ1r78pUX7uX021vzX7Alr4vFCku4yOxwO2dSbuG7QrxinyVmyS5ICnWLTQUMRssmHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766320; c=relaxed/simple;
	bh=mv4sWrnGN3yg+DD9INvjKvWO21DxrtZ2beUvMJCbzp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpdXLtA32+wXid1dn/zagE8BLh1bt8oVodKhBkaRvwJX6Xg9tx6D8Ph5UlR3HR3rIWlM/2u7Nx9chU4rpfoV0E9FrWnM9NEIx2eiB5XWWYhd4XC0i4dF2FyHBvGiK1PaY3IdKOAD5dz4o0BkS3SdZedoHxhqYxOMb2iVWls+e4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DC50220044D;
	Mon, 03 Aug 2026 16:11:49 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wqtOP-002i3L-2V;
	Mon, 03 Aug 2026 16:11:49 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7DF7457A665;
	Mon, 03 Aug 2026 14:11:49 +0000 (UTC)
Date: Mon, 3 Aug 2026 16:11:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v3] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <20260803-big-wise-skua-f7264b-mkl@pengutronix.de>
References: <20260803135011.230006-1-sean@geanix.com>
 <20260803140917.6A3661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z46ei6zew2ialjou"
Content-Disposition: inline
In-Reply-To: <20260803140917.6A3661F000E9@smtp.kernel.org>


--z46ei6zew2ialjou
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] can: tcan4x5x: put tcan into sleep when removing
 driver
MIME-Version: 1.0

On 03.08.2026 14:09:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The transceiver is not put into sleep mode if a regulator is c=
onfigured, defeating the power-saving goal for shared or always-on regulato=
rs.
> --
>
> --- Patch [1]: [PATCH v3] can: tcan4x5x: put tcan into sleep when removin=
g driver ---
> commit 153dfa0940acefa28cd89e367eedf818096ade5b
> Author: Sean Nyekjaer <sean@geanix.com>
>
> can: tcan4x5x: put tcan into sleep when removing driver
>
> This commit attempts to put the tcan4x5x transceiver into sleep mode when
> the driver is removed to reduce power consumption. It updates
> tcan4x5x_power_enable to send the sleep command via SPI if the RST pin is
> available and no regulator is present.
>
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_=
can/tcan4x5x-core.c
> > index 31cc9d0abd453..a318f1874b351 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -211,10 +211,26 @@ static int tcan4x5x_write_fifo(struct m_can_class=
dev *cdev,
> >  	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_off=
set, val, val_count);
> >  }
> >
> > -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> > +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enabl=
e)
> >  {
> > -	if (IS_ERR_OR_NULL(reg))
> > +	struct regulator *reg =3D priv->power;
> > +
> > +	/*
> > +	 * Check if the power regulator is configured. If it is, just power
> > +	 * the device on/off. If not, put the device into sleep mode here if
> > +	 * the RST pin is available, since a wake-up event, RST pin toggle,
> > +	 * or power cycle are the only ways to exit sleep mode.
> > +	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
> > +	 * https://www.ti.com/lit/gpn/tcan4550
> > +	 */
> > +	if (IS_ERR_OR_NULL(reg)) {
> > +		if (priv->reset_gpio && !enable)
> > +			return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> > +						  TCAN4X5X_MODE_SEL_MASK,
> > +						  TCAN4X5X_MODE_SLEEP);
> > +
> >  		return 0;
> > +	}
>
> [Severity: Medium]
> Will this miss the power savings if the regulator is shared or marked as
> always-on?
>
> Because the sleep command is nested inside the IS_ERR_OR_NULL(reg) check,
> the device is not put into sleep mode if a regulator is configured. Inste=
ad,
> the function continues to the else block and calls regulator_disable().
>
> If the regulator is shared with other active devices or is marked always-=
on in
> the device tree, regulator_disable() will only decrement the reference co=
unt
> without physically turning off the power. The transceiver will stay fully
> powered in its active operating mode.
>
> Should the driver issue the sleep command via SPI whenever priv->reset_gp=
io
> is available, before disabling the regulator, to ensure power is saved re=
gardless
> of the physical regulator state?

Sean, sounds like a valid point to me, what do you think? The additional
SPI message, even if the device is powered off, should not hurt.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z46ei6zew2ialjou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanChogAKCRDMOmT6rpmt
0os0AP45TRVs4w1o1MkOvgMcXb1RloTfSq0NZEwNyawc4A+4zAD/SHTuZJDUtYbC
brLN8578QZ0/p8n6WdYCmEzb/dqJNg4=
=5zJn
-----END PGP SIGNATURE-----

--z46ei6zew2ialjou--
