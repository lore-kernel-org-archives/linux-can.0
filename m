From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Bug] mtd: rawnand: gpmi
Date: Thu, 5 Sep 2019 22:39:36 +0200
Message-ID: <9db42086-027f-e096-44d7-6d39b8af94ee@pengutronix.de>
References: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2910849127678432163=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Sean Nyekjaer <sean@geanix.com>, s.hauer@pengutronix.de, miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org, linux-can <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2910849127678432163==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5dQik6L09IRMXXsePXfzC0PhJe2enN51h"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5dQik6L09IRMXXsePXfzC0PhJe2enN51h
Content-Type: multipart/mixed; boundary="fXrJmMosEU8RMe8VehDddG5VVSRdBvTWf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, s.hauer@pengutronix.de,
 miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <9db42086-027f-e096-44d7-6d39b8af94ee@pengutronix.de>
Subject: Re: [Bug] mtd: rawnand: gpmi
References: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>
In-Reply-To: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>

--fXrJmMosEU8RMe8VehDddG5VVSRdBvTWf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/5/19 10:26 PM, Sean Nyekjaer wrote:
> I have been troubleshooting some CAN problems on our imx6ull with a raw=
=20
> nand flash.
> I normally run with a 4.19 series kernel, but to verify those CAN=20
> problems have been resolved in newer kernels i have been trying ~5.3-rc=
6.

What kind of CAN problem? (Cc +=3D linux-can).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fXrJmMosEU8RMe8VehDddG5VVSRdBvTWf--

--5dQik6L09IRMXXsePXfzC0PhJe2enN51h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1xcogACgkQWsYho5Hk
nSBz7Af/ai1hQLjrzTi/jsQDJRAIf4qjhJW/doaHYZAleBEBs4wZqVh4ncWt4Ura
gR9AKbL3jTS4qsxWat/F7oL87jTPik3Yz36PsPLz1nrKL5C5xyIS6h82TJgfF9d3
ujULqt17EZ5xHPWc6Qumv1hgJ0seTNooA2xjVoJqxLnuI22ipKsRhj/rR4r679AT
fAYoUZPiokn26FtT9eAFfyoEVcfXqHU8QoIY78NcPoGGxG9mIuKLh3r/V5aBWyBe
0uU5f16jwy1eUMKGbRRdrvgGW40qxkyYzDqp/Xc2i4tMeSdH4r8K03VN9y0gAImB
BY1WRlAtP4bdehj0rHITUGzA3YQzZQ==
=cMqv
-----END PGP SIGNATURE-----

--5dQik6L09IRMXXsePXfzC0PhJe2enN51h--


--===============2910849127678432163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============2910849127678432163==--
