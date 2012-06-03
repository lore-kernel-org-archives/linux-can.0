From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 0/2] can: c_can: Add support for Bosch D_CAN controller
Date: Mon, 04 Jun 2012 00:56:26 +0200
Message-ID: <4FCBEB9A.8050000@pengutronix.de>
References: <1338270196-7819-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6799558AA0BC707B661DFD2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39147 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab2FCW4c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 3 Jun 2012 18:56:32 -0400
In-Reply-To: <1338270196-7819-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6799558AA0BC707B661DFD2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/29/2012 07:43 AM, AnilKumar Ch wrote:
> This patch series adds support for Bosch D_CAN controller to the
> existing C_CAN controller driver.
>=20
> Bosch D_CAN controller is a full-CAN implementation compliant to
> CAN protocol version 2.0 part A and B. Bosch D_CAN user manual
> can be obtained from: http://www.semiconductors.bosch.de/media/
> en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf
>=20
> D_CAN device is used on many SoCs like AM335x, DM811x, DM813x and
> DM8148 EVMs from TI, D_CAN details on AM335x can be accessed from:
> http://www.ti.com/lit/ug/spruh73c/spruh73c.pdf
>=20
> These patches have been tested on AM335x EVM using some additional
> patches adding runtime PM support and some code to initialize the
> AM335x D_CAN RAM. I will submit these patches once these patches are
> accepted.
>=20
> Due to lack of hardware I am not able to test c_can functionality.
> I appreciate if anyone can test C_CAN functionality with this patch
> series.
>=20
> This series applies on top of three patches submitted and accepted
> earlier. Details of those three patches are
> 	- http://marc.info/?l=3Dlinux-can&m=3D133777549929733&w=3D2
> 	- http://marc.info/?l=3Dlinux-can&m=3D133777550329736&w=3D2
> 	- http://marc.info/?l=3Dlinux-can&m=3D133777550929737&w=3D2
>=20
> Changes from v4:
> 	- Incorporated all Wolfgang's review comments on v4
> 	  * Changed id_table entries
> 	  * Modified Kconfig entry and help
> 	- Dropped three patches from v4
>=20
> Changes from v3:
> 	- Incorporated all Marc's review comments on v3 (patch4)
> 	- Resending rest of the patches, because all the patches are
> 	  interdependent
>=20
> Changes from v2:
>         - Dropped patch 1 (acc. to v2) because no update from v2. Can
>           be found at http://permalink.gmane.org/gmane.linux.can/1081
>         - Incorporated all Marc's review comments on v2
>           * Changed patch 2 (acc. to v2) subject line to "can: c_can:
>             fix race condition in c_can_open()"
>           * Moved "int reg" in patch 3 (acc. to v2) to "enum reg index"=

>           * Device registration changed by using "platform_device:
>             id_table"
>         - Changed iface hard coded way to a macro implementation.
>=20
> Changes form v1:
>         - Changed the Macro implementation to access registers via an
>           array with virtual register index.
>         - Dropped "can: c_can: fix "BUG! echo_skb is occupied!" during
>           transmit" patch because it's accepted.
>         - Reworked on second patch (acc. to v1) based on Marc's comment=
s.
>         - Found one more issue and added as separate patch.
>         - Third patch (acc. to v1) is split into two patches, first
>           patch only do c_can modifications to incorporate the current
>           implementation and second one adds d_can support
>=20
>=20
> AnilKumar Ch (2):
>   can: c_can: Move overlay structure to array with offset as index
>   can: c_can: Add support for Bosch D_CAN controller
>=20
>  drivers/net/can/c_can/Kconfig          |   13 ++-
>  drivers/net/can/c_can/c_can.c          |  120 ++++++++++++-----------
>  drivers/net/can/c_can/c_can.h          |  163 ++++++++++++++++++++++++=
--------
>  drivers/net/can/c_can/c_can_platform.c |   76 ++++++++++-----
>  4 files changed, 247 insertions(+), 125 deletions(-)

I've just send a pull-request to David for the c_can fixes. They go via
the net tree. These patches will be delayed until net is merged back
into the net-next branch.

As soon as David has taken the c_can patches, I'll ask him to merge them
to net-next.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE6799558AA0BC707B661DFD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/L65oACgkQjTAFq1RaXHPcsgCggtkcT5NJVEEde89QGLRYxdJW
md4An0ZNIm8IU2m9uIvLCp+wzm0L/gPJ
=nvgX
-----END PGP SIGNATURE-----

--------------enigE6799558AA0BC707B661DFD2--
