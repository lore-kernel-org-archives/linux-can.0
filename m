From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: iproute2 fd-non-iso PoC - was Re: [PATCH v4] can/peak_usb: add
 support for PEAK new CANFD USB adapters
Date: Thu, 08 Jan 2015 10:04:33 +0100
Message-ID: <54AE4821.3090204@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54AD6ED8.2020808@hartkopp.net> <54AD7D06.5030705@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1WuTGaoQGT7oDTiw2w32Ci7i1ESvNW4P0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54935 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbbAHJEg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Jan 2015 04:04:36 -0500
In-Reply-To: <54AD7D06.5030705@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1WuTGaoQGT7oDTiw2w32Ci7i1ESvNW4P0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/07/2015 07:37 PM, Oliver Hartkopp wrote:
> Just a short test:
>=20
> I added u32 ctrlmode in Stephanes peak_usb_adapter struct for a test:
>=20
> @@ -44,8 +46,11 @@ struct peak_usb_device;
>  struct peak_usb_adapter {
>         char *name;
>         u32 device_id;
> +       u32 ctrlmode_supported;
> +       u32 ctrlmode;
>         struct can_clock clock;
>=20
> Which looks like this in pcan_usb_pro.c
>=20
> @@ -1015,6 +1007,8 @@ struct peak_usb_adapter pcan_usb_pro =3D {
>         .name =3D "PCAN-USB Pro",
>         .device_id =3D PCAN_USBPRO_PRODUCT_ID,
>         .ctrl_count =3D PCAN_USBPRO_CHANNEL_COUNT,
> +       .ctrlmode =3D 0,

Not needed, as 0 is default.

> +       .ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_L=
ISTENONLY,
>         .clock =3D {
>=20
> and in pcan_usb_fd.c :
>=20
> /* describes the PCAN-USB Pro FD adapter */
> struct peak_usb_adapter pcan_usb_pro_fd =3D {
>         .name =3D "PCAN-USB Pro FD",
>         .device_id =3D PCAN_USBPROFD_PRODUCT_ID,
>         .ctrl_count =3D PCAN_USBPROFD_CHANNEL_COUNT,
>         .ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO,
>         .ctrlmode_supported =3D CAN_CTRLMODE_FD |
>                         CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONL=
Y,
>         .clock =3D {
>=20
> Finally the ip tools gives this output (when FD is enabled):
>=20
> # ip -det link show can0
> 17: can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group =
default qlen 10
>     link/can  promiscuity 0=20
>     can <FD,FD-NON-ISO> state STOPPED restart-ms 0=20
> 	  pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1=

> 	  pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024 dbrp-in=
c 1
> 	  clock 80000000
>=20
> AND - as expected - removing this flag is denied:
>=20
> # ip link set dev can0 type can fd-non-iso off
> RTNETLINK answers: Operation not supported
>=20
> Regards,
> Oliver
>=20
> ps. Current patch for iproute2 is attached. Will send a proper patch wh=
en
> CAN_CTRLMODE_FD_NON_ISO found its way into mainline.
>=20
>=20
>=20
> iproute2-fd-non-iso.patch
>=20
>=20
> diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
> index 25fd52c..6d4ec2a 100644
> --- a/include/linux/can/netlink.h
> +++ b/include/linux/can/netlink.h
> @@ -98,6 +98,7 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
>  #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
>  #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
> +#define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */

AFAIC the headers are imported from the Linux tree, so no need to modify
this file in the final patch. You might have to ask for the import when
sending these patches, though.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1WuTGaoQGT7oDTiw2w32Ci7i1ESvNW4P0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrkghAAoJECte4hHFiupUZwwQAIdXrSVXPPqheIetFaFMBl8d
+QbjMH1jE1YvDl8yy12kqu5kGMyG92sqsaHdrd4t64y4btHSn2XzqKkHdWPUiQR4
OG0Ffh04XtBguIlpTLxqpOTklPllGUPBMDZKUC49JfN65q4+Ks7Z3g64JKP45B5E
vCEIMF6dHYfiC9Bgu7tS0DfVW1X6kz6ICR4yDriyB+mljMKjlHZpCPA3TysHwCbA
Pjx/TFKkMNER/gbmUxSh/KFEwziUz5xTd4tRuC5Jzl41kndvkp+6Am59cid3ne98
dOvwxifU4CQllmBAIXraSF2W/XLzA+a3xrx3Y1Yczo0F4IzMynWfwaLhdr5eS4fJ
JvlzQ7ZgpvNyzLByLezSaeF9lFEG07ZSlANngz46iNr/40INDUbFywWDzrUZiQ8q
cE3h0Qj/azX0Fh1iCYBEnL2L7sdAYEj2ONSfBEjd9go9ADipTFPihY1WqB2xJzJc
sS2h8tUb2qYx6n8SiNtcu5KGOMvPLnKbK5IMlQnQEqCJ7b39kapS/PYXRMXmVJI/
BHLz7hujw0GwADNdRE62VNi0kBlYCRL3mAKts2gK/Yyjlk9Ho6eZdNRy8X+3dOwz
Z32zBOwYo60ZpOVusHONCcByrlEm5BqB8KZtoNiek3sAAD5TgFaQZT68yF+l0MRM
HozLWsJ+h7vHOqiIOU8A
=cVJ3
-----END PGP SIGNATURE-----

--1WuTGaoQGT7oDTiw2w32Ci7i1ESvNW4P0--
