From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 11:13:56 +0100
Message-ID: <50BDCCE4.5080901@pengutronix.de>
References: <50BBF73F.9080208@universalnet.at> <50BCB1E8.2070705@pengutronix.de> <50BD09D1.6040009@universalnet.at> <50BD00A2.8010300@pengutronix.de> <50BD0FD2.5060002@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8451F61F1AC46B1860A07AA7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45018 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2LDKOD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Dec 2012 05:14:03 -0500
In-Reply-To: <50BD0FD2.5060002@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8451F61F1AC46B1860A07AA7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

please leave the mailinglist on Cc

On 12/03/2012 09:47 PM, krumboeck@universalnet.at wrote:
>>>
>>> Gives following error:
>>> usb_8dev.c:979:27: warning: assignment discards =E2=80=98const=E2=80=99=
 qualifier from
>>> pointer target type [enabled by default]
>>
>> which kernel are you using?
>>
>=20
> Linux debian 3.2.0-4-amd64 #1 SMP Debian 3.2.32-1 x86_64 GNU/Linux

The struct definition has been changed with commit:

194b9a4 can: mark bittiming_const pointer in struct can_priv as const

which was first released with v3.6-rc1.

Please develop and send patches against David Miller's net-next/master,
or even better, linux-can-next/master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8451F61F1AC46B1860A07AA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC9zOgACgkQjTAFq1RaXHPFugCgh8St/Xqe214HSR/19pW/1qS1
8rQAn2LPrxC3J95beh+w7kx4UkkAD+a/
=VSx3
-----END PGP SIGNATURE-----

--------------enig8451F61F1AC46B1860A07AA7--
