From: Marek Vasut <marex@denx.de>
Subject: [PATCH 5/5][RFC] can: kline: Add KLine ldisc
Date: Thu,  9 Jun 2016 21:21:04 +0200
Message-ID: <1465500064-5402-5-git-send-email-marex@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34501 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbcFITVn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2016 15:21:43 -0400
In-Reply-To: <1465500064-5402-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Add initial TTY line discipline connected into the socketcan stack
which facilitates the communication with KLine device.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
---

NOTE: There is a lot of stuff in this patch which is not fleshed out yet.

 drivers/net/can/Kconfig    |  19 ++
 drivers/net/can/Makefile   |   1 +
 drivers/net/can/sl_kline.c | 683 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/can.h   |  33 +++
 include/uapi/linux/tty.h   |   1 +
 net/can/af_can.c           |   6 +-
 net/can/raw.c              |   2 +-
 7 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/can/sl_kline.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 20be638..e1a8728 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -29,6 +29,25 @@ config CAN_SLCAN
 	  can be changed by the 'maxdev=xx' module option. This driver can
 	  also be built as a module. If so, the module will be called slcan.
 
+config CAN_SL_KLINE
+	tristate "Serial K-Line protocol using SocketCAN (sl_kline)"
+	depends on TTY
+	---help---
+	  SocketCAN driver for the ISO 9141-2 K-Line protocol using TTY
+	  line discipline. This driver allows userland to communicate
+	  using standard SocketCAN interface to a device using K-Line
+	  protocol. Such K-Line device is connected to a regular serial
+	  port via level-shifter or similar logic. The TTY line discipline
+	  type is N_SL_KLINE.
+
+	  Userspace tools to attach the SL_KLINE ldisc (sl_kline_attach,
+	  sl_kline_d) can be found in the can-utils at the SocketCAN git).
+
+	  The sl_kline driver supports up to 10 KLine netdevices by default
+	  which can be changed by the 'maxdev=xx' module option. This driver
+	  can also be built as a module. If so, the module will be called
+	  sl_kline.
+
 config CAN_DEV
 	tristate "Platform CAN drivers with Netlink support"
 	default y
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index e3db0c8..60648e9 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
+obj-$(CONFIG_CAN_SL_KLINE)	+= sl_kline.o
 
 obj-$(CONFIG_CAN_DEV)		+= can-dev.o
 can-dev-y			:= dev.o
