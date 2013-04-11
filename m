From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 17:09:37 +0200
Message-ID: <5166D231.2040107@pengutronix.de>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de> <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2IXCAFTVJQXSIFFFLVLHI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55572 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab3DKPJk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 11:09:40 -0400
In-Reply-To: <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mylene Josserand <Mylene.Josserand@navocap.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2IXCAFTVJQXSIFFFLVLHI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/11/2013 04:39 PM, Mylene Josserand wrote:
>> Err... don't set IP addresses on CAN interfaces, that's wrong.
> Yes, I even do not know why I set the IP address !

might be the usual habit of giving network interfaces IP addresses  :)

[...]

> Bad news for me.
>=20
> I think that your patch works but I have the same error as my first pos=
t=20
> : the CAN / spi is blocked after some frames sent/received.
>=20
> Currently, I use a CAN232 and a small program which send CAN frames=20
> through the 232 to the CAN. Then, In the same time, I read the CAN=20
> frames sent with "candump can0".
>=20
> I received the good message sent (00 01 02 03 04) :
>=20
> "
> root@navocap:~# candump can0
> interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> <0x001> [5] 00 01 02 03 04
> [...]
> "
>=20
> I have read 15 383 frames but after 15 834, it hangs. And after that, I=
=20
> can not act on the CAN anymore. A "ifconfig can0 down" hangs the kernel=
=20
> (even with ^C) and I have to restart the board to use the CAN again !

Ohhh, not good.

Activate "MAGIC_SYSRQ" in the kernel via "make menuconfog" (Kernel
hacking -> Magic SysRq key) and bring your system to hang again. Then
connect via serial line to your embedded system and send a "break". (See
documentation of your terminal program.). After the "break" send a
normal "?" to get the help. If I remember correctly, use "break" +  "d"
to create a stackdump (see
http://lxr.linux.no/linux+v3.8.6/Documentation/sysrq.txt for more
documentation). You might want to try the magic sys request if your
system is still alive to test if your setup is working.

With the stack trace you might figure out what the system is doing.

> I really think that it is not linked to your patch (do you want me to=20
> send the "Tested by" anyway ?) but to my first problem. The kernel=20
> update did not seem to fix that.
> Could you help me to try to fix it ? Because I really do not know how t=
o=20
> debug / fix it.
> For CAN bus, which is the most CAN chip used ? Do you think that the=20
> MCP2515 is a good choice ?

No, mcp2515 is the second worst choice if CAN chips I know, just the
mcp2510 is worse. If you can change your processor switch to a imx25 or
imx35, they have a CAN controller built-in. If you can redesign your
hardware, you can add a sja1000 to the external memory interface of the
imx27. But you need 3.3V -> 5V level shifters, as AFAIK the sja1000 is
only available with 5V io voltage. The easiest option is to add an USB
based CAN adapter to your system. Have a look at the kernel which USB
adapters are supported.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2IXCAFTVJQXSIFFFLVLHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFm0jEACgkQjTAFq1RaXHM6eACeNBHAp0Isp0rIg1wuxL+ewj+r
ZyQAnjgozQ7/S1M2upNAEd2MAjAbYgcZ
=VwA9
-----END PGP SIGNATURE-----

------enig2IXCAFTVJQXSIFFFLVLHI--
