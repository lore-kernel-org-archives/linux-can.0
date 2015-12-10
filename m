From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: flexcan: Ancient Freescale Reference FlexCAN Driver and bug
 fixes so it works.
Date: Thu, 10 Dec 2015 13:44:20 +0100
Message-ID: <566973A4.5000703@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696582.7020503@optusnet.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Rwk3SsMOFolO7I8u70L79dCaO6o4T3QDf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60254 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbbLJMon (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:44:43 -0500
In-Reply-To: <56696582.7020503@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, Sharma Bhupesh <bhupesh.sharma@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rwk3SsMOFolO7I8u70L79dCaO6o4T3QDf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/10/2015 12:44 PM, Tom Evans wrote:
> I've just had to delve back into the deep murky past and try to get=20
> Freescale's Kernel 2.6.35 FlexCAN driver working. That's because the=20
> only code base that supports Freescale's Video Hardware is that one and=
=20
> we need working video.

2.6.x I feel your pain. Another option would be to port the flexcan
driver to that old kernel. But I'm getting off topic here :)

> I'm suggesting this code as an "historical reference" that might be=20
> useful for anyone looking for simple/simplistic ways to handle a FlexCA=
N=20
> port. It isn't like the driver actually works fully. It can't have ever=
=20
> been tested very much. Which is why I've had to fix it.
>=20
> It has the Driver, Register handling and Message Buffer handling split =

> into three separate source files, which is a useful simplification.

YMMV :)

> It can't be configured with "canconfig", but exposes a huge number of=20
> variables in the sysfs which is actually quite powerful and extendable.=

>=20
> Freescale's "2.6.35_maintain" kernel consists of 2.6.35 plus about 1200=
=20
> Freescale patches which basically replace all the hardware drivers.
>=20
> The source for this driver in this tree (until someone renames it to NX=
P):
>=20
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/log/?h=3Dim=
x_2.6.35_maintain
>=20
> The Driver is in the expected place:
>=20
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/driver=
s/net/can/flexcan?h=3Dimx_2.6.35_maintain
>=20
> 1 - It defaults to 32 receive and 32 transmit MBs, but that can be chan=
ged.
>=20
> 2 - It can't receive in order, but you'd only need to sort on the=20
> timestamps to fix that (or use the FIFO).

In order reception is crucial.

> 3 - It can't transmit in order either (unless you drop it to one=20
> transmit MB), but a simple change to the Transmit MB assignment would=20
> fix that.

Same here.

> 4 - It supports FIFO mode, but it doesn't work at all. The FIFO hardwar=
e=20
> gets so badly screwed by the driver that it has to be power-cycled to=20
> get it working again.
>=20
> 5 - Transmit doesn't work either. If you push it it'll start sending ON=
E=20
> Message per SECOND. That's an easy fix by changing the code to actually=
=20
> unblock the netif queue instead of what it does.
>=20
> 6 - The sysfs variable that reserves receive message buffers is named t=
o=20
> reserve transmit buffers, it messes up if the DLC is over 8 (because it=
=20
> doesn't call get_can_dlc()), the Dump routines don't work properly,=20
> off-by-one bug, comparison-reversal bug and so on.
>=20
> 7 - The only good thing about it is that it doesn't use NAPI, so when=20
> fixed it doesn't drop messages when you try to use MMC/eMMC/ESDHC.
>=20
> FIFO bug documented and fixed here:
>=20
> https://community.freescale.com/thread/381075
>=20
> Transmit bug documented and fixed here (and the other ones listed), als=
o=20
> MMC/eMMC problem:
>=20
> https://community.freescale.com/message/595897
>=20
> Patches to fix all of it on the end of this thread:
>=20
> https://community.freescale.com/thread/303271

If there's interest in working with this prehistoric kernel, why isn't
there anyone that picks up all the patches and add them to a git repo.
fsl doesn't seem to care either, maybe unless you're using their newest
product :(

just my 2=C2=A2,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rwk3SsMOFolO7I8u70L79dCaO6o4T3QDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWaXOnAAoJEP5prqPJtc/HatUH/jOwHWM81yl9/94xYqFEJ1Sz
hvf4jE5hqKdfkzxY5g7KXDdHExLEDxaR91edHcVsIJ2k3PAzqeydsnATRyj5mdmM
c4aWwlSDGLCNYe3a2kXgAjH7vIc7LzJRv4vDOfBqmIkenJUvJQLtU99QsErsqQft
lst8ZWKFPwZrAQ1Hp9bP6i+cLnNBU/CvVEG9zVfb6Q1VgevU/mVUhOQ7uxnj0Qcp
np8kTa6TA1U7qj5/3WFypHPGHggfM5iYa52d8qKz/Z4YzKJ1iSuq9p8tdbqeNusc
ZwkGqgk7XhMv8a3bXffSeus4KvkfJAtXzJNk3WyBKzjVVMXxC6Z8Gy5lwJf9DKY=
=H5mm
-----END PGP SIGNATURE-----

--Rwk3SsMOFolO7I8u70L79dCaO6o4T3QDf--
