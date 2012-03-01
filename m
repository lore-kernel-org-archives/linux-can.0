From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can/peak_pci: add support of some new PEAK-System
 PCI cards
Date: Thu, 01 Mar 2012 18:12:16 +0100
Message-ID: <4F4FADF0.3070401@pengutronix.de>
References: <1330357923-14080-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8533143430DEEAFF9222602B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37471 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944Ab2CARMl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Mar 2012 12:12:41 -0500
In-Reply-To: <1330357923-14080-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8533143430DEEAFF9222602B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/27/2012 04:52 PM, Stephane Grosjean wrote:
> This patch adds the support of some new PEAK-System PCI cards in the CA=
N
> network sub-system. These are:
>=20
> PCAN-PCIeC (PCI-ExpressCard)
> PCAN-mminiPCI (mini-PCI)
> PCAN-PCI (PCI next-gen)
>=20
> This patch also adds the control of the blinking leds of the PCAN-PCIeC=
=2E
>=20
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  Note: that patch contains modifications tested and approved in
>        peak_pci v6.1 but also includes Kconfig and Makefile modificatio=
ns
>        from peak_pcmcia v4.1
>=20
>  drivers/net/can/sja1000/Kconfig    |   27 ++-
>  drivers/net/can/sja1000/Makefile   |    1 +
>  drivers/net/can/sja1000/peak_pci.c |  505 ++++++++++++++++++++++++++++=
+++++++-
>  3 files changed, 516 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/=
Kconfig
> index b21523d..b60d6c5 100644
> --- a/drivers/net/can/sja1000/Kconfig
> +++ b/drivers/net/can/sja1000/Kconfig
> @@ -43,12 +43,33 @@ config CAN_EMS_PCI
>  	  CPC-PCIe and CPC-104P cards from EMS Dr. Thomas Wuensche
>  	  (http://www.ems-wuensche.de).
> =20
> +config CAN_PEAK_PCMCIA
> +	tristate "PEAK PCAN-PC Card"
> +	depends on PCMCIA
> +	---help---
> +	  This driver is for the PCAN-PC Card PCMCIA adapter (1 or 2 channels=
)
> +	  from PEAK-System (http://www.peak-system.com). To compile this
> +	  driver as a module, choose M here: the module will be called
> +	  peak_pcmcia.
> +
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
> diff --git a/drivers/net/can/sja1000/Makefile b/drivers/net/can/sja1000=
/Makefile
> index 0604f24..b3d05cb 100644
> --- a/drivers/net/can/sja1000/Makefile
> +++ b/drivers/net/can/sja1000/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_SJA1000_OF_PLATFORM) +=3D sja1000_of_p=
latform.o
>  obj-$(CONFIG_CAN_EMS_PCMCIA) +=3D ems_pcmcia.o
>  obj-$(CONFIG_CAN_EMS_PCI) +=3D ems_pci.o
>  obj-$(CONFIG_CAN_KVASER_PCI) +=3D kvaser_pci.o
> +obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o
>  obj-$(CONFIG_CAN_PEAK_PCI) +=3D peak_pci.o
>  obj-$(CONFIG_CAN_PLX_PCI) +=3D plx_pci.o
>  obj-$(CONFIG_CAN_TSCAN1) +=3D tscan1.o

Sorry, that series is not bisectable. At least if you switch on the
CONFIG_CAN_PEAK_PCMCIA option.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8533143430DEEAFF9222602B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PrfMACgkQjTAFq1RaXHMIJACeK0T2OsEpLUZ0k+y+l41Kk820
U84Ani+lf/v1PcS81LJK5QAW3CPFbak4
=Qvp4
-----END PGP SIGNATURE-----

--------------enig8533143430DEEAFF9222602B--
