From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 4/5] can: slcan: Add bitrate change support
Date: Tue, 15 Apr 2014 16:51:07 +0200
Message-ID: <1397573468-7619-5-git-send-email-alexander.stein@systec-electronic.com>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40114 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbaDOOw0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 10:52:26 -0400
In-Reply-To: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Only a fixed set of bitrates are supported.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/Kconfig |  5 +++--
 drivers/net/can/slcan.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index 8a578bb..8d98f50 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -454,6 +454,58 @@ static int slc_open(struct net_device *dev)
 	return 0;
 }
 
+static int slc_set_bittiming(struct net_device *dev)
+{
+	struct slcan *sl = netdev_priv(dev);
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
 /* Hook the destructor so we can free slcan devs at the right point in time */
 static void slc_free_netdev(struct net_device *dev)
 {
@@ -613,6 +665,7 @@ static int slcan_open(struct tty_struct *tty)
 		sl->rcount   = 0;
 		sl->xleft    = 0;
 
+		sl->can.do_set_bittiming = slc_set_bittiming;
 		set_bit(SLF_INUSE, &sl->flags);
 
 		err = register_candev(sl->dev);
-- 
1.8.3.2

