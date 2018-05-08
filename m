From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2018-05-08
Date: Tue,  8 May 2018 11:28:24 +0200
Message-ID: <20180508092831.28247-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request for 7 patches for net/master.

The first patch is by Jakob Unterwurzacher and increases the severity of
bus-off messages in the generic CAN device infrastructure. The next two patches
are by Uwe Kleine-König and fix the endianess detection in the flexcan driver.
Jimmy Assarsson's patch for the kvaser driver corrects the stats counter for
dropped tx-messages. Geert Uytterhoeven provides one patch and Sergei Shtylyov
two patches for the rcan_canfd device tree binding description.

regards,
Marc

---

The following changes since commit 2c5d5b13c6eb79f5677e206b8aad59b3a2097f60:

  llc: better deal with too small mtu (2018-05-08 00:11:40 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.17-20180508

for you to fetch changes up to 7a25ac2f71a409e77dd5c85cf3cbe1cbf2ae77f3:

  DT: net: can: rcar_canfd: document R8A77980 bindings (2018-05-08 10:41:38 +0200)

----------------------------------------------------------------
linux-can-fixes-for-4.17-20180508

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: can: rcar_can: Fix R8A7796 SoC name

Jakob Unterwurzacher (1):
      can: dev: increase bus-off message severity

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Sergei Shtylyov (2):
      DT: net: can: rcar_canfd: document R8A77970 bindings
      DT: net: can: rcar_canfd: document R8A77980 bindings

Uwe Kleine-König (2):
      can: flexcan: fix endianess detection
      arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25's flexcan

 .../devicetree/bindings/net/can/rcar_canfd.txt     |  4 +++-
 arch/arm/boot/dts/imx35.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                       |  4 ++--
 drivers/net/can/dev.c                              |  2 +-
 drivers/net/can/flexcan.c                          | 26 ++++++++++++----------
 drivers/net/can/usb/kvaser_usb.c                   |  2 +-
 6 files changed, 23 insertions(+), 19 deletions(-)
