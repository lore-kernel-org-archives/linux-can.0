From: Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on SPI interface
Date: Tue, 25 Mar 2014 15:30:22 +0100
Message-ID: <1395757822-22283-4-git-send-email-sbabic@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp2.ngi.it ([88.149.128.113]:52603 "EHLO smtp2.ngi.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbaCYOar (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Mar 2014 10:30:47 -0400
In-Reply-To: <1395757822-22283-1-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>

This driver implements a simple protocol
to transfer CAN messages to and from an external
microcontroller via SPI interface.
Multiple busses can be tranfered on the same SPI channel.

It was tested on a i.MX35 connected to a Freescale's
HCS12 16-bit controller with 5 CAN busses.

Signed-off-by: Stefano Babic <sbabic@denx.de>

---

Changes in v2:
- drop all references to i.MX35 and HCS12

 drivers/net/can/spi/Kconfig         |   10 +
 drivers/net/can/spi/Makefile        |    1 +
 drivers/net/can/spi/spi_can.c       | 1534 +++++++++++++++++++++++++++++++++++
 include/linux/can/platform/spican.h |   36 +
 4 files changed, 1581 insertions(+)
 create mode 100644 drivers/net/can/spi/spi_can.c
 create mode 100644 include/linux/can/platform/spican.h

diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
index 148cae5..299d71ca 100644
--- a/drivers/net/can/spi/Kconfig
+++ b/drivers/net/can/spi/Kconfig
@@ -7,4 +7,14 @@ config CAN_MCP251X
 	---help---
 	  Driver for the Microchip MCP251x SPI CAN controllers.
 
+config CAN_SPI
+	tristate "Support for CAN over SPI"
+	depends on CAN_DEV
+	---help---
+	  Driver to transfer CAN messages to a microcontroller
+	  connected via the SPI interface using a simple messaged based
+	  protocol.
+
+	  Say Y here if you want to support for CAN to SPI.
+
 endmenu
diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
index 90bcacf..0fd2126 100644
--- a/drivers/net/can/spi/Makefile
+++ b/drivers/net/can/spi/Makefile
@@ -4,5 +4,6 @@
 
 
 obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
+obj-$(CONFIG_CAN_SPI)		+= spi_can.o
 
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/spi/spi_can.c b/drivers/net/can/spi/spi_can.c
new file mode 100644
index 0000000..aee924a
--- /dev/null
+++ b/drivers/net/can/spi/spi_can.c
@@ -0,0 +1,1534 @@
+/*
+ * (C) Copyright 2012-2014
+ * Stefano Babic, DENX Software Engineering, sbabic@denx.de.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/netdevice.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/kthread.h>
+#include <linux/workqueue.h>
+#include <linux/can/platform/spican.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio.h>
+#include <linux/net_tstamp.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+
+#define MAX_CAN_CHANNELS	16
+#define CFG_CHANNEL		0xFF
+#define DRV_NAME		"canoverspi"
+#define DRV_VERSION		"0.10"
+
+/* SPI constants */
+#define SPI_MAX_FRAME_LEN	1472	/* max total length of a SPI frame */
+#define BITS_X_WORD		32	/* 4 bytes */
+#define SPI_MIN_TRANSFER_LENGTH	32	/* Minimum SPI frame length */
+#define CAN_FRAME_MAX_DATA_LEN	8	/* max data lenght in a CAN message */
+#define MAX_ITERATIONS		100	/* Used to check if GPIO stucks */
+#define SPI_CAN_ECHO_SKB_MAX	4
+#define SLAVE_CLK_FREQ		100000000
+#define SLAVE_SUPERVISOR_FREQ	((u32)1000000)
+
+#define IS_GPIO_ACTIVE(p)	(!!gpio_get_value(p->gpio) == p->gpio_active)
+#define MS_TO_US(ms)		(ms * 1000)
+
+/* more RX buffers are required for delayed processing */
+#define	SPI_RX_NBUFS		MAX_CAN_CHANNELS
+
+/* CAN channel status to drop not required frames */
+enum {
+	CAN_CHANNEL_DISABLED = 0,
+	CAN_CHANNEL_ENABLED	= 1,
+};
+
+/* operational mode to set the SPI frequency */
+enum {
+	SLAVE_SUPERVISOR_MODE	= 0,
+	SLAVE_USER_MODE		= 1,
+};
+
+/* Message between Master and Slave
+ *
+ * see spi_can_spi.txt for details
+ *
+ *	,'''''''','''''''''''''''','''''''''''''''''''''''','''''''''''''|
+ *	|MSG ID  |  Length(16 bit)|    DATA                |  CHECKSUM   |
+ *	L________|________________|________________________|_____________|
+ */
+struct spi_can_frame_header {
+	u8	msgid;
+	u16	length;
+} __packed;
+
+struct spi_can_frame {
+	struct spi_can_frame_header	header;
+	u8	data[1];
+} __packed;
+
+/* Message IDs for SPI Frame */
+enum msg_type {
+	SPI_MSG_STATUS_REQ	= 0x01,
+	SPI_MSG_SEND_DATA	= 0x02,
+	SPI_MSG_SYNC		= 0x03,
+	SPI_MSG_CFG		= 0x04,
+	SPI_MSG_REQ_DATA	= 0x05
+};
+
+/* CAN data sent inside a
+ * SPI_MSG_SEND_DATA message
+ *
+ *  _____,________________
+ * |     |                ,''''''''''''''''',''''''''''''|       ,'''''''|
+ * |ID=2 | LENGTH         | CAN MESSAGE     |CAN MESSAGE |       |CHECKSUM
+ * |_____L________________|_________________|____________|       L_______|
+ *                    _.-'                  `--._
+ *               _,,-'                           ``-.._
+ *           _.-'                                      `--._
+ *      _,--'                                               ``-.._
+ *  ,.-'                                                          `-.._
+ *  ,'''''',''''''''''''','''''''''''''','''''',''''''|     ,'''''''''|
+ *  | CH   |TIMESTAMP    |  CAN ID      |DLC   |D[0]  |     |D[dlc-1] |
+ *  L______L_____________|______________L______|______|     L_________|
+ */
+
+struct msg_channel_data {
+	u8	channel;
+	u32	timestamp;
+	u32	can_id;
+	u8	dlc;
+	u8	data[8];
+} __packed;
+
+/* CFG message */
+struct msg_cfg_data {
+	u8	channel;
+	u8	enabled;
+	struct can_bittiming bt;
+} __packed;
+
+/* Status message */
+struct msg_status_data {
+	u16	length;
+} __packed;
+
+/* The ndo_start_xmit entry point
+ * insert the CAN messages into a list that
+ * is then read by the working thread.
+ */
+struct msg_queue_tx {
+	struct list_head	list;
+	u32			channel;
+	u32			enabled;
+	struct sk_buff		*skb;
+	u32			echo_index;
+	enum msg_type		type;
+};
+
+struct msg_queue_rx {
+	struct list_head	list;
+	struct spi_can_frame	*frame;
+	u32			len;
+	u32			bufindex;
+};
+
+struct spi_rx_data {
+	u8 __aligned(4) spi_rx_buf[SPI_MAX_FRAME_LEN];
+	u32		msg_in_buf;
+	struct mutex	bufmutex;
+};
+
+/* Private data for the SPI device. */
+struct spi_can_data {
+	struct spi_device	*spi;
+	u32			gpio;
+	u32			gpio_active;
+	u32			num_channels;
+	u32			freq;
+	u32			slow_freq;
+	u32			max_freq;
+	u32			slave_op_mode;
+	struct net_device	*can_dev[MAX_CAN_CHANNELS + 1];
+	spinlock_t		lock;
+	struct msg_queue_tx	msgtx;
+	struct msg_queue_rx	msgrx;
+	struct mutex		lock_wqlist;
+	wait_queue_head_t	wait;
+	struct workqueue_struct *wq;
+	struct work_struct	work;
+	/* buffers must be 32-bit aligned  ! */
+	u8 __aligned(4)		spi_tx_buf[SPI_MAX_FRAME_LEN];
+	struct spi_rx_data	rx_data[SPI_RX_NBUFS];
+	/* Statistics and debug data */
+	u32			spibytes;
+	u32			maxreqbytes;
+	u32			cantxmsg;
+	u32			canrxmsg;
+	u32			cfgmsg;
+	u32			messages_in_queue;
+	u32			average_length;
+	u32			current_length;
+	u32			short_frames;
+	u32			spi_sent_frames;
+	struct timeval		refTime;
+};
+
+/* Default Values */
+static struct can_bittiming_const spi_can_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = 4,
+	.tseg1_max = 16,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+
+/* Private data of the CAN devices */
+struct spi_can_priv {
+	struct can_priv		can;
+	struct net_device	*dev;
+	struct spi_can_data	*spi_priv;
+	u32			channel;
+	u32			devstatus;
+	u32			echo_index[SPI_CAN_ECHO_SKB_MAX];
+};
+
+/* Pointer to the worker task */
+static struct task_struct *spi_can_task;
+
+/* Provide a way to disable checksum */
+static unsigned int chksum_en;
+module_param(chksum_en, uint, 0);
+MODULE_PARM_DESC(chksum_en,
+	"Enable checksum test on received frames (default is disabled)");
+static unsigned int freq;
+module_param(freq, uint, 0);
+MODULE_PARM_DESC(freq,
+	"SPI clock frequency (default is set by platform device)");
+static unsigned int slow_freq;
+module_param(slow_freq, uint, 0);
+MODULE_PARM_DESC(slow_freq,
+	"SPI clock frequency to be used in supervisor mode (default 1 Mhz)");
+static unsigned int debug;
+module_param(debug, uint, 0);
+MODULE_PARM_DESC(freq, "enables dump of received bytes");
+
+#define SHOW_SYS_ATTR(name, get)				\
+static ssize_t show_##name(struct device *dev,			\
+			       struct device_attribute *attr,	\
+			       char *buf)			\
+{								\
+	struct spi_can_data *spi_data = dev_get_drvdata(dev);	\
+	return sprintf(buf, "%d\n", spi_data->get);		\
+}								\
+static DEVICE_ATTR(name, S_IRUGO, show_##name, NULL);
+
+SHOW_SYS_ATTR(spi_sent_bytes, spibytes);
+SHOW_SYS_ATTR(max_req_bytes, maxreqbytes);
+SHOW_SYS_ATTR(canmsg_sent, cantxmsg);
+SHOW_SYS_ATTR(canmsg_received, canrxmsg);
+SHOW_SYS_ATTR(cfgmsg_sent, cfgmsg);
+SHOW_SYS_ATTR(messages_in_queue, messages_in_queue);
+SHOW_SYS_ATTR(average_length, average_length);
+SHOW_SYS_ATTR(current_length, current_length);
+SHOW_SYS_ATTR(short_frames, short_frames);
+SHOW_SYS_ATTR(spi_sent_frames, spi_sent_frames);
+
+static struct attribute *sysfs_attrs[] = {
+	&dev_attr_spi_sent_bytes.attr,
+	&dev_attr_max_req_bytes.attr,
+	&dev_attr_canmsg_sent.attr,
+	&dev_attr_canmsg_received.attr,
+	&dev_attr_cfgmsg_sent.attr,
+	&dev_attr_messages_in_queue.attr,
+	&dev_attr_average_length.attr,
+	&dev_attr_current_length.attr,
+	&dev_attr_short_frames.attr,
+	&dev_attr_spi_sent_frames.attr,
+	NULL
+};
+
+static struct attribute_group slave_attribute_group = {
+	.attrs = sysfs_attrs
+};
+
+static void dump_frame(u8 *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < min(len, SPI_MAX_FRAME_LEN); i++) {
+		if (!(i % 16))
+			printk(KERN_ERR "\n0x%04X: ", i);
+		printk("0x%02x ", *buf++);
+	}
+	printk("\n");
+}
+
+static inline u16 compute_checksum(char *buf, u32 len)
+{
+	int i;
+	u16 chksum = 0;
+
+	if (!chksum_en)
+		return 0;
+	for (i = 0; i < len; i++, buf++)
+		chksum += *buf;
+
+	return (~chksum + 1) & 0xFFFF;
+}
+
+static u32 verify_checksum(struct spi_device *spi, char *buf, u32 len)
+{
+	int i = 0;
+	u16 chksum = 0;
+	u16 received_checksum;
+	u32 nwords = 0;
+	u32 end = len - 2;
+	u32 val;
+
+	if (!chksum_en)
+		return 0;
+
+	if (!((u32)buf & 0x03)) {
+		nwords = (end / 4);
+		for (i = 0 ; i < nwords; i++, buf += 4) {
+			val = *(u32 *)buf;
+			chksum += (val & 0xFF) + ((val & 0xFF00) >> 8) +
+				((val & 0xFF0000) >> 16) + (val >> 24);
+		}
+	}
+
+	for (i = nwords * 4; i < len - 2; i++, buf++)
+		chksum += *buf;
+
+	/* The last two bytes contain the checksum as 16 bit value */
+	received_checksum = *buf++;
+	received_checksum =  (received_checksum << 8) + *buf;
+
+	if ((chksum + received_checksum) & 0xFFFF) {
+		dev_err(&spi->dev,
+		"Received wrong checksum: computed 0x%04x received 0x%04x\n",
+		chksum, received_checksum);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+/* The protocol requires to send data in big-endian
+ * format. The processor can have a different endianess.
+ * Because the protocol uses 32 bits x word (bits sent
+ * in one chip select cycle), the function checks that the buffer
+ * length is a multiple of four.
+ */
+static int format_frame_output(char *buf, int len)
+{
+	u32 *p;
+	int cnt;
+
+	if (len % (BITS_X_WORD / 8))
+		return -1;
+
+	len /= (BITS_X_WORD / 8);
+	p = (u32 *)buf;
+
+	for (cnt = 0; cnt < len; cnt++, p++)
+		*p = cpu_to_be32(*p);
+
+	return 0;
+}
+
+static int format_frame_input(char *buf, int len)
+{
+	u32 *p;
+	int cnt;
+
+	if (len % (BITS_X_WORD / 8))
+		return -1;
+
+	len /= (BITS_X_WORD / 8);
+	p = (u32 *)buf;
+
+	for (cnt = 0; cnt < len; cnt++, p++)
+		*p = be32_to_cpu(*p);
+
+	return 0;
+}
+
+/* The processor manages 32-bit aligned buffer.
+ * At least 32 bytes are always sent.
+ * The function fills the buffer with trailing zero to fullfill
+ * these requirements
+ */
+static int fix_spi_len(char *buf, u32 len)
+{
+	int tmp;
+
+	if (len < SPI_MIN_TRANSFER_LENGTH) {
+		memset(&buf[len], 0, SPI_MIN_TRANSFER_LENGTH - len);
+		len = SPI_MIN_TRANSFER_LENGTH;
+	}
+
+	tmp = len % (BITS_X_WORD / 8);
+	if (tmp) {
+		tmp = (BITS_X_WORD / 8) - tmp;
+		memset(&buf[len], 0, tmp);
+		len += tmp;
+	}
+
+	return len;
+}
+
+static int check_rx_len(u32 len, u16 frame_len)
+{
+	if (frame_len > len ||
+		frame_len < sizeof(struct spi_can_frame_header))
+		return -1;
+
+	return 0;
+}
+
+static void spi_can_set_timestamps(struct sk_buff *skb,
+	struct msg_channel_data *msg)
+{
+	msg->timestamp = ktime_to_ns(skb->tstamp);
+}
+
+static struct net_device *candev_from_channel(struct spi_can_data *spi_data,
+	u8 channel)
+{
+	/* Last device is the CFG device */
+	if (channel == CFG_CHANNEL)
+		return spi_data->can_dev[spi_data->num_channels];
+	else
+		return spi_data->can_dev[channel];
+}
+
+static int insert_cfg_msg(struct net_device *dev, int enabled)
+{
+	struct spi_can_priv *priv = netdev_priv(dev);
+	struct spi_can_data	*spi_priv = priv->spi_priv;
+	struct msg_queue_tx *tx_pkt;
+	unsigned long flags;
+
+	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
+	if (!tx_pkt) {
+		dev_err(&dev->dev, "out of memory");
+		return -ENOMEM;
+	}
+	tx_pkt->channel = priv->channel;
+	tx_pkt->enabled = enabled;
+	tx_pkt->type = SPI_MSG_CFG;
+
+	priv->devstatus = enabled;
+
+	spin_lock_irqsave(&spi_priv->lock, flags);
+	list_add_tail(&(tx_pkt->list), &(spi_priv->msgtx.list));
+	spi_priv->messages_in_queue++;
+	spin_unlock_irqrestore(&spi_priv->lock, flags);
+
+	/*  Wakeup thread */
+	wake_up_interruptible(&spi_priv->wait);
+
+	return 0;
+}
+
+static int spi_can_open(struct net_device *dev)
+{
+	int ret;
+
+	ret = open_candev(dev);
+	if (ret)
+		return ret;
+
+	ret = insert_cfg_msg(dev, CAN_CHANNEL_ENABLED);
+	if (ret)
+		return ret;
+
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+static int spi_can_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+
+	insert_cfg_msg(dev, CAN_CHANNEL_DISABLED);
+
+	close_candev(dev);
+
+	return 0;
+}
+
+static int spi_can_hwtstamp_ioctl(struct net_device *netdev,
+	struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	if (config.flags)
+		return -EINVAL;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+	case HWTSTAMP_TX_ON:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	default:
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	}
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
+static int spi_can_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	if (cmd == SIOCSHWTSTAMP)
+		return spi_can_hwtstamp_ioctl(dev, rq, cmd);
+
+	return -EINVAL;
+}
+
+static int spi_can_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	int err;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		err =  0;
+		if (err)
+			return err;
+
+		netif_wake_queue(dev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int spi_can_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct spi_can_priv *priv = netdev_priv(dev);
+	struct spi_can_data	*spi_priv = priv->spi_priv;
+	struct msg_queue_tx *tx_pkt;
+	unsigned long flags;
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
+	tx_pkt->channel = priv->channel;
+	tx_pkt->skb = skb;
+	tx_pkt->type = SPI_MSG_SEND_DATA;
+	INIT_LIST_HEAD(&(tx_pkt->list));
+
+	/* Add the incoming message to the end of the list */
+	spin_lock_irqsave(&spi_priv->lock, flags);
+	list_add_tail(&(tx_pkt->list), &(spi_priv->msgtx.list));
+	spi_priv->messages_in_queue++;
+	spin_unlock_irqrestore(&spi_priv->lock, flags);
+
+	/*  Wakeup thread */
+	wake_up_interruptible(&spi_priv->wait);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops spi_can_netdev_ops = {
+	.ndo_open	= spi_can_open,
+	.ndo_stop	= spi_can_close,
+	.ndo_start_xmit	= spi_can_start_xmit,
+	.ndo_do_ioctl = spi_can_ioctl,
+};
+
+/* GPIO Interrupt Handler.
+ * when the Slave has something to send, it raises
+ * an interrupt changing a GPIO. The handler does
+ * nothing else than waking up the worker.
+ */
+static irqreturn_t spi_can_irq(int irq, void *pdata)
+{
+	struct spi_can_data *spi_priv = (struct spi_can_data *)pdata;
+	int val;
+
+	val = gpio_get_value(spi_priv->gpio);
+
+	/* Wakeup thread */
+	wake_up_interruptible(&spi_priv->wait);
+
+	return IRQ_HANDLED;
+}
+
+/* The parameters for SPI are fixed and cannot be changed due
+ * to hardware limitation in Slave.
+ * Only the frequency can be changed
+ */
+static void spi_can_initialize(struct spi_device *spi, u32 freq)
+{
+	/* Configure the SPI bus */
+	spi->mode = SPI_MODE_1;
+	spi->bits_per_word = BITS_X_WORD;
+	spi_setup(spi);
+}
+
+static int spi_can_transfer(struct spi_can_data *priv,
+				u32 bufindex, int len)
+{
+	struct spi_device *spi = priv->spi;
+	struct spi_message m;
+	struct spi_transfer t;
+	int ret = 0;
+
+	memset(&t, 0, sizeof(struct spi_transfer));
+	t.tx_buf = priv->spi_tx_buf;
+	t.rx_buf = priv->rx_data[bufindex].spi_rx_buf;
+	t.len = len;
+	t.cs_change = 0;
+	if (priv->freq)
+		t.speed_hz = priv->freq;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
+
+	ret = spi_sync(spi, &m);
+	if (ret)
+		dev_err(&spi->dev, "spi transfer failed: ret = %d\n", ret);
+	return ret;
+}
+
+/* Prepare a SYNC message to synchronize with the start of frame */
+static u32 spi_can_spi_sync_msg(struct spi_can_data *spi_data, char *buf)
+{
+	struct spi_can_frame_header *header;
+	int len;
+
+	header = (struct spi_can_frame_header *)spi_data->spi_tx_buf;
+
+	header->msgid = SPI_MSG_SYNC;
+	*buf++ = 0xAA;
+	*buf++ = 0x55;
+	*buf++ = 0x55;
+	*buf++ = 0xAA;
+	len = 4;
+
+	do_gettimeofday(&spi_data->refTime);
+
+	return len;
+}
+
+static int spi_can_fill_skb_msg(struct net_device *dev,
+	struct msg_channel_data *pcan, struct timeval *timeref)
+{
+	struct spi_can_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	struct skb_shared_hwtstamps *shhwtstamps;
+	ktime_t tstamp;
+	u64 ns;
+
+	if (priv->devstatus != CAN_CHANNEL_ENABLED) {
+		dev_err(&dev->dev, "frame received when CAN deactivated\n");
+		return 1;
+	}
+	skb = alloc_can_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 1;
+	}
+
+	cf->can_id = pcan->can_id;
+	cf->can_dlc = pcan->dlc;
+	memcpy(cf->data, pcan->data,  pcan->dlc);
+
+	/* Set HW timestamps */
+	shhwtstamps = skb_hwtstamps(skb);
+	memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+	ns = MS_TO_US(pcan->timestamp);
+	tstamp = ktime_add_us(timeval_to_ktime(*timeref), ns);
+	shhwtstamps->hwtstamp = tstamp;
+	skb->tstamp = tstamp;
+
+	netif_receive_skb(skb);
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	return 0;
+}
+
+/* parse_can_msg gets all CAN messages encapsulated
+ * in a SEND_DATA message, and sends them upstream
+ */
+static int parse_can_msg(struct spi_can_data *spi_data,
+	struct spi_can_frame *frame,
+	int len)
+{
+	struct msg_channel_data *pcan;
+	char *pbuf = frame->data;
+	struct spi_device *spi = spi_data->spi;
+	struct net_device	*netdev;
+	u32 can_msg_length;
+	u32 ret = 0;
+
+	while (len > 0) {
+		if (len < sizeof(struct msg_channel_data) -
+			CAN_FRAME_MAX_DATA_LEN) {
+			dev_err(&spi->dev,
+				"Received incompleted CAN message: length %d pbuf 0x%x\n",
+				len, *pbuf);
+			ret = -1;
+			break;
+		}
+		pcan = (struct msg_channel_data *)pbuf;
+		if ((pcan->channel > spi_data->num_channels) &&
+			(pcan->channel != CFG_CHANNEL)) {
+			dev_err(&spi->dev,
+				"Frame with wrong channel %d, frame dropped",
+				pcan->channel);
+			ret = -1;
+			break;
+		}
+
+		/* Check for a valid CAN message lenght */
+		if (pcan->dlc > CAN_FRAME_MAX_DATA_LEN) {
+			dev_err(&spi->dev,
+				"CAN message with wrong length: id 0x%x dlc %d",
+				pcan->can_id, pcan->dlc);
+			ret = -1;
+			break;
+		}
+
+		pcan->can_id = be32_to_cpu(pcan->can_id);
+		pcan->timestamp = be32_to_cpu(pcan->timestamp);
+
+		/* Get the device corresponding to the channel */
+		netdev = candev_from_channel(spi_data, pcan->channel);
+
+		if (spi_can_fill_skb_msg(netdev, pcan, &spi_data->refTime))
+			dev_err(&spi->dev,
+				"Error sending data to upper layer");
+		can_msg_length = (sizeof(struct msg_channel_data) + pcan->dlc -
+			CAN_FRAME_MAX_DATA_LEN);
+
+		len -= can_msg_length;
+		pbuf += can_msg_length;
+		spi_data->canrxmsg++;
+	}
+
+	return ret;
+}
+
+
+static void spi_can_extract_msg(struct spi_can_data *spi_data,
+	struct msg_queue_rx *msg)
+{
+	/* Extract all CAN messages, do not check
+	 * the last two bytes as they are reserved for checksum
+	 */
+	mutex_lock(&spi_data->rx_data[msg->bufindex].bufmutex);
+	if (parse_can_msg(spi_data, msg->frame, msg->len - 2) < 0) {
+		if (debug)
+			dump_frame(spi_data->rx_data[msg->bufindex].spi_rx_buf,
+					msg->len);
+	}
+
+	/* I can now set the message as processed and decrease
+	 * the number of messages in the SPI buffer.
+	 * When all messages are processed, the TX thread
+	 * can use the SPI buffer again
+	 */
+	spi_data->rx_data[msg->bufindex].msg_in_buf--;
+	mutex_unlock(&spi_data->rx_data[msg->bufindex].bufmutex);
+}
+
+static void spi_can_rx_handler(struct work_struct *ws)
+{
+	struct spi_can_data *spi_data = container_of(ws,
+			struct spi_can_data, work);
+	struct msg_queue_rx *msg;
+
+	while (1) {
+
+		if (list_empty(&spi_data->msgrx.list))
+			break;
+
+		mutex_lock(&spi_data->lock_wqlist);
+		msg = list_first_entry(&spi_data->msgrx.list,
+				struct msg_queue_rx, list);
+		list_del(&msg->list);
+		mutex_unlock(&spi_data->lock_wqlist);
+
+		spi_can_extract_msg(spi_data, msg);
+		kfree(msg);
+	}
+}
+
+/* This is called in overload condition to process a siongle frame and
+ * free a SPI frame for transfer
+ * This is called by the thread
+ */
+static void spi_can_process_single_frame(struct spi_can_data *spi_data,
+	u32 index)
+{
+	struct list_head *pos;
+	struct msg_queue_rx *msg;
+	u32 found = 0, freed;
+
+	mutex_lock(&spi_data->lock_wqlist);
+	list_for_each(pos, &spi_data->msgrx.list) {
+		msg = list_entry(pos, struct msg_queue_rx, list);
+		if (msg->bufindex == index) {
+			found = 1;
+			break;
+		}
+	}
+
+	/* Drop the message from the list */
+	if (found)
+		list_del(&msg->list);
+	mutex_unlock(&spi_data->lock_wqlist);
+
+	if (!found) {
+
+		/* I cannot parse the buffer because it is worked
+		 * by another task, check when it is finished
+		 */
+
+		do {
+			mutex_lock(&spi_data->rx_data[index].bufmutex);
+			freed = (spi_data->rx_data[index].msg_in_buf == 0);
+			mutex_unlock(&spi_data->rx_data[index].bufmutex);
+		} while (!freed);
+
+		return;
+	}
+
+	spi_can_extract_msg(spi_data, msg);
+
+}
+
+static u32 spi_can_receive(struct spi_can_data *spi_data,
+	int len, int bufindex, u16 *req_bytes)
+{
+	int i, start = 0;
+	char *pbuf, *pspibuf;
+	struct spi_can_frame *frame;
+	struct msg_status_data *status_msg;
+	struct msg_queue_rx	*rxmsg;
+	u16 rx_len;
+	struct spi_device *spi = spi_data->spi;
+	u32 rx_frames = 0;
+
+	pspibuf = spi_data->rx_data[bufindex].spi_rx_buf;
+	format_frame_input(pspibuf, len);
+
+	/* Requested bytes for next SPI frame.
+	 * The value is updated by a SEND_STATUS message.
+	 */
+	*req_bytes = 0;
+
+	while ((len - start) > 1) {
+		/* first search for start of frame */
+		for (i = start; i < len; i++) {
+			if (pspibuf[i] != 0)
+				break;
+		}
+
+		/* No more frame to be examined */
+		if (i == len)
+			return rx_frames;
+
+		/* Set start in the buffer for next iteration */
+		start = i;
+
+		frame = (struct spi_can_frame *)&pspibuf[i];
+		switch (frame->header.msgid) {
+		case SPI_MSG_STATUS_REQ:
+			status_msg = (struct msg_status_data *)frame->data;
+			rx_len = be16_to_cpu(status_msg->length);
+			*req_bytes = rx_len;
+			rx_frames++;
+			break;
+
+		case SPI_MSG_SEND_DATA:
+			rx_len = be16_to_cpu(frame->header.length);
+			if (check_rx_len(len - start, rx_len)) {
+				dev_err(&spi->dev,
+				"Frame fragmented received, frame dropped\n");
+				if (debug)
+					dump_frame(pspibuf, len);
+				return -EPROTO;
+			}
+			if (verify_checksum(spi, (char *)frame,
+				rx_len + sizeof(frame->header)) < 0)
+				return -EPROTO;
+			pbuf = frame->data;
+
+			/* Put the recognized frame into the receive list
+			 * to be processed by the workqueue
+			 */
+			rxmsg = kzalloc(sizeof(struct msg_queue_rx),
+					GFP_KERNEL);
+			if (!rxmsg) {
+				dev_err(&spi->dev, "out of memory");
+				return -ENOMEM;
+			}
+			rxmsg->frame = frame;
+			rxmsg->len = rx_len;
+			rxmsg->bufindex = bufindex;
+
+			/* Add the frame to be processed to the rx list */
+			mutex_lock(&spi_data->lock_wqlist);
+			spi_data->rx_data[bufindex].msg_in_buf++;
+			if (spi_data->rx_data[bufindex].msg_in_buf > 1)
+				dev_err(&spi->dev, "More as one SEND_DATA\n");
+			list_add_tail(&(rxmsg->list), &spi_data->msgrx.list);
+			mutex_unlock(&spi_data->lock_wqlist);
+
+			rx_frames++;
+			break;
+
+		default:
+			dev_err(&spi->dev, "wrong frame received with MSG-ID=0x%x\n",
+				frame->header.msgid);
+			if (debug)
+				dump_frame(pspibuf, len);
+			return -EPROTO;
+		}
+
+		rx_len += sizeof(frame->header);
+		start += rx_len;
+	}
+
+	return rx_frames;
+}
+
+/* The function sends setup for the
+ * CAN channel. No answer is allowed from Slave,
+ * as this is a high-priority message.
+ */
+static u32 spi_can_cfg(struct spi_can_data *spi_data,
+	struct msg_queue_tx *msg, char *buf)
+{
+	struct net_device *dev;
+	struct spi_can_priv *priv;
+	struct msg_cfg_data can_cfg;
+	struct spi_device *spi = spi_data->spi;
+	int i;
+	u32 *pbe_bt, *pbt;
+	u8 channel;
+
+	channel = msg->channel & 0xFF;
+
+	can_cfg.channel = channel;
+	can_cfg.enabled = msg->enabled;
+
+	dev = candev_from_channel(spi_data, channel);
+	priv = netdev_priv(dev);
+
+	/* Configuration values are interpreted by the Slave
+	 * firmware only. Values on the SPI line are in big
+	 * endian order and must be converted before to be put
+	 * on the line.
+	 */
+	for (i = 0, pbe_bt = (u32 *)&can_cfg.bt,
+		pbt = (u32 *)&priv->can.bittiming;
+		i < (sizeof(struct can_bittiming) / sizeof(*pbe_bt));
+		i += sizeof(u32)) {
+			*pbe_bt++ = cpu_to_be32(*pbt++);
+	}
+
+	memcpy(buf, &can_cfg, sizeof(can_cfg));
+
+	if (channel == CFG_CHANNEL) {
+		u32 changed = 0;
+		switch (spi_data->slave_op_mode) {
+		case SLAVE_SUPERVISOR_MODE:
+			if (priv->can.bittiming.bitrate > 125000) {
+				spi_data->freq = spi_data->max_freq;
+				spi_data->slave_op_mode = SLAVE_USER_MODE;
+				changed = 1;
+			}
+			break;
+		case SLAVE_USER_MODE:
+			if (priv->can.bittiming.bitrate <= 125000) {
+				spi_data->freq = spi_data->slow_freq;
+				spi_data->slave_op_mode = SLAVE_SUPERVISOR_MODE;
+				changed = 1;
+			}
+			break;
+		default:
+			dev_err(&spi_data->spi->dev, "Erroneous Slave OP Mode %d\n",
+				spi_data->slave_op_mode);
+			spi_data->slave_op_mode = SLAVE_SUPERVISOR_MODE;
+		}
+		if (changed) {
+			spi_can_initialize(spi, spi_data->freq);
+			dev_info(&spi->dev,
+				"Slave into %s mode, SPI frequency set to %d\n",
+				(spi_data->slave_op_mode == SLAVE_USER_MODE) ?
+					"User" : "Supervisor",
+				spi_data->freq);
+		}
+	}
+
+	return sizeof(struct msg_cfg_data);
+}
+
+static u32 spi_can_send_data(struct spi_can_data *spi_data,
+	struct msg_queue_tx *msg, char *buf)
+{
+	struct sk_buff		*skb;
+	struct msg_channel_data can_spi_msg;
+	struct can_frame *frame;
+	u16 len = 0;
+	struct spi_can_priv *priv;
+	struct net_device *dev;
+	struct net_device_stats *stats;
+
+	/* Encapsulate the CAN message inside the SPI frame */
+	skb = msg->skb;
+	frame = (struct can_frame *)skb->data;
+	if (frame->can_dlc > CAN_FRAME_MAX_DATA_LEN)
+		frame->can_dlc = CAN_FRAME_MAX_DATA_LEN;
+
+	can_spi_msg.channel = msg->channel & 0xFF;
+
+	spi_can_set_timestamps(skb, &can_spi_msg);
+
+	can_spi_msg.can_id = cpu_to_be32(frame->can_id);
+	can_spi_msg.dlc = frame->can_dlc;
+	memcpy(can_spi_msg.data,
+		frame->data, frame->can_dlc);
+	len =  sizeof(struct msg_channel_data) +
+		frame->can_dlc - CAN_FRAME_MAX_DATA_LEN;
+	memcpy(buf, &can_spi_msg, len);
+
+	dev = candev_from_channel(spi_data, can_spi_msg.channel);
+	priv = netdev_priv(dev);
+
+	/* Update statistics for device */
+	stats = &dev->stats;
+	stats->tx_bytes += frame->can_dlc;
+	stats->tx_packets++;
+	netif_wake_queue(dev);
+
+	return len;
+}
+
+static int spi_can_thread(void *data)
+{
+	struct spi_can_data *spi_data = (struct spi_can_data *)data;
+	u16 len = 0;
+	u16 alen = 0;
+	u16 req_bytes = 0;
+	u32 cnt = 0, resync_required = 1;
+	u32 bufindex = 0;
+	u32 rx_frames;
+	struct msg_queue_tx	*msg, *tmp;
+	char *buf;
+	struct spi_can_frame_header *header;
+	u16 chksum;
+	unsigned long flags;
+	struct spi_device *spi = spi_data->spi;
+
+	/* Only to zero the whole buffers */
+	len = SPI_MAX_FRAME_LEN;
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+
+		if (spi_data->rx_data[bufindex].msg_in_buf)
+			spi_can_process_single_frame(spi_data, bufindex);
+
+		/* Clear buffers from last transfer */
+		memset(spi_data->spi_tx_buf, 0, len);
+
+		len = 0;
+		header = (struct spi_can_frame_header *)spi_data->spi_tx_buf;
+		buf = ((struct spi_can_frame *)spi_data->spi_tx_buf)->data;
+
+		/* There is not yet any message */
+		header->msgid = 0;
+
+		/* getting CAN message from upper layer */
+		spin_lock_irqsave(&spi_data->lock, flags);
+		list_for_each_entry_safe(msg, tmp,
+			&spi_data->msgtx.list, list) {
+
+			/* we cannot mix messages of different type.
+			 * If the new request is of different type,
+			 * stop scanning the list
+			 * and send the actual message first
+			 */
+			if (header->msgid && (header->msgid != msg->type))
+				break;
+
+			/* Extract packet and remove it from the list */
+			spi_data->messages_in_queue--;
+			list_del(&msg->list);
+
+			alen = 0;
+
+			switch (msg->type) {
+
+			case SPI_MSG_SEND_DATA:
+				/* There are data to be sent */
+				header->msgid = SPI_MSG_SEND_DATA;
+				alen = spi_can_send_data(spi_data, msg, buf);
+				spi_data->cantxmsg++;
+				break;
+
+			case SPI_MSG_CFG:
+				header->msgid = SPI_MSG_CFG;
+				alen = spi_can_cfg(spi_data, msg, buf);
+				spi_data->cfgmsg++;
+				break;
+
+			default:
+				dev_err(&spi->dev,
+					"Message to Slave wrong: type %d",
+					msg->type);
+			}
+
+			/* Update total length with length of CAN message */
+			len += alen;
+			buf += alen;
+
+			/* Free the memory for message, not used anymore */
+			if (msg->skb)
+				kfree_skb(msg->skb);
+			kfree(msg);
+
+			/* Check if there is enough place for other messages
+			 * else messages will be transfered in the next
+			 * iteration
+			 */
+			if ((len + sizeof(chksum) +
+				sizeof(*header) +
+				sizeof(u32)) >= SPI_MAX_FRAME_LEN)
+					break;
+		}
+		spin_unlock_irqrestore(&spi_data->lock, flags);
+
+		/* Check if a resync is required. It is sent
+		 * the first time the thread is started and when an error
+		 * is recognized. Not required if data must be sent.
+		 */
+		if (!len) {
+			if (resync_required) {
+				len = spi_can_spi_sync_msg(spi_data, buf);
+				resync_required = 0;
+			} else {
+				header->msgid = SPI_MSG_REQ_DATA;
+				len = max(req_bytes,
+					(u16)((SPI_MIN_TRANSFER_LENGTH) -
+					sizeof(*header) -
+					sizeof(u16) /* checksum */));
+			}
+			buf += len;
+		} else {
+			int delta = req_bytes - len;
+			if ((delta > 0) &&
+				(header->msgid == SPI_MSG_SEND_DATA)) {
+
+				/* buf points to the next CAN message */
+				buf += delta;
+				len += delta;
+			}
+		}
+
+		/* Take into account CHECKSUM
+		 * MSGID and LENGTH are not computed in the lenght field
+		 */
+		len += sizeof(chksum);
+		header->length = cpu_to_be16(len);
+		len += sizeof(*header);
+
+		/* Compute checksum */
+		chksum = compute_checksum(spi_data->spi_tx_buf,
+					  len - sizeof(chksum));
+		chksum = cpu_to_be16(chksum);
+		memcpy(buf, &chksum, sizeof(chksum));
+
+		len = fix_spi_len(spi_data->spi_tx_buf, len);
+
+		format_frame_output(spi_data->spi_tx_buf, len);
+		spi_data->spibytes += len;
+
+		spi_data->average_length =
+			(spi_data->average_length + len) >> 1;
+		spi_data->current_length = len;
+		if (len == 32)
+			spi_data->short_frames++;
+		spi_data->spi_sent_frames++;
+
+		spi_can_transfer(spi_data, bufindex, len);
+		rx_frames = spi_can_receive(spi_data, len, bufindex,
+				&req_bytes);
+
+		/* Trigger the workqueue for RX processing */
+		queue_work(spi_data->wq, &spi_data->work);
+
+		if (rx_frames < 0)
+			resync_required = 1;
+
+		if (req_bytes > spi_data->maxreqbytes)
+			spi_data->maxreqbytes = req_bytes;
+
+		bufindex++;
+		if (bufindex == SPI_RX_NBUFS)
+			bufindex = 0;
+
+		/* Check if the GPIO is still set,
+		 * because the Slave wants to send more data
+		 */
+		if (IS_GPIO_ACTIVE(spi_data) && (rx_frames <= 0))  {
+			cnt++;
+			if (cnt > MAX_ITERATIONS) {
+				dev_err(&spi->dev,
+				"GPIO stuck ! Send SYNC message");
+				resync_required = 1;
+				cnt = 0;
+			}
+		} else {
+			cnt = 0;
+		}
+
+		wait_event_interruptible(spi_data->wait,
+			(!list_empty(&spi_data->msgtx.list) ||
+				IS_GPIO_ACTIVE(spi_data) ||
+				resync_required) ||
+				(req_bytes > 0) ||
+				kthread_should_stop());
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct spi_device_id spi_can_ids[] = {
+	{ "spican", 0},
+	{ "canoverspi", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, spi_can_ids);
+#endif
+
+static int spi_can_probe(struct spi_device *spi)
+{
+	struct net_device *dev;
+	struct spi_can_platform_data *pdata = spi->dev.platform_data;
+	int ret = -ENODEV;
+	struct spi_can_data *spi_data;
+	struct spi_can_priv *priv;
+	int index, i;
+	u32 can_channels;
+	u32 active = GPIO_ACTIVE_LOW;
+	int data_gpio;
+	u32 flags;
+
+	if (spi->dev.of_node) {
+		if (of_property_read_u32(spi->dev.of_node,
+			    "channels", &can_channels))
+			return -ENODEV;
+		if (!slow_freq) {
+			of_property_read_u32(spi->dev.of_node,
+			    "slowfreq", &slow_freq);
+		}
+		if (!freq) {
+			of_property_read_u32(spi->dev.of_node,
+			    "freq", &freq);
+		}
+		data_gpio = of_get_gpio_flags(spi->dev.of_node,
+				0, &flags);
+		active = (flags & GPIO_ACTIVE_LOW) ? 0 : 1;
+	} else {
+		if (!pdata || (pdata->can_channels < 0) ||
+			(pdata->can_channels > MAX_CAN_CHANNELS))
+			return -ENODEV;
+		if (pdata->slow_freq)
+			slow_freq = pdata->slow_freq;
+		data_gpio = pdata->gpio;
+		active = pdata->active;
+		can_channels = pdata->can_channels;
+	}
+
+	if (!gpio_is_valid(data_gpio)) {
+		dev_err(&spi->dev,
+			"Wrong data valid GPIO: %d\n",
+			data_gpio);
+		return -EINVAL;
+	}
+
+	dev_info(&spi->dev, "Channels: %d, gpio %d active %s\n",
+				can_channels,
+				data_gpio,
+				active ? "high" : "low");
+	/* It is possible to adjust frequency at loading time
+	 * if the driver is compiled as module
+	 */
+	if (freq) {
+		if (freq > spi->max_speed_hz) {
+			dev_err(&spi->dev,
+				"Frequency too high: %d Hz > %d Hz. Falling back to %d\n",
+				freq,
+				spi->max_speed_hz,
+				spi->max_speed_hz);
+			freq = spi->max_speed_hz;
+		}
+	}
+
+	/* Check if the supervisor frequency is passed as parameter
+	 * Fallback to 1 Mhz
+	 */
+	if (!slow_freq)
+		slow_freq = SLAVE_SUPERVISOR_FREQ;
+
+	if ((freq && (slow_freq > freq)) ||
+		(slow_freq > SLAVE_SUPERVISOR_FREQ)) {
+		dev_err(&spi->dev,
+			"Supervisor frequency too high: %d Hz > %d Hz. Falling back to %d\n",
+			slow_freq,
+			min(freq, SLAVE_SUPERVISOR_FREQ),
+			min(freq, SLAVE_SUPERVISOR_FREQ));
+			slow_freq = min(freq, SLAVE_SUPERVISOR_FREQ);
+	}
+
+	ret = gpio_request(data_gpio, "spican-irq");
+	if (ret) {
+		dev_err(&spi->dev,
+			"gpio %d cannot be acquired\n",
+			data_gpio);
+		return -ENODEV;
+	}
+
+	/* The SPI structure is common to all CAN devices */
+	spi_data = (struct spi_can_data *)
+		kzalloc(sizeof(struct spi_can_data), GFP_KERNEL | __GFP_ZERO);
+	if (!spi_data)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&spi_data->msgtx.list);
+	INIT_LIST_HEAD(&spi_data->msgrx.list);
+
+	/* Get the GPIO used as interrupt. The Slave raises
+	 * an interrupt when there are messages to be sent
+	 */
+	gpio_direction_input(data_gpio);
+	ret = request_irq(gpio_to_irq(data_gpio), spi_can_irq,
+		(active ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING) ,
+		"spican-rx", spi_data);
+	if (ret) {
+		gpio_free(data_gpio);
+		kfree(spi_data);
+		return -ENODEV;
+	}
+
+	spi_data->num_channels = can_channels;
+	spi_data->gpio = data_gpio;
+	spi_data->gpio_active = active;
+	spi_data->spi = spi;
+	spi_data->messages_in_queue = 0;
+	spi_data->average_length = 0;
+	spi_data->current_length = 0;
+	spi_data->short_frames = 0;
+	spi_data->spi_sent_frames = 0;
+	spi_data->max_freq = freq;
+	spi_data->slow_freq = slow_freq;
+	spi_data->freq = slow_freq;
+	spi_data->slave_op_mode = SLAVE_SUPERVISOR_MODE;
+	spin_lock_init(&spi_data->lock);
+	mutex_init(&spi_data->lock_wqlist);
+	for (index = 0; index < SPI_RX_NBUFS; index++)
+		mutex_init(&spi_data->rx_data[index].bufmutex);
+
+	/* Now alloc the CAN devices */
+	for (index = 0; index < (spi_data->num_channels + 1); index++) {
+		dev = alloc_candev(sizeof(struct spi_can_priv),
+			SPI_CAN_ECHO_SKB_MAX);
+		if (!dev) {
+			ret = -ENOMEM;
+			goto failed_candev_alloc;
+		}
+
+		/* Get the pointer to the driver data */
+		priv = netdev_priv(dev);
+
+		/* Last channel is used for configuration only */
+		if (index == spi_data->num_channels) {
+			strncpy(dev->name, "cfg", IFNAMSIZ);
+			priv->channel = CFG_CHANNEL;
+		} else {
+			snprintf(dev->name, IFNAMSIZ, "hcan%d", index);
+			priv->channel = index;
+		}
+
+		dev->netdev_ops = &spi_can_netdev_ops;
+
+		priv->spi_priv = spi_data;
+		priv->dev = dev;
+		priv->devstatus = CAN_CHANNEL_DISABLED;
+
+		spi_data->can_dev[index] = dev;
+		init_waitqueue_head(&spi_data->wait);
+
+		/* Set CAN specific parameters */
+		priv->can.clock.freq = SLAVE_CLK_FREQ;
+		priv->can.bittiming_const = &spi_can_bittiming_const;
+		priv->can.do_set_mode = spi_can_set_mode;
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;
+
+		for (i = 0; i < SPI_CAN_ECHO_SKB_MAX; i++)
+			priv->echo_index[i] = SPI_CAN_ECHO_SKB_MAX;
+
+		ret = register_candev(dev);
+		if (ret) {
+			dev_err(&spi->dev,
+				"registering netdev %d failed with 0x%x\n",
+				index, ret);
+			goto failed_register;
+		}
+
+		dev_info(&spi->dev, "CAN device %d registered\n",
+			 index);
+	}
+
+	dev_set_drvdata(&spi->dev, spi_data);
+	spi_can_initialize(spi, freq);
+
+	/* Initialize work que for RX background processing */
+	spi_data->wq = alloc_workqueue("spican_wq",
+			WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
+	INIT_WORK(&spi_data->work, spi_can_rx_handler);
+
+	spi_can_task = kthread_run(spi_can_thread, spi_data, "kspican");
+	if (!spi_can_task) {
+		ret = -EIO;
+		goto failed_register;
+	}
+
+	dev_info(&spi->dev, "%s version %s initialized\n",
+		DRV_NAME, DRV_VERSION);
+	dev_info(&spi->dev, "SPI frequency %d, supervisor frequency %d : now set to %d\n",
+		spi_data->max_freq, spi_data->slow_freq, spi_data->freq);
+
+	ret = sysfs_create_group(&spi->dev.kobj,
+			&slave_attribute_group);
+
+	return 0;
+
+failed_register:
+	free_candev(spi_data->can_dev[index]);
+
+failed_candev_alloc:
+	for (i = 0; i < index; i++) {
+		unregister_candev(spi_data->can_dev[i]);
+		free_candev(spi_data->can_dev[index]);
+	}
+
+	return ret;
+}
+
+static int spi_can_remove(struct spi_device *spi)
+{
+	struct spi_can_data *priv = dev_get_drvdata(&spi->dev);
+	int index;
+
+	if (spi_can_task)
+		kthread_stop(spi_can_task);
+	if (priv->wq) {
+		flush_workqueue(priv->wq);
+		destroy_workqueue(priv->wq);
+	}
+
+	for (index = 0; index < (priv->num_channels + 1); index++) {
+		if (priv->can_dev[index]) {
+			unregister_candev(priv->can_dev[index]);
+			free_candev(priv->can_dev[index]);
+		}
+	}
+
+	free_irq(gpio_to_irq(priv->gpio), priv);
+	gpio_free(priv->gpio);
+	sysfs_remove_group(&spi->dev.kobj,
+			   &slave_attribute_group);
+	return 0;
+}
+
+static struct spi_driver spi_can_driver = {
+	.probe = spi_can_probe,
+	.remove = spi_can_remove,
+#if CONFIG_OF
+	.id_table = spi_can_ids,
+#endif
+	.driver = {
+		.name = DRV_NAME,
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init spi_can_init(void)
+{
+	return spi_register_driver(&spi_can_driver);
+}
+
+static void __exit spi_can_exit(void)
+{
+	spi_unregister_driver(&spi_can_driver);
+}
+
+module_init(spi_can_init);
+module_exit(spi_can_exit);
+
+MODULE_AUTHOR("Stefano Babic <sbabic@denx.de");
+MODULE_DESCRIPTION("CAN over SPI driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRV_VERSION);
diff --git a/include/linux/can/platform/spican.h b/include/linux/can/platform/spican.h
new file mode 100644
index 0000000..e8cccf7
--- /dev/null
+++ b/include/linux/can/platform/spican.h
@@ -0,0 +1,36 @@
+/*
+ * (C) Copyright 2010
+ * Stefano Babic, DENX Software Engineering, sbabic@denx.de.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __CAN_PLATFORM_SPICAN_H__
+#define __CAN_PLATFORM_SPICAN_H__
+
+#include <linux/spi/spi.h>
+
+/*
+ * struct hcs12_imx_platform_data - i.MX to HCS12 CAN controller platform data
+ */
+
+struct spi_can_platform_data {
+	unsigned int can_channels;
+	unsigned int gpio;
+	unsigned int active;
+	unsigned int slow_freq;
+};
+
+#endif
-- 
1.7.9.5

