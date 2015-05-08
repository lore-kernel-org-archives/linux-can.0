From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Raw CAN socket support in LXC?
Date: Fri, 8 May 2015 10:54:44 +0200
Message-ID: <554C79D4.8000901@pengutronix.de>
References: <554C6FDE.6080706@actia.se> <554C73C8.5070705@pengutronix.de>
 <554C7790.1000302@actia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NmqtnRDfNOhmrC4puDlpFBmrwr2WlD8vG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60999 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbEHIyx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 May 2015 04:54:53 -0400
in-reply-to: <554C7790.1000302@actia.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Adam_Engstr=c3=b6m?= <adam.engstrom@actia.se>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NmqtnRDfNOhmrC4puDlpFBmrwr2WlD8vG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2015 10:45 AM, John Ernberg wrote:
> Our main use-case is to prevent a possible misbehaving application to=20
> bring down the entire system through memory leaks, crashes etc.
> At this time we have not considered any filtering or blocking of direct=
ions.

Can you see the your CAN interface inside of the LXC container? Or are
the RAW sockets the problem?

Marc

btw: you can use systemd to do memory limiting, too. It makes use of the
same feature in the kernel (cgroups).

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NmqtnRDfNOhmrC4puDlpFBmrwr2WlD8vG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVTHnUAAoJECte4hHFiupU3+wP/RC31K/tNEdIcnoz7AInLIXA
fYID5a5D+lpx/WLXjjWOa20zPdVFAwd0kwE7PniDQeNixcUOW2sd0xanlKXU7p+u
ZBWEOsgtfwtO2tEgxtgSRuGdjO/99KWSNwx4SjrXauKZFiPp4E0Cg93o7kV2TxYC
ZQ2VjpmiXBi6UUfY4Aiia3PIijJG8QM3GdiYKYyYmrxinKyW7Qhb/ZGPhX4Ac+8V
cl1ydjMu0VaxBFNN4eevwsPR9UmSOq6ZVMTchE+1Jt0jftpw9nuVPzBWEpFUcye4
fveUaODq1EJHuLQl9S04QYC7ybQ79TilddGPZh0eVmxwOCTCpc+lkd4UjhdM+9G5
7KMYMMNLWpAOfKvuH3LoXw2gMYfN1Ldrq1BtFdR05lMmtfqsqqMez+8hutE+nHD2
xoVWTMPybpCaxpwqMTX2AKt1ZCJ7dJ0A0hkzSgxd9kos+94TE1JVpe+fKx6mQYI7
tUbTMfwdBGgb1nGFzFHD5EAPy9vspK7R4uaB2PYkagx4YM0SiwhBGUYZBDkR9oHA
1igNHkAYQm5WmN1O5nWs9rbUKPdBdqFq/p7gV1D+nVxRa9lEWtdRZrJ6/6ywWuyu
Ydud78fPySP4tnd1/U7j7hRqUHRAa/t48RSva9+YA9RIgAH1uGvEi535OR3l6ILe
IIoBC8ks0ZcgPDOFZX/I
=EWGA
-----END PGP SIGNATURE-----

--NmqtnRDfNOhmrC4puDlpFBmrwr2WlD8vG--
