From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-07-24
Date: Wed, 24 Jul 2019 11:00:24 +0200
Message-ID: <93540cba-184a-a9c5-f9d2-b1779a69a36f@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mcwcQRZcymoRCEPFj9qin1ccxdXCla9Fm"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mcwcQRZcymoRCEPFj9qin1ccxdXCla9Fm
Content-Type: multipart/mixed; boundary="Ny076OquJ5tQUUcfzJ1ODEqRkRFUVdKW8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <93540cba-184a-a9c5-f9d2-b1779a69a36f@pengutronix.de>
Subject: pull-request: can-next 2019-07-24

--Ny076OquJ5tQUUcfzJ1ODEqRkRFUVdKW8
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 26 patches.

The first two patches are by me. One adds missing files of the CAN
subsystem to the MAINTAINERS file, while the other sorts the
Makefile/Kconfig of the sja1000 drivers sub directory. In the next patch
Ji-Ze Hong (Peter Hong) provides a driver for the "Fintek PCIE to 2 CAN"
controller, based on the the sja1000 IP core.

Gustavo A. R. Silva's patch for the kvaser_usb driver introduces the use
of struct_size() instead of open coding it. Henning Colliander's patch
adds a driver for the "Kvaser PCIEcan" devices.

Another patch by Gustavo A. R. Silva marks expected switch fall-throughs
properly.

Dan Murphy provides 5 patches for the m_can. After cleanups a framework
is introduced so that the driver can be used from memory mapped IO as
well as SPI attached devices. Finally he adds a driver for the tcan4x5x
which uses this framework.

A series of 5 patches by Appana Durga Kedareswara rao for the xilinx_can
driver, first clean up,then add support for CANFD. Colin Ian King
contributes another cleanup for the xilinx_can driver.

Robert P. J. Day's patch corrects the brief history of the CAN protocol
given in the Kconfig menu entry.

2 patches by Dong Aisheng for the flexcan driver provide PE clock source
select support and dt-bindings description.
2 patches by Sean Nyekjaer for the flexcan driver provide add CAN
wakeup-source property and dt-bindings description.

Jeroen Hofstee's patch converts the ti_hecc driver to make use of the
rx-offload helper fixing a number of outstanding bugs.

The first patch of Oliver Hartkopp removes the now obsolete empty
ioctl() handler for the CAN protocols. The second patch adds SPDX
license identifiers for CAN subsystem.

regards,
Marc

---

