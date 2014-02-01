From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Can't start ESD CAN-USB/2
Date: Sat, 01 Feb 2014 15:27:04 +0100
Message-ID: <52ED0438.2060100@pengutronix.de>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de> <52EBF7C5.9050309@iit.it> <52ECE6BB.7000602@pengutronix.de> <52ECEE3D.4000701@iit.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lrbuoXk2FeSs7DvjKaBvPLwuATaBmhNF9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933177AbaBAO1Q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Feb 2014 09:27:16 -0500
In-Reply-To: <52ECEE3D.4000701@iit.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giovannini <francesco.giovannini@iit.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrbuoXk2FeSs7DvjKaBvPLwuATaBmhNF9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>>> Any chance you might have a last minute inspiration? ;)
>> Can you make a firmware update of the USB adapter? Does the adapter wo=
rk
>> under windows?

> So yesterday I tried the same esd device on my Debian machine running
> Wheezy and kernel 3.2.0 (so an older kernel than the OpenSuse one) and
> everything worked fine. I was able to set the bitrate and dump data fro=
m
> the device. And yes the device works flawlessly under windows.

Okay, the device is working. Even under Linux :)

> With Suse I also tried switching esd devices and cables without any luc=
k.

But the Suse is a different machine, so different USB
controller/hardware and different USB driver.

> Do you think this behaviour might be due caused by problems on the
> driver side or on the canutils side? As in: should I raise this issue
> with the ESD driver developers?

It's not the canutils, they just send the parameters into the kernel.
The kernel driver hasn't changed much. Feel free to contact the driver
developer Matthias Fuchs <matthias.fuchs@esd.eu>, keep the mailinglist
on Cc, if possible.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lrbuoXk2FeSs7DvjKaBvPLwuATaBmhNF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLtBDgACgkQjTAFq1RaXHNr5ACcCIy5Na/m9nZj3tUiLPLXuZmo
VMcAoJgz9UImI+pKPfy5roJ3g05zgEPt
=Nz/t
-----END PGP SIGNATURE-----

--lrbuoXk2FeSs7DvjKaBvPLwuATaBmhNF9--
