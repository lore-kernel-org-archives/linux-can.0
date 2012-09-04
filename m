From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN device filterting
Date: Tue, 04 Sep 2012 15:57:31 +0200
Message-ID: <504608CB.9080709@pengutronix.de>
References: <1346765466.5440.3.camel@punsfloyd-desktop> <504604E3.1040305@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2AF9E4C5A279B0DCBD4EDC55"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43313 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab2IDN5k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 09:57:40 -0400
In-Reply-To: <504604E3.1040305@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: puneet.sharma@moschip.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AF9E4C5A279B0DCBD4EDC55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 03:40 PM, Oliver Hartkopp wrote:
> On 04.09.2012 15:31, Puneet Sharma wrote:
>=20
>> I need some guidance on implementing the CAN filtering of identifier i=
n
>> the driver code of CAN for atmel AT91SAM9263 board. Please guide me ho=
w
>> to proceed with it..
>=20
>=20
> Hm - i wrote that some days ago:

I talked to Puneet in private before, if I understand him correctly he
wants to implement hardware filtering, although software filtering is
available.

=46rom my point of view it should become a per device callback, which you=

(admin, i.e. the root user) can set when the device is down. You have to
extend the CAN netlink interface [1].

Each device should identify what kind and how many hardware filters it
supports:
a) mask+id
b) just id
c) ...
Analogue to ctrlmode [2][3].

The requested filers are transferred into the kernel via netlink, but
you have to figure out how to encode a variable length list (netfilter
has probably a solution for this). Then the code in can_changelink() [4]
should check if the transferred filter is supported on that hardware.
Then, during open the driver should code the filters into hardware, on
at91 it should be done in at91_setup_mailboxes [5][6].

Marc

[1] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L585
[2] http://lxr.free-electrons.com/source/include/linux/can/netlink.h#L81
[3] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L691
[4] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L600
[5] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L418
[6] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L336
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2AF9E4C5A279B0DCBD4EDC55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBGCM4ACgkQjTAFq1RaXHPN4ACeOdrgevwxF9tDAbQrPGBpF5I4
tpcAnjFTDOl424uhXyZkByh6thgYgqdC
=hfJA
-----END PGP SIGNATURE-----

--------------enig2AF9E4C5A279B0DCBD4EDC55--