diff --git a/drivers/net/can/sl_kline.c b/drivers/net/can/sl_kline.c
new file mode 100644
index 0000000..fc9ca24
--- /dev/null
+++ b/drivers/net/can/sl_kline.c
@@ -0,0 +1,683 @@
+/*
+ * sl_kline.c - serial line K-Line interface driver (using tty line discipline)
+ *
+ * Heavilty based on slcan.c by Oliver Hartkopp <socketcan@hartkopp.net>
+ *   serial line CAN interface driver (using tty line discipline)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <linux/uaccess.h>
+#include <linux/bitops.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/can.h>
+#include <linux/can/skb.h>
+
+#include <linux/can/dev.h>
+
+MODULE_ALIAS_LDISC(N_SL_KLINE);
+MODULE_DESCRIPTION("serial line K-Line interface");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+
+#define SL_KLINE_MAGIC 0x53CB	/* FIXME */
+
+static int maxdev = 10;		/* MAX number of SL_KLINE channels;
+				   This can be overridden with
+				   insmod sl_kline.ko maxdev=nnn	*/
+module_param(maxdev, int, 0);
+MODULE_PARM_DESC(maxdev, "Maximum number of sl_kline interfaces");
+
+struct sl_kline {
+	struct can_priv		can;	/* must be the first member */
+
+	int			magic;
+
+	/* Various fields. */
+	struct tty_struct	*tty;
+	struct net_device	*dev;
+	spinlock_t		lock;
+	struct work_struct	tx_work;	/* Flushes transmit buffer   */
+
+	/* These are pointers to the malloc()ed frame buffers. */
+	unsigned char		rbuff[KLINE_MAX_DLEN];
+	int			rcount;
+
+	unsigned long		flags;
+
+#define KLF_IN_USE		(1 << 0)
+#define KLF_INIT		(1 << 1)
+#define KLF_WAIT_FOR_55		(1 << 2)
+#define KLF_WAIT_FOR_ADDR1	(1 << 3)
+#define KLF_WAIT_FOR_ADDR2	(1 << 4)
+#define KLF_WAIT_FOR_CC		(1 << 5)
+
+	struct kline_frame	tx_kf;
+	struct timer_list	timer;
+};
+
+static struct net_device **sl_kline_devs;
+
+/* Send one kline_frame to the network layer */
+static void sl_kline_bump(struct sl_kline *sl)
+{
+	struct sk_buff *skb;
+	struct kline_frame kf;
+
+	kf.can_id = 0;
+	kf.len = sl->rcount;
+	memcpy(kf.data, sl->rbuff, sl->rcount);
+
+	skb = dev_alloc_skb(sizeof(struct kline_frame) +
+			    sizeof(struct can_skb_priv));
+	if (!skb)
+		return;
+
+	skb->dev = sl->dev;
+	skb->protocol = htons(ETH_P_CAN);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	memcpy(skb_put(skb, sizeof(struct kline_frame)),
+	       &kf, sizeof(struct kline_frame));
+
+	sl->dev->stats.rx_packets++;
+	sl->dev->stats.rx_bytes += kf.len;
+	netif_rx_ni(skb);
+}
+
+/* Write transmit buffer. Scheduled when tty is writable */
+static void sl_kline_transmit(struct work_struct *work)
+{
+	struct sl_kline *sl = container_of(work, struct sl_kline, tx_work);
+	struct kline_frame *kf = &sl->tx_kf;
+	struct ktermios ktermios = sl->tty->termios;
+	int i;
+
+	spin_lock_bh(&sl->lock);
+	/* First make sure we're connected. */
+	if (!sl->tty || sl->magic != SL_KLINE_MAGIC || !netif_running(sl->dev)) {
+		spin_unlock_bh(&sl->lock);
+		return;
+	}
+
+	/* Push out start frame */
+	if (kf->flags & (KLINE_ISO9141_START | KLINE_KWP_SLOW_START)) {
+		/* Wait time W0=2mS */
+		mdelay(sl->can.kline_timing.w0);
+
+		/* Set speed to 5 Bd/s */
+		ktermios.c_cflag &= ~CBAUD;
+		tty_termios_encode_baud_rate(&ktermios, 5, 5);
+		tty_set_termios(sl->tty, &ktermios);
+
+		/* Transmit init */
+		tty_put_char(sl->tty, 0x33);
+		sl->dev->stats.tx_bytes++;
+
+		sl->flags |= KLF_INIT | KLF_WAIT_FOR_55;
+		spin_unlock_bh(&sl->lock);
+
+		/* Start timer to measure W1 */
+		mod_timer(&sl->timer,
+			  jiffies + msecs_to_jiffies(sl->can.kline_timing.w1));
+		return;
+	}
+
+	/* We should NEVER end up here with KLF_INIT set. */
+	WARN_ON(sl->flags & KLF_INIT);
+
+	/* Just write the data and be done with it. */
+	for (i = 0; i < kf->len; i++) {
+		tty_put_char(sl->tty, kf->data[i]);
+		sl->dev->stats.tx_bytes++;
+		/* FIXME: Delay for the inter-byte interval */
+	}
+	spin_unlock_bh(&sl->lock);
+}
+
+static void sl_kline_timeout(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct sl_kline *sl = netdev_priv(dev);
+
+	/* Check if the link-partner responded */
+	if (sl->flags & KLF_WAIT_FOR_55) {	/* No response */
+		sl->flags &= ~(KLF_INIT | KLF_WAIT_FOR_55);
+		sl->dev->stats.tx_errors++;
+		netif_wake_queue(sl->dev);
+	}
+}
+
+/*
+ * Called by the driver when there's room for more data.
+ * Schedule the transmit.
+ */
+static void sl_kline_write_wakeup(struct tty_struct *tty)
+{
+	struct sl_kline *sl = tty->disc_data;
+
+	schedule_work(&sl->tx_work);
+}
+
+/* Send a kline_frame to a TTY queue. */
+static netdev_tx_t sl_kline_ndev_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct sl_kline *sl = netdev_priv(dev);
+
+	if (skb->len != sizeof(struct kline_frame))
+		goto out;
+
+	spin_lock(&sl->lock);
+	if (!netif_running(dev))  {
+		spin_unlock(&sl->lock);
+		printk(KERN_WARNING "%s: xmit: iface is down\n", dev->name);
+		goto out;
+	}
+	if (sl->tty == NULL) {
+		spin_unlock(&sl->lock);
+		goto out;
+	}
+
+	netif_stop_queue(sl->dev);
+	memcpy(&sl->tx_kf, (struct kline_frame *)skb->data, sizeof(sl->tx_kf));
+	schedule_work(&sl->tx_work);
+	spin_unlock(&sl->lock);
+
+out:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+
+/******************************************
+ *   Routines looking at netdevice side.
+ ******************************************/
+
+/* Netdevice UP -> DOWN routine */
+static int sl_kline_ndev_close(struct net_device *dev)
+{
+	struct sl_kline *sl = netdev_priv(dev);
+
+	spin_lock_bh(&sl->lock);
+	if (sl->tty) {
+		/* TTY discipline is running. */
+		clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
+	}
+	netif_stop_queue(dev);
+	sl->rcount   = 0;
+	spin_unlock_bh(&sl->lock);
+
+	return 0;
+}
+
+/* Netdevice DOWN -> UP routine */
+static int sl_kline_ndev_open(struct net_device *dev)
+{
+	struct sl_kline *sl = netdev_priv(dev);
+
+	if (sl->tty == NULL)
+		return -ENODEV;
+
+	setup_timer(&sl->timer, sl_kline_timeout, (unsigned long)dev);
+
+	sl->flags &= KLF_IN_USE;
+	netif_start_queue(dev);
+	return 0;
+}
+
+/* Hook the destructor so we can free sl_kline devs at the right point in time */
+static void sl_kline_ndev_free(struct net_device *dev)
+{
+	struct sl_kline *sl = netdev_priv(dev);
+	int i = dev->base_addr;
+
+	del_timer_sync(&sl->timer);
+
+	free_netdev(dev);
+	sl_kline_devs[i] = NULL;
+}
+
+static int sl_kline_ndev_change_mtu(struct net_device *dev, int new_mtu)
+{
+	return -EINVAL;
+}
+
+static const struct net_device_ops sl_kline_ndev_ops = {
+	.ndo_open               = sl_kline_ndev_open,
+	.ndo_stop               = sl_kline_ndev_close,
+	.ndo_start_xmit         = sl_kline_ndev_xmit,
+	.ndo_change_mtu         = sl_kline_ndev_change_mtu,
+};
+
+/******************************************
+  Routines looking at TTY side.
+ ******************************************/
+static void sl_kline_receive_buf(struct tty_struct *tty,
+			      const unsigned char *cp, char *fp, int count)
+{
+	struct sl_kline *sl = (struct sl_kline *) tty->disc_data;
+	struct ktermios ktermios = tty->termios;
+
+	if (!sl || sl->magic != SL_KLINE_MAGIC || !netif_running(sl->dev))
+		return;
+
+	/* FIXME: Add mutex for the flags */
+
+	/* Handle incoming data */
+	if (!(sl->flags & KLF_INIT)) {	/* Normal data. */
+		sl->rcount = 0;
+		while (count--) {
+			if (fp && *fp++) {
+				/* FIXME: Log RX errors ? */
+				sl->dev->stats.rx_errors++;
+				cp++;
+				continue;
+			} else {
+				sl->rbuff[sl->rcount++] = *cp++;
+			}
+		}
+		sl_kline_bump(sl);
+		netif_wake_queue(sl->dev);
+		return;
+	}
+
+	if (sl->flags & KLF_WAIT_FOR_55) {
+		if (!count)
+			return;
+
+		sl->flags &= ~KLF_WAIT_FOR_55;
+		if (*cp == 0x55) {	/* Valid response */
+			/* Set speed to 10400 Bd/s */
+			ktermios.c_cflag &= ~CBAUD;
+			tty_termios_encode_baud_rate(&ktermios, 10400, 10400);
+			tty_set_termios(tty, &ktermios);
+		}
+
+		if (*cp != 0x55)	/* Invalid response */
+			goto fail;
+
+		sl->rcount = 0;
+		sl->rbuff[sl->rcount++] = *cp++;
+
+		sl->flags |= KLF_WAIT_FOR_ADDR1;
+	}
+
+	if (sl->flags & KLF_WAIT_FOR_ADDR1) {
+		if (!count)
+			return;
+
+		sl->flags &= ~KLF_WAIT_FOR_ADDR1;
+		if (*cp != 0x08 && *cp != 0x94)	/* Invalid address */
+			goto fail;
+
+		sl->rbuff[sl->rcount++] = *cp++;
+
+		sl->flags |= KLF_WAIT_FOR_ADDR2;
+	}
+
+	if (sl->flags & KLF_WAIT_FOR_ADDR2) {
+		if (!count)
+			return;
+
+		sl->flags &= ~KLF_WAIT_FOR_ADDR2;
+		if (*cp != 0x08 && *cp != 0x94)	/* Invalid address */
+			goto fail;
+
+		/* Send negated address */
+		tty_put_char(sl->tty, ~(*cp) & 0xff);
+		sl->dev->stats.tx_bytes++;
+
+		sl->rbuff[sl->rcount++] = *cp++;
+
+		sl->flags |= KLF_WAIT_FOR_CC;
+	}
+
+	if (sl->flags & KLF_WAIT_FOR_CC) {
+		if (!count)
+			return;
+
+		sl->flags &= ~(KLF_WAIT_FOR_CC | KLF_INIT);
+		if (*cp != 0xcc)	/* Invalid response */
+			goto fail;
+
+		sl->rbuff[sl->rcount] = *cp;
+
+		sl_kline_bump(sl);
+
+		sl->rcount = 0;
+
+		/* Wakeup TX queue */
+		netif_wake_queue(sl->dev);
+	}
+	return;
+fail:
+	sl->dev->stats.rx_errors++;
+	while (count--)
+		sl->rbuff[sl->rcount++] = *cp++;
+	sl_kline_bump(sl);
+	netif_wake_queue(sl->dev);
+}
+
+/************************************
+ *  sl_kline_open helper routines.
+ ************************************/
+
+/* Collect hanged up channels */
+static void sl_kline_sync(void)
+{
+	int i;
+	struct net_device *dev;
+	struct sl_kline	  *sl;
+
+	for (i = 0; i < maxdev; i++) {
+		dev = sl_kline_devs[i];
+		if (dev == NULL)
+			break;
+
+		sl = netdev_priv(dev);
+		if (sl->tty)
+			continue;
+		if (dev->flags & IFF_UP)
+			dev_close(dev);
+	}
+}
+
+/* Find a free SL_KLINE channel, and link in this `tty' line. */
+static struct sl_kline *sl_kline_alloc(dev_t line)
+{
+	int i;
+	struct net_device *dev = NULL;
+	struct sl_kline       *sl;
+
+	for (i = 0; i < maxdev; i++) {
+		dev = sl_kline_devs[i];
+		if (dev == NULL)
+			break;
+	}
+
+	/* Sorry, too many, all slots in use */
+	if (i >= maxdev)
+		return NULL;
+
+	dev = alloc_socketdev("sl_kline%d", sizeof(*sl), 0);
+	if (!dev)
+		return NULL;
+	dev->netdev_ops = &sl_kline_ndev_ops;
+	dev->base_addr = i;
+	dev->destructor = sl_kline_ndev_free;
+	dev->mtu = KLINE_MTU;
+
+	sl = netdev_priv(dev);
+
+	/* Initialize channel control data */
+	sl->magic = SL_KLINE_MAGIC;
+	sl->dev	= dev;
+	spin_lock_init(&sl->lock);
+	INIT_WORK(&sl->tx_work, sl_kline_transmit);
+	init_timer(&sl->timer);
+	sl_kline_devs[i] = dev;
+
+	return sl;
+}
+
+/*
+ * Open the high-level part of the SL_KLINE channel.
+ * This function is called by the TTY module when the
+ * SL_KLINE line discipline is called for.  Because we are
+ * sure the tty line exists, we only have to link it to
+ * a free SL_KLINE channel...
+ *
+ * Called in process context serialized from other ldisc calls.
+ */
+
+static int sl_kline_open(struct tty_struct *tty)
+{
+	struct sl_kline *sl;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (tty->ops->write == NULL)
+		return -EOPNOTSUPP;
+
+	/* RTnetlink lock is misused here to serialize concurrent
+	   opens of sl_kline channels. There are better ways, but it is
+	   the simplest one.
+	 */
+	rtnl_lock();
+
+	/* Collect hanged up channels. */
+	sl_kline_sync();
+
+	sl = tty->disc_data;
+
+	err = -EEXIST;
+	/* First make sure we're not already connected. */
+	if (sl && sl->magic == SL_KLINE_MAGIC)
+		goto err_exit;
+
+	/* OK.  Find a free SL_KLINE channel to use. */
+	err = -ENFILE;
+	sl = sl_kline_alloc(tty_devnum(tty));
+	if (sl == NULL)
+		goto err_exit;
+
+	sl->tty = tty;
+	tty->disc_data = sl;
+
+	if (!(sl->flags & KLF_IN_USE)) {
+		/* Perform the low-level SL_KLINE initialization. */
+		sl->rcount   = 0;
+
+		sl->flags |= KLF_IN_USE;
+
+		err = register_candevice(sl->dev);
+		if (err)
+			goto err_free_chan;
+	}
+
+	/* Done.  We have linked the TTY line to a channel. */
+	rtnl_unlock();
+	tty->receive_room = 65536;	/* We don't flow control */
+
+	/* TTY layer expects 0 on success */
+	return 0;
+
+err_free_chan:
+	sl->tty = NULL;
+	tty->disc_data = NULL;
+	sl->flags &= ~KLF_IN_USE;
+
+err_exit:
+	rtnl_unlock();
+
+	/* Count references from TTY module */
+	return err;
+}
+
+/*
+ * Close down a SL_KLINE channel.
+ * This means flushing out any pending queues, and then returning. This
+ * call is serialized against other ldisc functions.
+ *
+ * We also use this method for a hangup event.
+ */
+
+static void sl_kline_close(struct tty_struct *tty)
+{
+	struct sl_kline *sl = (struct sl_kline *) tty->disc_data;
+
+	/* First make sure we're connected. */
+	if (!sl || sl->magic != SL_KLINE_MAGIC || sl->tty != tty)
+		return;
+
+	spin_lock_bh(&sl->lock);
+	tty->disc_data = NULL;
+	sl->tty = NULL;
+	spin_unlock_bh(&sl->lock);
+
+	flush_work(&sl->tx_work);
+
+	/* Flush network side */
+	unregister_netdev(sl->dev);
+	/* This will complete via sl_free_netdev */
+}
+
+static int sl_kline_hangup(struct tty_struct *tty)
+{
+	sl_kline_close(tty);
+	return 0;
+}
+
+/* Perform I/O control on an active SL_KLINE channel. */
+static int sl_kline_ioctl(struct tty_struct *tty, struct file *file,
+		       unsigned int cmd, unsigned long arg)
+{
+	struct sl_kline *sl = (struct sl_kline *) tty->disc_data;
+	unsigned int tmp;
+
+	/* First make sure we're connected. */
+	if (!sl || sl->magic != SL_KLINE_MAGIC)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCGIFNAME:
+		tmp = strlen(sl->dev->name) + 1;
+		if (copy_to_user((void __user *)arg, sl->dev->name, tmp))
+			return -EFAULT;
+		return 0;
+
+	case SIOCSIFHWADDR:
+		return -EINVAL;
+
+	default:
+		return tty_mode_ioctl(tty, file, cmd, arg);
+	}
+}
+
+static struct tty_ldisc_ops sl_kline_ldisc = {
+	.owner		= THIS_MODULE,
+	.magic		= TTY_LDISC_MAGIC,
+	.name		= "sl_kline",
+	.open		= sl_kline_open,
+	.close		= sl_kline_close,
+	.hangup		= sl_kline_hangup,
+	.ioctl		= sl_kline_ioctl,
+	.receive_buf	= sl_kline_receive_buf,
+	.write_wakeup	= sl_kline_write_wakeup,
+};
+
+static int __init sl_kline_init(void)
+{
+	int status;
+
+	if (maxdev < 4)
+		maxdev = 4; /* Sanity */
+
+	pr_info("sl_kline: serial line K-Line interface driver\n");
+	pr_info("sl_kline: %d dynamic interface channels.\n", maxdev);
+
+	sl_kline_devs = kzalloc(sizeof(struct net_device *)*maxdev, GFP_KERNEL);
+	if (!sl_kline_devs)
+		return -ENOMEM;
+
+	/* Fill in our line protocol discipline, and register it */
+	status = tty_register_ldisc(N_SL_KLINE, &sl_kline_ldisc);
+	if (status)  {
+		pr_err("sl_kline: can't register line discipline\n");
+		kfree(sl_kline_devs);
+	}
+	return status;
+}
+
+static void __exit sl_kline_exit(void)
+{
+	int i;
+	struct net_device *dev;
+	struct sl_kline *sl;
+	unsigned long timeout = jiffies + HZ;
+	int busy = 0;
+
+	if (sl_kline_devs == NULL)
+		return;
+
+	/* First of all: check for active disciplines and hangup them.
+	 */
+	do {
+		if (busy)
+			msleep_interruptible(100);
+
+		busy = 0;
+		for (i = 0; i < maxdev; i++) {
+			dev = sl_kline_devs[i];
+			if (!dev)
+				continue;
+			sl = netdev_priv(dev);
+			spin_lock_bh(&sl->lock);
+			if (sl->tty) {
+				busy++;
+				tty_hangup(sl->tty);
+			}
+			spin_unlock_bh(&sl->lock);
+		}
+	} while (busy && time_before(jiffies, timeout));
+
+	/* FIXME: hangup is async so we should wait when doing this second
+	   phase */
+
+	for (i = 0; i < maxdev; i++) {
+		dev = sl_kline_devs[i];
+		if (!dev)
+			continue;
+		sl_kline_devs[i] = NULL;
+
+		sl = netdev_priv(dev);
+		if (sl->tty) {
+			pr_err("%s: tty discipline still running\n",
+			       dev->name);
+			/* Intentionally leak the control block. */
+			dev->destructor = NULL;
+		}
+
+		unregister_netdev(dev);
+	}
+
+	kfree(sl_kline_devs);
+	sl_kline_devs = NULL;
+
+	i = tty_unregister_ldisc(N_SL_KLINE);
+	if (i)
+		printk(KERN_ERR "sl_kline: can't unregister ldisc (err %d)\n", i);
+}
+
+module_init(sl_kline_init);
+module_exit(sl_kline_exit);
diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 9692cda..732cdc0 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -89,6 +89,10 @@ typedef __u32 can_err_mask_t;
 #define CANFD_MAX_DLC 15
 #define CANFD_MAX_DLEN 64
 
