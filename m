Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3033E2752;
	Wed,  5 Aug 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915113; cv=none; b=IE0JjL23NOH/8XI1T1eF2iiQ9DfnwFtpYUjyNBDAbD2sipT6PUXIVlnJaEWbIPo9ba8aLyj2U+3b0R1mwVxkn/L+ony8CVX/6gpgWdDdiR7hGqxDVrzlnW3F2LwcngF3nJJd/QZzEXGfmlPi1pyVtjsdmxd0SFcHYs3ONFJ/HoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915113; c=relaxed/simple;
	bh=CotV+uXs4pLOgXcJbw4/X0DmR00g6ebRtb8WNRjxxeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EApzFrqvDnPSJiVHdPFZtr1/7J/cW0ntzx/ftN+qzmtUFUWMC/1UTXKZS2+DA/p1DgwagVlPxWmIzuxQiY00TpiG0UrWdzSzqm+QTYzfvdrj0lwBu+ZLA6wBpND9FEaJtc6yMLBovStefW/ljf94DVw8PkH9Kg13oEu5QNXxk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3803F200048;
	Wed, 05 Aug 2026 09:31:41 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wrW6H-0034JZ-0J;
	Wed, 05 Aug 2026 09:31:41 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C34F257BE80;
	Wed, 05 Aug 2026 07:31:40 +0000 (UTC)
Date: Wed, 5 Aug 2026 09:31:40 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <20260805-prophetic-flounder-of-judgment-5fd269-mkl@pengutronix.de>
References: <20260804113027.1626442-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uh4fwku6cpvhwkyw"
Content-Disposition: inline
In-Reply-To: <20260804113027.1626442-1-sean@geanix.com>


--uh4fwku6cpvhwkyw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] can: tcan4x5x: put tcan into sleep when removing
 driver
MIME-Version: 1.0

On 04.08.2026 13:30:26, Sean Nyekjaer wrote:
> Put the tcan4x5x transceiver into sleep mode when the driver is
> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - Moved enter sleep mode into tcan4x5x_power_enable()
>
> Changes since v2:
>  - Added comment about RST pin
>  - Fixed all calls to tcan4x5x_power_enable()
>
> Changes since v3:
>  - When powering off, always put the device into sleep mode (if the RST p=
in is
>    present). This will ensure the device is in sleep mode even if the
>    power regulator is shared.
>
>  drivers/net/can/m_can/tcan4x5x-core.c | 29 +++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd45..d8fd219a27cc 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -211,8 +211,29 @@ static int tcan4x5x_write_fifo(struct m_can_classdev=
 *cdev,
>  	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offse=
t, val, val_count);
>  }
>
> -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
>  {
> +	struct regulator *reg =3D priv->power;
> +	int ret;
> +
> +	/*
> +	 * Put the device into sleep mode if the RST pin is available,
> +	 * since a wake-up event, RST pin toggle, or power cycle are the only
> +	 * ways to exit sleep mode.
> +	 * Redundant if the regulator is exclusive to this device, but that
> +	 * can't be determined here.
> +	 *
> +	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
> +	 * https://www.ti.com/lit/gpn/tcan4550
> +	 */
> +	if (priv->reset_gpio && !enable) {
> +		ret =3D regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> +					 TCAN4X5X_MODE_SEL_MASK,
> +					 TCAN4X5X_MODE_SLEEP);
> +		if (ret)
> +			return ret;

As sashiko pointed out, maybe only log a error here and continue.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uh4fwku6cpvhwkyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanLm2QAKCRDMOmT6rpmt
0jBLAQC205D/V7kKsnaYfslHDmb6Z/q0bHJGCqHuhvAV4+AxgwD/cjpNu6r46Q8z
iDRp1Oh20hdEF4A/sZl8cRrM7f1i0QU=
=4EO5
-----END PGP SIGNATURE-----

--uh4fwku6cpvhwkyw--
