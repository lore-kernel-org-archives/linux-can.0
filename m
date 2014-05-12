From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 2/4] can: slcan: Send open/close command upon interface up/down
Date: Mon, 12 May 2014 11:58:42 +0200
Message-ID: <1399888724-27874-3-git-send-email-alexander.stein@systec-electronic.com>
References: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55381 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbaELKAN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 06:00:13 -0400
In-Reply-To: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

In case a command could not be sent, print a warning. E.g. when slcand
is killed before the interface is shutdown.
Always close serial CAN device upon CAN interface initialization.
Otherwise no bitrate setting can be done.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/slcan.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 626b0df..919c278 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -103,6 +103,40 @@ struct slcan {
 static struct net_device **slcan_devs;
 static DEFINE_MUTEX(slcan_mutex);
 
+#define CLOSE_COMMAND "C\r"
+#define OPEN_COMMAND "O\r"
+
+static int slc_open_device(struct slcan *sl) __must_hold(&sl->lock)
+{
+	int written;
+
+	if (sl->tty) {
+		written = sl->tty->ops->write(sl->tty, OPEN_COMMAND,
+					      strlen(OPEN_COMMAND));
+		if (written != strlen(OPEN_COMMAND)) {
+			netdev_warn(sl->dev, "Open command could not be sent. Serial interface still inactive!\n");
+			return -EIO;
+		}
+	}
+	sl->can.state = CAN_STATE_ERROR_ACTIVE;
+	return 0;
+}
+
+static int slc_close_device(struct slcan *sl) __must_hold(&sl->lock)
+{
+	int written;
+
+	if (sl->tty) {
+		written = sl->tty->ops->write(sl->tty, CLOSE_COMMAND,
+					      strlen(CLOSE_COMMAND));
+		if (written != strlen(CLOSE_COMMAND)) {
+			netdev_warn(sl->dev, "Close command could not be sent. Serial interface still active!\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
  /************************************************************************
   *			SLCAN ENCAPSULATION FORMAT			 *
   ************************************************************************/
@@ -372,10 +406,13 @@ static int slc_close(struct net_device *dev)
 	struct slcan *sl = netdev_priv(dev);
 
 	spin_lock_bh(&sl->lock);
+
 	if (sl->tty) {
 		/* TTY discipline is running. */
 		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
 	}
+
+	slc_close_device(sl);
 	netif_stop_queue(dev);
 	sl->rcount   = 0;
 	sl->xleft    = 0;
@@ -401,10 +438,18 @@ static int slc_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	sl->can.state = CAN_STATE_ERROR_ACTIVE;
+	spin_lock_bh(&sl->lock);
+
+	err = slc_open_device(sl);
+	if (err) {
+		spin_unlock_bh(&sl->lock);
+		return err;
+	}
+
 	sl->flags &= (1 << SLF_INUSE);
 	netif_start_queue(dev);
 
+	spin_unlock_bh(&sl->lock);
 	return 0;
 }
 
@@ -564,6 +609,10 @@ static int slcan_open(struct tty_struct *tty)
 	sl->tty = tty;
 	tty->disc_data = sl;
 
+	err = slc_close_device(sl);
+	if (err)
+		goto err_free_chan;
+
 	if (!test_bit(SLF_INUSE, &sl->flags)) {
 		/* Perform the low-level SLCAN initialization. */
 		sl->rcount   = 0;
-- 
1.8.5.5

