From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] canbusload: Add exact CAN frame length calculation
 (including bitstuffing)
Date: Fri, 31 Jan 2014 11:16:13 +0100
Message-ID: <52EB77ED.5000902@pengutronix.de>
References: <87fvo5k2w2.fsf@steelpick.2x.cz> <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pKNPfqObkKx9jEv74uD7wpXeABc1Od66A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbaAaKQR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 05:16:17 -0500
In-Reply-To: <1391089139-31201-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pKNPfqObkKx9jEv74uD7wpXeABc1Od66A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 02:38 PM, Michal Sojka wrote:
> This adds an algorithm for calculating the exact number of bits a CAN
> frame occupies on the bus and uses this algorithm in canbusload. It
> also moves the other methods for CAN frame length calculation, already
> present in canbusload, to the new file.
>=20
> The added algorithm calculates the exact number of stuffed bit in a
> CAN frame. Note that in order to calculate that correctly, we must
> also know the frame's CRC. Hence, the algorithm also includes CRC
> calculation routine.
>=20
> The correctness of the algorithm was verified on an oscilloscope for
> several different SFF and EFF frames.
>=20
> Currently only CAN frames are supported. For CANFD frames, a different
> algorithm is needed. CANFD uses different CRC polynomials and
> calculates the CRC from the staffed bit-stream (CAN calculates CRC
> from de-stuffed bit-stream).
>=20
> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>

Tnx, applied both to master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pKNPfqObkKx9jEv74uD7wpXeABc1Od66A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLrd+0ACgkQjTAFq1RaXHPTLACfVQmslnp3GGKBfyZOu2OStDSg
wZkAoI9KsJNTYLXh/Yup7pVMn0kT9x1R
=PLlQ
-----END PGP SIGNATURE-----

--pKNPfqObkKx9jEv74uD7wpXeABc1Od66A--
