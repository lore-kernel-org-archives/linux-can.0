From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 1/4] can: slcan: Convert to can_dev interface
Date: Mon, 12 May 2014 11:58:41 +0200
Message-ID: <1399888724-27874-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:55387 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbaELKAR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 06:00:17 -0400
In-Reply-To: <1399888724-27874-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

No actual feature change despite the interface name. This is just a
preparation for additional CAN related features.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/Kconfig |  40 +++++++++---------
 drivers/net/can/slcan.c | 107 +++++++++++++++++++++---------------------------
 2 files changed, 66 insertions(+), 81 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 9e7d95d..daea043 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -9,26 +9,6 @@ config CAN_VCAN
 	  This driver can also be built as a module.  If so, the module
 	  will be called vcan.
 
-config CAN_SLCAN
-	tristate "Serial / USB serial CAN Adaptors (slcan)"
-	depends on TTY
-	---help---
-	  CAN driver for several 'low cost' CAN interfaces that are attached
-	  via serial lines or via USB-to-serial adapters using the LAWICEL
-	  ASCII protocol. The driver implements the tty linediscipline N_SLCAN.
-
-	  As only the sending and receiving of CAN frames is implemented, this
-	  driver should work with the (serial/USB) CAN hardware from:
-	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
-
-	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
-	  slcand) can be found in the can-utils at the SocketCAN SVN, see
-	  http://developer.berlios.de/projects/socketcan for details.
-
-	  The slcan driver supports up to 10 CAN netdevices by default which
-	  can be changed by the 'maxdev=xx' module option. This driver can
-	  also be built as a module. If so, the module will be called slcan.
-
 config CAN_DEV
 	tristate "Platform CAN drivers with Netlink support"
 	default y
@@ -125,6 +105,26 @@ config CAN_GRCAN
 	  endian syntheses of the cores would need some modifications on
 	  the hardware level to work.
 
+config CAN_SLCAN
+	tristate "Serial / USB serial CAN Adaptors (slcan)"
+	depends on TTY
+	---help---
+	  CAN driver for several 'low cost' CAN interfaces that are attached
+	  via serial lines or via USB-to-serial adapters using the LAWICEL
+	  ASCII protocol. The driver implements the tty linediscipline N_SLCAN.
+
+	  As only the sending and receiving of CAN frames is implemented, this
+	  driver should work with the (serial/USB) CAN hardware from:
+	  www.canusb.com / www.can232.com / www.mictronics.de / www.canhack.de
+
+	  Userspace tools to attach the SLCAN line discipline (slcan_attach,
+	  slcand) can be found in the can-utils at the SocketCAN SVN, see
+	  http://developer.berlios.de/projects/socketcan for details.
+
+	  The slcan driver supports up to 10 CAN netdevices by default which
+	  can be changed by the 'maxdev=xx' module option. This driver can
+	  also be built as a module. If so, the module will be called slcan.
+
 source "drivers/net/can/mscan/Kconfig"
 
 source "drivers/net/can/sja1000/Kconfig"
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index dcf9196..626b0df 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -53,6 +53,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/can.h>
+#include <linux/can/dev.h>
 #include <linux/can/skb.h>
 
 static __initconst const char banner[] =
