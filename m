From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Date: Mon, 18 Mar 2019 17:02:40 +0530
Message-ID: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

This patch series does the below
--> Added support for CANFD FD frames
--> Fix Checkpatch reported warnings and checks

Appana Durga Kedareswara rao (6):
  net: can: xilinx_can: Fix style issues
  net: can: xilinx_can: Fix flags field initialization for axi can and
    canps
  net: can: xilinx_can: Add cantype parameter in xcan_devtype_data
    struct
  net: can: xilinx_can: Add support for CANFD FD frames
  net: can: xilinx_can: Add SPDX license
  net: can: xilinx_can: Fix kernel doc warnings

 drivers/net/can/xilinx_can.c | 303 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 257 insertions(+), 46 deletions(-)

-- 
2.7.4
