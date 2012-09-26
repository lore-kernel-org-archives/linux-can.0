From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: can_oc: Add driver for CAN_OC cores from Aeroflex
 Gaisler
Date: Wed, 26 Sep 2012 13:41:34 +0200
Message-ID: <5062E9EE.2020300@pengutronix.de>
References: <1348552379-3909-1-git-send-email-andreas@gaisler.com> <5062CD27.3090803@pengutronix.de> <5062D13F.1090908@grandegger.com> <5062E99B.8020700@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4B47707AE1B42284E9210038"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab2IZLmX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Sep 2012 07:42:23 -0400
In-Reply-To: <5062E99B.8020700@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B47707AE1B42284E9210038
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/26/2012 01:40 PM, Andreas Larsson wrote:
> On 09/26/2012 11:56 AM, Wolfgang Grandegger wrote:
>> On 09/26/2012 11:38 AM, Marc Kleine-Budde wrote:
>>> On 09/25/2012 07:52 AM, Andreas Larsson wrote:
>>>> This driver is for the sja1000 compatible CAN_OC cores from Aeroflex=

>>>> Gaisler available in the GRLIB VHDL IP core library.
>>>
>>> Why don't you describe a single sja1000 compatible core with an OF
>>> device? The devices have indipendent address spaces and IRQs. With a
>>> proper abstraction/desciption you would not need this driver.
>>
>> Right, at least I do not see anything special. The following DTS entry=

>> should do the jobs:
>> [...]
>=20
> I'll look into this. Note that this is a SPARC device and not a PowerPC=

> device.

The driver doesn't care about your processor :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4B47707AE1B42284E9210038
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBi6fYACgkQjTAFq1RaXHMlGgCfYIw+oI1avlV5PoqyDPd55Haw
nxIAn3MRHyTRMvZ+I9ah+bEiQb5VmknA
=kAKm
-----END PGP SIGNATURE-----

--------------enig4B47707AE1B42284E9210038--
