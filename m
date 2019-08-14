From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-08-14
Date: Wed, 14 Aug 2019 08:16:24 +0200
Message-ID: <f0658ccd-389f-fc60-7538-c512112b9978@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tT6upIpksf70DqJYx4HU3tzNJSTM4Bj7e"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tT6upIpksf70DqJYx4HU3tzNJSTM4Bj7e
Content-Type: multipart/mixed; boundary="fzRiYf3JlkZf0FPiKDHpQZU25i5AIWrq9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <f0658ccd-389f-fc60-7538-c512112b9978@pengutronix.de>
Subject: pull-request: can-next 2019-08-14

--fzRiYf3JlkZf0FPiKDHpQZU25i5AIWrq9
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 41 patches.

The first two patches are for the kvaser_pciefd driver: Christer Beskow
removes unnecessary code in the kvaser_pciefd_pwm_stop() function,
YueHaibing removes the unused including of <linux/version.h>.

In the next patch YueHaibing also removes the unused including of
<linux/version.h> in the f81601 driver.

In the ti_hecc driver the next 6 patches are by me and fix checkpatch
warnings. YueHaibing's patch removes an unused variable in the
ti_hecc_mailbox_read() function.

The next 6 patches all target the xilinx_can driver. Anssi Hannula's
patch fixes a chip start failure with an invalid bus. The patch by
Venkatesh Yadav Abbarapu skips an error message in case of a deferred
probe. The 3 patches by Appana Durga Kedareswara rao fix the RX and TX
path for CAN-FD frames. Srinivas Neeli's patch fixes the bit timing
calculations for CAN-FD.

The next 12 patches are by me and several checkpatch warnings in the
af_can, raw and bcm components.

Thomas Gleixner provides a patch for the bcm, which switches the timer
to HRTIMER_MODE_SOFT and removes the hrtimer_tasklet.

Then 6 more patches by me for the gw component, which fix checkpatch
warnings, followed by 2 patches by Oliver Hartkopp to add CAN-FD
support.

The vcan driver gets 3 patches by me, fixing checkpatch warnings.

And finally a patch by Andre Hartmann to fix typos in CAN's netlink
header.

regards,
Marc

---

