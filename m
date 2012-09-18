From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:24:39 +0200
Message-ID: <50587617.8060508@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <50586AF4.2080205@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8C339D2E689306CBDA488CE6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56742 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790Ab2IRNYn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:24:43 -0400
In-Reply-To: <50586AF4.2080205@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C339D2E689306CBDA488CE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 02:37 PM, Wolfgang Grandegger wrote:
> On 09/17/2012 03:58 PM, Heinz-J=FCrgen Oertel wrote:
>>
>> Hello,
>> is there a way to empty the tx buffer ?
>> Or read out the occupied size of it
>> to get the mumber of CAN frames waiting for transmission?
>=20
> As we usally get a TX done interrupt we in principle know how much
> messages are still pending in the software and hardware queue but we
> will only be able to flush the messages in the software queue because
> aborting of messages in the device TX queue is not supported (even if
> most controllers can do it). Therefore the only clean way to get rid of=

> all pending messages is to stop and restart the device (ifconfig down -=
>
> up).

This is more a sledgehammer approach, a I outlined a more fine grained
solution (if hardware supports it) in my other mail.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8C339D2E689306CBDA488CE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYdhcACgkQjTAFq1RaXHNqEQCfYDiEM4Is2xDSRkVYpTEdkypA
03oAn2dsWTKy+r2q2C/I6v3pjsUXPg0q
=RlXW
-----END PGP SIGNATURE-----

--------------enig8C339D2E689306CBDA488CE6--
