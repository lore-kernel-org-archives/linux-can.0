From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] can: at91_can: Fix Kconfig dependencies
Date: Tue, 6 May 2014 10:19:15 +0200
Message-ID: <20140506101915.649e86ce@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58337 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934235AbaEFITT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 May 2014 04:19:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

The at91_can driver is AT91-specific so it should depend on ARCH_AT91
rather than just ARM. Add COMPILE_TEST as an alternative, so that the
driver can still be build-tested elsewhere.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
Note: the COMPILE_TEST might need additional dependencies, I'm not
sure... Builds fine on x86_64.

 drivers/net/can/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc4.orig/drivers/net/can/Kconfig	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.15-rc4/drivers/net/can/Kconfig	2014-05-06 09:27:49.552401940 +0200
@@ -65,7 +65,7 @@ config CAN_LEDS
 
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
-	depends on ARM
+	depends on ARCH_AT91 || COMPILE_TEST
 	---help---
 	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
 	  and AT91SAM9X5 processors.


-- 
Jean Delvare
SUSE L3 Support
