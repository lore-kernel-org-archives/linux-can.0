From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 0/5] can: c_can: Add support for Bosch D_CAN controller
Date: Thu, 24 May 2012 10:20:54 +0200
Message-ID: <4FBDEF66.1050307@pengutronix.de>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93DAD4EB513223F57F0511DB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52596 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2EXIVH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 04:21:07 -0400
In-Reply-To: <1337775313-28219-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93DAD4EB513223F57F0511DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

Oliver just poked me, what about these patches :)

On 05/23/2012 02:15 PM, AnilKumar Ch wrote:
> This patch series adds support for Bosch D_CAN controller to the
> existing C_CAN controller driver.
>=20
> Bosch D_CAN controller is a full-CAN implementation compliant to CAN
> protocol version 2.0 part A and B. Bosch D_CAN user manual can be
> obtained from: http://www.semiconductors.bosch.de/media/
> en/pdf/ipmodules_1/can/d_can_users_manual_111.pdf
>=20
> D_CAN device is used on many SoCs like AM335x, DM8148 and DM813x EVMs
> from TI, D_CAN details on AM335x can be accessed from:
> http://www.ti.com/lit/ug/spruh73c/spruh73c.pdf
>=20
> This patch series also fixes some issues in the current c_can driver.
> These issues were found while integrating d_can driver to c_can driver.=

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
> AnilKumar Ch (5):
>   can: c_can: fix "BUG! echo_skb is occupied!" during transmit
>   can: c_can: fix an interrupt thrash issue with c_can driver
>   can: c_can: fix race condition in c_can_open()

I've added these three patches to the linux-can/master on gitorious [1].
I fixed a typo in the first patch's commit message, added Wolfgang's
Acked-by and stable to Cc. The series is compile tested only. I'm going
to write a pull request to David. Any objections?

>   can: c_can: Move overlay structure to array with offset as index
>   can: c_can: Add support for Bosch D_CAN controller

I'm going to add these patches to linux-can-next after we've sorted out
the outstanding minor things about the id_table.

cheers, Marc

[1] https://gitorious.org/linux-can/linux-can

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig93DAD4EB513223F57F0511DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+972oACgkQjTAFq1RaXHMaRgCePZ6duY+VGlsIuYr3z2YfO1RP
gxIAoIPwmn+f0p6qus2FsZcVte583zsB
=Xz3S
-----END PGP SIGNATURE-----

--------------enig93DAD4EB513223F57F0511DB--
