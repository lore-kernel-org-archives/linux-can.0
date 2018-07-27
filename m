From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2018-01-16
Date: Fri, 27 Jul 2018 11:40:10 +0200
Message-ID: <60b8c42f-5c0b-d953-bdae-e83c01b408c4@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HyuAbGgzOcKGlz0G03gg6qkhw285cCi3E"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HyuAbGgzOcKGlz0G03gg6qkhw285cCi3E
Content-Type: multipart/mixed; boundary="2fD5r0LZkenxN4AmkdDRX3uDpqc3EJY4R";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <60b8c42f-5c0b-d953-bdae-e83c01b408c4@pengutronix.de>
Subject: pull-request: can-next 2018-01-16

--2fD5r0LZkenxN4AmkdDRX3uDpqc3EJY4R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 38 patches.

Dan Murphy's patch fixes the path to a file in the comment of the CAN
Error Message Frame Mask structure.

A patch by Colin Ian King fixes a typo in the cc770 driver.

The next patch is by me an sorts the Kconfigand Makefile entries of the
CAN-USB driver subdir alphabetically.

The patch by Jakob Unterwurzacher adds support for the UCAN USB-CAN
adapter.

YueHaibing's patch replaces a open coded skb_put()+memset() by
skb_put_zero() in the CAN-dev infrastructure.

Zhu Yi provides a patch to enable multi-queue CAN devices.

Three patches by Luc Van Oostenryck fix the return value of several
driver's xmit function, I contribute a patch for the a fourth driver.

Fabio Estevam's patch switches the flexcan driver to SPDX identifier.

Two patches by Jia-Ju Bai replace the mdelay() by a usleep_range() in
the sja1000 drivers.

The next 6 patches are by Anssi Hannula and refactor the xilinx CAN
driver and add support for the xilinx CAN FD core.

A patch by Gustavo A. R. Silva adds fallthrough annotation to the
peak_usb driver.

5 patches by Stephane Grosjean for the peak CANFD driver do some
cleanups and provide more improvements for further firmware releases.

The remaining 13 patches are by Jimmy Assarsson and the first clean up
the kvaser_usb driver, so that the later patches add support for the
Kvaser USB hydra family.

regards,
Marc

---

