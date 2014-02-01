From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Sat, 01 Feb 2014 13:21:15 +0100
Message-ID: <52ECE6BB.7000602@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de> <52EBF7C5.9050309@iit.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RqxHwIhVMnwRqXosIBsvJAKTQ7Ow7MkqM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbaBAMVZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Feb 2014 07:21:25 -0500
In-Reply-To: <52EBF7C5.9050309@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RqxHwIhVMnwRqXosIBsvJAKTQ7Ow7MkqM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2014 08:21 PM, Francesco Giovannini wrote:
> Sorry my email client does that automatically.

It's all a matter where you position your cursor before starting to type =
:P

> I just re-build the kernel module without luck. I am getting the same
> weird behaviour. I also tried changing CAN-USB/2 device, cable and port=
=2E
> This too did not solve the problem.
>=20
> Unfortunately I cannot try a different machine. I am bound to this
> OpenSuse machine because of hardware requirements.

If you have a different linux machine I suggest to test, just to make
sure the USB adapter works under linux. Although the kernel is quite new
can you try a newer one?

> Any chance you might have a last minute inspiration? ;)

Can you make a firmware update of the USB adapter? Does the adapter work
under windows?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RqxHwIhVMnwRqXosIBsvJAKTQ7Ow7MkqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLs5rsACgkQjTAFq1RaXHM39ACfS5KIgAu9sHd7n1z+rr9q9k9N
Z+QAniDriZ65OyhW2PDbk9HPmaNgiAWd
=/J9f
-----END PGP SIGNATURE-----

--RqxHwIhVMnwRqXosIBsvJAKTQ7Ow7MkqM--
