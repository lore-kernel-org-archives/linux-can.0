From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received
 RTR, frames
Date: Wed, 18 Oct 2017 13:49:56 +0200
Message-ID: <f6139d9d-47a3-ab10-fe36-27dcff7ef54a@pengutronix.de>
References: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wD0aKWK1h1lLWfcpMNu1pogMgGmhOAKwa"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41687 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965443AbdJRM21 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Oct 2017 08:28:27 -0400
In-Reply-To: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wD0aKWK1h1lLWfcpMNu1pogMgGmhOAKwa
Content-Type: multipart/mixed; boundary="d5UUVmWQl85UmUgRpA5OS7RGRlQLUHbSf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <f6139d9d-47a3-ab10-fe36-27dcff7ef54a@pengutronix.de>
Subject: Re: [PATCH 2/2] can: usb: esd_usb2: Fix can_dlc value for received
 RTR, frames
References: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>
In-Reply-To: <c66525cb-77bd-fa5f-d3ab-78db08bdd763@esd.eu>

--d5UUVmWQl85UmUgRpA5OS7RGRlQLUHbSf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/18/2017 01:25 PM, Stefan M=C3=A4tje wrote:
> The dlc member of the struct rx_msg contains also the ESD_RTR flag to m=
ark
> received RTR frames. Without the fix the can_dlc value for received RTR=

> frames would always be set to 8 by get_can_dlc() instead of the receive=
d
> value.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
> index 6183b7707ad7..20f2aa21677f 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -49,7 +49,7 @@ MODULE_LICENSE("GPL v2");
>  #define CMD_IDADD              6 /* also used for IDADD_REPLY */
>=20
>  /* esd CAN message flags - dlc field */
> -#define ESD_RTR                        0x10
> +#define ESD_RTR                        0x10u

I think this is not needed, is it?

>=20
>  /* esd CAN message flags - id field */
>  #define ESD_EXTID              0x20000000
> @@ -334,7 +334,7 @@ static void esd_usb2_rx_can_msg(struct
> esd_usb2_net_priv *priv,
>                 }
>=20
>                 cf->can_id =3D id & ESD_IDMASK;
> -               cf->can_dlc =3D get_can_dlc(msg->msg.rx.dlc);
> +               cf->can_dlc =3D get_can_dlc(msg->msg.rx.dlc & ~ESD_RTR)=
;
>=20
>                 if (id & ESD_EXTID)
>                         cf->can_id |=3D CAN_EFF_FLAG;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--d5UUVmWQl85UmUgRpA5OS7RGRlQLUHbSf--

--wD0aKWK1h1lLWfcpMNu1pogMgGmhOAKwa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlnnP+QACgkQHv7KIOw4
HPbOUQgA2JwX3IVCiwlCjwo0liUqt5pnugyDVMW/NydAsv6XMPhu64XoXlBeW2Ib
Je0VIeiP9z35Su3Ys7WV5JbI+iZc1p4vtfmfzSUSa6EQGZFG9plOqWGsARhBKNFe
irUiHEsSNfNJB2uXl0+qOij2ghJm4klyWj+0/Wt5Y8mHrUK0SlZFaci0TL/oh/tA
2RZMxkpl6guo1YjCx8UdeR7QjYiC+zEqa8swlNDTbaHqJIlmC7uazba/asPgwUlx
1BsEl7djR1mI7ghdtIyp97zLMXXMLh+Ph1zRYqcV2dKRaKhTNq3kF1/+t4qB0/0f
DkmDEaY/v+gADHFz5bMAwyt7hPbDzw==
=2Va4
-----END PGP SIGNATURE-----

--wD0aKWK1h1lLWfcpMNu1pogMgGmhOAKwa--
