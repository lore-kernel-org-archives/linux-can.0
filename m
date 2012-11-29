From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can: Kconfig: switch on CAN_RAW by default
Date: Thu, 29 Nov 2012 14:58:09 +0100
Message-ID: <1354197491-31205-4-git-send-email-mkl@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab2K2N6O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:58:14 -0500
In-Reply-To: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

As CAN_RAW is the basic CAN protocol, switch it on by default.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/Kconfig b/net/can/Kconfig
index 0435fc4..c017121 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -20,7 +20,7 @@ if CAN
 
 config CAN_RAW
 	tristate "Raw CAN Protocol (raw access with CAN-ID filtering)"
-	default N
+	default y
 	---help---
 	  The raw CAN protocol option offers access to the CAN bus via
 	  the BSD socket API. You probably want to use the raw socket in
-- 
1.7.10.4

