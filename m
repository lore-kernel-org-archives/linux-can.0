From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Thu, 19 Nov 2015 14:23:35 +0100
Message-ID: <564DCD57.1000801@pengutronix.de>
References: <20151119124219.GC2638@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DNrM0H3cbbxTp6S3oJin5SiKqRJR775mD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbbKSNXr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2015 08:23:47 -0500
In-Reply-To: <20151119124219.GC2638@mwanda>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, olivier@sobrie.be
Cc: linux-can@vger.kernel.org, socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DNrM0H3cbbxTp6S3oJin5SiKqRJR775mD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/19/2015 01:42 PM, Dan Carpenter wrote:
> Hello Olivier Sobrie,
>=20
> The patch 080f40a6fa28: "can: kvaser_usb: Add support for Kvaser
> CAN/USB devices" from Nov 21, 2012, leads to the following static
> checker warning:
>=20
> 	drivers/net/can/usb/kvaser_usb.c:949 kvaser_usb_rx_error()
> 	0x08 | 0x18 has 0x08 set on both sides
>=20
> drivers/net/can/usb/kvaser_usb.c
>    941          switch (dev->family) {
>    942          case KVASER_LEAF:
>    943                  if (es->leaf.error_factor) {
>    944                          cf->can_id |=3D CAN_ERR_BUSERROR | CAN_=
ERR_PROT;
>    945 =20
>    946                          if (es->leaf.error_factor & M16C_EF_ACK=
E)
>    947                                  cf->data[3] |=3D (CAN_ERR_PROT_=
LOC_ACK);
>    948                          if (es->leaf.error_factor & M16C_EF_CRC=
E)
>    949                                  cf->data[3] |=3D (CAN_ERR_PROT_=
LOC_CRC_SEQ |
>    950                                                  CAN_ERR_PROT_LO=
C_CRC_DEL);
>=20
> CAN_ERR_PROT_LOC_CRC_SEQ is 0x08
> CAN_ERR_PROT_LOC_CRC_DEL is 0x18
>=20
> It's weird that the bits overlap.  Was that intentional?  Why isn't it
> enough to just say?:
> 					cf->data[3] |=3D CAN_ERR_PROT_LOC_CRC_DEL;

Looking at include/uapi/linux/can/error.h I'd say, they are not meant to
be used bitwise. Oliver?

> The static checker complains about most places where
> CAN_ERR_PROT_LOC_CRC_SEQ is used.  I see us setting the flag but not I
> don't see where we test for this so I'm not sure.
>=20
>    951                          if (es->leaf.error_factor & M16C_EF_FOR=
ME)
>    952                                  cf->data[2] |=3D CAN_ERR_PROT_F=
ORM;
>    953                          if (es->leaf.error_factor & M16C_EF_STF=
E)
>    954                                  cf->data[2] |=3D CAN_ERR_PROT_S=
TUFF;
>    955                          if (es->leaf.error_factor & M16C_EF_BIT=
E0)
>    956                                  cf->data[2] |=3D CAN_ERR_PROT_B=
IT0;
>    957                          if (es->leaf.error_factor & M16C_EF_BIT=
E1)
>    958                                  cf->data[2] |=3D CAN_ERR_PROT_B=
IT1;
>    959                          if (es->leaf.error_factor & M16C_EF_TRE=
)
>    960                                  cf->data[2] |=3D CAN_ERR_PROT_T=
X;
>    961                  }
>    962                  break;
>    963          case KVASER_USBCAN:

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DNrM0H3cbbxTp6S3oJin5SiKqRJR775mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWTc1XAAoJEP5prqPJtc/HhccH/0QCl+a/bwMky05/eroi7Ntm
giI8AwMBNK2anatsuQ8MsvWbNvdSBaPxoEQzjRwx2KHFqDKgYPzf2BAl4VDRf/Kg
d5R9WZPi+PlzP+Qm0ROgYF0d8opDa9xLhWyICI3humKkius7EPOt8fuSJVKa6uMU
SP8RxcPNXEEGyCp6HAxn07h1HI8l3n6u9Q1mKuQFl3k1NynKO2cXe27/vs9FVyHQ
cTsLuUXJHcRDLIB/AlOuTaYFFytGBi4Px+IQAh8zKGL374T+8m/yc4urq9B55B4d
i9war0Wo15bCaD9hjz4dPUM/h/Fom60ndk5IIhzpyXf/uLoEm3L8yVbgbncdt0g=
=SdRy
-----END PGP SIGNATURE-----

--DNrM0H3cbbxTp6S3oJin5SiKqRJR775mD--