The following changes since commit 3e3bb69589e482e0783f28d4cd1d8e56fda0bc=
bb:

  tc-testing: added tdc tests for [b|p]fifo qdisc (2019-07-23 14:08:15 -0=
700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.4-20190724

for you to fetch changes up to fba76a58452694b9b13c07e48839fa84c75f57af:

  can: Add SPDX license identifiers for CAN subsystem (2019-07-24 10:31:5=
5 +0200)

----------------------------------------------------------------
linux-can-next-for-5.4-20190724

----------------------------------------------------------------
Aisheng Dong (1):
      can: flexcan: implement can Runtime PM

Appana Durga Kedareswara rao (5):
      can: xilinx_can: Fix style issues
      can: xilinx_can: Fix kernel doc warnings
      can: xilinx_can: Fix flags field initialization for axi can and can=
ps
      can: xilinx_can: Add cantype parameter in xcan_devtype_data struct
      can: xilinx_can: Add support for CANFD FD frames

Colin Ian King (1):
      can: xilinx_can: clean up indentation issue

Dan Murphy (5):
      can: m_can: Fix checkpatch issues on existing code
      can: m_can: Create a m_can platform framework
      can: m_can: Rename m_can_priv to m_can_classdev
      dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
      can: tcan4x5x: Add tcan4x5x driver to the kernel

Dong Aisheng (2):
      dt-bindings: can: flexcan: add PE clock source property to device t=
ree
      can: flexcan: add support for PE clock source select

Gustavo A. R. Silva (2):
      can: kvaser_usb: Use struct_size() in alloc_candev()
      can: mark expected switch fall-throughs

Henning Colliander (1):
      can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices

Jeroen Hofstee (1):
      can: ti_hecc: use timestamp based rx-offloading

Ji-Ze Hong (Peter Hong) (1):
      can: sja1000: f81601: add Fintek F81601 support

Marc Kleine-Budde (2):
      MAINTAINERS: can: add missing files to CAN NETWORK DRIVERS and CAN =
NETWORK LAYER
      can: sja1000: Makefile/Kconfig: sort alphabetically

Oliver Hartkopp (2):
      can: remove obsolete empty ioctl() handler
      can: Add SPDX license identifiers for CAN subsystem

Robert P. J. Day (1):
      can: Kconfig: correct history of the CAN protocol

Sean Nyekjaer (2):
      dt-bindings: can: flexcan: add can wakeup property
      can: flexcan: add support for DT property 'wakeup-source'

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   10 +
 .../devicetree/bindings/net/can/tcan4x5x.txt       |   37 +
 MAINTAINERS                                        |    5 +
 drivers/net/can/Kconfig                            |   13 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/at91_can.c                         |    6 +-
 drivers/net/can/flexcan.c                          |  136 +-
 drivers/net/can/kvaser_pciefd.c                    | 1912 ++++++++++++++=
++++++
 drivers/net/can/m_can/Kconfig                      |   22 +-
 drivers/net/can/m_can/Makefile                     |    2 +
 drivers/net/can/m_can/m_can.c                      | 1079 +++++------
 drivers/net/can/m_can/m_can.h                      |  110 ++
 drivers/net/can/m_can/m_can_platform.c             |  202 +++
 drivers/net/can/m_can/tcan4x5x.c                   |  532 ++++++
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |    2 +-
 drivers/net/can/sja1000/Kconfig                    |   79 +-
 drivers/net/can/sja1000/Makefile                   |   11 +-
 drivers/net/can/sja1000/f81601.c                   |  212 +++
 drivers/net/can/spi/mcp251x.c                      |    3 +-
 drivers/net/can/ti_hecc.c                          |  191 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    3 +-
 drivers/net/can/usb/peak_usb/pcan_usb.c            |    2 +-
 drivers/net/can/xilinx_can.c                       |  293 ++-
 include/linux/can/core.h                           |    3 +-
 include/linux/can/skb.h                            |    2 +-
 net/can/Kconfig                                    |   11 +-
 net/can/af_can.c                                   |   10 +-
 net/can/af_can.h                                   |    1 +
 net/can/bcm.c                                      |    3 +-
 net/can/gw.c                                       |    1 +
 net/can/proc.c                                     |    1 +
 net/can/raw.c                                      |    3 +-
 32 files changed, 4098 insertions(+), 800 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.tx=
t
 create mode 100644 drivers/net/can/kvaser_pciefd.c
 create mode 100644 drivers/net/can/m_can/m_can.h
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/tcan4x5x.c
 create mode 100644 drivers/net/can/sja1000/f81601.c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |






--Ny076OquJ5tQUUcfzJ1ODEqRkRFUVdKW8--

--mcwcQRZcymoRCEPFj9qin1ccxdXCla9Fm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl04HigACgkQWsYho5Hk
nSBEdQf/f1itwIrD0OxlTvEXBspSy9dVCFphyt2sWUe3VU5wOd8HD65QzEGJde7I
Ny/BBbyNpeXcyUKtBcCsDGH0IRodm+kxXhdFEb0QiT5UTLXgMvYQSqnIvqx8CwWb
Ux5fGMwv77vqtdVfwGYTpj55gIuB2ufWRZylioq9TEp0AYqE+YWKA3OEAYb0D6MT
FVxorSCqEXi6FxNlslc+OeeyjIP/7NqiIG8bxfxonheZUbkp9uoJo1wzq4cEOgb2
yaOTGb+w3RA5tud5Kj+Rm7rYys6DER5T9z2s/L6R3+DuR3T53iqNRddxZid0M5jo
CYfK5OpmfCetszPH9Pdl7bKo7mn9Mw==
=Wgs/
-----END PGP SIGNATURE-----

--mcwcQRZcymoRCEPFj9qin1ccxdXCla9Fm--