The following changes since commit ecbcd689d74a394b711d2360aef7e5d007ec9d=
98:

  Merge tag 'mlx5e-updates-2018-07-26' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/saeed/linux (2018-07-26 21:33:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.19-20180727

for you to fetch changes up to 1f6ed42c742e8d1cfd3811ef7a134eaa75a511d6:

  can: kvaser_usb: Simplify struct kvaser_cmd_cardinfo (2018-07-27 10:40:=
19 +0200)

----------------------------------------------------------------
linux-can-next-for-4.19-20180727

----------------------------------------------------------------
Anssi Hannula (6):
      can: xilinx_can: only report warning and passive states on state ch=
anges
      can: xilinx_can: use can_change_state()
      can: xilinx_can: update stats.tx_bytes after transmission
      dt-bindings: can: xilinx_can: add Xilinx CAN FD bindings
      can: xilinx_can: refactor code in preparation for CAN FD support
      can: xilinx_can: add support for Xilinx CAN FD core

Colin Ian King (1):
      can: cc770: fix spelling mistake: "comptibility" -> "compatibility"=


Dan Murphy (1):
      can: uapi: can.h: Fix can error class mask dir path

Fabio Estevam (1):
      can: flexcan: Switch to SPDX identifier

Gustavo A. R. Silva (1):
      can: peak_usb: mark expected switch fall-throughs

Jakob Unterwurzacher (1):
      can: ucan: add driver for Theobroma Systems UCAN devices

Jia-Ju Bai (2):
      can: sja1000: Replace mdelay with usleep_range in peak_pci_probe
      can: sja1000: Replace mdelay with usleep_range in pcan_add_channels=


Jimmy Assarsson (13):
      can: kvaser_usb: Remove unnecessary return
      can: kvaser_usb: Remove unused commands and defines
      can: kvaser_usb: Rename message/msg to command/cmd
      can: kvaser_usb: Replace USB timeout constants with one define
      can: kvaser_usb: Add pointer to struct usb_interface into struct kv=
aser_usb
      can: kvaser_usb: Refactor kvaser_usb_get_endpoints()
      can: kvaser_usb: Refactor kvaser_usb_init_one()
      can: kvaser_usb: Improve logging messages
      can: kvaser_usb: Fix typos
      can: kvaser_usb: Add SPDX GPL-2.0 license identifier
      can: kvaser_usb: Split driver into kvaser_usb_core.c and kvaser_usb=
_leaf.c
      can: kvaser_usb: Add support for Kvaser USB hydra family
      can: kvaser_usb: Simplify struct kvaser_cmd_cardinfo

Luc Van Oostenryck (3):
      can: janz-ican3: fix ican3_xmit()'s return type
      can: sun4i: fix sun4ican_start_xmit()'s return type
      can: xilinx: fix xcan_start_xmit()'s return type

Marc Kleine-Budde (2):
      can: usb: Kconfig/Makefile: sort alphabetically
      can: flexcan: fix flexcan_start_xmit()'s return type

Stephane Grosjean (5):
      can: peak_canfd: improves 32-bit alignment
      can: peak_canfd: remove useless defined symbols
      can: peak_canfd: use ndev irq instead of pci_dev one
      can: peak_canfd: fix typo in error message
      can: peak_canfd: rearrange the way resources are released

YueHaibing (1):
      can: dev: use skb_put_zero to simplfy code

Zhu Yi (1):
      can: dev: enable multi-queue for SocketCAN devices

 .../devicetree/bindings/net/can/xilinx_can.txt     |   35 +-
 Documentation/networking/can_ucan_protocol.rst     |  332 ++++
 Documentation/networking/index.rst                 |    1 +
 drivers/net/can/cc770/cc770.c                      |    2 +-
 drivers/net/can/dev.c                              |   14 +-
 drivers/net/can/flexcan.c                          |   33 +-
 drivers/net/can/janz-ican3.c                       |    2 +-
 drivers/net/can/peak_canfd/peak_canfd.c            |    2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c      |   20 +-
 drivers/net/can/sja1000/peak_pci.c                 |    2 +-
 drivers/net/can/sja1000/peak_pcmcia.c              |    2 +-
 drivers/net/can/sun4i_can.c                        |    2 +-
 drivers/net/can/usb/Kconfig                        |   48 +-
 drivers/net/can/usb/Makefile                       |    7 +-
 drivers/net/can/usb/kvaser_usb.c                   | 2085 --------------=
------
 drivers/net/can/usb/kvaser_usb/Makefile            |    2 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h        |  188 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  835 ++++++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  | 2028 ++++++++++++++=
+++++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 1358 +++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb.c            |    1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |    1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |    2 +
 drivers/net/can/usb/ucan.c                         | 1613 ++++++++++++++=
+
 drivers/net/can/xilinx_can.c                       |  512 +++--
 include/linux/can/dev.h                            |    7 +-
 include/uapi/linux/can.h                           |    2 +-
 27 files changed, 6841 insertions(+), 2295 deletions(-)
 create mode 100644 Documentation/networking/can_ucan_protocol.rst
 delete mode 100644 drivers/net/can/usb/kvaser_usb.c
 create mode 100644 drivers/net/can/usb/kvaser_usb/Makefile
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb.h
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
 create mode 100644 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
 create mode 100644 drivers/net/can/usb/ucan.c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2fD5r0LZkenxN4AmkdDRX3uDpqc3EJY4R--

--HyuAbGgzOcKGlz0G03gg6qkhw285cCi3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlta6HoACgkQk9IU1zQo
ZfFK9Af/QeQf5iBxUMNXUBwysRnU6Isw+olfsK3XQPDB8PVEnMzb4wTt6wTCL0+f
1HJeqvZgdsIjGJJ81rJC0Jx8fb6sgCulObiO81JA/h8S+liHtmKyLrqzP2XEABAS
5ycwFHEDj2R0vPkM2tQFnpdezROuttzlGSgZvcugp5eoUBB40aNOL5DGoiYPY6Xn
cHaVZoawmGpAOlLAzNmRgpLaWXZECi16MWhU+dseqGHQpBNi3pHHz6x3L02tRCJe
4OkwoR08YZnxyw2HhpUPd7fXmwZ2cPSft5EU2qP9+n8Eswrqdy8B6JkcqWAWnx9R
AMN8M717qlOvSYSXZ8ThTB27f6/QiQ==
=0fse
-----END PGP SIGNATURE-----

--HyuAbGgzOcKGlz0G03gg6qkhw285cCi3E--
