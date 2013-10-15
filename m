From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] Add broadcast manager documentation
Date: Tue, 15 Oct 2013 09:20:18 +0200
Message-ID: <525CECB2.4040605@pengutronix.de>
References: <CAENe87otPZVjDkvJJDR4CLE2e4dcyzde1=5rQZWytG_JyOpvsQ@mail.gmail.com> <525C48F8.1050907@hartkopp.net> <525C4DC0.5030107@pengutronix.de> <525CCB3C.8050609@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rgf00kCII6aGCkv9NbSWbdNSC7B6DL03w"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34130 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3JOHUZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Oct 2013 03:20:25 -0400
In-Reply-To: <525CCB3C.8050609@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Brian Thorne <hardbyte@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rgf00kCII6aGCkv9NbSWbdNSC7B6DL03w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/15/2013 06:57 AM, Oliver Hartkopp wrote:
> On 14.10.2013 22:02, Marc Kleine-Budde wrote:
>> On 10/14/2013 09:41 PM, Oliver Hartkopp wrote:
>=20
>>> +  configuration message is defined. The basic BCM configuration mess=
age used
>>> +  to communicate with the broadcast manager and the available operat=
ions are
>>> +  defined in the linux/can/bcm.h include. The BCM message consists o=
f a
>>
>> Nitpick
>> It's "include/uapi/linux/can/bcm.h" in recent kernel trees.
>>
>=20
> AFAIK the uapi directory is the place where the 'user API' relevant hea=
der
> files are /generated/ at build time. Finally these header files are cop=
ied to
>=20
> 	/usr/include/linux/...
>=20
> in the different Linux distributions to be accessed by application deve=
lopers.
>=20
> So in the application C code it's still:
>=20
> #include <linux/can.h>
> #include <linux/can/raw.h>
> #include <linux/can/bcm.h>
>=20
> Right?

Correct, from that point of view (which makes more sense).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Rgf00kCII6aGCkv9NbSWbdNSC7B6DL03w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJc7LIACgkQjTAFq1RaXHOzpQCglaYl1c0wZx7YmzJD2iOFCAXJ
owkAn2CWGykbpbhucpUsHOxrCRuDXoqn
=d2w7
-----END PGP SIGNATURE-----

--Rgf00kCII6aGCkv9NbSWbdNSC7B6DL03w--
