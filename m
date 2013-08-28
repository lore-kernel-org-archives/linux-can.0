From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: candump app will lost rx packets while it prints the received
 data frames
Date: Wed, 28 Aug 2013 12:28:39 +0200
Message-ID: <521DD0D7.50208@pengutronix.de>
References: <loom.20130828T111233-886@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Hd8cvwqENKlLxSBOFwdVmTqw97OQUEpwI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36003 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab3H1K2q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Aug 2013 06:28:46 -0400
In-Reply-To: <loom.20130828T111233-886@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: xuewentian <xuewt@embedinfo.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hd8cvwqENKlLxSBOFwdVmTqw97OQUEpwI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2013 11:17 AM, xuewentian wrote:
> Hi all,
>=20
>   I wonder that when the can select/poll bug can be fixed ? What reason=
=20
> has it not been fixed yet? Thanks a lot.
>=20
>  and now I encounter another problem, I use a sufficient delay for cans=
end=20
> on the first borad, and anther board using candump to
> receive the data frame.
>=20
> board 1:
> cansend can0  -l 500 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77=20
> 0x88   //cansend I have added the delay,and no any write failaure repor=
t
>=20
> board 2:
> candump can0    // on the serial terminal, I have only received about 4=
34
>                 // data frames which are printed on the serial
>                 // terminal,and no any read error information
>=20
> and use "ifconfig can0" on the two boards, I found that board 1 has=20
> increased 500 "TX packets",and board 2 has also increased 500 "RX=20
> packets", but candump app seemed that lost some packets. what reason is=
=20
> it??

Don't print on a serial line what you have received over CAN. Your
serial port is slower than CAN, the socket buffer between kernel and
application will be full sooner or less, then the kernel drops frames.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Hd8cvwqENKlLxSBOFwdVmTqw97OQUEpwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlId0NcACgkQjTAFq1RaXHOwLgCdFIqKg/ieBE5jK7MWJTukl4xk
FKkAn1Gb26q5l+Z8E3NOMeF43bdgtgrP
=Y6Hi
-----END PGP SIGNATURE-----

--Hd8cvwqENKlLxSBOFwdVmTqw97OQUEpwI--
