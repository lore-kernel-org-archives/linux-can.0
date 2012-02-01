From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 16:48:08 +0100
Message-ID: <4F295EB8.3090202@pengutronix.de>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC34EA22A9A56410B1BF8F15B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57779 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab2BAPsP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 10:48:15 -0500
In-Reply-To: <4F295865.2040304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC34EA22A9A56410B1BF8F15B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 04:21 PM, Marc Kleine-Budde wrote:

[...]

>> +/* PCIeC leds management needs I2C algobit */
>> +#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)=

>> +#define PEAK_CONFIG_PCIEC_LEDS
>> +#endif
>=20
> ifdefs in the .c file are not welcome in general. What about something
> like this:
>=20
> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
> #define peak_pci_support_pcie()	(1)
> #else
> #define peak_pci_support_pcie()	(0)
> #endif
>=20
> In the probe function you can write:
>=20
> probe() {
> 	...
>=20
> 	if (peak_pci_support_pcie() &&
> 	    pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
> 		...
> 	}
> }
>=20
> There should be no ifdefs left in the code. One question remains, is th=
e
> i2c core clever enough to define no-ops if the i2c subsystem is switche=
d
> off?

I just tried - :( - it doesn't work

drivers/net/can/sja1000/peak_pci.c: In function 'peak_pciec_write_pca9553=
':
drivers/net/can/sja1000/peak_pci.c:267: error: implicit declaration of fu=
nction 'i2c_transfer'
drivers/net/can/sja1000/peak_pci.c: In function 'peak_pciec_init':
drivers/net/can/sja1000/peak_pci.c:491: error: implicit declaration of fu=
nction 'i2c_del_adapter'

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC34EA22A9A56410B1BF8F15B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pXrsACgkQjTAFq1RaXHPsfwCfSRcOUZ4eVI7+9s1ETfT9AJg1
KIwAoJPW8NCP3mHjLylAqdbnR6pPyU3+
=+FOw
-----END PGP SIGNATURE-----

--------------enigC34EA22A9A56410B1BF8F15B--
