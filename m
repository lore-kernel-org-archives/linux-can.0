From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 16:57:35 +0100
Message-ID: <4F2960EF.6000308@pengutronix.de>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de> <4F295EB8.3090202@pengutronix.de> <4F296068.9090009@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE327C80D01FAB9338BCE439B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34957 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab2BAP5l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 10:57:41 -0500
In-Reply-To: <4F296068.9090009@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE327C80D01FAB9338BCE439B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 04:55 PM, Stephane Grosjean wrote:
> Le 01/02/2012 16:48, Marc Kleine-Budde a =E9crit :
>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
>> #define peak_pci_support_pcie()    (1)
>> #else
>> #define peak_pci_support_pcie()    (0)
>> #endif
>>
>> In the probe function you can write:
>>
>> probe() {
>>     ...
>>
>>     if (peak_pci_support_pcie()&&
>>     pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
>>         ...
>>     }
>> }
>>
>> There should be no ifdefs left in the code. One question remains, is t=
he
>> i2c core clever enough to define no-ops if the i2c subsystem is switch=
ed
>> off?
>> I just tried - :( - it doesn't work
>>
>> drivers/net/can/sja1000/peak_pci.c: In function
>> 'peak_pciec_write_pca9553':
>> drivers/net/can/sja1000/peak_pci.c:267: error: implicit declaration of=

>> function 'i2c_transfer'
>> drivers/net/can/sja1000/peak_pci.c: In function 'peak_pciec_init':
>> drivers/net/can/sja1000/peak_pci.c:491: error: implicit declaration of=

>> function 'i2c_del_adapter'
>>
>> Marc
>=20
> What about that:
>=20
>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)
>> #define peak_pci_support_pcie()    (1)
>> #else
>> #define peak_pci_support_pcie()    (0)
> #define i2_transfer(a, b, c)
> #define i2c_del_adapter(a)
>> #endif

This is an option, please make it static inline function, to have
typechecking.

Wolfgang, what do you think?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE327C80D01FAB9338BCE439B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pYO8ACgkQjTAFq1RaXHMOegCcCHquuBC/g8w6WWvglihHIkWc
ge8AoJWW81VPLehxQMJCL2SQ1ERp/Ajs
=VAGA
-----END PGP SIGNATURE-----

--------------enigE327C80D01FAB9338BCE439B--
