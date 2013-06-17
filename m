From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCAN drivers?
Date: Mon, 17 Jun 2013 16:49:15 +0200
Message-ID: <51BF21EB.9080402@pengutronix.de>
References: <51BF1C74.5030506@mlbassoc.com> <51BF1FDF.2060003@pengutronix.de> <51BF211D.7030404@mlbassoc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WNRUMEWAGUCMDFHCTBBH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39995 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3FQOtY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 10:49:24 -0400
In-Reply-To: <51BF211D.7030404@mlbassoc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WNRUMEWAGUCMDFHCTBBH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/17/2013 04:45 PM, Gary Thomas wrote:
> On 2013-06-17 15:40, Marc Kleine-Budde wrote:
>> On 06/17/2013 04:25 PM, Gary Thomas wrote:
>>> What's the best driver for the Peak PCAN PCI board?
>>>    PEAK-System Technik GmbH PCAN-PCI CAN-Bus controller
>>> I'm interested in linux-3.5.2 on Fedora 17
>>
>> The PEAK PCI  should work out-of-the box with kernel version v3.2. The=

>> PCI Express Cards shoud work with v3.4.
>=20
> Thanks.  What driver module do I need for this (none seem to come
> packaged with the Fedora kernel)?

It should be loaded automatically, it's called peak_pci.ko

> What about the CAN utils (cansend, candump, etc)?
>=20
> Sorry for the barrage of questions; I used this stuff years ago
> and time seems to have marched on whilst I had to do other things...

compile yourself:

    https://gitorious.org/linux-can/can-utils

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WNRUMEWAGUCMDFHCTBBH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlG/Ie8ACgkQjTAFq1RaXHOCNACfVJ9PriejOOweG9kmHlN2SpzQ
PigAoJZ3PUgXtexmhoC6BZjAbZP2fSEK
=hg06
-----END PGP SIGNATURE-----

------enig2WNRUMEWAGUCMDFHCTBBH--
