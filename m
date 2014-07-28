From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 5/5] net: can: flexcan: fix for wrong TX error count
 behaviour on i.MX53
Date: Mon, 28 Jul 2014 09:05:56 +0200
Message-ID: <53D5F654.6050203@pengutronix.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de> <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hL6qfJW6B13vAR4oUM5bBESbgS7eOGMta"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40839 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaG1HGJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 03:06:09 -0400
In-Reply-To: <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hL6qfJW6B13vAR4oUM5bBESbgS7eOGMta
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2014 08:34 AM, Matthias Klein wrote:
> Once the CAN-bus is open and a packet is sent, the controller switches
> into the PASSIVE state and the TX error count goes to 0x80. When the
> bus is closed and the packet gets acknowledged the controller switches
> to ERROR-WARNING state and the TX error counter is decremented to 0x7f.=

> Everything OK so far.
>=20
> When now the bus is open again and a packet is sent, the controller
> switches into PASSIVE state and sets the TX error count to 0x86.
> When now the bus is closed the TX error is decremented to 0x85, but
> the state does not change to ERROR-WARNING. Now with each successfully
> transfered packet (in PASSIVE state!) the TX error counter is
> decremented, and when the TX error counter reaches 0x7f the controller
> switched back into ERROR-WARNING state.

My original comment still applies, I don't see a problem with sending
CAN frames in error passive mode.

The only thing that violates the specs is IMHO, that the TX error
counter is incremented > 127 when the bus is open, although is does not
reach 255.

> This fix sets the TX error count back to zero when entering the
> ERROR-WARNING state (after the first retransfered packet is acknowledge=
d).

Why do you this? The expected behaviour is that each successfully
transmitted CAN frame decreases the TX error counter. So it will take a
few frames until you reach a TX error counter of 0 when coming from
error passive.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hL6qfJW6B13vAR4oUM5bBESbgS7eOGMta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPV9lQACgkQjTAFq1RaXHOZswCgg2D8cYZNaOfv6nrZKCR2JD1k
BvAAniorXv4wMCIKBAXiUu0CXXF1fBZX
=kHQn
-----END PGP SIGNATURE-----

--hL6qfJW6B13vAR4oUM5bBESbgS7eOGMta--
