From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2019-06-07
Date: Fri,  7 Jun 2019 23:15:32 +0200
Message-ID: <20190607211541.16095-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull reqeust of 9 patches for net/master.

The first patch is by Alexander Dahl and removes a duplicate menu entry from
the Kconfig. The next patch by Joakim Zhang fixes the timeout in the flexcan
driver when setting small bit rates. Anssi Hannula's patch for the xilinx_can
driver fixes the bittiming_const for CAN FD core. The two patches by Sean
Nyekjaer bring mcp25625 to the existing mcp251x driver. The patch by Eugen
Hristev implements an errata for the m_can driver. YueHaibing's patch fixes the
error handling ing can_init(). The patch by Fabio Estevam for the flexcan
driver removes an unneeded registration message during flexcan_probe(). And the
last patch is by Willem de Bruijn and adds the missing purging the  socket
error queue on sock destruct.

regards,
Marc

---

The following changes since commit c7e3c93abbc1382923c7f4fe5ba9ea6aa0fa8d0e:

  Merge tag 'wireless-drivers-for-davem-2019-06-07' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers (2019-06-07 12:16:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.2-20190607

for you to fetch changes up to fd704bd5ee749d560e86c4f1fd2ef486d8abf7cf:

  can: purge socket error queue on sock destruct (2019-06-07 23:03:54 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.2-20190607

----------------------------------------------------------------
Alexander Dahl (1):
      can: usb: Kconfig: Remove duplicate menu entry

Anssi Hannula (1):
      can: xilinx_can: use correct bittiming_const for CAN FD core

Eugen Hristev (1):
      can: m_can: implement errata "Needless activation of MRAF irq"

Fabio Estevam (1):
      can: flexcan: Remove unneeded registration message

Joakim Zhang (1):
      can: flexcan: fix timeout when set small bitrate

Sean Nyekjaer (2):
      dt-bindings: can: mcp251x: add mcp25625 support
      can: mcp251x: add support for mcp25625

Willem de Bruijn (1):
      can: purge socket error queue on sock destruct

YueHaibing (1):
      can: af_can: Fix error path of can_init()

 .../bindings/net/can/microchip,mcp251x.txt         |  1 +
 drivers/net/can/flexcan.c                          |  5 +----
 drivers/net/can/m_can/m_can.c                      | 21 ++++++++++++++++++
 drivers/net/can/spi/Kconfig                        |  5 +++--
 drivers/net/can/spi/mcp251x.c                      | 25 ++++++++++++++--------
 drivers/net/can/usb/Kconfig                        |  6 ------
 drivers/net/can/xilinx_can.c                       |  2 +-
 net/can/af_can.c                                   | 25 +++++++++++++++++++---
 8 files changed, 65 insertions(+), 25 deletions(-)
