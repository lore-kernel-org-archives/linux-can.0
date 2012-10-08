From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 13:46:06 +0200
Message-ID: <5072BCFE.5000006@pengutronix.de>
References: <6309304.MqJsLKDGaO@lisa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE24F5E43F73585A007B106D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2JHLqM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 07:46:12 -0400
In-Reply-To: <6309304.MqJsLKDGaO@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE24F5E43F73585A007B106D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/08/2012 12:16 PM, Steffen Rose wrote:
> Hello,=20
> I'm unsure, what I see.
>=20
> I use:
> Virtual box - Host Win 7/Guest kubuntu=20
> Linux lisa 3.2.0-30-generic #48-Ubuntu SMP Fri Aug 24 16:52:48 UTC 2012=
 x86_64=20
> x86_64 x86_64 GNU/Linux
>=20
> SocketCAN connector is a EMS CPC-USB.
>=20
> On startup, the network works fine.
> In different situation one or both directions (RX/TX) stop it's work.
> My Linux program say:
>=20
> 	write: No buffer space available
>=20
> It's the write to the socketcan device can0.

Your program probably produces CAN frames faster than they could be
delivered by your CAN hardware. Your choices are:
1) If the write/sendto system call returns with -ENOBUFS,
   add the filedesciptor to poll/select and wait for it to be writeable
   again. For some known, but not yet resolved reasons (a.k.a. bug),
   the poll/select will return immediately, but the write will fail
   again. To workaround this usleep for some milliseconds between
   the write/sendto and the poll/select system call.

2) Increase txqueue length to 10000 or so.
   (ifconfig can0 txqueuelen 10000)
   This avoids to trigger the above bug and your write/sendto will
   block until the queues are free again and your CAN frame will added
   to the send queue. With this workaround poll/select work as expected,
   i.e. when they return the socket is writeable without problems.

Hope that helps,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDE24F5E43F73585A007B106D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlByvQEACgkQjTAFq1RaXHPG/wCfVz9dwc3nxphXQQMCQXbepvYn
w6oAn0dgK+aT8BP/snPdKjlaJoHBKYIh
=ySrd
-----END PGP SIGNATURE-----

--------------enigDE24F5E43F73585A007B106D--
