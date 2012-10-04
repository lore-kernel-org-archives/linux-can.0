From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable and compilable on SPARC
Date: Thu,  4 Oct 2012 15:59:10 +0200
Message-ID: <1349359150-18012-1-git-send-email-andreas@gaisler.com>
References: <506D9266.6010707@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:55143 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933158Ab2JDN7x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 09:59:53 -0400
In-Reply-To: <506D9266.6010707@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/sja1000/Kconfig               |    2 +-
 drivers/net/can/sja1000/sja1000_of_platform.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index f2683eb..e45258d 100644
--- a/drivers/net/can/sja1000/sja1000_of_platform.c
+++ b/drivers/net/can/sja1000/sja1000_of_platform.c
@@ -42,6 +42,8 @@
 #include <linux/can/dev.h>
 
 #include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <asm/prom.h>
 
 #include "sja1000.h"
@@ -59,13 +61,13 @@ MODULE_LICENSE("GPL v2");
 
 static u8 sja1000_ofp_read_reg(const struct sja1000_priv *priv, int reg)
 {
-	return in_8(priv->reg_base + reg);
+	return ioread8(priv->reg_base + reg);
 }
 
 static void sja1000_ofp_write_reg(const struct sja1000_priv *priv,
 				  int reg, u8 val)
 {
-	out_8(priv->reg_base + reg, val);
+	iowrite8(val, priv->reg_base + reg);
 }
 
 static int __devexit sja1000_ofp_remove(struct platform_device *ofdev)
-- 
1.7.0.4

