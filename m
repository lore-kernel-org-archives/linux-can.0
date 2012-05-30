From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:16:39 +0200
Message-ID: <4FC60FA7.2000600@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5BF54BFE2BBD69AE926BF6F5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab2E3MQp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 08:16:45 -0400
In-Reply-To: <jq52en$i2e$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5BF54BFE2BBD69AE926BF6F5
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 02:05 PM, Martin Kozusky wrote:
>> Why do you want to use can4linux? Socketcan is the official CAN Stack
>> for Linux. Be sure you use the latest kernel, because the flexcan driv=
er
>> has some bugs and problems prior to v3.4.
>>
>> Regards, Marc

> Hello Marc,
> I wanted to try if it will be faster than socketcan (which is dropping
> some CAN frames on my HW under heavy load). I need the closest way to

Have you debugged which component is dropping frames? Is it the hardware
or the socket because your application is to slow?

> the controller, and I thought that when can4linux is not using sockets
> layer it could be faster. I also wanted to try LinCAN (which is compare=
d
> to SocketCAN here:
> http://dce.felk.cvut.cz/hanzalek/publications/Hanzalek10_168894.pdf  )
> but I think it doesn't support Flexcan

Good luck :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5BF54BFE2BBD69AE926BF6F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GD6cACgkQjTAFq1RaXHN0XACdF0pMeva+Wjrn0Ilt3TOZ9V2u
WbMAn0YErtyvfjO1c935lJuf2A+VtV4v
=ITZ0
-----END PGP SIGNATURE-----

--------------enig5BF54BFE2BBD69AE926BF6F5--
