From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2018-11-28
Date: Wed, 28 Nov 2018 17:01:13 +0100
Message-ID: <98eab65a-24c5-aba6-d4f0-746d7758d5ce@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aQ4faIWfdi6O3hiMxxbUsw30zE5QvgN3k"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQ4faIWfdi6O3hiMxxbUsw30zE5QvgN3k
Content-Type: multipart/mixed; boundary="LSsI5BwGk5Z2k2vVMhL5IRwchKiwoCE0R";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <98eab65a-24c5-aba6-d4f0-746d7758d5ce@pengutronix.de>
Subject: pull-request: can-next 2018-11-28

--LSsI5BwGk5Z2k2vVMhL5IRwchKiwoCE0R
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 18 patches.

The first patch is by Colin Ian King and fixes the spelling in the ucan
driver.

The next three patches target the xilinx driver. YueHaibing's patch
fixes the return type of ndo_start_xmit function. Two patches by
Shubhrajyoti Datta add support for the CAN FD 2.0 controllers.

Flavio Suligoi's patch for the sja1000 driver add support for the ASEM
CAN raw hardware.

Wolfram Sang's and Kuninori Morimoto's patches switch the rcar driver to
use SPDX license identifiers.

The remaining 111 patches improve the flexcan driver. Pankaj Bansal's
patch enables the driver in Kconfig on all architectures with IOMEM
support. The next four patches by me fix indention, add missing
parentheses and comments. Aisheng Dong's patches add self wake support
and document it in the DT bindings. The remaining patches by Pankaj
Bansal first fix the loopback support and prepare the driver for the
CAN-FD support needed for the LX2160A SoC. The actual CAN-FD support
will be added in a later patch series.

regards,
Marc

---
The following changes since commit 86d1d8b72caf648e5b14ac274f9afeaab58bba=
e1:

  net/ipv4: Fix missing raw_init when CONFIG_PROC_FS is disabled (2018-11=
-27 20:58:02 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.21-20181128

for you to fetch changes up to 6cbf76028dcac01129211828d62314285231f79e:

  can: flexcan: split the Message Buffer RAM area (2018-11-28 16:52:25 +0=
100)

----------------------------------------------------------------
linux-can-next-for-4.21-20181128

----------------------------------------------------------------
Aisheng Dong (2):
      dt-bindings: can: flexcan: add stop mode property to device tree
      can: flexcan: add self wakeup support

Colin Ian King (1):
      can: ucan: fix spelling mistake: "resumbmitting" -> "resubmitting"

Flavio Suligoi (1):
      can: sja1000: plx_pci: add support for ASEM CAN raw device

Kuninori Morimoto (1):
      can: rcar: add SPDX identifiers to Kconfig and Makefile

Marc Kleine-Budde (4):
      can: flexcan: flexcan_start_xmit(): fix indention
      can: flexcan: flexcan_irq(): fix indention
      can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument
      can: flexcan: flexcan_chip_start(): adjust comment to match the cod=
e

Pankaj Bansal (5):
      can: flexcan: enable flexcan for all architectures
      can: flexcan: flexcan_chip_start(): enable loopback mode in flexcan=

      can: flexcan: move rx_offload_add() from flexcan_probe() to flexcan=
_open()
      can: flexcan: Add provision for variable payload size
      can: flexcan: split the Message Buffer RAM area

Shubhrajyoti Datta (2):
      dt-bindings: can: xilinx_can: add Xilinx CAN FD 2.0 bindings
      can: xilinx: add can 2.0 support

Wolfram Sang (1):
      can: rcar: use SPDX identifier for Renesas drivers

YueHaibing (1):
      can: xilinx: fix return type of ndo_start_xmit function

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   8 +
 .../devicetree/bindings/net/can/xilinx_can.txt     |   1 +
 drivers/net/can/Kconfig                            |   2 +-
 drivers/net/can/flexcan.c                          | 365 +++++++++++++++=
+-----
 drivers/net/can/rcar/Kconfig                       |   1 +
 drivers/net/can/rcar/Makefile                      |   1 +
 drivers/net/can/rcar/rcar_can.c                    |   6 +-
 drivers/net/can/rcar/rcar_canfd.c                  |   6 +-
 drivers/net/can/sja1000/Kconfig                    |   1 +
 drivers/net/can/sja1000/plx_pci.c                  |  65 +++-
 drivers/net/can/usb/ucan.c                         |   2 +-
 drivers/net/can/xilinx_can.c                       |  36 +-
 12 files changed, 402 insertions(+), 92 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--LSsI5BwGk5Z2k2vVMhL5IRwchKiwoCE0R--

--aQ4faIWfdi6O3hiMxxbUsw30zE5QvgN3k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv+u8kACgkQk9IU1zQo
ZfFcLwf/Y406Pxw/oUj4OzpIUjHmBijPVwLcr/Im/d1YRG553l5FCXrDL7Jp7iei
CR8GfraduTfu0y5XTsXUc2cgCzi8omDU+afdoZzTndXDFUvrjHePvQk3J5le33Hq
kV9VURbSt4WrD/o02ipZ4ad5hb0kI6lC3K2uR4Ib64YFFrLsFnnPdHCnSJItZ6Xx
int7lg1DYxPljlvVNLUBLYq1wz7H9wD373P1UwC2mNAwljxytj52MBVmHlvIFJjh
J4/jV2bXqgiYTUD3CKSvlZz6l/4zJLSZdfXVe7PUwEZUGgT1jPin8+yMbK++Dhis
8xGNHplvrjzy1t3hiNE53N1c9QbAUA==
=mIqz
-----END PGP SIGNATURE-----

--aQ4faIWfdi6O3hiMxxbUsw30zE5QvgN3k--
