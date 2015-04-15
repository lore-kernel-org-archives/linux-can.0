From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: =?UTF-8?Q?Re:_Hilfe_-_Wohin_Anfragen_bez=c3=bcgl._SocketCAN?=
 =?UTF-8?Q?/FlexCAN?=
Date: Wed, 15 Apr 2015 14:30:36 +0200
Message-ID: <552E59EC.9030408@pengutronix.de>
References: <552E55ED.7080904@synergetik.de> <552E5827.6010304@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="O2gaw0iNhDkqMOlS9F6K05At7DCp3pn7N"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38332 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586AbbDOMam (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Apr 2015 08:30:42 -0400
In-Reply-To: <552E5827.6010304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus Uhle <markus.uhle@synergetik.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O2gaw0iNhDkqMOlS9F6K05At7DCp3pn7N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2015 02:23 PM, Marc Kleine-Budde wrote:
> Das ist richtig, diesen R=C3=BCckgabewert gibt es nicht, da der Treiber=
 seine
> TX-Queue anh=C3=A4lt, falls er keine Pakete mehr aufnehmen kann. Zur Ze=
it ist
> im Flexcan Treiber nur eine Queue mit der Tiefe von einem Paket
> implementiert. Die L=C3=A4nge der Queue ist per default 10 Pakete. Das =
k=C3=B6nnte
> Ihre Beobachtung erkl=C3=A4ren. Vielleicht ist der BCM nicht darauf
> ausgelegt, dass nicht alle Pakete in der Queue laden.
>=20
> Ich schlage vor, dass Sie Ihre Problembeschreibung auf die Liste posten=

> und wir dort weiter diskutieren.

Doh! Since I put the mailinglist by accident on Cc I'll recap the
problem for the audience.

Markus is using the flexcan on a imx53. He encounters a problem with the
broadcast manager. When registering more than 12 messages (to be send
every 100ms) at the BCM, the 13th message delayed and only send every 1
to 10 seconds.

I suspect the problem may be related with the default queue length of 10
CAN frames per interface. The BCM might not handle -ENOBUFS correctly.

Markus, try to increase the TX queue length by:

    ifconfig can0 txqueuelen 100

or 1000.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--O2gaw0iNhDkqMOlS9F6K05At7DCp3pn7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVLlnsAAoJECte4hHFiupUuqkQAKmuJLuUX2+JuI2vbIkRzinv
I0zuLicMSh6Czn7TINqcHU7HfTGXLEQ+hZ3SDUAbSZjYkmAcbBfSjObg7yPKJ+of
BmUt9gqZDqEUt/Hli95DdzhH9fasQpEjQFO48TCHeTTpnHTtOagi2Y1ZXA2/I+xw
3KruZ9crKcK6GcDGboW9iPj7g6wYVNoP1rPioI1qMaWJ0tmfg6YFUUTHVf8WQ10Y
POfF7HPTU+YIzmPNDfWUqlirWjwUvR5hlAXgpeK6H7XDGtZC4YA/ffW/OK5+QYaU
mPnRhh3MuHWVdzhd9My20WR4ljidrI325acYZ6KWAZW3sim7DA/rpyS3sY7HynVi
Id96VI1g9pArOFSKbgcW8unJLWtOo6CqYof6hJ9dnYkxtXPf7mbX1FzVnIY+3aJ6
5O+NlVB4c7Sgf0mWne0yv5YKC7vn0ZaJbnnYcDJ0ekjkFo5gJIUp/llJ7zDWM1Ir
jIR3B+puhdhWXdBa7jB7svHesnQ49vn5NvT3+zqeRQh2mB+P8KePOFBg6HcM/Gf1
gAnW43662wV5VqSFxiyLCidiC4Spb8EAktIGs0B1hTbmLhIP9JSOMsVr1EAqtKQK
r653lwDSluvGLJtJK2bIMBR8drBGhvh6z9RymAhWaPbtDd64vDnhAbeYdVg/N0sl
ejtBRi8CfmVsWMvV1xgX
=eVCz
-----END PGP SIGNATURE-----

--O2gaw0iNhDkqMOlS9F6K05At7DCp3pn7N--