@@ -79,6 +80,7 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 #define SLC_EFF_ID_LEN 8
 
 struct slcan {
+	struct can_priv		can;	/* must be the first member */
 	int			magic;
 
 	/* Various fields. */
@@ -99,6 +101,7 @@ struct slcan {
 };
 
 static struct net_device **slcan_devs;
+static DEFINE_MUTEX(slcan_mutex);
 
  /************************************************************************
   *			SLCAN ENCAPSULATION FORMAT			 *
@@ -143,31 +146,33 @@ static struct net_device **slcan_devs;
 static void slc_bump(struct slcan *sl)
 {
 	struct sk_buff *skb;
-	struct can_frame cf;
+	struct can_frame *cf;
+	canid_t can_id;
+	u8 can_dlc;
 	int i, tmp;
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
-	cf.can_id = 0;
+	can_id = 0;
 
 	switch (*cmd) {
 	case 'r':
-		cf.can_id = CAN_RTR_FLAG;
+		can_id = CAN_RTR_FLAG;
 		/* fallthrough */
 	case 't':
 		/* store dlc ASCII value and terminate SFF CAN ID string */
-		cf.can_dlc = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
+		can_dlc = sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN];
 		sl->rbuff[SLC_CMD_LEN + SLC_SFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
 		cmd += SLC_CMD_LEN + SLC_SFF_ID_LEN + 1;
 		break;
 	case 'R':
-		cf.can_id = CAN_RTR_FLAG;
+		can_id = CAN_RTR_FLAG;
 		/* fallthrough */
 	case 'T':
-		cf.can_id |= CAN_EFF_FLAG;
+		can_id |= CAN_EFF_FLAG;
 		/* store dlc ASCII value and terminate EFF CAN ID string */
-		cf.can_dlc = sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
+		can_dlc = sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN];
 		sl->rbuff[SLC_CMD_LEN + SLC_EFF_ID_LEN] = 0;
 		/* point to payload data behind the dlc */
 		cmd += SLC_CMD_LEN + SLC_EFF_ID_LEN + 1;
@@ -179,49 +184,38 @@ static void slc_bump(struct slcan *sl)
 	if (kstrtou32(sl->rbuff + SLC_CMD_LEN, 16, &tmpid))
 		return;
 
-	cf.can_id |= tmpid;
+	can_id |= tmpid;
 
 	/* get can_dlc from sanitized ASCII value */
-	if (cf.can_dlc >= '0' && cf.can_dlc < '9')
-		cf.can_dlc -= '0';
+	if (can_dlc >= '0' && can_dlc < '9')
+		can_dlc -= '0';
 	else
 		return;
 
-	*(u64 *) (&cf.data) = 0; /* clear payload */
+	skb = alloc_can_skb(sl->dev, &cf);
+	if (!skb)
+		return;
+	cf->can_id = can_id;
+	cf->can_dlc = can_dlc;
 
 	/* RTR frames may have a dlc > 0 but they never have any data bytes */
