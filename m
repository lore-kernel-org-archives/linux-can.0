From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Wed, 24 Apr 2013 23:24:38 +0200
Message-ID: <51784D96.8000309@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>  <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox> <51780336.5060800@pengutronix.de> <51781907.3030306@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2CBJIITQRBJCIFBBPLLEN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40782 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab3DXVYr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 17:24:47 -0400
In-Reply-To: <51781907.3030306@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2CBJIITQRBJCIFBBPLLEN
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2013 07:40 PM, Oliver Hartkopp wrote:
>>> assumptions that are made:
>>> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:u6=
4 .
>>> * It is also assumed that existing defines like CAN_EFF_FLAG in can.h=

>>> and can/error.h don't change, as they are used by the device to
>>> construct the can_id field.
>>
>> You cannot rely in your firmware, that the struct can_frame and
>> CAN_*_FLAG doesn't change. Please define your own struct.
>>
>=20
>=20
> Hm - i really appreciate the memcopy-only approach which can cope with =
the
> host byte order directly. This is a real improvement on the host side.
>=20
> The struct can_frame and the error message content is official Kernel A=
PI and
> therefore can be assumed to be fix.

Yes but no. The struct can_frame to the _userspace_ is official Kernel
API/ABI, but within the kernel the is no stable API (see
stable_api_nonsense.txt). But if we go this way we should make compile
time checks, so that the compilation breaks if the struct can_frame chang=
es.

> Btw. extensions like the introduction of the struct canfd_frame can alw=
ays
> take place. But this comes along with really new functionality then.

> I would like to continue with the memcopy approach - but we probably ne=
ed some
> frame type identifier to be able to handle different host CAN frames, l=
ike
> struct can_frame and struct canfd_frame, ...

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2CBJIITQRBJCIFBBPLLEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF4TZkACgkQjTAFq1RaXHP05gCfZceqjdkcNLaN5ojYcO9GSbn/
g7IAn08F6RiAT2xKSLJHhBxHqWL6akVB
=04wb
-----END PGP SIGNATURE-----

------enig2CBJIITQRBJCIFBBPLLEN--
