From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can-utils: install in /usr/bin instead of /usr/local/bin ??
Date: Thu, 23 Jan 2014 15:12:07 +0100
Message-ID: <52E12337.5020207@pengutronix.de>
References: <52E12015.7000201@hartkopp.net> <52E12081.4010301@pengutronix.de> <CAGm1_ksyL6SEWLfBjigig2iW5Tdc8eGXZez6brypvZxVOtWMFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oW8qiO5QKMBBL0TUFDufmNOSIgxqEadfn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaAWOMR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 09:12:17 -0500
In-Reply-To: <CAGm1_ksyL6SEWLfBjigig2iW5Tdc8eGXZez6brypvZxVOtWMFQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Alexander GQ Gerasiov <gq@debian.org>, Nikita <nebaruzdin@lvk.cs.msu.su>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oW8qiO5QKMBBL0TUFDufmNOSIgxqEadfn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2014 03:07 PM, Yegor Yefremov wrote:
> On Thu, Jan 23, 2014 at 3:00 PM, Marc Kleine-Budde <mkl@pengutronix.de>=
 wrote:
>> On 01/23/2014 02:58 PM, Oliver Hartkopp wrote:
>>> Hi Marc,
>>>
>>> when can-utils are now intended to be packaged for Debian:
>>>
>>> Does it make sense to move the installation directory to /usr/bin ins=
tead of
>>> the current /usr/local/bin target??
>>
>> No, Uwe will probably use ./configure --prefix=3D/usr
>=20
> CC Alexander and Nikita.

I consider the plain Makefile legacy, so using autotools for the debian
package is the way to go. The standard way to configure the installation
prefix is: ./configure --prefix=3D/usr

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oW8qiO5QKMBBL0TUFDufmNOSIgxqEadfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLhIzcACgkQjTAFq1RaXHNxZwCaAzup/oGAJeidnYPBzHBQLixz
5YMAn0qSrL6LM/W2ipBiZNc6OtSZRyKl
=IQDw
-----END PGP SIGNATURE-----

--oW8qiO5QKMBBL0TUFDufmNOSIgxqEadfn--
