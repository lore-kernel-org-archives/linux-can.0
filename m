From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socketcan receive queue too many frames
Date: Wed, 27 Mar 2013 12:50:10 +0100
Message-ID: <5152DCF2.80804@pengutronix.de>
References: <loom.20130327T122706-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WRNWCONQDMPMSQSVOHXV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab3C0LuQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 07:50:16 -0400
In-Reply-To: <loom.20130327T122706-603@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: du <duzhenhuan@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WRNWCONQDMPMSQSVOHXV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/27/2013 12:38 PM, du wrote:
> Hello, I'm using socketcan buffer ,=20

What is "socketcan buffer"?

> but i'm getting frames for tens of seconds even after I have open the C=
AN wire
> from the bus, In my application ,frame lost is not a problem since I'm =
using

What kind of CAN frame do you get? Maybe error messages, due to the open
bus?

> cyclic process data. I just want to make sure the frame is stopped just=
 when I
> disconnect the cable.=20
>=20
> What should I do ? How can I make receive buffer smaller?

That will not solve your problem.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WRNWCONQDMPMSQSVOHXV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFS3PUACgkQjTAFq1RaXHOO2gCePRqTSPLcFVbVUBz1sfhe/4wv
n8wAnj5LCpKCyISCmYRjTqiwfpB2dg67
=+V8n
-----END PGP SIGNATURE-----

------enig2WRNWCONQDMPMSQSVOHXV--
