From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-07-24
Date: Wed, 24 Jul 2019 15:03:15 +0200
Message-ID: <20190724130322.31702-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull reqeust of 7 patches for net/master.

The first patch is by Rasmus Villemoes add a missing netif_carrier_off() to
register_candev() so that generic netdev trigger based LEDs are initially off.

Nikita Yushchenko's patch for the rcar_canfd driver fixes a possible IRQ storm
on high load.

The patch by Weitao Hou for the mcp251x driver add missing error checking to
the work queue allocation.

Both Wen Yang's and Joakim Zhang's patch for the flexcan driver fix a problem
with the stop-mode.

Stephane Grosjean contributes a patch for the peak_usb driver to fix a
potential double kfree_skb().

The last patch is by YueHaibing and fixes the error path in can-gw's
cgw_module_init() function.

regards,
Marc

---

The following changes since commit d86afb89305de205b0d2f20c2160adf039e9508d:

  net: thunderx: Use fwnode_get_mac_address() (2019-07-23 14:09:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.3-20190724

for you to fetch changes up to b7a14297f102b6e2ce6f16feffebbb9bde1e9b55:

  can: gw: Fix error path of cgw_module_init (2019-07-24 11:19:03 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.3-20190724

----------------------------------------------------------------
Joakim Zhang (1):
      can: flexcan: fix stop mode acknowledgment

Nikita Yushchenko (1):
      can: rcar_canfd: fix possible IRQ storm on high load

Rasmus Villemoes (1):
      can: dev: call netif_carrier_off() in register_candev()

Stephane Grosjean (1):
      can: peak_usb: fix potential double kfree_skb()

Weitao Hou (1):
      can: mcp251x: add error check when wq alloc failed

Wen Yang (1):
      can: flexcan: fix an use-after-free in flexcan_setup_stop_mode()

YueHaibing (1):
      can: gw: Fix error path of cgw_module_init

 drivers/net/can/dev.c                        |  2 ++
 drivers/net/can/flexcan.c                    | 39 ++++++++++++++++++----
 drivers/net/can/rcar/rcar_canfd.c            |  9 ++---
 drivers/net/can/spi/mcp251x.c                | 49 +++++++++++++---------------
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  8 ++---
 net/can/gw.c                                 | 48 ++++++++++++++++++---------
 6 files changed, 98 insertions(+), 57 deletions(-)
