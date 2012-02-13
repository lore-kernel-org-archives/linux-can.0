From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Mon, 13 Feb 2012 10:20:48 +0100
Message-ID: <4F38D5F0.2070605@pengutronix.de>
References: <1328543212-9016-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig716E498947238B0DB151B27A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab2BMJUu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 04:20:50 -0500
In-Reply-To: <1328543212-9016-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig716E498947238B0DB151B27A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2012 04:46 PM, Stephane Grosjean wrote:
> This patch adds the support for the following 3x sja1000 based PCI card=
s
> from PEAK-System Technik (www.peak-system.com):
>=20
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
>=20
> The PCAN-ExpressCard card needs I2C bit-banging interface, so it must b=
e
> explicitly selected. Doing this automatically selects I2C and I2C_ALGOB=
IT
> bit-banging kernel configuration options.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> v6 changes:
> - the PCANExpressCard device id belongs to the module device id. table =
only if
>   the kernel is configured for (see CONFIG_CAN_PEAK_PCIEC)
>=20
>  drivers/net/can/sja1000/Kconfig    |   18 +-
>  drivers/net/can/sja1000/peak_pci.c |  509 ++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 510 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index 36e9d59..8116336 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -44,11 +44,23 @@ config CAN_EMS_PCI
>  	  (http://www.ems-wuensche.de).
> =20
>  config CAN_PEAK_PCI
> -	tristate "PEAK PCAN PCI/PCIe Cards"
> +	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
>  	depends on PCI
>  	---help---
> -	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> -	  from PEAK Systems (http://www.peak-system.com).
> +	  This driver is for the PCAN-PCI/PCIe/miniPCI cards
> +	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> +	  (http://www.peak-system.com).
> +
> +config CAN_PEAK_PCIEC
> +	bool "PEAK PCAN-ExpressCard Cards"

Is there a particular reason to make this bool, why not tristate? Todays
dekstop distros usually build everything modular.

> +	depends on CAN_PEAK_PCI
> +	select I2C
> +	select I2C_ALGOBIT
> +	default y
> +	---help---
> +	  Say Y here if you want to use a PCAN-ExpressCard from PEAK-System
> +	  Technik. This will also automatically select I2C and I2C_ALGO
> +	  configuration options.
> =20
>  config CAN_KVASER_PCI
>  	tristate "Kvaser PCIcanx and Kvaser PCIcan PCI Cards"

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig716E498947238B0DB151B27A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk841fAACgkQjTAFq1RaXHNIGQCdH2HobOpn4OFPl64GQDunrWSH
RF4An08XHGxD3LsDXkvmD+aJoMlAbCSz
=h4NG
-----END PGP SIGNATURE-----

--------------enig716E498947238B0DB151B27A--
