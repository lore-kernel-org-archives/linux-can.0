From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 3/5] can: flexcan: Add ls1021a flexcan device entry
Date: Thu, 14 May 2015 17:38:02 +0200
Message-ID: <5554C15A.6050501@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-4-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ASg4aBxHS2X9GVsuhrAfUWSksmNjcoufD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38233 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbbENPiW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 May 2015 11:38:22 -0400
in-reply-to: <1431603215-25546-4-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh Sharma <bhupesh.sharma@freescale.com>, arnd@arndb.de, linux-can@vger.kernel.org
Cc: bhupesh.linux@gmail.com, Sakar.Arora@freescale.com, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ASg4aBxHS2X9GVsuhrAfUWSksmNjcoufD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
> This patch adds ls1021a flexcan device entry to the flexcan driver code=
=2E
>=20
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  drivers/net/can/flexcan.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index ad0a7e8..deaa24e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -267,10 +267,26 @@ static struct flexcan_devtype_data fsl_imx28_devt=
ype_data;
>  static struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
>  	.features =3D FLEXCAN_HAS_V10_FEATURES,
>  };
> +
>  static struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
>  	.features =3D FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
>  };
> =20
> +/* LS1021A-Rev1 has a broken RX-FIFO support. So only legacy RX messag=
e-buffers
> + * work here.
> + */
> +static struct flexcan_devtype_data fsl_ls1021a_devtype_data =3D {
> +	.features =3D FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES |
> +		    FLEXCAN_HAS_ONLY_LEGACY_RX_SUPPORT,
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This will probably not compile.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ASg4aBxHS2X9GVsuhrAfUWSksmNjcoufD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVVMFeAAoJECte4hHFiupUROsP/2JTFasab6zmHIUnYoKIGZP0
pq0W/0CfCid/51qEu9HD1c8cJ2KU7hXscJ+D0zIjCHwJ0qgQP5g5pdWvRVo76CXj
8NNCXha6b87j+hGmssGMppjCtLUdcNlzqseF3UgBbSW4wAxQ835i4bE5CkB7DaFu
LGsB49i15DCEHe8j1+t+hEsJCgXbb1Tm4P9ZaJ/Smj5FDiGUDqQ3IMTNE0mjhv06
3YR1yLORimUdltVmDbst+9tyEEu+nGkoK2gVmZy6j4OP9VtOP3b3LXOjhgw/Rn4h
rm8S0NfgYi96AO5QetUzpwd27rtaVdKE3tz8FP8HWtDcQtr2bYH+Qf7Pt0DDWYSy
B9nwA/Q0FswkjNoTDB4f/LuhE0pWPXnTw1RKouYygYkOyDRPNElJofQ/ODwzHzUe
09LIDYs4bZ/WAaZ2G3nKeM55oRTAkDJXnXf8H6OpIQj7ap1mVHw3DLyDUw3BAJeu
L/94Io0x75uVMrL8ZGcON6UMC7SfnoY8BfuTnfTGF7Rww58wq5Wqo0+1jHdeS9WX
8yASDsbS56emt3tCoJs6KsRwvnt17H108nFqzbZovxjht8Ky5TDL0EZnd0KuXLf4
jmCaYDoG/gP7RRM5qInv8R2CezjezSxMIIb5/29lPYiGBBAJ/y/awReMfSxl+Zok
A4zLFh5D1loZQV8YlHko
=pazr
-----END PGP SIGNATURE-----

--ASg4aBxHS2X9GVsuhrAfUWSksmNjcoufD--