+/* KLine payload length and DLC FIXME */
+#define KLINE_MAX_DLC	15
+#define KLINE_MAX_DLEN	255
+
 /**
  * struct can_frame - basic CAN frame structure
  * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
@@ -146,8 +150,37 @@ struct canfd_frame {
 	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
 };
 
+/*
+ * FIXME
+ * defined bits for kline_frame.flags
+ *
+ */
+#define KLINE_ISO9141_START 0x1  /* ISO slow start sequence */
+#define KLINE_KWP_SLOW_START 0x2 /* KWP slow start sequence */
+#define KLINE_KWP_FAST_START 0x4 /* KWP fast start sequence */
+
+/**
+ * FIXME
+ * struct canfd_frame - CAN flexible data rate frame structure
+ * @can_id: CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @len:    frame payload length in byte (0 .. CANFD_MAX_DLEN)
+ * @flags:  additional flags for CAN FD
+ * @__res0: reserved / padding
+ * @__res1: reserved / padding
+ * @data:   CAN FD frame payload (up to CANFD_MAX_DLEN byte)
+ */
+struct kline_frame {
+	canid_t can_id;  /* 32 bit KLine address + EFF/RTR/ERR flags (unused) */
+	__u8    len;     /* frame payload length in byte */
+	__u8    flags;   /* additional flags for KLine */
+	__u8    __res0;  /* reserved / padding */
+	__u8    __res1;  /* reserved / padding */
+	__u8    data[KLINE_MAX_DLEN] __attribute__((aligned(8)));
+};
+
 #define CAN_MTU		(sizeof(struct can_frame))
 #define CANFD_MTU	(sizeof(struct canfd_frame))
