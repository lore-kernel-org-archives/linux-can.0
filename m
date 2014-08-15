From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: flexcan: Detect error passive state change
Date: Fri, 15 Aug 2014 10:07:06 +0200
Message-ID: <53EDBFAA.3070809@pengutronix.de>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com> <1407850987-26707-2-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VTRdqjs5QCRHeaBjU9grrWO5Ua7DcP7gH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48816 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaHOIHN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Aug 2014 04:07:13 -0400
In-Reply-To: <1407850987-26707-2-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VTRdqjs5QCRHeaBjU9grrWO5Ua7DcP7gH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 03:43 PM, Alexander Stein wrote:
> Assuming there is no CAN frame reception or CAN_CTRLMODE_BERR_REPORTING=
:
> If the Tx error counter steps from 127 to 128 the hardware enters error=

> passive. But in this case the FLEXCAN_ESR_ERR_STATE bits are unset:
> TWRN_INT and RWRN_INT are not set during the transition from <96 to >=3D=
96.

Which hardware are you using? According to the documentation TWRN_INT
and RWRN_INT _are_ actually set during the transition from <96 to >=3D96.=


> So we do not schedule NAPI thus not evaluating the error counters.
> So we also check TX_WRN and RX_WRN in order to detect error passive.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/net/can/flexcan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index fd79dd40840b..5e391ec70a2b 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -721,7 +721,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_i=
d)
>  	 * - bus error IRQ and bus error reporting is activated
>  	 */
>  	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
> -	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +	    (reg_esr & (FLEXCAN_ESR_ERR_STATE |
> +			FLEXCAN_ESR_TX_WRN | FLEXCAN_ESR_RX_WRN)) ||
>  	    flexcan_has_and_handle_berr(priv, reg_esr)) {
>  		/*
>  		 * The error bits are cleared on read,
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VTRdqjs5QCRHeaBjU9grrWO5Ua7DcP7gH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPtv6oACgkQjTAFq1RaXHPcswCfS6xJFdnwRCljxdlQKBlGpHBb
UpYAn2jwgua1g9REgBkxBBlJyNin901j
=y4fV
-----END PGP SIGNATURE-----

--VTRdqjs5QCRHeaBjU9grrWO5Ua7DcP7gH--
