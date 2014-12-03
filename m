From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 10:53:42 +0100
Message-ID: <547EDDA6.3070903@pengutronix.de>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n1bCIqvS8KPME1QX8b3vGRWoowlJetb02"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53638 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbaLCKbV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:31:21 -0500
In-Reply-To: <547EDA21.6030802@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n1bCIqvS8KPME1QX8b3vGRWoowlJetb02
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2014 10:38 AM, Stephane Grosjean wrote:
> Le 02/12/2014 16:17, Marc Kleine-Budde a =C3=A9crit :
>> On 12/02/2014 04:08 PM, Stephane Grosjean wrote:
>>>>>    drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955
>>>>> +++++++++++++++++++++++++++++
>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
>>>> Please don't create a header file, if it's only included once. Pleas=
e
>>>> merge into the correct .c file.
>>> Ok. So I merge both header files into the .c file. There will be only=
 a
>>> single (and big) pcan_usb_fd.c file.
>> Yes, we only want code in header files that's used in more than one .c=

>> file.
>=20
> Is this rule quite recent? I mean, the current version of peak_usb
> contains "pcan_usb_pro.h" which is included only by "pcan_usb_pro.c"?
>=20
> Moreover, "pcan_ucan.h" defines some data structures that might be used=

> by some other new "non USB" PEAK -FD devices (peak_pci, for example).
> So, how to manage to avoid to have to define several times the same dat=
a
> structures and constants, please?

If something is used by more than one .c file, put it in a header. If
it's only used in one .c file, put it into that .c file.

Follow this rule when adding this driver to the kernel. When you add a
new driver in the future and now some data structures/definitions/etc...
are shared between more then one driver or .c file, simply move that
code into a header and include the header in all .c file where you need i=
t.

Hope this clarifies it,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--n1bCIqvS8KPME1QX8b3vGRWoowlJetb02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUft2mAAoJECte4hHFiupU9ocP/R4hS+6n0rcUUFZiRSmVWACh
nS81nihqOkYHxLcdEa5xV88OBvR6MacjFBGNnqj2JNgE/6p3OP7SEL8s2QX/NEGs
wO3So59UCrjNIjKa5UQGRkjiC7/vTMYgGjM0vifrfS5zDy5FFYMS9ZbMBBxAsBa/
XBuZBZO1XNaQDR2X9hx6BE9eVZmqHKddjH53dbsw1zHG5J8KMZypCwdueUqX4ZRz
lLsQnPEZaoBQqE0IpXBUE7MykUhtgkCHRUKLRMryve4N0hLaM7Iruf0aGRkqNQWB
tHy3Ex/NsODFxSV7ySf3zTavy+ZQv9QqV11OM7XBcC4rAY+t3nsU5+/flEk2h/7S
dALYGS2DA2ypxzrGTYEHGVakXj/7EuPZg5/7Uczkc11cMOT/3tL2P9YRLs9eUbTj
E0QrEkX6tnfwTLylXo9Ta3iwyy1WDgdia9bVpi2XL1iyei1yVX82yv6FMCVIn3R4
E0HzJTJ84C7rHIDrn3GQqZUCMhBFl260Px2X00YOJdRFbZJ/sLilrb/kDB6Gh2zh
CkgJWpNpIpNpPmC74qHy8aNO2Skn2zN1zHx5ED5A5tHZrEAZeHlSgiYeOKsCVVKB
gxk91O6Piq4HKRvll9YML0NGLufMGB/gUWev+T8yIw5dHv3TehbnY4onLtALVbyh
dmxh4eI1CJmr/DKohYOG
=JGHP
-----END PGP SIGNATURE-----

--n1bCIqvS8KPME1QX8b3vGRWoowlJetb02--
