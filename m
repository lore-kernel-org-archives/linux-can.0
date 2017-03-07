From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: m_can: handle frame transmission on IP core >=
 3.1.x
Date: Tue, 7 Mar 2017 08:43:10 +0100
Message-ID: <65373472-29cf-b5eb-05c5-89d5fdb51db2@pengutronix.de>
References: <20170306212011.29519-1-socketcan@hartkopp.net>
 <20170306212011.29519-2-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fIDxp8HESCqhCeq70lQ0vXNBxswc3GEUe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41529 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752641AbdCGHpI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Mar 2017 02:45:08 -0500
In-Reply-To: <20170306212011.29519-2-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fIDxp8HESCqhCeq70lQ0vXNBxswc3GEUe
Content-Type: multipart/mixed; boundary="iLjxo2wbXTXbBAuWAqkR7fgqhF6FVwbWe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <65373472-29cf-b5eb-05c5-89d5fdb51db2@pengutronix.de>
Subject: Re: [PATCH 2/2] can: m_can: handle frame transmission on IP core >=
 3.1.x
References: <20170306212011.29519-1-socketcan@hartkopp.net>
 <20170306212011.29519-2-socketcan@hartkopp.net>
In-Reply-To: <20170306212011.29519-2-socketcan@hartkopp.net>

--iLjxo2wbXTXbBAuWAqkR7fgqhF6FVwbWe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:20 PM, Oliver Hartkopp wrote:
> Enables the transmission of CAN FD frames on M_CAN IP core >=3D v3.1.x
> including bit rate switching and error state indicator.
>=20
> Suggested-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index 650b656f3c05..297b55163812 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -283,8 +283,12 @@ enum m_can_mram_cfg {
> =20
>  /* Tx Buffer Element */
>  /* R0 */
> +#define TX_BUF_ESI		BIT(31)
>  #define TX_BUF_XTD		BIT(30)
>  #define TX_BUF_RTR		BIT(29)
> +#define TX_BUF_EFC		BIT(23)
> +#define TX_BUF_FDF		BIT(21)
> +#define TX_BUF_BRS		BIT(20)
> =20
>  /* address offset and element number for each FIFO/Buffer in the Messa=
ge RAM */
>  struct mram_cfg {
> @@ -916,7 +920,7 @@ static void m_can_chip_config(struct net_device *de=
v)
>  	}
> =20
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> -		cccr |=3D CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
> +		cccr |=3D (CCCR_CME_CANFD_BRS | CCCR_CME_CANFD) << CCCR_CME_SHIFT;
> =20
>  	m_can_write(priv, M_CAN_CCCR, cccr);
>  	m_can_write(priv, M_CAN_TEST, test);
> @@ -1079,6 +1083,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buf=
f *skb,
>  	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
>  	u32 id, cccr;
>  	int i;
> +	u32 dlc;
> =20
>  	if (can_dropped_invalid_skb(dev, skb))
>  		return NETDEV_TX_OK;
> @@ -1097,7 +1102,6 @@ static netdev_tx_t m_can_start_xmit(struct sk_buf=
f *skb,
> =20
>  	/* message ram configuration */
>  	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
> -	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16)=
;
> =20
>  	for (i =3D 0; i < cf->len; i +=3D 4)
>  		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
> @@ -1105,19 +1109,34 @@ static netdev_tx_t m_can_start_xmit(struct sk_b=
uff *skb,
> =20
>  	can_put_echo_skb(skb, dev, 0);
> =20
> +	dlc =3D can_len2dlc(cf->len) << 16;
> +
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> -		cccr =3D m_can_read(priv, M_CAN_CCCR);
> -		cccr &=3D ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
> -		if (can_is_canfd_skb(skb)) {
> -			if (cf->flags & CANFD_BRS)
> -				cccr |=3D CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
> -			else
> -				cccr |=3D CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
> +		if (m_can_read_core_rev(priv) < M_CAN_COREREL_3_1_0) {

Please don't read this register in the hot path. Do it once in the probe
function.

> +			/* set CCCR according to frame content */
> +			cccr =3D m_can_read(priv, M_CAN_CCCR);
> +			cccr &=3D ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
> +			if (can_is_canfd_skb(skb)) {
> +				if (cf->flags & CANFD_BRS)
> +					cccr |=3D CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
> +				else
> +					cccr |=3D CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
> +			} else {
> +				cccr |=3D CCCR_CMR_CAN << CCCR_CMR_SHIFT;
> +			}
> +			m_can_write(priv, M_CAN_CCCR, cccr);
>  		} else {
> -			cccr |=3D CCCR_CMR_CAN << CCCR_CMR_SHIFT;
> +			/* set tx buffer according to frame content */
> +			if (can_is_canfd_skb(skb)) {
> +				dlc |=3D TX_BUF_FDF;
> +				if (cf->flags & CANFD_ESI)
> +					dlc |=3D TX_BUF_ESI;
> +				if (cf->flags & CANFD_BRS)
> +					dlc |=3D TX_BUF_BRS;
> +			}
>  		}
> -		m_can_write(priv, M_CAN_CCCR, cccr);
>  	}
> +	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, dlc);
> =20
>  	/* enable first TX buffer to start transfer  */
>  	m_can_write(priv, M_CAN_TXBTIE, 0x1);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iLjxo2wbXTXbBAuWAqkR7fgqhF6FVwbWe--

--fIDxp8HESCqhCeq70lQ0vXNBxswc3GEUe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAli+ZJEACgkQHv7KIOw4
HPYjmAf/cHHJDGjDIaCOo+9RH6oJbGqp9f8GbnVtD6rO1k4sU/XFwy00vFO3Aqlo
bjYusCCXNAELSfIOfMTGmApz4e3XyByz26Wk2m0EwkhOt0Kor/FgB1UNMg8gPMFm
sC1qCZ2qUu4idOKklEbfQ4AjLjdg/LBPAtJU0u6tFgJuHh9PA1viCQRYgDViQ4GX
4dq5AQ9CVrVHrBba3oMUUGE6c+jeZXnymIKH3F9Hs+ymxMRC04L/0GtonntHT+B3
GbvWQqaVOYy5XRuPogB0k6uBF7nfSRwyc5C32q6EmkwkUvFAJZp7itwJREE+5iLz
vWkYjyWp0oiqBEGbYObXbqVB/IxPrw==
=KIey
-----END PGP SIGNATURE-----

--fIDxp8HESCqhCeq70lQ0vXNBxswc3GEUe--
