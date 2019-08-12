From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 0/5] can: xilinx_can: Bug fixes
Date: Mon, 12 Aug 2019 15:36:41 +0530
Message-ID: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

This patch series fixes below issues
--> Bugs in the driver w.r.to CANFD 2.0 IP support
--> Defer the probe if clock is not found

Changes for v2:
[1/5]:
--> Improved commit description
[1/5] and [5/5]:
--> Added sob line
[1/5], [2/5], [3/5], [4/5], [5/5]:
--> Added Fixes tag in the commit description

Appana Durga Kedareswara rao (3):
  can: xilinx_can: Fix FSR register handling in the rx path
  can: xilinx_can: Fix the data updation logic for CANFD FD frames
  can: xilinx_can: Fix FSR register FL and RI mask values for canfd 2.0

Srinivas Neeli (1):
  can: xilinx_can: Fix the data phase btr1 calculation

Venkatesh Yadav Abbarapu (1):
  can: xilinx_can: Skip error message on deferred probe

 drivers/net/can/xilinx_can.c | 162 +++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 90 deletions(-)

-- 
2.7.4
