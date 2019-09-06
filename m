From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Bug] mtd: rawnand: gpmi
Date: Fri, 6 Sep 2019 09:01:27 +0200
Message-ID: <a861dd9d-8aa3-c084-a850-efba5efa6f87@pengutronix.de>
References: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>
 <9db42086-027f-e096-44d7-6d39b8af94ee@pengutronix.de>
 <E8555824-943E-45B4-A0ED-D42E13156EEC@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8792047006331962315=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <E8555824-943E-45B4-A0ED-D42E13156EEC@geanix.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>
Cc: s.hauer@pengutronix.de, linux-can <linux-can@vger.kernel.org>, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8792047006331962315==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="q523e3DEDk2YYo7dcVYCGwHdFZCMBUvJv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q523e3DEDk2YYo7dcVYCGwHdFZCMBUvJv
Content-Type: multipart/mixed; boundary="a1TTesxWp0zXy6L0ILxW6m8RIkCckApNW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean@geanix.com>
Cc: s.hauer@pengutronix.de, miquel.raynal@bootlin.com,
 linux-mtd@lists.infradead.org, linux-can <linux-can@vger.kernel.org>
Message-ID: <a861dd9d-8aa3-c084-a850-efba5efa6f87@pengutronix.de>
Subject: Re: [Bug] mtd: rawnand: gpmi
References: <6a333d0f-09b2-d0d1-a3a5-955b31b6291e@geanix.com>
 <9db42086-027f-e096-44d7-6d39b8af94ee@pengutronix.de>
 <E8555824-943E-45B4-A0ED-D42E13156EEC@geanix.com>
In-Reply-To: <E8555824-943E-45B4-A0ED-D42E13156EEC@geanix.com>

--a1TTesxWp0zXy6L0ILxW6m8RIkCckApNW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/5/19 10:58 PM, Sean Nyekj=C3=A6r wrote:
> On 5 Sep 2019, at 22.39, Marc Kleine-Budde <mkl@pengutronix.de
> <mailto:mkl@pengutronix.de>> wrote:
>=20
>> On 9/5/19 10:26 PM, Sean Nyekjaer wrote:
>>> I have been troubleshooting some CAN problems on our imx6ull with a r=
aw
>>> nand flash.
>>> I normally run with a 4.19 series kernel, but to verify those CAN
>>> problems have been resolved in newer kernels i have been trying ~5.3-=
rc6.
>>
>> What kind of CAN problem? (Cc +=3D linux-can).

> The deadlock problem when suspending/waking with flexcan...

Oh right, should have looked at your name :)

> This was supposed to fix it:
>=20
> =E2=80=9Ccan: flexcan: fix deadlock when using self wakeup=E2=80=9D
>=20
> But I can=E2=80=99t easily (in my setup) verify it when ubi/nand is fai=
ling :)

Sascha has Maintainer Duties on his todo for today anyways.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--a1TTesxWp0zXy6L0ILxW6m8RIkCckApNW--

--q523e3DEDk2YYo7dcVYCGwHdFZCMBUvJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1yBEcACgkQWsYho5Hk
nSAU2Qf+NxAEwmNL2UIBizdB7BC1gEfkYs9b7YQnAX0s/xCTBm71xi97S30pGGja
VWWTISrD9Sp3BM582I+5/rpjslgDqO0Tn5LL9tTQC6GBUOv+Drjy5F3hcu5Vgcqq
+ZIyTiM6/3eVrA0oXWqvVhrqpXUKprJGx0PVtXT1c6vhOejO1C8ZDNFdFDD5Qx3h
hDLXeLU5e4v6hPelxqNyKZmekqGdhGzYNfKgx3h/8opLegTDn8SuUG08apVEpDGy
l5xEmYCWiogEWLY8XRcEHsiqqjBN79aLGhcMR0Jkh0b6vmAvt1iSZyY7f0t8S2pL
lLljghdmZFPv2Bxhj8rVwD7gafRnTw==
=t8xa
-----END PGP SIGNATURE-----

--q523e3DEDk2YYo7dcVYCGwHdFZCMBUvJv--


--===============8792047006331962315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============8792047006331962315==--
