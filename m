Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C527E1C5;
	Wed,  1 Jul 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904068; cv=none; b=TXm4E8s3VY/C6Kzpwt8WbJsCpMP/QV6hcccOGBQhM16CYjoFF3eTWJS675/yOW+4m6RYTsNaPymhR60AlzTnDZoqVIZLUFX2MuMQExtXy9L66AVQe3y7BcNbo2Ei11KPLbK2grInXPnpS+21lfFbbsxq/XGdev9ykcn2XurM4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904068; c=relaxed/simple;
	bh=9ycf7UENsfYVCVxKpQ0cuazaRGuTf4YFcNTUv0lSMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peG/Lk8hYOfvUPYmuoWsYZeaiQnm7kWIP0ObZS5OtB0vuN4f0ZXPvFQdMmtpDY3r4AZLPKRwq+1VLwPEe7i2HGcwL5fjujzbnnC7WY+j4zYjUEuK9iRb1ecjTSMJPdKGXIO3PCkkecGsb3JjJuKEVbpQ16HUgA5PV2y1KOucz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61568201975;
	Wed, 01 Jul 2026 13:07:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wesn4-005ZKD-0y;
	Wed, 01 Jul 2026 13:07:38 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3D9255D58F;
	Wed, 01 Jul 2026 11:07:37 +0000 (UTC)
Date: Wed, 1 Jul 2026 13:07:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, 1579567540@qq.com, 
	Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Message-ID: <20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260701070128.2096267-1-1579567540@qq.com>
 <tencent_124D6134EB32480979234201E688087E5408@qq.com>
 <2064877.jZfb76A358@diego>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zddsmsw5y2ehct5y"
Content-Disposition: inline
In-Reply-To: <2064877.jZfb76A358@diego>


--zddsmsw5y2ehct5y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
MIME-Version: 1.0

On 01.07.2026 11:55:39, Heiko St=C3=BCbner wrote:
> Hi,
>
> Am Mittwoch, 1. Juli 2026, 09:01:27 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb 1579567540@qq.com:
> > From: luch00 <1579567540@qq.com>
>
> please use a real name, not an alias.
>
>
> > Add support for the RK3588v2 CAN-FD controller by introducing a
> > dedicated model ID and OF match entry.
> >
> > The block is closely related to the existing RK3568 variants, but it
> > cannot reuse their match data unchanged. In particular, RK3588v2
> > encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
> > SoC-specific handling.
> >
> > Validation on RK3588v2 also shows that its observed errata profile does
> > not fully match rk3568v2/rk3568v3, so keep a dedicated devtype for this
> > variant instead of relying on an rk3568 fallback.
>
> Funnily enough, we seem to have worked on the same topic
> at the same time :-)
>
> https://lore.kernel.org/lkml/20260630164336.3444550-1-heiko@sntech.de/
>
> > Signed-off-by: luch00 <1579567540@qq.com>
> > ---
> >  drivers/net/can/rockchip/rockchip_canfd-core.c | 14 ++++++++++++++
> >  drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
> >  drivers/net/can/rockchip/rockchip_canfd.h      | 12 +++++++++++-
> >  3 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/n=
et/can/rockchip/rockchip_canfd-core.c
> > index 29de0c01e..3c2480785 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> > +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> > @@ -50,6 +50,15 @@ static const struct rkcanfd_devtype_data rkcanfd_dev=
type_data_rk3568v3 =3D {
> >  		RKCANFD_QUIRK_CANFD_BROKEN,
> >  };
> >
> > +/* Tests on the rk3588v2 reproduce Erratum 5, but not
> > + * Erratum 6 or the special CAN-FD frames that trigger Error Interrupts
> > + * on rk3568v2/rk3568v3.
> > + */
>
> Here I could reproduce erratum 6 though:
> https://lore.kernel.org/lkml/20260630164336.3444550-4-heiko@sntech.de/
>
>
> [...]
>
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net=
/can/rockchip/rockchip_canfd-rx.c
> > index 475c0409e..fe64db373 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> > +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> > @@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv =
*priv)
> >  {
> >  	const u32 reg =3D rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
> >
> > -	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
> > +	if (priv->devtype_data.model =3D=3D RKCANFD_MODEL_RK3588V2)
> > +		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
> > +
> > +	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
> >  }
> >
> >  int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/ca=
n/rockchip/rockchip_canfd.h
> > index 93131c7d7..f6105b904 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd.h
> > +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> > @@ -214,7 +214,8 @@
> >  #define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
> >
> >  #define RKCANFD_REG_RX_FIFO_CTRL 0x118
> > -#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
> > +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568 GENMASK(6, 4)
> > +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588 GENMASK(7, 5)
>
> Oh, didn't see this when doing my variant of the support, so cool that you
> found this.

The "Rockchip RK3588 TRM V1.0-Part1-20220309.pdf" datasheet says bits
"7:5" are RX_FIFO_FRAME_CNT, while bit "6" is marked as reserved. =F0=9F=A4=
=B7

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zddsmsw5y2ehct5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakT09wAKCRDMOmT6rpmt
0ptJAP0V1ggWlmdXB4K6fWYKfQM6O0/UiXoS8io2aIaPk936IQD/fJPILelVtYoR
mRtNCMATzYSF6Az4KXu0H6TsCNQvsww=
=9f9+
-----END PGP SIGNATURE-----

--zddsmsw5y2ehct5y--
