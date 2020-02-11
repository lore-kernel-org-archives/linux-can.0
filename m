From: Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH] can: mcp25xxfd: minor register definition fixes
Date: Tue, 11 Feb 2020 13:04:46 +0100
Message-ID: <20200211120446.1390-1-thomas.kopp@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:25352 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBKMEv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2020 07:04:51 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, thomas.kopp@microchip.com

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
Hi Marc,
I started testing your driver at https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/drivers/net/can/spi/mcp25xxfd?h=v5.4/mcp25xxfd and noticed two small things in the register definitions. Overall TX seems to be working fine - one thing I noticed when testing with cangen can0 -b -g 0 and another external node periodically sending frames on the bus (with 2ms gaps) I'm eventually getting stuffing errors from which the driver never really recovers. As soon as the external node then stops sending messages, the MCP2518FD node stops sending as well and gets unresponsive (ssh isn't possible anymore etc.). When resuming the external CAN traffic the node becomes responsive again. The driver was compiled with Additional Debugging output and Logging enabled. Ifconfig doesn't s
 how any RX/TX errors and shows plausible numbers for packets transmitted/received. Am I chasing ghosts here or have you encountered similar behaviour?
Best Regards,
Thomas

 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
index 6bf211673d0e..13af06d7fd67 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
@@ -94,7 +94,7 @@ static inline void __dump(const void *d, unsigned int len)
 #define MCP25XXFD_CAN_TDC 0x0c
 #define MCP25XXFD_CAN_TDC_EDGFLTEN BIT(25)
 #define MCP25XXFD_CAN_TDC_SID11EN BIT(24)
-#define MCP25XXFD_CAN_TDC_TDCMOD_MASK GENMASK(17, 6)
+#define MCP25XXFD_CAN_TDC_TDCMOD_MASK GENMASK(17, 16)
 #define MCP25XXFD_CAN_TDC_TDCMOD_AUTO 2
 #define MCP25XXFD_CAN_TDC_TDCMOD_MANUAL 1
 #define MCP25XXFD_CAN_TDC_TDCMOD_DISABLED 0
@@ -304,7 +304,7 @@ static inline void __dump(const void *d, unsigned int len)
 #define MCP25XXFD_CAN_FLTOBJ(x) (0x1f0 + 8 * (x))
 #define MCP25XXFD_CAN_FLTOBJ_EXIDE BIT(30)
 #define MCP25XXFD_CAN_FLTOBJ_SID11 BIT(29)
-#define MCP25XXFD_CAN_FLTOBJ_EID_MASK GENMASK(28. 11)
+#define MCP25XXFD_CAN_FLTOBJ_EID_MASK GENMASK(28, 11)
 #define MCP25XXFD_CAN_FLTOBJ_SID_MASK GENMASK(10, 0)
 
 #define MCP25XXFD_CAN_FLTMASK(x) (0x1f4 + 8 * (x))
-- 
2.17.1
