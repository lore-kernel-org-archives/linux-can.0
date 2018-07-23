From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: mark expected switch fall-throughs
Date: Mon, 23 Jul 2018 10:14:50 +0200
Message-ID: <f6f0bf83-84b1-0cf0-3c78-828b56694b92@pengutronix.de>
References: <20180628174142.GA17081@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628174142.GA17081@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0
Content-Type: multipart/mixed; boundary="xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <f6f0bf83-84b1-0cf0-3c78-828b56694b92@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: mark expected switch fall-throughs
References: <20180628174142.GA17081@embeddedor.com>
In-Reply-To: <20180628174142.GA17081@embeddedor.com>

--xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 06/28/2018 07:41 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

applied to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xT716j30djcJ5nwgAp2Vk31O1hyjm5C7G--

--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVjnoACgkQk9IU1zQo
ZfGelAf5AfQeNzehZW/bovXlJpiWRLU8epG4YOmZG+2xHcsMtidTq7jpJQNhfp3M
qYJ/7alelstX5GAWT6RYlONZo8IqJ4ps3efKvKidd+D8fQfTAjVDeC7jkRzqt9na
9+FUF9BSwI7Z0G8bdAcErsre2CJFR5DDABEbrqe3Sn1APeKnDm4S5soMR1EHw3TG
Z4Cb/N4Lo5nApLTmOcDFSWCAGxHvD8DiPF4QPSsG5MHcjcs8Mv9rfmsxSPqYIlaO
xtB+iUpqqfuySeBXFusLFDBki+6K+RHqK3bo3Kp+eb3ZAG6xuep2I0PLbN3I5aXo
8gThfUTp11Te4xKxc7PFh2O3qu+xgQ==
=R8kB
-----END PGP SIGNATURE-----

--GtZDdLRzLjn81QO2ovso2LYLDRpa9X8R0--
