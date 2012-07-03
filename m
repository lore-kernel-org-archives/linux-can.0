From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: Socket CAN - ENOBUFS on write()
Date: Tue, 03 Jul 2012 18:21:59 +0200
Message-ID: <4FF31C27.50905@pengutronix.de>
References: <CACJ51z3gDnDa=iVBaVd+nS8JV_fNE7Vyts38dj2ndBCFvWp17Q@mail.gmail.com> <CACJ51z0uOH3Wu1TShhVbj8hqHL-L6M8DEz0XM8o=gru01ahqqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88AD4B26EF691034AAEDF0AA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCQWL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 12:22:11 -0400
In-Reply-To: <CACJ51z0uOH3Wu1TShhVbj8hqHL-L6M8DEz0XM8o=gru01ahqqA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88AD4B26EF691034AAEDF0AA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Andew,

please subscribe to the linux-can mailinglist linux-can@vger.kernel.org.

On 07/03/2012 05:55 PM, Andrew Bell wrote:
> I saw an old mail that you wrote about fixing the problem with receivin=
g an
> ENOBUFS error on write() with CAN.  I searched the latest kernel but di=
d
> not see the patch there.  Can you tell me what has happened with this f=
ix?

Here's no proper fix, yet. If you receive an ENOBUFS, use poll or select
to wait until you can write again. Unfortunately poll will return too
early, so that the next write will probably fail again. Just keep
trying. You can work around the problem by you increasing the
tx_queue_len of your CAN card (before ifconfig up):

    ifconfig can0 txqueuelen 10000

Regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig88AD4B26EF691034AAEDF0AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/zHCwACgkQjTAFq1RaXHOj5QCdFSGLcQ5E6R/JIIDW4iVBD+Rt
mGgAnAnXcr2Moa8u57K51puBwR3Nu25C
=HyQ/
-----END PGP SIGNATURE-----

--------------enig88AD4B26EF691034AAEDF0AA--
