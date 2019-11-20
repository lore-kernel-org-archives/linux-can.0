From: Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH 0/2] can: xilinx_can: Bug fixes on can driver
Date: Wed, 20 Nov 2019 17:41:03 +0530
Message-ID: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com, Srinivas Neeli <srinivas.neeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

This patch series does the following:
-skip printing error message on deferred probe
-Fix usage of skb memory

Srinivas Neeli (1):
  can: xilinx_can: Fix usage of skb memory

Venkatesh Yadav Abbarapu (1):
  can: xilinx_can: skip error message on deferred probe

 drivers/net/can/xilinx_can.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.7.4
