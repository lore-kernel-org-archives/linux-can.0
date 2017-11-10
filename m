From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can 2017-11-10
Date: Fri, 10 Nov 2017 14:07:26 +0100
Message-ID: <20171110130730.6662-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hello David,

this is a pull request for net/master.

The first patch by Richard Schütz for the c_can driver removes the false
indication to support triple sampling for d_can. Gerhard Bertelsmann's
patch for the sun4i driver improves the RX overrun handling. The patch
by Stephane Grosjean for the peak_canfd driver adds the PCI ids for
various new PCIe/M2 interfaces. Marek Vasut's patch for the ifi driver
fix transmitter delay calculation.

regards,
Marc

---

The following changes since commit 1cb483a5cc84b497afb51a6c5dfb5a38a0b67086:

  rds: ib: Fix NULL pointer dereference in debug code (2017-11-10 14:54:47 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.14-20171110

for you to fetch changes up to 4f7116757b4bd99e4ef2636c7d957a6d63035d11:

  can: ifi: Fix transmitter delay calculation (2017-11-10 11:35:09 +0100)

----------------------------------------------------------------
linux-can-fixes-for-4.14-20171110

----------------------------------------------------------------
Gerhard Bertelsmann (1):
      can: sun4i: handle overrun in RX FIFO

Marek Vasut (1):
      can: ifi: Fix transmitter delay calculation

Richard Schütz (1):
      can: c_can: don't indicate triple sampling support for D_CAN

Stephane Grosjean (1):
      can: peak: Add support for new PCIe/M2 CAN FD interfaces

 drivers/net/can/c_can/c_can_pci.c             |  1 -
 drivers/net/can/c_can/c_can_platform.c        |  1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  6 +++---
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 14 ++++++++++++--
 drivers/net/can/sun4i_can.c                   | 12 ++++++++++--
 5 files changed, 25 insertions(+), 9 deletions(-)
