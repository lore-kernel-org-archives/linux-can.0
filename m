From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-08-20
Date: Tue, 20 Aug 2019 19:32:13 +0200
Message-ID: <827b7ab8-f678-d5ce-a0c6-2a4b5f42238d@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ZKmfzWjGv2CJ5wDzG95EOwMiAyo94VoQ9"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZKmfzWjGv2CJ5wDzG95EOwMiAyo94VoQ9
Content-Type: multipart/mixed; boundary="OZT6XtUoTd9MHUaXgwXWvfibvKh3zgDf2";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <827b7ab8-f678-d5ce-a0c6-2a4b5f42238d@pengutronix.de>
Subject: pull-request: can-next 2019-08-20

--OZT6XtUoTd9MHUaXgwXWvfibvKh3zgDf2
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 18 patches.

The first patch is by Geert Uytterhoeven, it removes the unused platform
data support from the rcar_can driver.

A patch by Nishka Dasgupta marks the structure peak_pciec_i2c_bit_ops in
the peak_pci driver as constant.

A patch by me removes the custom DMA support from the hi311x driver.

The next 4 patches target the tcan4x5x driver and are also by me, they
first clean up the driver a bit, and then add missing error handling and
fix a bug in the length calculation in the regmap callbacks.

The next 2 patches are by me for the m_can_platform driver, they also
remove unneeded casts and add missing error handling.

The remaining 9 patches all target the mcp251x driver. The first 5 are
clean up patches by me, the next relaxes the timing in the
mcp251x_hw_reset() function. Alexander Shiyan's patch improves the name
which is used while registering the interrupt handler. Phil Elwell's
patch improves the mcp251x_open() function to use the DT-supplied
interrupt flags instead of hard coding them. The final patch is again by
me, it removes the custom DMA support from the hi311x driver.

Marc

---

The following changes since commit 932630fa902878f4c8c50d0b1260eeb9de16b0=
a4:

  Merge tag 'wireless-drivers-next-for-davem-2019-08-19' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2019-08-19 =
18:32:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.4-20190820

for you to fetch changes up to df58525df395561551440392d92daa6416b4f8f3:

  can: mcp251x: remove custom DMA mapped buffer (2019-08-20 13:41:26 +020=
0)

----------------------------------------------------------------
linux-can-next-for-5.4-20190820

----------------------------------------------------------------
Alexander Shiyan (1):
      can: mcp251x: Use dev_name() during request_threaded_irq()

Geert Uytterhoeven (1):
      can: rcar_can: Remove unused platform data support

Marc Kleine-Budde (14):
      can: hi311x: remove custom DMA mapped buffer
      can: tcan4x5x: remove unused struct tcan4x5x_priv::tcan4x5x_lock
      can: tcan4x5x: remove not needed casts to struct tcan4x5x_priv *
      can: tcan4x5x: tcan4x5x_can_probe(): add missing error handling if =
mcan_class is NULL
      can: tcan4x5x: fix data length in regmap write path
      can: m_can_platform: remove not needed casts to struct m_can_plat_p=
riv *
      can: m_can_platform: m_can_plat_probe(): add missing error handling=
 if mcan_class is NULL
      can: mcp251x: convert block comments to network style comments
      can: mcp251x: remove unnecessary blank lines

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |










--OZT6XtUoTd9MHUaXgwXWvfibvKh3zgDf2--

--ZKmfzWjGv2CJ5wDzG95EOwMiAyo94VoQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1cLp0ACgkQWsYho5Hk
nSCm4QgAhLYwwRBkWcxh9Cgwsc0wsEPJI7a2UgZLZelDl28RkErcESceY4qA+Gs/
2q98SCSWV1fgkCc/ff4KfxDI1EAg51Vta8HBsf7seCR58vHQ6hrnOr6U3/s17txd
+wkjlYusZQkFt0sQkxr9RNKH4dm/LTgN/Xk29EXIVKbKSYdEf/7DugI48H3nAPvO
vRiS6pj8gFpU0yMENU6PCR0kn1wKEckx4frnjp8/elrkAc4WOWLnS5fLHFmbrdhh
2VXFcnQFetx4N1BEhVe6EmPelt1oPyL0F0Kpwba+V9ECzPsQpnBm++vPKheRbobF
j1vw/AOWh0KFxr1+oswsEmk3zKvMZw==
=Zbov
-----END PGP SIGNATURE-----

--ZKmfzWjGv2CJ5wDzG95EOwMiAyo94VoQ9--
