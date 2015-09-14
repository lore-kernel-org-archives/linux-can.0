From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH v6 2/3] can: Allwinner A10/A20 CAN Controller support - Defconfigs
Date: Mon, 14 Sep 2015 14:54:58 +0200
Message-ID: <1442235299-5885-3-git-send-email-info@gerhard-bertelsmann.de>
References: <1442235299-5885-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:55394 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbbINMzL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Sep 2015 08:55:11 -0400
In-Reply-To: <1442235299-5885-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, maxime.ripard@free-electrons.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---

 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/sunxi_defconfig                   |   2 +
 2 files changed, 3 insertions(+)


diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7f..14eb6b9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -153,6 +153,7 @@ CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
+CONFIG_CAN_SUN4I=y
 CONFIG_BT=m
 CONFIG_BT_MRVL=m
 CONFIG_BT_MRVL_SDIO=m
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 51eea22..fe020a5 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -31,6 +31,8 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
+CONFIG_CAN=y
+CONFIG_CAN_SUN4I=y
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
