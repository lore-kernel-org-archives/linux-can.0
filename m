Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49497385D96;
	Fri, 31 Jul 2026 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482289; cv=none; b=awsUFeQZsYoMxS0JwqFuF6Q7TlrXFFcykDzqrNqDvbrEmUSyCjFkY93ZevI8xSzolNSRKJKs0/6Hx4Hm+ZWuqXcfDqSitAtU+qS/q6GSg2HfVC2klkRFL80iywfYaLfU8S8+5U3N0edudoGtEDQulgvXKQCKNjwtw8Ubgk+7Uc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482289; c=relaxed/simple;
	bh=w65ABpDtQYeVpxMjhXN2XWCU5581eQKLmdm+rHUKvH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBG2UNxWMjFaO0eyv36cXy4IYvnsN8dbJcCU6Jd81QpjjctVIr2Z++i1PKlpKumapACkyWyA/C6FOVCmq5nMPLM2MU615RHYYxlsBTdvxhRu0G5qBa9s9HYrSTtmB6ivrm+NJONFRx8avWrZRepBInMTCkwFfVsFhLohyGc+kgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0DEAB202C5D;
	Fri, 31 Jul 2026 09:18:05 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wphVM-002Ajk-33;
	Fri, 31 Jul 2026 09:18:04 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A0F0B577C44;
	Fri, 31 Jul 2026 07:18:04 +0000 (UTC)
Date: Fri, 31 Jul 2026 09:18:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cunhao Lu <1579567540@qq.com>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Message-ID: <20260731-tall-camouflaged-earthworm-e1a7d0-mkl@pengutronix.de>
References: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
 <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5nhk727xcrd5z4s"
Content-Disposition: inline
In-Reply-To: <tencent_207E464D12344B3228096E23A001D6882508@qq.com>


--a5nhk727xcrd5z4s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
MIME-Version: 1.0

On 30.07.2026 22:34:03, Cunhao Lu wrote:
> Add support for the RK3588 CAN controller by introducing a dedicated
> model ID and OF match entry.
>
> The block is closely related to the existing RK3568 variants, but it
> cannot reuse their match data unchanged. In particular, RK3588
> encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
> SoC-specific handling.
>
> The RX FIFO count bitfield difference was found by comparing Rockchip's
> vendor kernel 6.1 CAN support for RK3568 and RK3588. Runtime testing on
> RK3588 also confirms that bits 7:5 are needed.
>
> Enable the existing erratum 5 empty-FIFO workaround for RK3588.
> Heiko reproduced erratum 6 on RK3588, so enable that workaround as
> well.
>
> CAN-FD is enabled for RK3588. The BRS bus-off issue seen in earlier
> testing was caused by the transmit delay compensation setting. With
> RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION programmed to 0 on RK3588,
> CAN-FD with BRS works in local testing.
>
> Tested on an embedfire,rk3588-lubancat-5io board with can0/can1
> directly connected, no other device on the bus, 60 Ohm bus
> termination, and a 300 MHz CAN clock. Runtime testing used 500 kbit/s
> arbitration bitrate and 1, 3 and 5 Mbit/s data bitrates. The 5 Mbit/s
> data phase test ran for 15 minutes with cangen using BRS and
> cansequence on the receiver. Both interfaces reported 9528377 packets
> and 150667356 bytes, with 0 bus-errors, 0 error-warn, 0 error-pass and
> 0 bus-off events.
>
> Co-developed-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
> v3 -> v4:
> - Disable TDC on RK3588 by programming
>   RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION to 0.
> - Drop RKCANFD_QUIRK_CANFD_BROKEN for RK3588 and enable CAN-FD support.
> - Document successful RK3588 CAN-FD/BRS testing.
> v2 -> v3:
> - Use Co-developed-by for Heiko's RK3588 contributions and add his
>   Signed-off-by
> - Collect Heiko's Reviewed-by and Tested-by tags
> ---
>  drivers/net/can/rockchip/rockchip_canfd-core.c | 17 +++++++++++++++++
>  drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
>  drivers/net/can/rockchip/rockchip_canfd.h      | 14 +++++++++++++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 29de0c01e4ed..37c1c22c40c9 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -50,6 +50,12 @@ static const struct rkcanfd_devtype_data rkcanfd_devty=
pe_data_rk3568v3 =3D {
>  		RKCANFD_QUIRK_CANFD_BROKEN,
>  };
>
> +static const struct rkcanfd_devtype_data rkcanfd_devtype_data_rk3588 =3D=
 {
> +	.model =3D RKCANFD_MODEL_RK3588,
> +	.quirks =3D RKCANFD_QUIRK_RK3568_ERRATUM_5 |
> +		RKCANFD_QUIRK_RK3568_ERRATUM_6,
> +};
> +
>  static const char *__rkcanfd_get_model_str(enum rkcanfd_model model)
>  {
>  	switch (model) {
> @@ -57,6 +63,8 @@ static const char *__rkcanfd_get_model_str(enum rkcanfd=
_model model)
>  		return "rk3568v2";
>  	case RKCANFD_MODEL_RK3568V3:
>  		return "rk3568v3";
> +	case RKCANFD_MODEL_RK3588:
> +		return "rk3588";
>  	}
>
>  	return "<unknown>";
> @@ -148,6 +156,12 @@ static int rkcanfd_set_bittiming(struct rkcanfd_priv=
 *priv)
>
>  	rkcanfd_write(priv, RKCANFD_REG_FD_DATA_BITTIMING, reg_dbt);
>
> +	/* RK3588 CAN-FD BRS works with TDC disabled. */
> +	if (priv->devtype_data.model =3D=3D RKCANFD_MODEL_RK3588) {
> +		rkcanfd_write(priv, RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION, 0);
> +		return 0;
> +	}
> +

Can you attach the TDC to the CAN framework? See commit 5e1663810e11
("can: mcp251xfd: fix TDC setting for low data bit rates"). And check if
CAN-FD works on the rk3588 works?

Marc

>  	tdco =3D (priv->can.clock.freq / dbt->bitrate) * 2 / 3;
>  	tdco =3D min(tdco, FIELD_MAX(RKCANFD_REG_TRANSMIT_DELAY_COMPENSATION_TD=
C_OFFSET));

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--a5nhk727xcrd5z4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamxMKgAKCRDMOmT6rpmt
0vXBAQDoBlfSjZe9dMhr9BurTP9gPUC5Y4L9MHxvMgzlVhRtaAEA0Wp6yKbuMIkW
a5YDShjRsc4DOMnQFcPUpi7oM9UkJQQ=
=EqJg
-----END PGP SIGNATURE-----

--a5nhk727xcrd5z4s--
