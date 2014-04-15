From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 5/5] can: slcan: Add CAN status flag support
Date: Tue, 15 Apr 2014 16:51:08 +0200
Message-ID: <1397573468-7619-6-git-send-email-alexander.stein@systec-electronic.com>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40117 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbaDOOw1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 10:52:27 -0400
In-Reply-To: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

CAN status flags have to be polled from the serial device. So send the
request every 10ms by default.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/Kconfig |   4 +-
 drivers/net/can/slcan.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 267aec2..9aa38943 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -113,8 +113,8 @@ config CAN_SLCAN
 	  via serial lines or via USB-to-serial adapters using the LAWICEL
 	  ASCII protocol. The driver implements the tty linediscipline N_SLCAN.
 
-	  Sending, receiving of CAN frames as well as bitrate setting is
-	  implemented, this driver should work with the
+	  Sending, receiving of CAN frames as well as bitrate setting and
+	  error handling is implemented, this driver should work with the
 	  (serial/USB) CAN hardware from:
 	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 8d98f50..35e5392 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -72,6 +72,15 @@ static int maxdev = 10;		/* MAX number of SLCAN channels;
 module_param(maxdev, int, 0);
 MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 
+/** \brief Status poll interval (in ms) in which the CAN status shall be polled
+ *
+ * Interval (in ms) in which the CAN status shall be polled.
+ * Can be overridden with insmod slcan.ko status_interval_ms=nnn
+ */
+static int status_interval_ms = 10;
+module_param(status_interval_ms, uint, 0);
+MODULE_PARM_DESC(status_interval_ms, "Status poll interval [ms]");
+
 /* maximum rx buffer len: extended CAN frame with timestamp */
 #define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
 
@@ -98,6 +107,20 @@ struct slcan {
 	unsigned long		flags;		/* Flag values/ mode etc     */
 #define SLF_INUSE		0		/* Channel in use            */
 #define SLF_ERROR		1               /* Parity, etc. error        */
+	unsigned char		can_flags;	/* CAN status flags          */
+/* #define SLC_CAN_FLAG_RFIFO_FULL BIT(0) */
+/* #define SLC_CAN_FLAG_TFIFO_FULL BIT(1) */
+#define SLC_CAN_FLAG_ERR_WARN   BIT(2)
+#define SLC_CAN_FLAG_OVERRUN    BIT(3)
+/* 4 is unused */
+#define SLC_CAN_FLAG_ERR_PASV   BIT(5)
+#define SLC_CAN_FLAG_ARB_LOST   BIT(6)
+#define SLC_CAN_FLAG_BUS_ERR    BIT(7)
+#define SLC_CAN_FLAG_VALID (SLC_CAN_FLAG_ERR_WARN | SLC_CAN_FLAG_OVERRUN \
+		| SLC_CAN_FLAG_ERR_PASV | SLC_CAN_FLAG_ARB_LOST \
+		| SLC_CAN_FLAG_BUS_ERR)
+
+	struct delayed_work work;
 };
 
 static struct net_device **slcan_devs;
@@ -105,6 +128,18 @@ static DEFINE_MUTEX(slcan_mutex);
 
 #define CLOSE_COMMAND "C\r"
 #define OPEN_COMMAND "O\r"
+#define FLAGS_COMMAND "F\r"
+
+static void slcan_queue_work(struct slcan *sl)
+{
+	unsigned long delay;
+
+	delay = msecs_to_jiffies(status_interval_ms);
+	if (delay >= HZ)
+		delay = round_jiffies_relative(delay);
+
+	queue_delayed_work(system_freezable_wq, &sl->work, delay);
+}
 
 static int slc_open_device(struct slcan *sl) __must_hold(&sl->lock)
 {
@@ -119,6 +154,7 @@ static int slc_open_device(struct slcan *sl) __must_hold(&sl->lock)
 		}
 	}
 	sl->can.state = CAN_STATE_ERROR_ACTIVE;
+	slcan_queue_work(sl);
 	return 0;
 }
 
