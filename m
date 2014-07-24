From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 24 Jul 2014 16:55:00 +0530
Message-ID: <53D0ED0C.4080400@gmail.com>
References: <1406196706-4548-1-git-send-email-sbabic@denx.de> <1406196706-4548-4-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:53349 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbaGXL0W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Jul 2014 07:26:22 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so3491083pdj.7
        for <linux-can@vger.kernel.org>; Thu, 24 Jul 2014 04:26:22 -0700 (PDT)
In-Reply-To: <1406196706-4548-4-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

On 07/24/2014 03:41 PM, Stefano Babic wrote:

(...)

> +#include <linux/netdevice.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/wait.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/kthread.h>
> +#include <linux/workqueue.h>
> +#include <linux/can/platform/spi_can.h>
> +#include <linux/spi/spi.h>
> +#include <linux/gpio.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +

It looks good if all headers sorted in alphabetical order..  :-)

> +#define MAX_CAN_CHANNELS	16
> +#define CFG_CHANNEL		0xFF
> +#define DRV_NAME		"spican"
> +#define DRV_VERSION		"0.10"
> +
> +/* SPI constants */
> +#define SPI_MAX_FRAME_LEN	1472	/* max total length of a SPI frame */
> +#define BITS_X_WORD		32	/* 4 bytes */
> +#define SPI_MIN_TRANSFER_LENGTH	32	/* Minimum SPI frame length */
> +#define CAN_FRAME_MAX_DATA_LEN	8	/* max data lenght in a CAN message */
> +#define MAX_ITERATIONS		100	/* Used to check if GPIO stucks */
> +#define SPI_CAN_ECHO_SKB_MAX	4
> +#define SLAVE_CLK_FREQ		100000000
> +#define SLAVE_SUPERVISOR_FREQ	((u32)1000000)
> +
> +#define IS_GPIO_ACTIVE(p)	(!!gpio_get_value(p->gpio) == p->gpio_active)
> +#define MS_TO_US(ms)		((ms) * 1000)
> +
> +/* more RX buffers are required for delayed processing */
> +#define	SPI_RX_NBUFS		MAX_CAN_CHANNELS
> +
> +/* Provide a way to disable checksum */
> +static unsigned int chksum_en = 1;
> +
> +static unsigned int freq;
> +module_param(freq, uint, 0);
> +MODULE_PARM_DESC(freq,
> +	"SPI clock frequency (default is set by platform device)");
> +static unsigned int slow_freq;
> +module_param(slow_freq, uint, 0);
> +MODULE_PARM_DESC(slow_freq,
> +	"SPI clock frequency to be used in supervisor mode (default 1 Mhz)");
> +
> +/* CAN channel status to drop not required frames */
> +enum {
> +	CAN_CHANNEL_DISABLED = 0,
> +	CAN_CHANNEL_ENABLED	= 1,
> +};
> +
> +/* operational mode to set the SPI frequency */
> +enum {
> +	SLAVE_SUPERVISOR_MODE	= 0,
> +	SLAVE_USER_MODE		= 1,
> +};
> +
> +/* Message between Master and Slave
> + *
> + * see spi_can_spi.txt for details
> + *
> + *	,'''''''','''''''''''''''','''''''''''''''''''''''','''''''''''''|
> + *	|MSG ID  |  Length(16 bit)|    DATA                |  CHECKSUM   |
> + *	L________|________________|________________________|_____________|
> + */
> +struct spi_can_frame_header {
> +	u8	msgid;
> +	u16	length;
> +} __packed;
> +
> +struct spi_can_frame {
> +	struct spi_can_frame_header	header;
> +	u8	data[1];
> +} __packed;
> +
> +/* Message IDs for SPI Frame */
> +enum msg_type {
> +	SPI_MSG_STATUS_REQ	= 0x01,
> +	SPI_MSG_SEND_DATA	= 0x02,
> +	SPI_MSG_SYNC		= 0x03,
> +	SPI_MSG_CFG_SET		= 0x04,
> +	SPI_MSG_REQ_DATA	= 0x05,
> +	SPI_MSG_CFG_GET		= 0x06
> +};
> +
> +/* CAN data sent inside a
> + * SPI_MSG_SEND_DATA message
> + *
> + *  _____,________________
> + * |     |                ,''''''''''''''''',''''''''''''|       ,'''''''|
> + * |ID=2 | LENGTH         | CAN MESSAGE     |CAN MESSAGE |       |CHECKSUM
> + * |_____L________________|_________________|____________|       L_______|
> + *                    _.-'                  `--._
> + *               _,,-'                           ``-.._
> + *           _.-'                                      `--._
> + *      _,--'                                               ``-.._
> + *  ,.-'                                                          `-.._
> + *  ,'''''',''''''''''''','''''''''''''','''''',''''''|     ,'''''''''|
> + *  | CH   |TIMESTAMP    |  CAN ID      |DLC   |D[0]  |     |D[dlc-1] |
> + *  L______L_____________|______________L______|______|     L_________|
> + */
> +
> +struct msg_channel_data {
> +	u8	channel;
> +	u32	timestamp;
> +	u32	can_id;
> +	u8	dlc;
> +	u8	data[8];
> +} __packed;
> +
> +/* CFG message */
> +struct msg_cfg_set_data {
> +	u8	channel;
> +	u8	enabled;
> +	struct can_bittiming bt;
> +} __packed;
> +
> +struct msg_cfg_get_data {
> +	u8	channel;
> +	u8	tseg1_min;
> +	u8	tseg1_max;
> +	u8	tseg2_min;
> +	u8	tseg2_max;
> +	u8	sjw_max;
> +	u32	brp_min;
> +	u32	brp_max;
> +	u32	brp_inc;
> +	u8	ctrlmode;
> +	u32	clock_hz;
> +} __packed;
> +
> +/* Status message */
> +struct msg_status_data {
> +	u16	length;
> +} __packed;
> +
> +/* The ndo_start_xmit entry point
> + * insert the CAN messages into a list that
> + * is then read by the working thread.
> + */
> +struct msg_queue_tx {
> +	struct list_head	list;
> +	u32			channel;
> +	u32			enabled;
> +	struct sk_buff		*skb;
> +	enum msg_type		type;
> +};
> +
> +struct msg_queue_rx {
> +	struct list_head	list;
> +	struct spi_can_frame	*frame;
> +	u32			len;
> +	u32			bufindex;
> +};
> +
> +struct spi_rx_data {
> +	u8 __aligned(4) spi_rx_buf[SPI_MAX_FRAME_LEN];
> +	u32		msg_in_buf;
> +	struct mutex	bufmutex;
> +};
> +
> +/* Private data for the SPI device. */
> +struct spi_can_data {
> +	struct spi_device	*spi;
> +	u32			gpio;
> +	u32			gpio_active;
> +	u32			num_channels;
> +	u32			freq;
> +	u32			slow_freq;
> +	u32			max_freq;
> +	u32			slave_op_mode;
> +	struct net_device	*can_dev[MAX_CAN_CHANNELS + 1];
> +	spinlock_t		lock;
> +	struct msg_queue_tx	msgtx;
> +	struct msg_queue_rx	msgrx;
> +	struct mutex		lock_wqlist;
> +	wait_queue_head_t	wait;
> +	struct workqueue_struct *wq;
> +	struct work_struct	work;
> +	/* buffers must be 32-bit aligned  ! */
> +	u8 __aligned(4)		spi_tx_buf[SPI_MAX_FRAME_LEN];
> +	struct spi_rx_data	rx_data[SPI_RX_NBUFS];
> +	struct timeval		ref_time;
> +};
> +
> +/* Private data of the CAN devices */
> +struct spi_can_priv {
> +	struct can_priv		can;
> +	struct net_device	*dev;
> +	struct spi_can_data	*spi_priv;
> +	struct can_bittiming_const spi_can_bittiming_const;
> +	u32			channel;
> +	u32			devstatus;
> +	u32			ctrlmode;
> +};
> +

