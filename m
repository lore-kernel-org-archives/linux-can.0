From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Setting bitrate from user-space application
Date: Wed, 23 Dec 2015 15:10:55 +0100
Message-ID: <567AAB6F.4040609@pengutronix.de>
References: <5655BF6D.3000701@picquet.fr> <5655CC8D.70508@pengutronix.de>
 <5655DC22.4000302@hartkopp.net> <5655DF32.5090505@picquet.fr>
 <567AA9AB.9010500@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n5FkVcCSNCKvdTHQLO8RA7B8uCChAK1Of"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46338 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757211AbbLWOLE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Dec 2015 09:11:04 -0500
In-Reply-To: <567AA9AB.9010500@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n5FkVcCSNCKvdTHQLO8RA7B8uCChAK1Of
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/23/2015 03:03 PM, Guillaume Picquet wrote:
> A status update, thanks to libsocketcan I am able to get and set bitrat=
e.

\o/

> remarks:
> Before setting bitrate a stop must be performed.

Yes - this way you can be sure that the new frames are send with the new
bitrate. Also think of a multi application CAN environment.

> I use poll() on CAN socket and it returns and set errno to ENETDOWN=20
> during the stop but sockets stay valid. (no need to close and reopen).
> I Suppose it is normal behaviour, right ?

ENETDOWN is expected behaviour. That you don't need to close and reopen
the socket is.....nice, isn't it :) Let's say it's implementation
defined behaviour. Better close and reopen the socket.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--n5FkVcCSNCKvdTHQLO8RA7B8uCChAK1Of
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWeqtvAAoJEP5prqPJtc/HEMsH+weGuCDrJc01GTtFBO2hB3yh
jCI8Oc0ofCd6Bl9gcUSnC/DWz631k7CqsjKb7cG3mi4vO+y4f71X9sT49noJGuI3
GFf1xb6mwugCdcsQEAN6Em09rUJdnnzRTkjZnDo+16bYzy2747Yjpx7HDoTln2IV
x0N2mP698Qe8fMtsQMKOZrpQvFBts8zpv88XDWejpal4Do+NtDbI4Bzy5pBPOSA5
pY2xU5G7deocuLyHf7OPe1WqfkTiU0pOgR6wD4gq8/DMGZCUc8DTC8ZApStCjwy5
W/1y10fabcyE3Kb3hLzmowKxNDLZZJVo3SlWgacmdEyo5jNlwd006FxxPdyHJmM=
=Yu2v
-----END PGP SIGNATURE-----

--n5FkVcCSNCKvdTHQLO8RA7B8uCChAK1Of--