@@ -126,6 +162,11 @@ static int slc_close_device(struct slcan *sl) __must_hold(&sl->lock)
 {
 	int written;
 
+	/* Release the lock while waiting for the delayed work to finish */
+	spin_unlock_bh(&sl->lock);
+	cancel_delayed_work_sync(&sl->work);
+	spin_lock_bh(&sl->lock);
+
 	if (sl->tty) {
 		written = sl->tty->ops->write(sl->tty, CLOSE_COMMAND,
 					      strlen(CLOSE_COMMAND));
@@ -137,6 +178,22 @@ static int slc_close_device(struct slcan *sl) __must_hold(&sl->lock)
 	return 0;
 }
 
+static void slcan_status_work(struct work_struct *work)
+{
+	struct slcan *sl = container_of(work, struct slcan, work.work);
+	int written;
+
+	spin_lock_bh(&sl->lock);
+	if (sl->tty) {
+		written = sl->tty->ops->write(sl->tty, FLAGS_COMMAND,
+					      strlen(FLAGS_COMMAND));
+		if (written != strlen(FLAGS_COMMAND))
+			netdev_warn(sl->dev, "Flags command could not be sent!\n");
+	}
+	spin_unlock_bh(&sl->lock);
+	slcan_queue_work(sl);
+}
+
  /************************************************************************
   *			SLCAN ENCAPSULATION FORMAT			 *
   ************************************************************************/
@@ -176,6 +233,94 @@ static int slc_close_device(struct slcan *sl) __must_hold(&sl->lock)
   *			STANDARD SLCAN DECAPSULATION			 *
   ************************************************************************/
 
+/* Analyse the error flags and send an error frame if approriate */
+static void slc_handle_flags(struct slcan *sl)
+{
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	struct net_device_stats *stats = &sl->dev->stats;
+	enum can_state state = sl->dev->state;
+	u8 new_flags;
+
+	if (hex2bin(&new_flags, sl->rbuff + SLC_CMD_LEN, 1))
+		return;
+
+	new_flags &= SLC_CAN_FLAG_VALID;
+
+	if (!(new_flags ^ sl->can_flags))
+		return;
+
+	skb = alloc_can_err_skb(sl->dev, &cf);
+	if (!skb)
+		return;
+
+	state = CAN_STATE_ERROR_ACTIVE;
+	if (new_flags & SLC_CAN_FLAG_ARB_LOST) {
+		sl->can.can_stats.arbitration_lost++;
+		stats->tx_errors++;
+		cf->can_id |= CAN_ERR_LOSTARB;
+	}
+	if (new_flags & SLC_CAN_FLAG_OVERRUN) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+	if (new_flags & SLC_CAN_FLAG_ERR_WARN)
+		state = CAN_STATE_ERROR_WARNING;
+	if (new_flags & SLC_CAN_FLAG_ERR_PASV)
+		state = CAN_STATE_ERROR_PASSIVE;
+	if (new_flags & SLC_CAN_FLAG_BUS_ERR)
+		state = CAN_STATE_BUS_OFF;
+
+	if (state != sl->can.state) {
+		stats->rx_errors++;
+
+		switch (state) {
+		case CAN_STATE_ERROR_ACTIVE:
+			cf->can_id |= CAN_ERR_PROT;
+			cf->data[2] = CAN_ERR_PROT_ACTIVE;
+			break;
+		case CAN_STATE_ERROR_WARNING:
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_WARNING |
+					CAN_ERR_CRTL_TX_WARNING;
+			sl->can.can_stats.error_warning++;
+			break;
+		case CAN_STATE_ERROR_PASSIVE:
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_PASSIVE |
+					CAN_ERR_CRTL_TX_PASSIVE;
+			sl->can.can_stats.error_passive++;
+			break;
+		case CAN_STATE_BUS_OFF:
+			cf->can_id |= CAN_ERR_BUSOFF;
+			can_bus_off(sl->dev);
+
+			/* Disable status fetching until
+			 * serial interface is restarted
+			 */
+			cancel_delayed_work_sync(&sl->work);
+			break;
+		case CAN_STATE_STOPPED:
+		case CAN_STATE_SLEEPING:
+		case CAN_STATE_MAX:
+			WARN_ON_ONCE(1);
+			break;
+		}
+	}
+
+	sl->can_flags = new_flags;
+	sl->can.state = state;
+
+	netif_rx_ni(skb);
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	return;
+}
+
 /* Send one completely decapsulated can_frame to the network layer */
 static void slc_bump(struct slcan *sl)
 {
@@ -190,6 +335,9 @@ static void slc_bump(struct slcan *sl)
 	can_id = 0;
 
 	switch (*cmd) {
+	case 'F':
+		slc_handle_flags(sl);
+		return;
 	case 'r':
 		can_id = CAN_RTR_FLAG;
 		/* fallthrough */
@@ -258,7 +406,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    (sl->rcount > 4))  {
+		    (sl->rcount > 2))  {
 			slc_bump(sl);
 		}
 		sl->rcount = 0;
@@ -454,6 +602,38 @@ static int slc_open(struct net_device *dev)
 	return 0;
 }
 
+static int slc_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	struct slcan *sl = netdev_priv(dev);
+	int err;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		spin_lock_bh(&sl->lock);
+
+		err = slc_close_device(sl);
+		if (err) {
+			spin_unlock_bh(&sl->lock);
+			return err;
+		}
+		err = slc_open_device(sl);
+		if (err) {
+			spin_unlock_bh(&sl->lock);
+			return err;
+		}
+
+		netif_wake_queue(dev);
+
+		spin_unlock_bh(&sl->lock);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int slc_set_bittiming(struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
@@ -655,8 +835,12 @@ static int slcan_open(struct tty_struct *tty)
 
 	sl->tty = tty;
 	tty->disc_data = sl;
+	INIT_DELAYED_WORK(&sl->work, slcan_status_work);
 
+	/* slc_close_device expects the lock to be taken */
+	spin_lock_bh(&sl->lock);
 	err = slc_close_device(sl);
+	spin_unlock_bh(&sl->lock);
 	if (err)
 		goto err_free_chan;
 
@@ -666,6 +850,7 @@ static int slcan_open(struct tty_struct *tty)
 		sl->xleft    = 0;
 
 		sl->can.do_set_bittiming = slc_set_bittiming;
+		sl->can.do_set_mode = slc_set_mode;
 		set_bit(SLF_INUSE, &sl->flags);
 
 		err = register_candev(sl->dev);
-- 
1.8.3.2

