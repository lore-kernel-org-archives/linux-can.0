From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] can: pch_can: Fix Kconfig dependencies
Date: Tue, 6 May 2014 10:20:59 +0200
Message-ID: <20140506102059.684db950@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934235AbaEFIVB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 May 2014 04:21:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

The pch_can driver is for a companion chip to the Intel Atom E600
series processors. These are 32-bit x86 processors so the driver is
only needed on X86_32. Add COMPILE_TEST as an alternative, so that the
driver can still be build-tested elsewhere.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc4.orig/drivers/net/can/Kconfig	2014-05-06 09:27:49.552401940 +0200
+++ linux-3.15-rc4/drivers/net/can/Kconfig	2014-05-06 09:52:33.480375067 +0200
@@ -110,7 +110,7 @@ config CAN_FLEXCAN
 
 config PCH_CAN
 	tristate "Intel EG20T PCH CAN controller"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	---help---
 	  This driver is for PCH CAN of Topcliff (Intel EG20T PCH) which
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).


-- 
Jean Delvare
SUSE L3 Support
