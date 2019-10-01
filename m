From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: prevent memory leak
Date: Tue, 1 Oct 2019 22:23:45 +0200
Message-ID: <0b3ac5bb-af87-92ab-1b87-c419bbb85395@pengutronix.de>
References: <20190920024445.28214-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wdn5ZD10inilur2w3Zvl7mKcpLj8aU6ma"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190920024445.28214-1-navid.emamdoost@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexios Zavras <alexios.zavras@intel.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wdn5ZD10inilur2w3Zvl7mKcpLj8aU6ma
Content-Type: multipart/mixed; boundary="NwQBjjnI9b4xRZrJx2I05muuYH8ly50eB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <0b3ac5bb-af87-92ab-1b87-c419bbb85395@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: prevent memory leak
References: <20190920024445.28214-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190920024445.28214-1-navid.emamdoost@gmail.com>

--NwQBjjnI9b4xRZrJx2I05muuYH8ly50eB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/20/19 4:44 AM, Navid Emamdoost wrote:
> In gs_can_open if usb_submit_urb fails the allocated urb should be
> released.
>=20
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/net/can/usb/gs_usb.c | 1 +
>  1 file changed, 1 insertion(+)

Added Fixes line and added stable@v.k.o on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NwQBjjnI9b4xRZrJx2I05muuYH8ly50eB--

--wdn5ZD10inilur2w3Zvl7mKcpLj8aU6ma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2TtdEACgkQWsYho5Hk
nSAwVAf9GmrmybB6sGdFeeuEu1gPZWBmusuRT8oot0ESFihdrc/cPY9RvB6RAmAO
qsqeZKr5kqa/sX82LJGFKdho7Hb5QvgKl/h36jRNYsyhLbzVT9dhyG0BIY1AP7Jf
fTRrhj8Q2agZwkbpVVEEQRmufLAWPvXcKK5PDqgCAMAtO7xOijQ8VKKLOp1mG72Y
3zjubgHh0m9CZ4JPe/z13VT72pfYi/ZmpnzgDF2/f9Fokvh7k8QpwkEkhqgB/iXJ
ciyBwYPLjqW1ntQOr1im1Xl6DkSNL4FgU1amxhQNOu0bw7XDxG+TgEOPdirNN50Z
P1bfTjJp+8AriIiHhWpFgBznAVR2Dw==
=PU+i
-----END PGP SIGNATURE-----

--wdn5ZD10inilur2w3Zvl7mKcpLj8aU6ma--
