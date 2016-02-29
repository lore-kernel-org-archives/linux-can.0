From: Marek Vasut <marex@denx.de>
Subject: [PATCH 3/4] net: can: ifi: Fix RX and TX ID mask
Date: Mon, 29 Feb 2016 20:59:30 +0100
Message-ID: <1456775971-4946-4-git-send-email-marex@denx.de>
References: <1456775971-4946-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42617 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbcB2T7p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Feb 2016 14:59:45 -0500
In-Reply-To: <1456775971-4946-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

The RX and TX ID mask for CAN2.0 is 11 bits wide. This patch fixes
the incorrect mask, which caused the CAN IDs to miss the MSBit both
on receive and transmit.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 82a33bd..6704098 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -135,7 +135,7 @@
 
 #define IFI_CANFD_RXFIFO_ID			0x6c
 #define IFI_CANFD_RXFIFO_ID_ID_OFFSET		0
-#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		0x3ff
+#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		0x7ff
 #define IFI_CANFD_RXFIFO_ID_ID_XTD_MASK		0x1fffffff
 #define IFI_CANFD_RXFIFO_ID_IDE			BIT(29)
 
@@ -156,7 +156,7 @@
 
 #define IFI_CANFD_TXFIFO_ID			0xbc
 #define IFI_CANFD_TXFIFO_ID_ID_OFFSET		0
-#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		0x3ff
+#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		0x7ff
 #define IFI_CANFD_TXFIFO_ID_ID_XTD_MASK		0x1fffffff
 #define IFI_CANFD_TXFIFO_ID_IDE			BIT(29)
 
-- 
2.7.0

