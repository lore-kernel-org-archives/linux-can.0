From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:00:08 +0200
Message-ID: <50587058.7090703@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3C9D582C641720E01E7042C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34321 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab2IRNAP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:00:15 -0400
In-Reply-To: <50586DE4.9020707@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3C9D582C641720E01E7042C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
[...]

>> We have several customers who asked how to abort pending TX messages,
>> too. Which involves:
>> a) clear the TX-queue in Linux
>> b) clear queue in hardware
>> c) abort currently transmitting CAN frame
>>
>> I think c) would be a usecase of its own, too.
>=20
> I think you need c) for b), at least for some controllers. These

Yes, if it's a hardware limitation so be it. But if we design an
interface it should support "clear everything" (a+b+c), but also just
only c.

> features, especially b) and c), are not yet available because they are
> not easy to implement (hardware-dependent) and there was no request so
> far.

Sure, this is why I'm coming up with this topic.

> Anyway, clearing the TX queue should be rather common and might
> already be available for other protocols.

Does anyone know?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE3C9D582C641720E01E7042C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYcFsACgkQjTAFq1RaXHP4dwCfVsb+I4SSInDN4WWWVLkQgjL2
o7IAoJBVEWjt2ptQdR8+W7RWJeWGdSTY
=n6YO
-----END PGP SIGNATURE-----

--------------enigE3C9D582C641720E01E7042C--