The following changes since commit 53f6f391786e01bf2050c03d8a36d9defdcc28=
31:

  caif: no need to check return value of debugfs_create functions (2019-0=
8-11 21:31:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.4-20190814

for you to fetch changes up to 3ca3c4aad2efa2931b663acc4ece7a38b31071d1:

  can: netlink: fix documentation typos (2019-08-13 17:32:21 +0200)

----------------------------------------------------------------
linux-can-next-for-5.4-20190814

----------------------------------------------------------------
Andre Hartmann (1):
      can: netlink: fix documentation typos

Anssi Hannula (1):
      can: xilinx_can: xcan_chip_start(): fix failure with invalid bus

Appana Durga Kedareswara rao (3):
      can: xilinx_can: xcanfd_rx(): fix FSR register handling in the RX p=
ath
      can: xilinx_can: fix the data update logic for CANFD FD frames
      can: xilinx_can: xcan_rx_fifo_get_next_frame(): fix FSR register FL=
 and RI mask values for canfd 2.0

Christer Beskow (1):
      can: kvaser_pciefd: kvaser_pciefd_pwm_stop(): remove unnecessary co=
de when setting pwm duty cycle to zero

Marc Kleine-Budde (27):
      can: ti_hecc: convert block comments to network style comments
      can: ti_hecc: fix indention
      can: ti_hecc: avoid long lines
      can: ti_hecc: fix print formating strings
      can: ti_hecc: ti_hecc_start(): avoid multiple assignments
      can: ti_hecc: ti_hecc_mailbox_read(): add blank lines to improve re=
adability
      can: af_can: convert block comments to network style comments
      can: af_can: balance braces around else statements
      can: af_can: fix alignment
      can: af_can: avoid splitting quoted string across lines
      can: af_can: can_pernet_init(): Use preferred style kzalloc(sizeof(=
)) usage
      can: af_can: add missing identifiers to struct receiver::func
      can: raw: convert block comments to network style comments
      can: raw: remove unnecessary blank lines, add suggested blank lines=

      can: raw: balance braces around else statements
      can: raw: raw_module_init(): use pr_err() instead of printk(KERN_ER=
R, ...)
      can: raw: raw_sock_no_ioctlcmd(): mark function as static
      can: bcm: bcm_sock_no_ioctlcmd(): mark function as static
      can: gw: convert block comments to network style comments
      can: gw: remove unnecessary blank lines, add suggested blank lines
      can: gw: add missing spaces around operators
      can: gw: can_can_gw_rcv(): remove return at end of void function
      can: gw: cgw_dump_jobs(): avoid long lines
      can: gw: cgw_parse_attr(): remove unnecessary braces for single sta=
tement block
      can: vcan: convert block comments to network style comments
      can: vcan: remove unnecessary blank lines
      can: vcan: introduce pr_fmt and make use of it

Oliver Hartkopp (2):
      can: gw: use struct canfd_frame as internal data structure
      can: gw: add support for CAN FD frames

Srinivas Neeli (1):
      can: xilinx_can: xcan_set_bittiming(): fix the data phase btr1 calc=
ulation

Thomas Gleixner (1):
      can: bcm: switch timer to HRTIMER_MODE_SOFT and remove hrtimer_task=
let

Venkatesh Yadav Abbarapu (1):
      can: xilinx_can: xcan_probe(): skip error message on deferred probe=


YueHaibing (3):
      can: kvaser_pciefd: Remove unused including <linux/version.h>
      can: sja1000: f81601: remove unused including <linux/version.h>
      can: ti_hecc: ti_hecc_mailbox_read(): remove set but not used varia=
ble 'mbx_mask'

 drivers/net/can/kvaser_pciefd.c  |  11 +-
 drivers/net/can/sja1000/f81601.c |   1 -
 drivers/net/can/ti_hecc.c        |  85 ++++---
 drivers/net/can/vcan.c           |  19 +-
 drivers/net/can/xilinx_can.c     | 175 ++++++--------
 include/uapi/linux/can/gw.h      |  17 +-
 include/uapi/linux/can/netlink.h |   6 +-
 net/can/af_can.c                 |  89 +++----
 net/can/af_can.h                 |   5 +-
 net/can/bcm.c                    | 160 +++++-------
 net/can/gw.c                     | 510 +++++++++++++++++++++++++--------=
------
 net/can/raw.c                    |  34 ++-
 12 files changed, 579 insertions(+), 533 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |








--fzRiYf3JlkZf0FPiKDHpQZU25i5AIWrq9--

--tT6upIpksf70DqJYx4HU3tzNJSTM4Bj7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1TpzgACgkQWsYho5Hk
nSA51Qf/ZNawLD88769eVybOvf28da4wye9OwAvplgBDGZCuNN0bFyBEOwVeSVgY
jjLPhs3enYDyLHoNTrxuPD0/w1jlc9AbIDtm6qWJSy2VkRvq79s0pXgSXCOxAogT
4mVsry61S59rcJLhj9BGsAxSbBSruAW0VDtl3n7PU3bijft3YkW9tbOPp7ajYcsB
85uaBEjFupR3Zf8ILvb8khZUemc7bV7PiulBdDiFv6VFFLUuKptzcv1WQgyJcixN
PKche9NAmqdjpwVYBMSQ4I9jEFl9kjwJB9AMof36QCUu/FcZZamD9J1EPN6Rwpu9
zrb4qi7HA/rSpc2H6JsSQqdBSlZYvA==
=Jm2o
-----END PGP SIGNATURE-----

--tT6upIpksf70DqJYx4HU3tzNJSTM4Bj7e--
