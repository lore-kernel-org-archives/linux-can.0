From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can: usb: Kconfig: Add PCAN-USB X6 device in help text
Date: Mon, 27 Mar 2017 14:36:11 +0200
Message-ID: <1490618171-3128-3-git-send-email-s.grosjean@peak-system.com>
References: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:37493 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdC0Mgq (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 27 Mar 2017 08:36:46 -0400
In-Reply-To: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds a text line in the help section of the CAN_PEAK_USB
config item describing the support of the PCAN-USB X6 adapter, which is
already included in the Kernel since 4.9.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 3f8adc3..5f9e0e6 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -73,6 +73,7 @@ config CAN_PEAK_USB
 	  PCAN-USB FD          single CAN-FD channel USB adapter
 	  PCAN-USB Pro FD      dual CAN-FD channels USB adapter
 	  PCAN-Chip USB        CAN-FD to USB stamp module
+	  PCAN-USB X6          6 CAN-FD channels USB adapter
 
 	  (see also http://www.peak-system.com).
 
-- 
2.7.4

