From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: m_can: change comparison to bitshift when dealing
 with a mask
Date: Thu, 8 Feb 2018 15:39:30 +0100
Message-ID: <a15c4dbc-0f62-b4af-9dbd-49b599c873fe@pengutronix.de>
References: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eMziEACJF3HIaxgX3ChwiNv7cnMJ08KCv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35375 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeBHOkM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 09:40:12 -0500
In-Reply-To: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eMziEACJF3HIaxgX3ChwiNv7cnMJ08KCv
Content-Type: multipart/mixed; boundary="u523Bk4iYEMvFScKxGSQWBDbg4gSbO1gO";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfgang Grandegger
 <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <a15c4dbc-0f62-b4af-9dbd-49b599c873fe@pengutronix.de>
Subject: Re: [PATCH] can: m_can: change comparison to bitshift when dealing
 with a mask
References: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180206085207.3882-1-wsa+renesas@sang-engineering.com>

--u523Bk4iYEMvFScKxGSQWBDbg4gSbO1gO
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/06/2018 09:52 AM, Wolfram Sang wrote:
> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--u523Bk4iYEMvFScKxGSQWBDbg4gSbO1gO--

--eMziEACJF3HIaxgX3ChwiNv7cnMJ08KCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8YSIACgkQk9IU1zQo
ZfFhHwf/QUaAQJJGrBh1eAPA15MIV0S4p9VZXF3+YzJaQsu96Ptjr5j0o9RnbVxE
VFxp5HuDEoPfbkbOUeaNrD/Ct+IjgqJxH2pBHQCshXUC+kvCYxhkiypWxQGnTTkC
CCekQBIKut191s8TE8Sk1FZxI9VC0e7VxN3bvBOax7Syzjiby5kImnjBjwLARRhW
0GBnEjZg63gQORX5K90EXndmCtuNb6hJxJ72ZNLhRobk7Ts79s25j5x04IenMM9k
bwrGBA8j3uoYBMMBTbcFr5asKwmwVsFt6OCm/HOW4hryDs8hR4LcPkoQxsP9SD7t
aEzWO2C6nshi1uYLPy7mNVK6dn+ueg==
=FEKQ
-----END PGP SIGNATURE-----

--eMziEACJF3HIaxgX3ChwiNv7cnMJ08KCv--
