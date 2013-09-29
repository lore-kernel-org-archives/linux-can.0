From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 19:44:51 +0200
Message-ID: <52486713.2000209@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com> <2109885.0l6dWmo4a5@heinz.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lMOhgJKmJiI0n62rQAwtGnGGVQl4fNUsC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab3I2Ro6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 13:44:58 -0400
In-Reply-To: <2109885.0l6dWmo4a5@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lMOhgJKmJiI0n62rQAwtGnGGVQl4fNUsC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2013 06:28 PM, Heinz-J=C3=BCrgen Oertel wrote:
> Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegger:
>> I think you need *strong* arguments to get it accepted.=20
>=20
> I have some good arguments for this kind of driver
> - it is much more simple in design than others,
>   simplicity is one of the Linux design goals

What is in your opinion too complicated about linux CAN? Is it a lack of
Documentation or examples?

> - It has a simple user API

For a simple program you need socket(), bind(), read(), write().

> - It does not need any other infrastructure than the kernel API

This is another way of telling, we've reinvented the rest on our own.

> - It is mature

The ultimate question is: What problem does it solve?

> I agree, it would be nice to share the low level CAN controller related=
=20
> experiences of the developers. That is may be something we can share if=
 we=20
> could agree of a set of CAN controller header files with shared registe=
r=20
> #defines. And a set of very basic functions like initialize and activat=
e CAN,=20
> set acceptance filters, transmit and receive, read out error register o=
r=20
> whatever.

Like the driver and the socket infrastructure?

> But to stay simple, I don't like the idea to have another additional la=
yer=20
> around SocketCAN as layer below the can4linux API.

Does this mean you want to duplicate the drivers?

> Linux offers real diversity on the desktop, why not with drivers? Linux=
 also=20
> has different sound devices and architectures.  Why not offering two di=
fferent=20
> CAN driver concepts to the application programmer,
> let she decide what to use.

Sorry, but I can only NAK this idea.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lMOhgJKmJiI0n62rQAwtGnGGVQl4fNUsC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJIZxcACgkQjTAFq1RaXHMZlACeOCSSwCGJiRdEsinJlAszrI6b
QIwAnRdZhuuVCU935PvtyB3DeTW4sw6F
=phuu
-----END PGP SIGNATURE-----

--lMOhgJKmJiI0n62rQAwtGnGGVQl4fNUsC--
