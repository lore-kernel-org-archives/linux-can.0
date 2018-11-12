From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-11-09
Date: Mon, 12 Nov 2018 12:57:08 +0100
Message-ID: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request of 20 patches for net/master.

First we have a patch by Oliver Hartkopp which changes the raw socket's
raw_sendmsg() to return an error value if the user tries to send a CANFD
frame to a CAN-2.0 device.

The next two patches are by Jimmy Assarsson and fix potential problems
in the kvaser_usb driver.

YueHaibing's patches for the ucan driver fix a compile time warning and
remove a duplicate include.

Eugeniu Rosca patch adds more binding documentation to the rcar_can
driver bindings. The next two patches are by Fabrizio Castro for the
rcar_can driver and fixes a problem in the driver's probe function and
document the r8a774a1 binding.

Lukas Wunner's patch fixes a recpetion problem in hi311x driver by
switching from edge to level triggered interruts.

The next three patches all target the flexcan driver. Pankaj Bansal's
patch unconditionally unlocks the last mailbox used for RX. Alexander
Stein provides a better workaround for a hardware limitation when
sending RTR frames, by using the last mailbox for TX, resulting in fewer
lost frames. The patch by me simplyfies the driver, by making a runtime
value a compile time constant.

The following 4 patches are by me and provide the groundwork for the
next patches by Oleksij Rempel. To avoid code duplication common code in
the common CAN driver infrastructure is factured out and error handling
is cleaned up.

The next 4 patches are by Oleksij Rempel and fix the problem in the
flexcan driver that other processes see TX frames arrive out of order
with ragards to a RX'ed frame (which are send by a different system on
the CAN bus as the result of our TX frame).

regards,
Marc

---

The following changes since commit 85b18b0237ce9986a81a1b9534b5e2ee116f5504:

  net: smsc95xx: Fix MTU range (2018-11-08 19:54:49 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.20-20181109

for you to fetch changes up to d788905f68fd4714c82936f6f7f1d3644d7ae7ef:

  can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*() (2018-11-09 17:33:33 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.20-20181109

----------------------------------------------------------------
Alexander Stein (1):
      can: flexcan: Always use last mailbox for TX

Eugeniu Rosca (1):
      dt-bindings: can: rcar_can: document r8a77965 support

Fabrizio Castro (2):
      can: rcar_can: Fix erroneous registration
      dt-bindings: can: rcar_can: Add r8a774a1 support

Jimmy Assarsson (2):
      can: kvaser_usb: Fix potential uninitialized variable use
      can: kvaser_usb: Fix accessing freed memory in kvaser_usb_start_xmit()

Lukas Wunner (1):
      can: hi311x: Use level-triggered interrupt

Marc Kleine-Budde (5):
      can: flexcan: remove not needed struct flexcan_priv::tx_mb and struct flexcan_priv::tx_mb_idx
      can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb

Oleksij Rempel (4):
      can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_offload_queue_sorted() functions
      can: flexcan: handle tx-complete CAN frames via rx-offload infrastructure
      can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_offload_queue_tail()
      can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*()

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()

Pankaj Bansal (1):
      can: flexcan: Unlock the MB unconditionally

YueHaibing (2):
      can: ucan: remove set but not used variable 'udev'
      can: ucan: remove duplicated include from ucan.c

 .../devicetree/bindings/net/can/holt_hi311x.txt    |   2 +-
 .../devicetree/bindings/net/can/rcar_can.txt       |  28 ++++--
 drivers/net/can/dev.c                              |  48 ++++++---
 drivers/net/can/flexcan.c                          | 108 ++++++++++++---------
 drivers/net/can/rcar/rcar_can.c                    |   5 +-
 drivers/net/can/rx-offload.c                       |  51 +++++++++-
 drivers/net/can/spi/hi311x.c                       |   2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  10 +-
 drivers/net/can/usb/ucan.c                         |   7 --
 include/linux/can/dev.h                            |   1 +
 include/linux/can/rx-offload.h                     |   7 +-
 net/can/raw.c                                      |  15 +--
 13 files changed, 190 insertions(+), 98 deletions(-)
