From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socketcan receive queue too many frames
Date: Wed, 27 Mar 2013 13:04:45 +0100
Message-ID: <5152E05D.80908@pengutronix.de>
References: <loom.20130327T122706-603@post.gmane.org> <5152DCF2.80804@pengutronix.de> <loom.20130327T125524-733@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VSPTIWLCAKQQRRTSQHIV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37257 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3C0MEr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 08:04:47 -0400
In-Reply-To: <loom.20130327T125524-733@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: du <duzhenhuan@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VSPTIWLCAKQQRRTSQHIV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/27/2013 01:01 PM, du wrote:
>> What is "socketcan buffer"?
> sorry ,I means socketcan only.

:)

>> What kind of CAN frame do you get? Maybe error messages, due to the op=
en
>> bus?
> It's not error message , just normal CAN  data frames.

Okay.

> I thought it may has something to do with buffer.=20
> If my application is not fast enough to read the frames in buffer,
>  I can still get frames even the bus is open, is it right?

Yes, socketcan is designed not to drop any messages, but it will, if the
rx-queue (between kernel and your apps) gets to lange. If you receive
frames in your application 10 seconds after you disconnected the cable
you have a serious design or performance problem (or both) in you system.=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VSPTIWLCAKQQRRTSQHIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFS4F0ACgkQjTAFq1RaXHNW5wCdFqhW/SRBRG57yyIkbCC5mgli
YG4AnjKohXBeByZF3C7APC6qf5OMJIBJ
=5rol
-----END PGP SIGNATURE-----

------enig2VSPTIWLCAKQQRRTSQHIV--
