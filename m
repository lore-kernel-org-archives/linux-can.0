From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] can: mscan: Fix Kconfig dependencies
Date: Tue, 6 May 2014 10:47:10 +0200
Message-ID: <20140506104710.3d361a40@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58859 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934512AbaEFIrM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 May 2014 04:47:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

The only driver based on MSCAN at the moment is for PPC machines,
so it makes no sense to present the menu on M68K. The menu will always
be empty there.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc4.orig/drivers/net/can/mscan/Kconfig	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.15-rc4/drivers/net/can/mscan/Kconfig	2014-05-06 10:13:50.563606721 +0200
@@ -1,5 +1,5 @@
 config CAN_MSCAN
-	depends on PPC || M68K
+	depends on PPC
 	tristate "Support for Freescale MSCAN based chips"
 	---help---
 	  The Motorola Scalable Controller Area Network (MSCAN) definition


-- 
Jean Delvare
SUSE L3 Support
