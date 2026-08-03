Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27D403EAD;
	Mon,  3 Aug 2026 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756462; cv=none; b=BRJcGglQfpmttEvF4aGgk1OYbQxCOOgVuQYFXokfgaF23N5ZeRVc+yIgGwRoFMyfndOTHAbCGEHCzixRIzSw0bITHp9fo/Sk8bbdCqML8u8+XAzcertW6gYX2zxIGJbpZwqobsA+fA3sF/CfalQyzhlGPjfz51eC9nF+nR5jdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756462; c=relaxed/simple;
	bh=pyQI/wfVJ0wjTgEzCUsQkp+3QJXFLiTUyH0mkMGlHkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzVjdnOJ9FGItjsYrBCuwOTC/HeGXDDIy0IRBDtnuaMdBb+TcQ1vn3AirKe9Gb/k6frGc9SDMF3CTSilarTPAm6rghZT4n48k86n9po8wJylxHGvNsabeovFN3TjLWBoC/HgkAPX/yegLr4UqxhlSC9oTw9bHb+9+Uzycgkza9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E9ADA20077D;
	Mon, 03 Aug 2026 13:27:37 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wqqpV-002gir-2m;
	Mon, 03 Aug 2026 13:27:37 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 992F057A44E;
	Mon, 03 Aug 2026 10:59:53 +0000 (UTC)
Date: Mon, 3 Aug 2026 12:59:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <anB0TXS1xEtYAMxn@pengutronix.de>
References: <20260803101927.17122-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lvdagxrpj53wtz37"
Content-Disposition: inline
In-Reply-To: <20260803101927.17122-1-sean@geanix.com>


--lvdagxrpj53wtz37
Content-Type: text/plain; charset=utf-8; protected-headers=v1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
MIME-Version: 1.0

On 03.08.2026 12:19:26, Sean Nyekjaer wrote:
> Put the tcan4x5x transceiver into sleep mode when the driver is
> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Seems you patch is not complete:

| drivers/net/can/m_can/tcan4x5x-core.c: In function =E2=80=98tcan4x5x_can_=
remove=E2=80=99:
| drivers/net/can/m_can/tcan4x5x-core.c:552:35: error: passing argument 1 o=
f =E2=80=98tcan4x5x_power_enable=E2=80=99 from incompatible pointer type [-=
Wincompatible-pointer-types]
|   552 |         tcan4x5x_power_enable(priv->power, 0);
|       |                               ~~~~^~~~~~~
|       |                                   |
|       |                                   struct regulator *
| drivers/net/can/m_can/tcan4x5x-core.c:214:56: note: expected =E2=80=98str=
uct tcan4x5x_priv *=E2=80=99 but argument is of type =E2=80=98struct regula=
tor *=E2=80=99
|   214 | static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int =
enable)
|       |                                  ~~~~~~~~~~~~~~~~~~~~~~^~~~

> ---
> Changes since v1:
>  - Moved enter sleep mode into tcan4x5x_power_enable()
>
>  drivers/net/can/m_can/tcan4x5x-core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd45..67902b8b0fab 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -211,15 +211,21 @@ static int tcan4x5x_write_fifo(struct m_can_classde=
v *cdev,
>  	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offse=
t, val, val_count);
>  }
>
> -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
>  {

If you add:

        struct regulator *reg =3D priv->power;

the diff should be smaller.

> -	if (IS_ERR_OR_NULL(reg))
> +	if (IS_ERR_OR_NULL(priv->power)) {

Can you please add a comment that the reset GPIO is needed to get the
device out of sleep mode.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lvdagxrpj53wtz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanB0pgAKCRDMOmT6rpmt
0jLeAQC/BESYLGJpBEuo6vbG03HhSo5CsOX+IXs+mC5t1EDbtQD/TbuUv3j6nYlt
YOeVMizxn5rO25KZE3try2HBpv3fMgw=
=cmKb
-----END PGP SIGNATURE-----

--lvdagxrpj53wtz37--
