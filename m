From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] can: sja1000: Make sja1000_of_platform selectable and compilable on SPARC
Date: Tue,  2 Oct 2012 15:13:19 +0200
Message-ID: <1349183599-28734-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:13346 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753645Ab2JBNNd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Oct 2012 09:13:33 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/sja1000/Kconfig               |    2 +-
 drivers/net/can/sja1000/sja1000_of_platform.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 03df9a8..44abee4 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -21,7 +21,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_SJA1000_OF_PLATFORM
 	tristate "Generic OF Platform Bus based SJA1000 driver"
-	depends on PPC_OF
+	depends on OF
 	---help---
 	  This driver adds support for the SJA1000 chips connected to
 	  the OpenFirmware "platform bus" found on embedded systems with
diff --git a/drivers/net/can/sja1000/sja1000_of_platform.c b/drivers/net/can/sja1000/sja1000_of_platform.c
index f2683eb..73d964e 100644
--- a/drivers/net/can/sja1000/sja1000_of_platform.c
+++ b/drivers/net/can/sja1000/sja1000_of_platform.c
@@ -42,6 +42,8 @@
 #include <linux/can/dev.h>
 
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <asm/prom.h>
 
 #include "sja1000.h"
-- 
1.7.0.4

