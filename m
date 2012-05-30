From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 15:18:31 +0200
Message-ID: <4FC61E27.6040309@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79969EF13041847EFE8D2B41"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44516 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab2E3NSi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 09:18:38 -0400
In-Reply-To: <jq5530$ag8$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79969EF13041847EFE8D2B41
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 02:50 PM, Martin Kozusky wrote:
>>> The best for me would be some kernel module which would just put the =
CAN
>>> frame into some big "from userspace available" buffer in the interrup=
t
>>> and nothing more. My app would check if there is anything new and rea=
d
>>> it out.
>>> There are around 1500/sec (at 250kbit) can frames on the bus when the=

>>> problem arise, I think it's not that much.
>>
>> Are you writing the can frames to storage in the same thread as
>> receiving them?
>=20
>=20
> No, CAN has it's own thread, which is just making struct from can
> messages (reading via select() )  and writes them into another buffer.
> Then the main thread reads this buffer and writes to SD card. Now I
> changed it so that this buffer is 30MB big, so I first store all the
> messages into RAM, and when I don't need to record CAN frames anymore, =
I
> write all of them to card from this big buffer.
> But this is just limited workaround because I'm limited with the RAM
> size (so I had to make the buffer cyclic and just latest xxxx messages
> are stored, older are overwritten when the buffer is full).

Have you setup realtime priorities for you CAN thread?

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig79969EF13041847EFE8D2B41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GHisACgkQjTAFq1RaXHNh3ACdEl1cy/zNq1GzLu3gNYWF8GfP
rK8AnRJIDI2KcGHmYx+WFceWRA6nufj1
=W6qH
-----END PGP SIGNATURE-----

--------------enig79969EF13041847EFE8D2B41--
