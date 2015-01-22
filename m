From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:40:04 +0100
Message-ID: <54C119D4.5050104@pengutronix.de>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com> <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com> <54C117BC.2080905@pengutronix.de> <54C11978.200@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9HA7cHixmWk2rbUtNw3asjdGbKOC3l0KN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54473 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbAVPkO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:40:14 -0500
In-Reply-To: <54C11978.200@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9HA7cHixmWk2rbUtNw3asjdGbKOC3l0KN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2015 04:38 PM, Stephane Grosjean wrote:
> Le 22/01/2015 16:31, Marc Kleine-Budde a =C3=A9crit :
>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>> Add a common function that pushes the skb in the network queue with a=
dding
>>> timestamps information, converted from time values read from the
>>> PEAK USB adapters.
>> Why is this function in core.c, it's only used by pcan_usb_fd.c.

> Because it should be able to use it from older source files (pcan_usb=20
> and pcan_usb_pro, AFAIR)

Are you planing to make use of the function in an upcoming patch?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9HA7cHixmWk2rbUtNw3asjdGbKOC3l0KN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUwRnbAAoJECte4hHFiupU4C4QAKxH4ffGW3Ed3QyaA7IpP+n/
nGKsB3MqO/PPvyBE+AMjz3o++AHd6bv/Mpa8bOKjV4ttW1prHEncd3fCpGrLsf/v
ELoI3o3isG0MuxEt/7WLMaw0XERzy1727dxOiDoFJlzLKk9fwHYSIPUCJZVqtz0O
Al0ngF3MKTh8FaVWWwluFt4y3EawYEf6MW89a5bEY9eliFFjBeOhVT3mtQnC86YO
KaDV0aeE5m4+xNJiOFsR6ff5tLQ6uY/P6l9QTdL0rYWLTrxten2hX86leSdIPKmj
Ocfgq0nkmD0zZH9BZ9gblypjNJsa69OWlQLB05DQMIywBj6FoKR5VcSmTqFMwCnj
vOPhydj8kdUv21y7XtOXKKBBZxzncd59f5bS2GTruT7/Ms34hJYvODZPq3iOrzPv
QBcatk42/LGNj98yh3y8yISWR+HrbJPm3nfcR2sOFGqK1Oy8MKD6kXzAb/sB06K/
BvoJuvPzbCILD6r3EdGS9hs1rR5KwsZMMczNJHQ5D1CoryT7Dqlb/wiG4EQiChkO
qCwDa8k6Oi68YX6QxS2W2ipLZRHd7mD/52u3lelandwi+L4V/U44DLTGcO4pl0lv
f+L0PvLWg6Utzi7nB3eRZdHJLNsO610/wx2vAhD5uxvjJi7pfwwFWDMbUGj1xiMj
eSVihqrwZLa7wWibYFxK
=mQbA
-----END PGP SIGNATURE-----

--9HA7cHixmWk2rbUtNw3asjdGbKOC3l0KN--
