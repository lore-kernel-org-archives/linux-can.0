From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Wed, 10 Apr 2013 17:30:05 +0200
Message-ID: <5165857D.1050303@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XVOITFHRXEISOTDSUQWR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41532 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761199Ab3DJPaM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Apr 2013 11:30:12 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XVOITFHRXEISOTDSUQWR
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/10/2013 04:11 PM, Mylene Josserand wrote:

>> If it's the first spi transfer in the driver that hangs and if the
>> mcp251x works if loaded as a module, there is probably some
>> initialisation missing. Look for stuff that gets initialized after the=

>> mcp251x would have been loaded if compiled into the kernel. Make a
>> "diff" between the bootload with mcp251x compiled into the kernel and
>> without. Other usual suspects are: clocks, pinmux (spi _and_ the mcp25=
1x
>> dedicated IRQ line), gpio setup.
>=20
> Thanks for the advice and the ideas to look at ! I have already compare=
d=20
> the bootload and I have seen no differences (maybe I will check that=20
> another time). I will search about clocks, pinmux and gpio setup and I =

> will update you if I found how to fix that.

Save the bootlog of a system start with the driver compiled as a module
into file bootlog-module.txt. Make a second bootlog with the driver
compiled into the kernel, save as bootlog-builtin.txt. Then:

    diff -u bootlog-module.txt bootlog-builtin.txt

Look for the stuff that would have been initialized _after_ the system
hangs. The diff should show you this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XVOITFHRXEISOTDSUQWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFlhYAACgkQjTAFq1RaXHMjZwCfW4VtBNB8qbdHiUxHEqyhAQv2
MFEAnjAqpPzG1UiPCT0o5MrESVlgHAnP
=7jTJ
-----END PGP SIGNATURE-----

------enig2XVOITFHRXEISOTDSUQWR--
