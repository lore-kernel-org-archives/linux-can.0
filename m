From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 10:00:10 +0200
Message-ID: <5231748A.2080009@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de> <1378968239-sup-1257@pruts.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HheSGXAe0f4HFVFU7Ds00F7ArArTaMn2w"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50208 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3ILIA2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Sep 2013 04:00:28 -0400
In-Reply-To: <1378968239-sup-1257@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HheSGXAe0f4HFVFU7Ds00F7ArArTaMn2w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2013 08:52 AM, Ico Doornekamp wrote:
> * On 2013-09-11 22:11:04 +0200, Marc Kleine-Budde wrote:
> =20
>> I'm not familiar with the tcpdump capture format, but the
>> "(little-endian)" above suggests that the format supports both little
>> and big endianes.
>=20
> As far as I know wireshark should be able to handle both formats.
>=20
> Maybe I can change the question so it's not directly related to capture=
 formats
> and wireshark:
>=20
> I have can packets of SDO transfers (not the same objects, though). Can=
 anyone
> tell me which one has the data in proper byte order as it passed on the=
 CAN
> bus?

I don't speak CANopen...

> 1: 8a 05 00 00 08 00 00 00 43 18 10 03 2f 01 00 00 =20
> 2: 00 00 06 02 08 5f db f6 2f 00 18 02 01 00 00 00  =20
>=20
> 1. packet #10 from capture-10. Node ID 10, SDO 0x1018sub3
> 2. packet #39 from capture-yegor. Node ID SDO 0x0018sub2

=2E..but your CAN frames don't look correct in wireshark. I suggest you
bring up the command line tools and use candump to display the raw CAN
frames. Raw CAN frames, as they enter the application, are in host
order. To be precise the can_id is in host order, as all other members
are u8. "data" is an array of 8 x u8, which is in fact big endian
ordered, if you want to access it with 2x32 or 64 bit.

> struct can_frame {
>         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_=
DLEN) */
>         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HheSGXAe0f4HFVFU7Ds00F7ArArTaMn2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIxdJYACgkQjTAFq1RaXHPiWgCcDUIllpkiosFFd2iJLoVTSuBR
Sq8An0Vtcj+vbKCqH3RBWLc23T/hVQn4
=JSbR
-----END PGP SIGNATURE-----

--HheSGXAe0f4HFVFU7Ds00F7ArArTaMn2w--