better to move all these into new local header file ...

> +/* Pointer to the worker task */
> +

(...)

> +
> +static void spi_can_set_timestamps(struct sk_buff *skb,
> +	struct msg_channel_data *msg)

good if match open parenthesis
static void spi_can_set_timestamps(struct sk_buff *skb,
				   struct msg_channel_data *msg)

> +{
> +	msg->timestamp = ktime_to_ns(skb->tstamp);
> +}
> +
> +static struct net_device *candev_from_channel(struct spi_can_data *spi_data,
> +	u8 channel)

Dto...

> +{
> +	/* Last device is the CFG device */
> +	if (channel == CFG_CHANNEL)
> +		return spi_data->can_dev[spi_data->num_channels];
> +	if (channel < spi_data->num_channels)
> +		return spi_data->can_dev[channel];
> +
> +	return NULL;
> +}
> +
> +static int insert_cfg_msg(struct net_device *dev, int enabled)
> +{
> +	struct spi_can_priv *priv = netdev_priv(dev);
> +	struct spi_can_data	*spi_priv = priv->spi_priv;
> +	struct msg_queue_tx *tx_pkt;
> +	unsigned long flags;
> +
> +	tx_pkt = kzalloc(sizeof(*tx_pkt), GFP_KERNEL);
> +	if (!tx_pkt) {
> +		dev_err(&dev->dev, "out of memory");

missed terminating new line...

> +		return -ENOMEM;
> +	}
> +	

(...)

> +
> +static int spi_can_hwtstamp_ioctl(struct net_device *netdev,
> +	struct ifreq *ifr, int cmd)

match open parenthesis...

> +{
> +	struct hwtstamp_config config;
> +
> +	i

(...)

> +static int spi_can_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct spi_can_priv *priv = netdev_priv(dev);
> +	struct spi_can_data	*spi_priv = priv->spi_priv;
> +	struct msg_queue_tx *tx_pkt;
> +	unsigned long flags;
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);

sizeof(*tx_pkt)...?

> +	tx_pkt->channel = priv->channel;
> +	tx_pkt->skb = skb;
> +	

(...)

> +static irqreturn_t spi_can_irq(int irq, void *pdata)
> +{
> +	struct spi_can_data *spi_priv = (struct spi_can_data *)pdata;
> +	int val;
> +
> +	val = gpio_get_value(spi_priv->gpio);
> +

Where did you use 'val' ?

> +	/* Wakeup thread */
> +	wake_up_interruptible(&spi_priv->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* The parameters for SPI are fixed and cannot be changed due
> + * to hardware limitation in Slave.
> + * Only the frequency can be changed
> + */
> +static void spi_can_initialize(struct spi_device *spi, u32 freq)
> +{
> +	/* Configure the SPI bus */
> +	spi->mode = SPI_MODE_1;
> +	spi->bits_per_word = BITS_X_WORD;
> +	spi_setup(spi);
> +}
> +
> +static int spi_can_transfer(struct spi_can_data *priv,
> +				u32 bufindex, u32 len)

static int spi_can_transfer(struct spi_can_data *priv,
			    u32 bufindex, u32 len)

> +{
> +	struct spi_device *spi = priv->spi;
> +	struct spi_message m;
> +	struct spi_transfer t;
> +	int ret = 0;
> +
> +	memset(&t, 0, sizeof(t));
> +	t.tx_buf = priv->spi_tx_buf;
> +	t.rx_buf = priv->rx_data[bufindex].spi_rx_buf;
> +	t.len = len;
> +	t.cs_change = 0;
> +	if (priv->freq)
> +		t.speed_hz = priv->freq;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);
> +
> +	ret = spi_sync(spi, &m);
> +	if (ret)
> +		dev_err(&spi->dev, "spi transfer failed: ret = %d\n", ret);

No need to include the ret in the message because this(dev_err()) already indicates an error

> +	return ret;
> +}
> +
> +/* Prepare a SYNC message to synchronize with the start of frame */
> +static u32 spi_can_spi_sync_msg(struct spi_can_data *spi_data, char *buf)
> +{
> +	struct spi_can_frame_header *header;
> +	u32 len;
> +
> +	header = (struct spi_can_frame_header *)spi_data->spi_tx_buf;
> +
> +	header->msgid = SPI_MSG_SYNC;
> +	*buf++ = 0xAA;
> +	*buf++ = 0x55;
> +	*buf++ = 0x55;
> +	*buf++ = 0xAA;
> +	len = 4;
> +
> +	do_gettimeofday(&spi_data->ref_time);
> +
> +	return len;
> +}
> +
> +static int spi_can_fill_skb_msg(struct net_device *dev,
> +	struct msg_channel_data *pcan, struct timeval *timeref)

static int spi_can_fill_skb_msg(struct net_device *dev,
				struct msg_channel_data *pcan,
				struct timeval *timeref)

> +{
> +	s

(...)

> +/* parse_can_msg gets all CAN messages encapsulated
> + * in a SEND_DATA message, and sends them upstream
> + */
> +static int parse_can_msg(struct spi_can_data *spi_data,
> +	struct spi_can_frame *frame,
> +	u32 len)

static int parse_can_msg(struct spi_can_data *spi_data,
			 struct spi_can_frame *frame,
			 u32 len)

> +{
> +	struct msg_channel_data *pcan;
> +	char *pbuf = frame->data;
> +	struct spi_device *spi = spi_data->spi;
> +	struct net_device	*netdev;
> +	u32 can_msg_length;
> +	int ret = 0;
> +
> +	while (len > 0) {
> +		if (len < sizeof(struct msg_channel_data) -
> +			CAN_FRAME_MAX_DATA_LEN) {
> +			dev_err(&spi->dev,
> +				"Received incompleted CAN message: length %d pbuf 0x%x\n",
> +				len, *pbuf);
> +			ret = -1;

proper error code...

> +			break;
> +		}
> +		pcan = (struct msg_channel_data *)pbuf;
> +		if ((pcan->channel > spi_data->num_channels) &&
> +			(pcan->channel != CFG_CHANNEL)) {
> +			dev_err(&spi->dev,
> +				"Frame with wrong channel %d, frame dropped",
> +				pcan->channel);
> +			ret = -1;

dto..

> +			break;
> +		}
> +
> +		/* Check for a valid CAN message lenght */
> +		if (pcan->dlc > CAN_FRAME_MAX_DATA_LEN) {
> +			dev_err(&spi->dev,
> +				"CAN message with wrong length: id 0x%x dlc %d",
> +				pcan->can_id, pcan->dlc);
> +			ret = -1;

dto...

> +			break;
> +		}
> +
> +		pcan->can_id = be32_to_cpu(pcan->can_id);
> +		pcan->timestamp = be32_to_cpu(pcan->timestamp);
> +
> +		/* Get the device corresponding to the channel */
> +		netdev = candev_from_channel(spi_data, pcan->channel);
> +
> +		if (spi_can_fill_skb_msg(netdev, pcan, &spi_data->ref_time))
> +			dev_err(&spi->dev,
> +				"Error sending data to upper layer");
> +		can_msg_length = (sizeof(struct msg_channel_data) + pcan->dlc -
> +			CAN_FRAME_MAX_DATA_LEN);
> +
> +		len -= can_msg_length;
> +		pbuf += can_msg_length;
> +	}
> +
> +	return ret;
> +}
> +
> +
> +static void spi_can_extract_msg(struct spi_can_data *spi_data,
> +	struct msg_queue_rx *msg)

static void spi_can_extract_msg(struct spi_can_data *spi_data,
				struct msg_queue_rx *msg)

> +{
> +	/* Extract all CAN messages, do not check
> +	 * the last two bytes as they are reserved for checksum
> +	 */
> +	mutex_lock(&spi_data->rx_data[msg->bufindex].bufmutex);
> +	if (parse_can_msg(spi_data, msg->frame, msg->len - 2) < 0) {
> +#ifdef DEBUG
> +		dump_frame(spi_data->rx_data[msg->bufindex].spi_rx_buf,
> +				msg->len);
> +#endif
> +	}
> +
> +	/* I can now set the message as processed and decrease
> +	 * the number of messages in the SPI buffer.
> +	 * When all messages are processed, the TX thread
> +	 * can use the SPI buffer again
> +	 */
> +	spi_data->rx_data[msg->bufindex].msg_in_buf--;
> +	mutex_unlock(&spi_data->rx_data[msg->bufindex].bufmutex);
> +}
> +
> +static void spi_can_rx_handler(struct work_struct *ws)
> +{
> +	struct spi_can_data *spi_data = container_of(ws,
> +			struct spi_can_data, work);

struct spi_can_data *spi_data = container_of(ws,
					     struct spi_can_data,
					     work);

> +	struct msg_queue_rx *msg;
> +
> +	while (1) {
> +
> +		if (list_empty(&spi_data->msgrx.list))
> +			break;
> +
> +		mutex_lock(&spi_data->lock_wqlist);
> +		msg = list_first_entry(&spi_data->msgrx.list,
> +				struct msg_queue_rx, list);

dto..

> +		list_del(&msg->list);
> +		mutex_unlock(&spi_data->lock_wqlist);
> +
> +		spi_can_extract_msg(spi_data, msg);
> +		kfree(msg);
> +	}
> +}
> +
> +/* This is called in overload condition to process a siongle frame and
> + * free a SPI frame for transfer
> + * This is called by the thread
> + */
> +static void spi_can_process_single_frame(struct spi_can_data *spi_data,
> +	u32 index)

dto....

> +{
> +	struct list_head *pos;
> +	struct msg_queue_rx *msg;
> +	unsigned int found = 0, freed;
> +
> +	mutex_lock(&spi_data->lock_wqlist);
> +	list_for_each(pos, &spi_data->msgrx.list) {
> +		msg = list_entry(pos, struct msg_queue_rx, list);
> +		if (msg->bufindex == index) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	/* Drop the message from the list */
> +	if (found)
> +		list_del(&msg->list);
> +	mutex_unlock(&spi_data->lock_wqlist);
> +
> +	if (!found) {
> +
> +		/* I cannot parse the buffer because it is worked
> +		 * by another task, check when it is finished
> +		 */
> +
> +		do {
> +			mutex_lock(&spi_data->rx_data[index].bufmutex);
> +			freed = (spi_data->rx_data[index].msg_in_buf == 0);
> +			mutex_unlock(&spi_data->rx_data[index].bufmutex);
> +		} while (!freed);
> +
> +		return;
> +	}
> +
> +	spi_can_extract_msg(spi_data, msg);
> +
> +}
> +
> +static int spi_can_process_get(struct spi_can_data *spi_data,
> +	struct msg_cfg_get_data *msg)

dto...

> +{
> +	s

(...)

> +#ifdef CONFIG_OF
> +static const struct spi_device_id spi_can_ids[] = {
> +	{ "spican", 0},
> +	{ "canoverspi", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, spi_can_ids);
> +#endif
> +

Move these device ids after probe/remove functionalities... Every driver follows
same concept.

Here you used #ifdef CONFIG_OF... What is the use ..?

> +static int spi_can_probe(struct spi_device *spi)
> +{
> +	struct spi_can_platform_data *pdata = spi->dev.platform_data;
> +	int ret = -ENODEV;
> +	

(...)

> +
> +	ret = gpio_request(data_gpio, "spican-irq");

use device managed APIs...

> +	if (ret) {
> +		dev_err(&spi->dev,
> +			"gpio %d cannot be acquired\n",
> +			data_gpio);
> +		return -ENODEV;
> +	}
> +
> +	/* The SPI structure is common to all CAN devices */
> +	spi_data = (struct spi_can_data *)
> +		kzalloc(sizeof(struct spi_can_data), GFP_KERNEL | __GFP_ZERO);

dto...devm_kzalloc()...

> +	if (!spi_data)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&spi_data->msgtx.list);
> +	INIT_LIST_HEAD(&spi_data->msgrx.list);
> +
> +	/* Get the GPIO used as interrupt. The Slave raises
> +	 * an interrupt when there are messages to be sent
> +	 */
> +	gpio_direction_input(data_gpio);
> +	ret = request_irq(gpio_to_irq(data_gpio), spi_can_irq,
> +		(active ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING) ,
> +		"spican-rx", spi_data);

devm_reuest_irq()..?

> +	if (ret) {
> +		gpio_free(data_gpio);
> +		kfree(spi_data);

These two statements not required if you use devm_* APIs above...

> +		return -ENODEV;
> +	}
> +
> +	spi_data->num_channels = can_channels;
> +	spi_data->gpio = data_gpio;
> +	spi_data->gpio_active = active;
> +	spi_data->spi = spi;
> +	spi_data->max_freq = freq;
> +	spi_data->slow_freq = slow_freq;
> +	spi_data->freq = slow_freq;
> +	spi_data->slave_op_mode = SLAVE_SUPERVISOR_MODE;
> +	spin_lock_init(&spi_data->lock);
> +	mutex_init(&spi_data->lock_wqlist);
> +	for (index = 0; index < SPI_RX_NBUFS; index++)
> +		mutex_init(&spi_data->rx_data[index].bufmutex);
> +
> +	/* Initialize SPI interface */
> +	dev_set_drvdata(&spi->dev, spi_data);
> +	spi_can_initialize(spi, freq);
> +
> +	/* Now alloc the CAN devices */
> +	for (index = 0; index < (can_channels + 1); index++) {
> +		tx_pkt = kzalloc(sizeof(*tx_pkt), GFP_KERNEL);
dto...
> +		if (!tx_pkt)
> +			return -ENOMEM;
> +
> +		if (index != can_channels)
> +			tx_pkt->channel = index;
> +		else
> +			tx_pkt->channel = CFG_CHANNEL;
> +		tx_pkt->type = SPI_MSG_CFG_GET;
> +		list_add_tail(&(tx_pkt->list), &(spi_data->msgtx.list));
> +	}
> +
> +	init_waitqueue_head(&spi_data->wait);
> +	/* Initialize work que for RX background processing */
> +	spi_data->wq = alloc_workqueue("spican_wq",
> +			WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
> +	INIT_WORK(&spi_data->work, spi_can_rx_handler);
> +
> +	spi_can_task = kthread_run(spi_can_thread, spi_data, "kspican");
> +	if (!spi_can_task) {
> +		ret = -EIO;
> +		goto failed_start_task;
> +	}
> +
> +	dev_info(&spi->dev, "%s version %s initialized\n",
> +		DRV_NAME, DRV_VERSION);
> +	dev_info(&spi->dev, "SPI frequency %d, supervisor frequency %d : now set to %d\n",
> +		spi_data->max_freq, spi_data->slow_freq, spi_data->freq);
> +
> +	return 0;
> +
> +failed_start_task:
> +
> +	free_irq(gpio_to_irq(spi_data->gpio), spi_data);
> +	gpio_free(spi_data->gpio);
> +

not required if you use devm_*

> +	return ret;
> +}
> +
> +static int spi_can_remove(struct spi_device *spi)
> +{
> +	struct spi_can_data *priv = dev_get_drvdata(&spi->dev);
> +	int index;
> +
> +	if (spi_can_task)
> +		kthread_stop(spi_can_task);
> +	if (priv->wq) {
> +		flush_workqueue(priv->wq);
> +		destroy_workqueue(priv->wq);
> +	}
> +
> +	for (index = 0; index < (priv->num_channels + 1); index++) {
> +		if (priv->can_dev[index]) {
> +			unregister_candev(priv->can_dev[index]);
> +			free_candev(priv->can_dev[index]);
> +		}
> +	}
> +
> +	free_irq(gpio_to_irq(priv->gpio), priv);
> +	gpio_free(priv->gpio);
> +

not required if you use devm_*

> +	return 0;
> +}
> +
> +static struct spi_driver spi_can_driver = {
> +	.probe = spi_can_probe,
> +	.remove = spi_can_remove,
> +#if CONFIG_OF
> +	.id_table = spi_can_ids,
> +#endif
> +	.driver = {
> +		.name = DRV_NAME,
> +		.bus = &spi_bus_type,
> +		.owner = THIS_MODULE,

this field updated automatically...

> +	},
> +};
> +
> +static int __init spi_can_init(void)
> +{
> +	return spi_register_driver(&spi_can_driver);
> +}
> +
> +static void __exit spi_can_exit(void)
> +{
> +	spi_unregister_driver(&spi_can_driver);
> +}
> +
> +module_init(spi_can_init);
> +module_exit(spi_can_exit);
> +

use module_spi_driver()..


-- 
Regards,
Varka Bhadram.

