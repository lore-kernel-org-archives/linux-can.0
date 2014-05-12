From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 3/4] can: slcan: Add bitrate change support
Date: Mon, 12 May 2014 11:58:43 +0200
Message-ID: <1399888724-27874-4-git-send-email-alexander.stein@systec-electronic.com>
References: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55380 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaELKAN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 06:00:13 -0400
In-Reply-To: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

Only a fixed set of bitrates are supported.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/Kconfig |  5 +++--
 drivers/net/can/slcan.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index daea043..267aec2 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -113,8 +113,9 @@ config CAN_SLCAN
 	  via serial lines or via USB-to-serial adapters using the LAWICEL
 	  ASCII protocol. The driver implements the tty linediscipline N_SLCAN.
 
-	  As only the sending and receiving of CAN frames is implemented, this
-	  driver should work with the (serial/USB) CAN hardware from:
+	  Sending, receiving of CAN frames as well as bitrate setting is
+	  implemented, this driver should work with the
+	  (serial/USB) CAN hardware from:
 	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
 
 	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 919c278..54823d5 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -400,6 +400,57 @@ out:
  *   Routines looking at netdevice side.
  ******************************************/
 
+static int slc_set_bittiming(struct slcan *sl)
+{
+	const struct can_bittiming *bt = &sl->can.bittiming;
+	int index, written, len;
+	char buf[4];
+
+	switch (bt->bitrate) {
+	case 1000000:
+		index = 8;
+		break;
+	case 800000:
+		index = 7;
+		break;
+	case 500000:
+		index = 6;
+		break;
+	case 250000:
+		index = 5;
+		break;
+	case 125000:
+		index = 4;
+		break;
+	case 100000:
+		index = 3;
+		break;
+	case 50000:
+		index = 2;
+		break;
+	case 20000:
+		index = 1;
+		break;
+	case 10000:
+		index = 0;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (!sl->tty)
+		return -ENOENT;
+
+	len = snprintf(buf, sizeof(buf), "S%d\r", index);
+	written = sl->tty->ops->write(sl->tty, buf, len);
+	if (written != len) {
+		netdev_warn(sl->dev, "Setting bitrate command could not be sent!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* Netdevice UP -> DOWN routine */
 static int slc_close(struct net_device *dev)
 {
@@ -434,6 +485,10 @@ static int slc_open(struct net_device *dev)
 	if (sl->tty == NULL)
 		return -ENODEV;
 
+	err = slc_set_bittiming(sl);
+	if (err)
+		return err;
+
 	err = open_candev(dev);
 	if (err)
 		return err;
-- 
1.8.5.5

