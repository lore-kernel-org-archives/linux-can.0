From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 12:03:09 +0100
Message-ID: <4F44CB6D.3090609@pengutronix.de>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0B5940AA934C5BBE7BC3420C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47126 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2BVLDV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 06:03:21 -0500
In-Reply-To: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>, linux usb Mailing List <linux-usb@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B5940AA934C5BBE7BC3420C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello USB Mailinglist,

On 02/17/2012 01:24 PM, Stephane Grosjean wrote:
> That serie of patches adds the peak_usb driver which handles the PCAN-U=
SB
> and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.com)=
=2E
> These patches are planned for kernel v3.02.00 and above.

Can someone please take a look at the USB related parts of these
drivers, please?

regards,  Marc

>=20
> Stephane Grosjean (3):
>   can/usb: PEAK-System Technik USB adapters driver core
>   can/usb: PEAK-System Technik PCAN-USB specific part
>   can/usb: PEAK-System Technik PCAN-USB Pro specific part
>=20
>  drivers/net/can/usb/Kconfig                  |    5 +
>  drivers/net/can/usb/Makefile                 |    1 +
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +
>  drivers/net/can/usb/peak_usb/pcan_usb.c      |  901 ++++++++++++++++++=
++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  954 ++++++++++++++++++=
++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  146 ++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 1036 ++++++++++++++++++=
++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  178 +++++
>  8 files changed, 3223 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0B5940AA934C5BBE7BC3420C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9Ey3AACgkQjTAFq1RaXHOO/wCdFlnNkwmvcKiYounXmBsK/W64
4mMAnjDVPmJF6AWanBAH1Zs4kbIRoHmn
=Zxyq
-----END PGP SIGNATURE-----

--------------enig0B5940AA934C5BBE7BC3420C--
