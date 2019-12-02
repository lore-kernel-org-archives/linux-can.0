From: Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V2 0/2] can: xilinx_can: Bug fixes on can driver
Date: Mon,  2 Dec 2019 18:32:09 +0530
Message-ID: <1575291731-11022-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com, Srinivas Neeli <srinivas.neeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

This patch series does the following:
-skip printing error message on deferred probe
-Fix usage of skb memory
---
Changes in V2:
-Called can_put_echo_skb call after usage of skb memory
---

Srinivas Neeli (1):
  can: xilinx_can: Fix usage of skb memory

Venkatesh Yadav Abbarapu (1):
  can: xilinx_can: skip error message on deferred probe

 drivers/net/can/xilinx_can.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

-- 
2.7.4
