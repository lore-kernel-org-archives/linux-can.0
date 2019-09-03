From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: mcp251x: Get rid of legacy platform data
Date: Tue, 3 Sep 2019 15:17:11 +0200
Message-ID: <dc494f9a-0de3-5beb-bcbf-adbfb4813761@pengutronix.de>
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
 <20190903124259.60920-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n5sBZwJJ7Bka1PTU2ZPDkaN2Az3YpP3g4"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190903124259.60920-5-andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n5sBZwJJ7Bka1PTU2ZPDkaN2Az3YpP3g4
Content-Type: multipart/mixed; boundary="psrDXrGuYnQ1RGwHJYK4gr5sJqiNnBS2T";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Russell King <linux@armlinux.org.uk>
Message-ID: <dc494f9a-0de3-5beb-bcbf-adbfb4813761@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: mcp251x: Get rid of legacy platform data
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
 <20190903124259.60920-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190903124259.60920-5-andriy.shevchenko@linux.intel.com>

--psrDXrGuYnQ1RGwHJYK4gr5sJqiNnBS2T
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/3/19 2:42 PM, Andy Shevchenko wrote:
> Instead of using legacy platform data, switch to use device properties.=

> For clock frequency we are using well established clock-frequency prope=
rty.
>=20
> Users, two for now, are also converted here.

[...]

> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251=
x.c
> index 6ee0ea51399a..3a4d7089dc7c 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -20,29 +20,26 @@
>   *
>   * Your platform definition file should specify something like:
>   *
> - * static struct mcp251x_platform_data mcp251x_info =3D {
> - *         .oscillator_frequency =3D 8000000,
> + * static const struct property_entry mpc251x_properties[] =3D {
> + *         PROPERTY_ENTRY_U32("clock-frequency", 8000000),
> + *         {}
>   * };
>   *
>   * static struct spi_board_info spi_board_info[] =3D {
>   *         {
>   *                 .modalias =3D "mcp2510",
>   *			// "mcp2515" or "mcp25625" depending on your controller
> - *                 .platform_data =3D &mcp251x_info,
> + *                 .properties =3D &mcp251x_properties,
>   *                 .irq =3D IRQ_EINT13,
>   *                 .max_speed_hz =3D 2*1000*1000,
>   *                 .chip_select =3D 2,
>   *         },
>   * };
> - *
> - * Please see mcp251x.h for a description of the fields in
> - * struct mcp251x_platform_data.
>   */

I've removed this section already in this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/co=
mmit/?h=3Dlinux-can-next-for-5.4-20190903&id=3Df6cae800bfdb6711f0d45af986=
43a944998be6f2

=2E..I've dropped that hunk.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--psrDXrGuYnQ1RGwHJYK4gr5sJqiNnBS2T--

--n5sBZwJJ7Bka1PTU2ZPDkaN2Az3YpP3g4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1uZ9cACgkQWsYho5Hk
nSA3twf5AcGcPk2DzPYSQpPzgXn7l78/Huj0kKxuuiUV7cjxj3CTBqLl7r1cFsNc
K/urBcggRoi0orke9OEZ/2HFhvxYvujbYLY8m3SEgTPFi40NKHnIQ8qOxsJM+4xA
hwwxErF3IXnHOay3/Vg14in2/deABSORYXFzbXOoIRQWOsPiDP+600w4xuMj0zsH
rTKJzpJPH3nhrYPOcPyQ3qLMgjxY80VDWkBgY59QtD5vpk1XRDHtqne60kv0L22a
sWxHsCJVmY7kVP5lOT2P+Mn0+h6FrXvhuYGILkiUb1aALqdtEuHOwZ+fAD3UA2bA
XWimCgLYOXgfyl5I8NyHssGIjHhpXQ==
=1Z8b
-----END PGP SIGNATURE-----

--n5sBZwJJ7Bka1PTU2ZPDkaN2Az3YpP3g4--
