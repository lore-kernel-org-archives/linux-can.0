From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] slcand: add option -p<file> to write pid to a file.
Date: Mon, 8 Jun 2015 15:55:26 +0200
Message-ID: <55759ECE.6000302@pengutronix.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
 <1433764540-24917-2-git-send-email-armin@uni-bremen.de>
 <557591E5.2080706@pengutronix.de>
 <20150608134327.Horde.pLkodAvAfc3OuL7mi_j9ulf@webmail.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AD1W8dm4T0k4Kx9QRHmWtUaQtnwPi9a1e"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47065 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbFHNze (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 09:55:34 -0400
In-Reply-To: <20150608134327.Horde.pLkodAvAfc3OuL7mi_j9ulf@webmail.uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Armin Burchardt <armin@uni-bremen.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AD1W8dm4T0k4Kx9QRHmWtUaQtnwPi9a1e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2015 03:43 PM, Armin Burchardt wrote:
> Hi Marc,
>=20
>> I think "/run/slcand/<IFACE>" would fit better into modern file system=

>> layout. What about having a default for the pid file path?
>=20
> I would not expect a daemon to accept a filename (or only parts of it) =
without

Me neither. I was thinking that "-p" without a path would generate a
pidfile in "/run/slcand/<IFACE>"

> a full path. The /etc/init.d/skeleton of Debian wheezy uses /var/run/$N=
AME.pid

wheezy (a.k.a. old-old-stable)? Ist that still alive? :D

> (for start-stop-daemon's --pidfile option).
> Do we know enough about the filesystem layout of existing (embedded) =20
> systems to define
> a useful default?

systemd uses "/run/<daemon>.pid" or "/run/<daemon>/<foo>.pid"

>> Does it make sense to open in exclusive mode?
>=20
> If another daemon is started with the same pidfile we would have to giv=
e
> up if the file already exists to take advantage of that. Is it =20
> expected of a daemon
> using a pidfile to exit with an error or should it just overwrite an =20
> existing file?

Right....probably not worth the trouble, keep it as is.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AD1W8dm4T0k4Kx9QRHmWtUaQtnwPi9a1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVdZ7OAAoJEP5prqPJtc/Hx6AH/iDBf+1Y4B65rUQBZvK3hjw5
D3K7AS0FWxrkV2CBomXDA4/IkOJyA81lD7nT4nvudommFPbActXjVOiQXjWVXuZA
RG/Qm5BlMCrtwmkYCSvaqmpIsb39GDvwT2N7PpgWsPAolvkIR2A1+C8quQLs5OED
edKRrBPAz+1cFrtmdlAk1nbdwn7TzvQngpXrwTaUA2ff4l6LjR/AAACgF1HL+bLu
k3VLLBc5P5CCW2Zou/XWy7ALDE8/SQHJ62tjoIL9EUQZiQ2lnfF0N44dqAFoyHOw
xVobeuylcaBg+40AINqX3u3loWXbTaYF2VZJIlY1NpCBYqUR18PEaR45f9IKYEo=
=SA5n
-----END PGP SIGNATURE-----

--AD1W8dm4T0k4Kx9QRHmWtUaQtnwPi9a1e--
