From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] Add DT support to C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 11:04:21 +0200
Message-ID: <500FB695.4080103@pengutronix.de>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig71BA20D180FCD4038D77411C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab2GYJE2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 05:04:28 -0400
In-Reply-To: <1343197417-27481-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71BA20D180FCD4038D77411C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 08:23 AM, AnilKumar Ch wrote:
> This patch series adds the device tree support to C_CAN/D_CAN
> controller with pinmux configuration and device tree data
> addition to corresponding dts and dtsi files.
>=20
> Also adds Runtime PM support to C_CAN/D_CAN controller.
>=20
> These patches have been tested on AM335x EVM using some additional
> patch to initialize D_CAN RAM. D_CAN raminit is controlled from
> control module register. This patch will be submitted once control
> module MFD driver support is added to mainline.
>=20
> Due to lack of hardware I am not able to test c_can functionality.
> I appreciate if anyone can test c_can functionality with this patch
> series.
>=20
> First and last patches applies on top of linux-next tree, 2nd and
> 3rd patches applies on linux-omap tree.

I think 1st and 4th patch (if not all) should go though the
linux-can-next tree. Please rebase against linux-can-next master. If you
need features from the v3.6 release cycle we have to wait until David
merges then back.

regards, Marc

>=20
> AnilKumar Ch (4):
>   can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
>   arm/dts: AM33XX: Add D_CAN device tree data
>   arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
>   can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller
>=20
>  .../devicetree/bindings/net/can/c_can.txt          |   38 ++++++++++++=
+
>  arch/arm/boot/dts/am335x-evm.dts                   |   13 +++++
>  arch/arm/boot/dts/am33xx.dtsi                      |    5 ++
>  drivers/net/can/c_can/c_can_platform.c             |   60 ++++++++++++=
+++-----
>  4 files changed, 101 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt=

>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig71BA20D180FCD4038D77411C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAPtpUACgkQjTAFq1RaXHOcrQCeIALiT1AHfDD0Iry2OFzQ9QJc
xvsAn1HrE4UJBBIAhjT55Ps9F+Kg8s2V
=nqlr
-----END PGP SIGNATURE-----

--------------enig71BA20D180FCD4038D77411C--
