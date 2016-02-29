From: Marek Vasut <marex@denx.de>
Subject: [PATCH 0/4] Synchronise IFI CANFD driver with real world
Date: Mon, 29 Feb 2016 20:59:27 +0100
Message-ID: <1456775971-4946-1-git-send-email-marex@denx.de>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

Thus far, this driver was only tested on a hardware synthesised in
the warm and safe insides of an FPGA, only against another IFI CANFD
core. The real hardware arrived now and I tested the IFI CANFD driver
against different, harsh, real-world CAN controller.

This uncovered a few bugs, so here are the fixes for those.

Marek Vasut (4):
  net: can: ifi: Fix clock generator configuration
  net: can: ifi: Fix TX DLC configuration
  net: can: ifi: Fix RX and TX ID mask
  net: can: ifi: Add obscure bit swap for EFF frame IDs

 drivers/net/can/ifi_canfd/ifi_canfd.c | 83 ++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 25 deletions(-)

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>

-- 
2.7.0
