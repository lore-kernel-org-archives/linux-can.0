From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 05/16] c_can: use 32 bit access for D_CAN
Date: Sun, 24 Nov 2013 20:07:54 +0100
Message-ID: <52924E8A.3070601@pengutronix.de>
References: <CAF03EBcKxO_JckT9BtxbHwax5o4rsQ1P+5X3ox_oJ_U+PPrLWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="knTwUWrlLKVIUGTcqOBSMwofuNwBAkaFN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33511 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab3KXTIL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 14:08:11 -0500
In-Reply-To: <CAF03EBcKxO_JckT9BtxbHwax5o4rsQ1P+5X3ox_oJ_U+PPrLWw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: T Thayer <tthayer.linux@gmail.com>
Cc: b.spranger@linutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--knTwUWrlLKVIUGTcqOBSMwofuNwBAkaFN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2013 05:37 PM, T Thayer wrote:
> What is the status of this patch?

The mail you copied reflects the current status, nothing happened since
then. Feel free to adopt this patch and address my comments.

> This fixes the problem I was seeing for the D_CAN portion of the
> driver which was
> 1. Transmitting 2 copies (probably the result of an AutoRetry)
> 2. Triggering a RX IRQ on a transmit because the Message Object # was
> assigned to RX.
> 3. CAN statistics were not incrementing properly.
>=20
> I just joined this mailing list and I don't have this email in my
> history so I'm copying it below.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--knTwUWrlLKVIUGTcqOBSMwofuNwBAkaFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKSTo4ACgkQjTAFq1RaXHOw4QCdFewjaJtODwZyWx1CTQzWmiTi
HjEAnisHUn7OEbAfnI4igaWPewAko9+H
=qVAN
-----END PGP SIGNATURE-----

--knTwUWrlLKVIUGTcqOBSMwofuNwBAkaFN--
