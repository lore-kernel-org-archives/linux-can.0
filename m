From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3 v7] can/usb: PEAK-System Technik USB adapters driver
 core
Date: Thu, 01 Mar 2012 18:22:04 +0100
Message-ID: <4F4FB03C.9030003@pengutronix.de>
References: <1330354431-12974-1-git-send-email-s.grosjean@peak-system.com> <1330354431-12974-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC30F0106263A0010F5E3E267"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42270 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2CARW0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Mar 2012 12:22:26 -0500
In-Reply-To: <1330354431-12974-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Alan Stern <stern@rowland.harvard.edu>, linux-can Mailing List <linux-can@vger.kernel.org>, linux usb Mailing List <linux-usb@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC30F0106263A0010F5E3E267
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/27/2012 03:53 PM, Stephane Grosjean wrote:
> This patch adds the core of the peak_usb driver which handles PEAK-Syst=
em
> Technik PCAN USB adapters. It defines the parts which are common to the=

> PCAN-USB adapters: can network interfaces management, network-to/from-u=
sb
> data path interface, timestamps management...
>=20
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  v7 changelog (pcan_usb_core.c only):
>  - use of print_hex_dump() in dump_mem() function
>  - use of monotonic clock in packets timestamp
>=20
>  drivers/net/can/usb/Kconfig                  |    6 +
>  drivers/net/can/usb/Makefile                 |    1 +
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  951 ++++++++++++++++++=
++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  146 ++++
>  5 files changed, 1106 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/Makefile
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_core.h
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 0452549..0a68768 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -13,4 +13,10 @@ config CAN_ESD_USB2
>            This driver supports the CAN-USB/2 interface
>            from esd electronic system design gmbh (http://www.esd.eu).
> =20
> +config CAN_PEAK_USB
> +	tristate "PEAK PCAN-USB/USB Pro interfaces"
> +	---help---
> +	  This driver supports the PCAN-USB and PCAN-USB Pro adapters
> +	  from PEAK-System Technik (http://www.peak-system.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
> index fce3cf1..da6d1d3 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -4,5 +4,6 @@
> =20
>  obj-$(CONFIG_CAN_EMS_USB) +=3D ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
> +obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> =20
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/usb/peak_usb/Makefile b/drivers/net/can/us=
b/peak_usb/Makefile
> new file mode 100644
> index 0000000..1aefbc8
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
> +peak_usb-y =3D pcan_usb_core.o pcan_usb.o pcan_usb_pro.o

Same problem with bisecability here, please fix.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC30F0106263A0010F5E3E267
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PsDwACgkQjTAFq1RaXHOW3QCglGL7BCEVvqwj6aY5HJbqdkwq
93MAoJlP4edJoNIshfExFfBfj1fVzKA5
=YvHr
-----END PGP SIGNATURE-----

--------------enigC30F0106263A0010F5E3E267--
