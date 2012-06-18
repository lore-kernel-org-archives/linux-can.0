From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 21:48:36 +0200
Message-ID: <4FDF8614.9040707@pengutronix.de>
References: <4FDF67C3.6020201@hartkopp.net> <4FDF7DE1.6000803@pengutronix.de> <4FDF7F25.8040605@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3E4E194813A7BA22EEA6B49C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53614 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2FRTsl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:48:41 -0400
In-Reply-To: <4FDF7F25.8040605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3E4E194813A7BA22EEA6B49C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 09:19 PM, Oliver Hartkopp wrote:
> On 18.06.2012 21:13, Marc Kleine-Budde wrote:
>=20
>> On 06/18/2012 07:39 PM, Oliver Hartkopp wrote:
>>> - add new struct canfd_frame
>=20
>>>  struct can_frame {
>>>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>> -	__u8    can_dlc; /* data length code: 0 .. 8 */
>>> +	__u8    can_dlc; /* frame payload length in byte (0 .. 8) */
>>>  	__u8    data[8] __attribute__((aligned(8)));
>>
>> checkpatch complains:
>>
>> WARNING: __aligned(size) is preferred over __attribute__((aligned(size=
)))
>> #84: FILE: include/linux/can.h:102:
>> +       __u8    data[64] __attribute__((aligned(8)));
>>
>> total: 0 errors, 1 warnings, 97 lines checked

> Hm, yes. I wanted to have it the same way as in struct can_frame.

> I wonder if "__aligened(size)" is also compatible for backports - or
> alternative if we should also modify the original can_frame:

__aligened(size) has been introduced in v2.6.21-rc1~91^2~274.

(How to figure out:
$ git blame include/linux/compiler-gcc.h
$ git describe 82ddcb04
v2.6.20-1507-g82ddcb0
$ git describe --contains 82ddcb04
v2.6.21-rc1~91^2~274
)

>>> - 	__u8    data[8] __attribute__((aligned(8)));
>>> + 	__u8    data[8] __aligned(8);

If you want to be super clean you can first make a patch that changes
the existing __attribute__((aligned(8))) to __aligned(8), and then add
your canfd series. If not, just mention it in the patch description
(While being here change can_fd to __aligned(8)).

Err..this is a userspace header, I just tested it, headers_install
doesn't remove it. And userspace fails to compile with this. For now
stick to __attribute__((aligned(8))).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3E4E194813A7BA22EEA6B49C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/fhhQACgkQjTAFq1RaXHOa9ACghvoBp8kugA0I+mTWY2d3zerN
DTYAn1jjSbjCnFIjPGsdTMzH72fQLDrJ
=NBfX
-----END PGP SIGNATURE-----

--------------enig3E4E194813A7BA22EEA6B49C--
