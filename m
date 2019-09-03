From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-09-03
Date: Tue, 3 Sep 2019 11:46:31 +0200
Message-ID: <a6751a50-f15d-612d-783b-a706098ea90e@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vaDxWTXAQZUBmXN3l4EPTj0zWvk0zWOIh"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vaDxWTXAQZUBmXN3l4EPTj0zWvk0zWOIh
Content-Type: multipart/mixed; boundary="umTbpMyEde8J6VOsRiiHQD4IMgq6CRYyh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <a6751a50-f15d-612d-783b-a706098ea90e@pengutronix.de>
Subject: pull-request: can-next 2019-09-03

--umTbpMyEde8J6VOsRiiHQD4IMgq6CRYyh
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 15 patches.

The first patch is by Christer Beskow, targets the kvaser_pciefd driver
and fixes the PWM generator's frequency.

The next three patches are by Dan Murphy, the tcan4x5x is updated to use
a proper interrupts/interrupt-parent DT binding to specify the devices
IRQ line. Further the unneeded wake ups of the device is removed from
the driver.

A patch by me for the mcp25xx driver removes the deprecated board file
setup example. Three patches by Andy Shevchenko simplify clock handling,
update the driver from OF to device property API and simplify the
mcp251x_can_suspend() function.

The remaining 7 patches are by me and clean up checkpatch warnings in
the generic CAN device infrastructure.

regards,
Marc

---

The following changes since commit 67538eb5c00f08d7fe27f1bb703098b17302bd=
c0:

  Merge branch 'mvpp2-per-cpu-buffers' (2019-09-02 12:07:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.4-20190903

for you to fetch changes up to 13ecee77fa810b21beaf3023e921525c55f88b04:

  can: dev: can_dev_init(): convert from printk(KERN_INFO) to pr_info (20=
19-09-03 10:28:13 +0200)

----------------------------------------------------------------
linux-can-next-for-5.4-20190903

----------------------------------------------------------------
Andy Shevchenko (3):
      can: mcp251x: Use devm_clk_get_optional() to get the input clock
      can: mcp251x: Make use of device property API
      can: mcp251x: Call wrapper instead of regulator_disable()

Christer Beskow (1):
      can: kvaser_pciefd: the PWM generator is running at the bus frequen=
cy of the system.

Dan Murphy (3):
      dt-bindings: can: tcan4x5x: Update binding to use interrupt propert=
y
      can: tcan4x5x: Remove data-ready gpio interrupt
      can: tcan4x5x: Remove checking the wake pin

Marc Kleine-Budde (8):
      can: mcp251x: remove deprecated board file setup example
      can: dev: convert block comments to network style comments
      can: dev: avoid long lines
      can: dev: remove unnecessary parentheses
      can: dev: remove unnecessary blank line
      can: dev: can_restart(): convert NULL pointer check
      can: dev: can_dellink(): remove return at end of void function
      can: dev: can_dev_init(): convert from printk(KERN_INFO) to pr_info=


 .../devicetree/bindings/net/can/tcan4x5x.txt       |   7 +-
 drivers/net/can/dev.c                              | 131 +++++++++------=
------
 drivers/net/can/kvaser_pciefd.c                    |   6 +-
 drivers/net/can/m_can/tcan4x5x.c                   |  24 +---
 drivers/net/can/spi/mcp251x.c                      |  68 +++--------
 include/linux/can/dev.h                            |   3 +-
 include/linux/can/rx-offload.h                     |  13 +-
 7 files changed, 97 insertions(+), 155 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |












--umTbpMyEde8J6VOsRiiHQD4IMgq6CRYyh--

--vaDxWTXAQZUBmXN3l4EPTj0zWvk0zWOIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1uNncACgkQWsYho5Hk
nSAXAgf+M4Tbgs1aNVymcDBEGZAU/P8w0MKYV70ebTbXE8CGG6H8aepP7Lh7fKwH
AvqbhN+7QrBoK8wcaQFdggFzf7saWUCF+1lVsjIXPRXyenW7Lhq7xFMBocMf8+z4
gKQlWcxkZVrVaF+pYeSzQTE8CF8e7KWWBMwSUPj9FkETj3ltqs5dOBWHnqClqHVL
bM50Va7h6Q1ysJgwFf9/25Nvl8VVcasD3xZ1GdH3i4ZOyTeE6sR/uSoEXe1r/8Rb
GXGpayZIL1v2pkMWxbC+euOUCxFyMM8AFbuivI0tKxE7FIYuftd21o7k2VzyzveK
Wp+2BSYHMUPRhUJnAGltGLhPjJBkhA==
=qTle
-----END PGP SIGNATURE-----

--vaDxWTXAQZUBmXN3l4EPTj0zWvk0zWOIh--
