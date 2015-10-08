From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] can: at91: remove at91_can_data
Date: Thu,  8 Oct 2015 16:56:07 +0200
Message-ID: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-can.vger.kernel.org

struct at91_can_data was used to pass a callback to the driver, allowing it
to switch the transceiver on and off. As all at91 boards are now using DT,
this is not used anymore, remove that structure.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/net/can/at91_can.c          | 21 ---------------------
 include/linux/platform_data/atmel.h |  5 -----
 2 files changed, 26 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 945c0955a967..8b3275d7792a 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -8,15 +8,6 @@
  * Public License ("GPL") version 2 as distributed in the 'COPYING'
  * file from the main directory of the linux kernel source.
  *
- *
- * Your platform definition file should specify something like:
- *
- * static struct at91_can_data ek_can_data = {
- *	transceiver_switch = sam9263ek_transceiver_switch,
- * };
- *
- * at91_add_device_can(&ek_can_data);
- *
  */
 
 #include <linux/clk.h>
@@ -33,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/platform_data/atmel.h>
 
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
@@ -324,15 +314,6 @@ static inline u32 at91_can_id_to_reg_mid(canid_t can_id)
 	return reg_mid;
 }
 
-/*
- * Swtich transceiver on or off
- */
-static void at91_transceiver_switch(const struct at91_priv *priv, int on)
-{
-	if (priv->pdata && priv->pdata->transceiver_switch)
-		priv->pdata->transceiver_switch(on);
-}
-
 static void at91_setup_mailboxes(struct net_device *dev)
 {
 	struct at91_priv *priv = netdev_priv(dev);
@@ -416,7 +397,6 @@ static void at91_chip_start(struct net_device *dev)
 
 	at91_set_bittiming(dev);
 	at91_setup_mailboxes(dev);
-	at91_transceiver_switch(priv, 1);
 
 	/* enable chip */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
@@ -444,7 +424,6 @@ static void at91_chip_stop(struct net_device *dev, enum can_state state)
 	reg_mr = at91_read(priv, AT91_MR);
 	at91_write(priv, AT91_MR, reg_mr & ~AT91_MR_CANEN);
 
-	at91_transceiver_switch(priv, 0);
 	priv->can.state = state;
 }
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 527a85c61924..c121ddf74f7f 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -74,11 +74,6 @@ struct atmel_uart_data {
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
