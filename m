From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 12:24:40 +0200
Message-ID: <4FEADF68.7070702@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <4FEAC3EF.3060606@pengutronix.de> <4FEACAAB.1000002@grandegger.com> <4FEAD5CF.9070601@grandegger.com> <4FEAD7B8.2000601@pengutronix.de> <4FEADCB8.80306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC6F813B7048059330D615F82"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56008 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab2F0KYw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 06:24:52 -0400
In-Reply-To: <4FEADCB8.80306@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org, Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6F813B7048059330D615F82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 12:13 PM, Hui Wang wrote:
[...]

>>> What compatible string do they actually use for the i.MX6Q board? Sha=
wn
>>> or Hui? We need to fix that. From the discussion mentioned above I th=
ink
>>>    =20
> Currently i modified the can1 DT entry in the  imx6q.dtsi like this:
>            flexcan@02090000 { /* CAN1 */
>                reg =3D <0x02090000 0x4000>;
>                interrupts =3D <0 110 0x04>;
>                hw-version =3D <10>;
                 ^^^^^^^^^^^^^^^^^^

remove

>            };
>=20
> and the DT entry in the imx6q-sabrelite.dts like this:
>            flexcan@02090000 { /* CAN1 */
>                compatible =3D "fsl,imx6q-flexcan", "fsl,p1010-flexcan";=

                                                   ^^^^^^^^^^^^^^^^^^^

If imx6q is the first sock with this core "fsl,imx6q-flexcan" is the
official name. "fsl,p1010-flexcan" will be removed. The compatible
should go into the imx6q.dtsi

>                phy-en-gpio =3D <&gpio1 4 0>;
>                phy-stby-gpio =3D <&gpio1 2 0>;
>                pinctrl-names =3D "default";
>                pinctrl-0 =3D <&pinctrl_flexcan1_1>;
>            };
> if we don't use hw-version entry and use flexcan-v10, do you mean we us=
e
> strcmp or strxxx to decide controller version?

No, have a look at the flexcan_of_match. The struct of_device_id has a
data pointer that can point to some arbitrary data. Define a struct
flexcan_devtype_data which has, for now, a hardware revision member.
Have a look at the imx-spi[1] driver.

Marc

[1] http://lxr.free-electrons.com/source/drivers/spi/spi-imx.c
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC6F813B7048059330D615F82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/q324ACgkQjTAFq1RaXHNy0wCdFtWjygEOH8btA4V6Olzpo80v
trcAnik5qPYNIpVchEFq4QTaRyZkV/eL
=Cbdf
-----END PGP SIGNATURE-----

--------------enigC6F813B7048059330D615F82--
