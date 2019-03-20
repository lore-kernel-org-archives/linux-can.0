From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Wed, 20 Mar 2019 14:18:02 +0100
Message-ID: <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HOQiaJuxXLuWF7i853A7jJVMy071Yx6Gh"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOQiaJuxXLuWF7i853A7jJVMy071Yx6Gh
Content-Type: multipart/mixed; boundary="c6b8qNbceyTBn9WImJL7AixlYa2v8Vx1l";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
 Per Christensen <pnc@deif.com>, Rasmus Villemoes
 <Rasmus.Villemoes@prevas.se>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>

--c6b8qNbceyTBn9WImJL7AixlYa2v8Vx1l
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/7/19 4:00 PM, Rasmus Villemoes wrote:
> While trying to add support for the Flexcan modules on the MPC8309,
> I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing
> succeeds. Checking the leftover value of timeout with a primitive
>=20
>   pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);
>=20
> after the loop in chip_disable() typically shows values around 12-14,
> i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit to
> appear. So a timeout value of about twice that seems reasonable.
>=20
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

I've scheduled the patch by Joakim Zhang:

    9daed89ae8a3 can: flexcan: fix timeout when set small bitrate

that doubles the timeout to 100.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--c6b8qNbceyTBn9WImJL7AixlYa2v8Vx1l--

--HOQiaJuxXLuWF7i853A7jJVMy071Yx6Gh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlySPYoACgkQWsYho5Hk
nSAzYwf/SeXbgOsP9YUiKjhwj4QT0d1mTt0+E5w2mm/dBit9CDiTBTW/K6feY+I4
AkXMlDxTDNWXKLc5NIVMsTzSwNOvIzCTGBJjpB7xq8BET54/WJkdpItf3EocDXQw
wmHolVlg7gja5+NNYTCLVbqp44Q8cAHZkEOi4klnEj0XvgtJF/x5AoZCROWpYFkE
bMdH9aAIOkWRThFPIydE1IYTfZdOmvGDlS0DLmlDP/aPjCp6vJzGVHY/K1H5I7vy
mxgBVz3aEjX6u4ohtcfDXs31/T6eZTgGfSrJLoXUGNfSQAZ9H1nDjPnOymzy/UOp
rhaSzPcjmfeeNtCy0zX0MXwHXwxzQw==
=Mwed
-----END PGP SIGNATURE-----

--HOQiaJuxXLuWF7i853A7jJVMy071Yx6Gh--
