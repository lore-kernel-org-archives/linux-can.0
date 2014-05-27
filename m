From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: only rename enabled led triggers when changing the netdev name
Date: Tue, 27 May 2014 13:30:56 +0200
Message-ID: <1401190256-2963-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:40734 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaE0Lb0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 May 2014 07:31:26 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: dev.kurt@vandijck-laurijssen.be, fabio.baltieri@gmail.com, Oliver Hartkopp <socketcan@hartkopp.net>

Commit a1ef7bd9fce8 ("can: rename LED trigger name on netdev renames") renames
the led trigger names according to the changed netdevice name.

As not every CAN driver supports and initializes the led triggers, checking for
the CAN private datastructure with safe_candev_priv() in the notifier chain is
not enough.

This patch adds a check when CONFIG_CAN_LEDS is enabled and the driver does not
support led triggers.

For stable 3.9+

CC: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
CC: Fabio Baltieri <fabio.baltieri@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index a3d99a8..ab7f1b0 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -97,6 +97,9 @@ static int can_led_notifier(struct notifier_block *nb, unsigned long msg,
 	if (!priv)
 		return NOTIFY_DONE;
 
+	if (!priv->tx_led_trig || !priv->rx_led_trig)
+		return NOTIFY_DONE;
+
 	if (msg == NETDEV_CHANGENAME) {
 		snprintf(name, sizeof(name), "%s-tx", netdev->name);
 		led_trigger_rename_static(name, priv->tx_led_trig);
-- 
2.0.0.rc4