+#define KLINE_MTU	(sizeof(struct kline_frame))
 
 /* particular protocols of the protocol family PF_CAN */
 #define CAN_RAW		1 /* RAW sockets */
diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index 01c4410..80b8f1e 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -35,5 +35,6 @@
 #define N_TRACESINK	23	/* Trace data routing for MIPI P1149.7 */
 #define N_TRACEROUTER	24	/* Trace data routing for MIPI P1149.7 */
 #define N_NCI		25	/* NFC NCI UART */
+#define N_SL_KLINE	26	/* ISO 9141-2 K-Line via SocketCAN */
 
 #endif /* _UAPI_LINUX_TTY_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 166d436..1a8b836 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -238,6 +238,10 @@ int can_send(struct sk_buff *skb, int loop)
 		skb->protocol = htons(ETH_P_CANFD);
 		if (unlikely(cfd->len > CANFD_MAX_DLEN))
 			goto inval_skb;
+	} else if (skb->len == KLINE_MTU) {
+		skb->protocol = htons(ETH_P_CAN);
+		if (unlikely(cfd->len > KLINE_MAX_DLEN))
+			goto inval_skb;
 	} else
 		goto inval_skb;
 
@@ -715,7 +719,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop;
 
 	if (WARN_ONCE(dev->type != ARPHRD_CAN ||
-		      skb->len != CAN_MTU ||
+		      (skb->len != CAN_MTU && skb->len != KLINE_MTU) ||
 		      cfd->len > CAN_MAX_DLEN,
 		      "PF_CAN: dropped non conform CAN skbuf: "
 		      "dev type %d, len %d, datalen %d\n",
diff --git a/net/can/raw.c b/net/can/raw.c
index 2e67b14..8a95404 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -734,7 +734,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if (unlikely(size != CANFD_MTU && size != CAN_MTU))
 			return -EINVAL;
 	} else {
-		if (unlikely(size != CAN_MTU))
+		if (unlikely((size != CAN_MTU) && (size != KLINE_MTU)))
 			return -EINVAL;
 	}
 
-- 
2.7.0

