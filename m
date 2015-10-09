From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: at91: remove at91_can_data
Date: Fri, 9 Oct 2015 12:07:40 +0200
Message-ID: <561791EC.7050102@pengutronix.de>
References: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7uOQNd76xHESt9HpeLp46EgAIPgLej6gI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbbJIKHy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Oct 2015 06:07:54 -0400
In-Reply-To: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7uOQNd76xHESt9HpeLp46EgAIPgLej6gI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2015 04:56 PM, Alexandre Belloni wrote:
> struct at91_can_data was used to pass a callback to the driver, allowin=
g it
> to switch the transceiver on and off. As all at91 boards are now using =
DT,
> this is not used anymore, remove that structure.

One board was obviously not converted properly to DT. As I don't have to
board to test, I'll apply this patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7uOQNd76xHESt9HpeLp46EgAIPgLej6gI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWF5HsAAoJEP5prqPJtc/HPpoH/2SVJCj7NBn8zWzdXl9Oo60g
ZrBsZhG34toevUKOShaK87i13YsI/gjeq+KgOpGXxFHHe0XkV+5qOs4PHVS+JtLU
4Pjuf1yWuru0MkVDNsR6xRxSNxEBL0wnRngPskFGHmxhXgkksKqn9WkclqF27VVZ
OmeM9s1KET2sZBDSEXqqAHpHj/+934pusKmy3BFKevdlyGAjJ3OVf95lkQBTEf6I
RE0jZoWaOxRROr/qh+pcdI5nN9+7vOPW+NzRsDOBk+J18KL6PkKEY7Z3yycc8mL2
V+IjTuv0pqYNXIY4J6jxj3tJ0AmqLEwCUgTYDVHKGl77c4D08yPchTAU7+YOAmA=
=KZgN
-----END PGP SIGNATURE-----

--7uOQNd76xHESt9HpeLp46EgAIPgLej6gI--
