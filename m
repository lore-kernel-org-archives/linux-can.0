From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:22:46 +0200
Message-ID: <505875A6.6040309@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <50586AF4.2080205@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig51C6FE8C5A126EB7A3D47D1F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790Ab2IRNWw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:22:52 -0400
In-Reply-To: <50586AF4.2080205@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51C6FE8C5A126EB7A3D47D1F
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
>=20
> Other protocols seem to provide the ioctl request SIOCINQ to query the
> number of untransmitted messages, e.g.:
>=20
>  http://lxr.linux.no/#linux+v3.5.4/net/packet/af_packet.c#L3385
>=20
> Should not be a big deal to add it to the CAN ioctl requests.

+1

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig51C6FE8C5A126EB7A3D47D1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYdakACgkQjTAFq1RaXHOagQCfTr5xRjEkJFj2OSVDgD8ZqeUW
L/kAn0P23388Kb2YHwkKuHR0nLICpmon
=zi1J
-----END PGP SIGNATURE-----

--------------enig51C6FE8C5A126EB7A3D47D1F--
