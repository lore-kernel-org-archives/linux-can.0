From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can/peak_pci: add support of some new PEAK-System
 PCI cards
Date: Thu, 01 Mar 2012 18:27:18 +0100
Message-ID: <4F4FB176.8020003@pengutronix.de>
References: <1330357923-14080-1-git-send-email-s.grosjean@peak-system.com> <4F4FADF0.3070401@pengutronix.de> <4F4FAF5E.3070605@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAFC0CD8F04497E3EA750DFE6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46561 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab2CAR1j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Mar 2012 12:27:39 -0500
In-Reply-To: <4F4FAF5E.3070605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFC0CD8F04497E3EA750DFE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/01/2012 06:18 PM, Oliver Hartkopp wrote:
> On 01.03.2012 18:12, Marc Kleine-Budde wrote:
>=20
>> On 02/27/2012 04:52 PM, Stephane Grosjean wrote:
>>> This patch adds the support of some new PEAK-System PCI cards in the =
CAN
>>> network sub-system. These are:
>>>
>>> PCAN-PCIeC (PCI-ExpressCard)
>>> PCAN-mminiPCI (mini-PCI)
>>> PCAN-PCI (PCI next-gen)
>>>
>>> This patch also adds the control of the blinking leds of the PCAN-PCI=
eC.
>>>
>>> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>> ---
>>>  Note: that patch contains modifications tested and approved in
>>>        peak_pci v6.1 but also includes Kconfig and Makefile modificat=
ions
>>>        from peak_pcmcia v4.1
>>>
>=20
>>
>> Sorry, that series is not bisectable. At least if you switch on the
>> CONFIG_CAN_PEAK_PCMCIA option.
>>
>=20
>=20
> Is this due to the fact that the both Kconfig entries are placed in the=
 first
> file?

Yes, but not :)
Adding the Kconfig option and this Makefile line:

+obj-$(CONFIG_CAN_PEAK_PCMCIA) +=3D peak_pcmcia.o

but no .c file would result in a compilation error if you swtich on the
Kconfig option.

> I asked myself, why this was optimized in this way. IMO adding
>=20
> 1. PCIEC support
> 2. PCMCIA support
>=20
> within two patches would be better, right?

Yes:
1. add PCIEC in Kconfig + .c file changes
2. add PCMCIA in Kconfig and Makefile + new .c file

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigAFC0CD8F04497E3EA750DFE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PsXYACgkQjTAFq1RaXHMpEQCcDB6/YUOM5hq5UrQ1ia2GtyzQ
qlwAn0VI/ChYipxX15cIj4hHPrNm1J3J
=UZpU
-----END PGP SIGNATURE-----

--------------enigAFC0CD8F04497E3EA750DFE6--
