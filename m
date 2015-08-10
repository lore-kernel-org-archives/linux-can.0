From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] can: at91: move at91_can_data to at91_can.c
Date: Mon, 10 Aug 2015 16:44:54 +0200
Message-ID: <1439217894-15230-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37567 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752341AbbHJOo6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Aug 2015 10:44:58 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

struct at91_can_data is now only used inside the driver, move it to
its c file.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/net/can/at91_can.c          | 5 ++++-
 include/linux/platform_data/atmel.h | 5 -----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 945c0955a967..83ddf4f46f0d 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -33,7 +33,6 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/platform_data/atmel.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -136,6 +135,10 @@ struct at91_devtype_data {
 	enum at91_devtype type;
 };
 
+struct at91_can_data {
+	void (*transceiver_switch)(int on);
+};
+
 struct at91_priv {
 	struct can_priv can;		/* must be the first member! */
 	struct napi_struct napi;
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 4b452c6a2f7b..b99d85f56a7d 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -86,11 +86,6 @@ struct atmel_uart_data {
 	struct serial_rs485	rs485;		/* rs485 settings */
 };
 
-/* CAN */
-struct at91_can_data {
-	void (*transceiver_switch)(int on);
-};
-
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
-- 
2.1.4

