From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN FD USB interfaces
Date: Mon, 26 Jan 2015 13:56:42 +0100
Message-ID: <54C6398A.5030203@pengutronix.de>
References: <2030058.NqX30u0ogQ@heinz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xp4J8ogbLLuiqxA5jiGMOpx5POojedNbd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58558 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbbAZM4s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 07:56:48 -0500
In-Reply-To: <2030058.NqX30u0ogQ@heinz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <oe@emtas.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xp4J8ogbLLuiqxA5jiGMOpx5POojedNbd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2015 01:38 PM, Heinz-J=C3=BCrgen Oertel wrote:
>  which CAN FD interfaces with USB to PC connection are currently suppor=
ted by SocketCAN?
>=20
> I can see that Peak is very active.
> How about IXXAT, Kvaser and Vector?
>=20
> At least receiving classic CAN, and CANFD non-ISO should work.

Peak support has just been added, it will probably hit mainline in v3.20.=


Feel free to post patches to support new devices. :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xp4J8ogbLLuiqxA5jiGMOpx5POojedNbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUxjmNAAoJECte4hHFiupUETIP/RojARK/D0vNGwy5Zj8zMJVX
br5ZlIRBfKjwDcG4vu0j5yiM6ulobuUYsIstOebr1HkHHsrCbGQqoE9KFgec1Kbk
6q5It5WZ5kF3F0H31YZGE2wRzBoENKg4dBPPGAE9Tch8rSYx8A5N0TwUrBBjPCcq
/hrO3d5NPj6BrMXSn4DLlTS1LhfUeoHT5avYTlUXsncFVbFWd39UHw5uppKEM6tB
c4wfN93l1gYyeZMxmoSnipaWxzfOvzPkD6azZKNUPDz0ZxT2S/hMXvYk+PhAx2r+
bMFfV0EF/EtqRdlJrIiwm0eyMxaWlipC3oke1kfgZ5VF4DYk6bimW2PsFUH1D9Cb
sblsMoNoXZgdS0o0sZeliYVAnTUBSmnaqENLbQ1BCcfgg0uno26cXS6eWOmzmMe4
Y2zpl+8KJA9Ay8ZY4szXrr6jkwD0Zk79Ytaf77gjj6Pe577+yc/cjNBWaU2lSK3V
UKM7ChdfMCpOxJwYX7NKOreeXvaiwisQypE8PjlrMsUW7IIo2Aifvqr31+RmoQ8b
hPax+hvF/wIK3s7mTIu04RTr7LHl0T8AG8wMJt5GlzjbkZif64+d8SXzfGWhRDIk
A8aTCSWOhEbkIBs27JJGhFgry1x0H+s9qLfXKHkKMCsEWz/Fv7gTe3sHzRPqZGw7
pUS27JgcjZ91Z9QSTwxN
=46Wk
-----END PGP SIGNATURE-----

--xp4J8ogbLLuiqxA5jiGMOpx5POojedNbd--