-	if (!(cf.can_id & CAN_RTR_FLAG)) {
-		for (i = 0; i < cf.can_dlc; i++) {
+	if (!(cf->can_id & CAN_RTR_FLAG)) {
+		for (i = 0; i < cf->can_dlc; i++) {
 			tmp = hex_to_bin(*cmd++);
 			if (tmp < 0)
 				return;
-			cf.data[i] = (tmp << 4);
+			cf->data[i] = (tmp << 4);
 			tmp = hex_to_bin(*cmd++);
 			if (tmp < 0)
 				return;
-			cf.data[i] |= tmp;
+			cf->data[i] |= tmp;
 		}
 	}
 
-	skb = dev_alloc_skb(sizeof(struct can_frame) +
-			    sizeof(struct can_skb_priv));
-	if (!skb)
-		return;
-
-	skb->dev = sl->dev;
-	skb->protocol = htons(ETH_P_CAN);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
+	sl->dev->stats.rx_packets++;
+	sl->dev->stats.rx_bytes += cf->can_dlc;
 
-	memcpy(skb_put(skb, sizeof(struct can_frame)),
-	       &cf, sizeof(struct can_frame));
 	netif_rx_ni(skb);
-
-	sl->dev->stats.rx_packets++;
-	sl->dev->stats.rx_bytes += cf.can_dlc;
 }
 
 /* parse tty input stream */
@@ -385,6 +379,10 @@ static int slc_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	sl->rcount   = 0;
 	sl->xleft    = 0;
+	sl->can.state = CAN_STATE_STOPPED;
+
+	close_candev(dev);
+
 	spin_unlock_bh(&sl->lock);
 
 	return 0;
@@ -394,12 +392,19 @@ static int slc_close(struct net_device *dev)
 static int slc_open(struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
+	int err;
 
 	if (sl->tty == NULL)
 		return -ENODEV;
 
+	err = open_candev(dev);
+	if (err)
+		return err;
+
+	sl->can.state = CAN_STATE_ERROR_ACTIVE;
 	sl->flags &= (1 << SLF_INUSE);
 	netif_start_queue(dev);
+
 	return 0;
 }
 
@@ -407,7 +412,7 @@ static int slc_open(struct net_device *dev)
 static void slc_free_netdev(struct net_device *dev)
 {
 	int i = dev->base_addr;
-	free_netdev(dev);
+	free_candev(dev);
 	slcan_devs[i] = NULL;
 }
 
@@ -423,23 +428,6 @@ static const struct net_device_ops slc_netdev_ops = {
 	.ndo_change_mtu         = slcan_change_mtu,
 };
 
-static void slc_setup(struct net_device *dev)
-{
-	dev->netdev_ops		= &slc_netdev_ops;
-	dev->destructor		= slc_free_netdev;
-
-	dev->hard_header_len	= 0;
-	dev->addr_len		= 0;
-	dev->tx_queue_len	= 10;
-
-	dev->mtu		= sizeof(struct can_frame);
-	dev->type		= ARPHRD_CAN;
-
-	/* New-style flags. */
-	dev->flags		= IFF_NOARP;
-	dev->features           = NETIF_F_HW_CSUM;
-}
-
 /******************************************
   Routines looking at TTY side.
  ******************************************/
@@ -501,7 +489,6 @@ static void slc_sync(void)
 static struct slcan *slc_alloc(dev_t line)
 {
 	int i;
-	char name[IFNAMSIZ];
 	struct net_device *dev = NULL;
 	struct slcan       *sl;
 
@@ -516,12 +503,13 @@ static struct slcan *slc_alloc(dev_t line)
 	if (i >= maxdev)
 		return NULL;
 
-	sprintf(name, "slcan%d", i);
-	dev = alloc_netdev(sizeof(*sl), name, slc_setup);
+	dev = alloc_candev(sizeof(*sl), 1);
 	if (!dev)
 		return NULL;
 
 	dev->base_addr  = i;
+	dev->netdev_ops = &slc_netdev_ops;
+	dev->destructor = slc_free_netdev;
 	sl = netdev_priv(dev);
 
 	/* Initialize channel control data */
@@ -554,11 +542,8 @@ static int slcan_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EOPNOTSUPP;
 
-	/* RTnetlink lock is misused here to serialize concurrent
-	   opens of slcan channels. There are better ways, but it is
-	   the simplest one.
-	 */
-	rtnl_lock();
+	/* Serialize concurrent opens of slcan channels. */
+	mutex_lock(&slcan_mutex);
 
 	/* Collect hanged up channels. */
 	slc_sync();
@@ -586,13 +571,13 @@ static int slcan_open(struct tty_struct *tty)
 
 		set_bit(SLF_INUSE, &sl->flags);
 
-		err = register_netdevice(sl->dev);
+		err = register_candev(sl->dev);
 		if (err)
 			goto err_free_chan;
 	}
 
 	/* Done.  We have linked the TTY line to a channel. */
-	rtnl_unlock();
+	mutex_unlock(&slcan_mutex);
 	tty->receive_room = 65536;	/* We don't flow control */
 
 	/* TTY layer expects 0 on success */
@@ -604,7 +589,7 @@ err_free_chan:
 	clear_bit(SLF_INUSE, &sl->flags);
 
 err_exit:
-	rtnl_unlock();
+	mutex_unlock(&slcan_mutex);
 
 	/* Count references from TTY module */
 	return err;
-- 
1.8.5.5

