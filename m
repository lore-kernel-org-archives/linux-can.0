From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1 0/5] can: add SAE J1939 protocol
Date: Tue, 30 Oct 2018 15:54:30 +0100
Message-ID: <d8a03c5f-cfd6-2a6f-0029-4272c7b57452@pengutronix.de>
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="y5o5j3kDpVBIqPDllkj5tmz9rTfGANsCw"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--y5o5j3kDpVBIqPDllkj5tmz9rTfGANsCw
Content-Type: multipart/mixed; boundary="jeep4h4KZhzIZGO51ETQ1sbiKNQkloaCz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <d8a03c5f-cfd6-2a6f-0029-4272c7b57452@pengutronix.de>
Subject: Re: [PATCH v1 0/5] can: add SAE J1939 protocol
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>

--jeep4h4KZhzIZGO51ETQ1sbiKNQkloaCz
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/08/2018 11:48 AM, Oleksij Rempel wrote:
> This series adds SAE J1939 support to the current kernel v4.19-rc6.
>=20
> This stack has long history, starting back in 27 Apr 2011, if not
> earlier:
> https://lists.openwall.net/netdev/2011/04/27/45
>=20
> After major rework and testing it is a time to send it mainline.

I've removed some trailing newlines and added the stack to
linux-can-next/j1939.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jeep4h4KZhzIZGO51ETQ1sbiKNQkloaCz--

--y5o5j3kDpVBIqPDllkj5tmz9rTfGANsCw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlvYcKYACgkQk9IU1zQo
ZfGXgAf/Y2kxZMR06W0KRHrDzD8i0DJYOPBQ+oVDpWy0oYnFDAeqvGjcdyre23xM
z0fRvHE/3U9c0w23Bk8vlaCAC+J1tVlJOMuZgtduruhnXGVBCHd+dY0qwz9o5Eop
VwFYkgidbp3DqLSTKsuaN6ZQm7bAp8kEJt/Yc5TLPB1/CcSN1/FMZiVAagFeIPPk
FYWUuJsWqahInWuCgiLPMT9YNFZWSrcCJfB/rijVAx5+ZKfv1qSIMdwhHEpEgYf0
cfLsrcOFtB7TG+wiFoem6r1zLh6/nN8U0FC99We8PXT0kgeKn5ATxMbmexuoFOLv
O1IfLewERNwPKAyx8ehiaa0rjzadKg==
=5Rko
-----END PGP SIGNATURE-----

--y5o5j3kDpVBIqPDllkj5tmz9rTfGANsCw--
