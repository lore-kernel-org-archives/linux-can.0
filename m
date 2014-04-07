From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Mon, 07 Apr 2014 10:29:04 +0200
Message-ID: <534261D0.8060802@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <534170AD.50506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38348 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891AbaDGI3S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 04:29:18 -0400
In-Reply-To: <534170AD.50506@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Wolfgang,

On 06/04/2014 17:20, Wolfgang Grandegger wrote:
> Hi Stefan,
> 
> sorry for jumping in late...

No problem..but you picked up V2. Some of the issues you see are already
solved in V3, some not, and some are new. I add here some comments when
there are still unsolved issues.

> This driver is rather special in various
> respects. As I see it, it does not support:
> 
>   - loopback (echo_skbs)
>   - error state handling
>   - any error reporting (CAN error messages)
>   - any error counting (net and CAN stats)
>   - recovery from bus-off
> 
> Any chance to improve on that? At least some kind of error reporting
> would be nice otherwise the app does not realize any problems. Or how
> does your app handle error cases.

About IFF_ECHO: in my understanding, by enabling IFF_ECHO the driver
should sent messages back to the upper layer as fast as these messages
are put on the bus. As I see in most drivers, can_put_echo() is called
directly into the ISR for most drivers.
This driver implements a sort of "remote CAN". I do not know when
messages are really put on the bus, because this is done by the
microcontroller and not by the Main Controller. There is always a
latency due to the fact that I can only enqueue messages on the SPI Bus
using the SPI framework, letting the microcontroller doing the rest.
Because I do not know when messages are really sent, I thought it makes
little sense to implement echo_skbs. I did it during the development
(you have found tracks of it), but I dropped later. IMHO this driver
should not turn on IFF_ECHO.

Agree that it should be nice to have some error reporting from the
microcontroller. However, it seeems quite difficult for the firmware
developers to get it. There is currently no error reporting to the main
controller, and if I do something in this direction, it remains untested
because I cannot get the related firmware. I will really prefer to let
the driver in, even if this feature is not implemented, and add it later
when there is a use case for it.

>> +config CAN_SPI
>> +	tristate "Support for CAN over SPI"
>> +	depends on CAN_DEV
>> +	---help---
>> +	  Driver to transfer CAN messages to a microcontroller
>> +	  connected via the SPI interface using a simple messaged based
>> +	  protocol.
>> +
>> +	  Say Y here if you want to support for CAN to SPI.
> 
> Would be nice to mention the doc here.

I'll do it.

>> +#define SPI_CAN_ECHO_SKB_MAX	4
> 
> Never used.

Right, it comes from earlier implementation with IFF_ECHO set.

> 
>> +#define SLAVE_CLK_FREQ		100000000
>> +#define SLAVE_SUPERVISOR_FREQ	((u32)1000000)
>> +
>> +#define IS_GPIO_ACTIVE(p)	(!!gpio_get_value(p->gpio) == p->gpio_active)
>> +#define MS_TO_US(ms)		(ms * 1000)
> 
>    #define MS_TO_US(ms)		((ms) * 1000)

I'll fix it.

>> +	struct timeval		refTime;
> 
> s/refTime/ref_time/ ?

ok

> 
>> +};
>> +
>> +/* Default Values */
>> +static struct can_bittiming_const spi_can_bittiming_const = {
>> +	.name = DRV_NAME,
>> +	.tseg1_min = 4,
>> +	.tseg1_max = 16,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 8,
>> +	.sjw_max = 4,
>> +	.brp_min = 1,
>> +	.brp_max = 64,
>> +	.brp_inc = 1,
>> +};
> 
> Hm, this is specific to the hardware and should not be set globally. Do
> you need/use it at all. Typically CAN handled by firmware does use
> rather fixed bit timing parameters. Just the bit-rate can usually be
> specified.

Changed in V3, but with the goal in V4 to query the microcontroller at
the start for the timing.

> 
>> +/* Private data of the CAN devices */
>> +struct spi_can_priv {
>> +	struct can_priv		can;
>> +	struct net_device	*dev;
>> +	struct spi_can_data	*spi_priv;
>> +	u32			channel;
>> +	u32			devstatus;
>> +	u32			echo_index[SPI_CAN_ECHO_SKB_MAX];
> 
> Seems not to be used.

See above.

> 
>> +};
>> +
>> +/* Pointer to the worker task */
>> +static struct task_struct *spi_can_task;
>> +
>> +/* Provide a way to disable checksum */
>> +static unsigned int chksum_en;
>> +module_param(chksum_en, uint, 0);
>> +MODULE_PARM_DESC(chksum_en,
>> +	"Enable checksum test on received frames (default is disabled)");
>> +static unsigned int freq;
>> +module_param(freq, uint, 0);
>> +MODULE_PARM_DESC(freq,
>> +	"SPI clock frequency (default is set by platform device)");
>> +static unsigned int slow_freq;
>> +module_param(slow_freq, uint, 0);
>> +MODULE_PARM_DESC(slow_freq,
>> +	"SPI clock frequency to be used in supervisor mode (default 1 Mhz)");
>> +static unsigned int debug;
>> +module_param(debug, uint, 0);
> 
> Why not using DEBUG and dev_dbg()?

Fixed in V3

>> +};
> 
> What is really useful for the real user? Debugging code just for
> development should be removed. Maybe you could map some of these
> counters to the CAN stats.

It is not useful for the real user ;-). Already dropped in V3.

>> +static inline u16 compute_checksum(char *buf, u32 len)
>> +{
>> +	int i;
>> +	u16 chksum = 0;
>> +
>> +	if (!chksum_en)
>> +		return 0;
>> +	for (i = 0; i < len; i++, buf++)
>> +		chksum += *buf;
> 
> I'm quite often confused how you use integer types. "i" is int but "len"
> is u32...

This issue is still open. I see I mixed in whole driver "int" and "u32",
thanks for pointing out. I will check it !

> 
>> +
>> +	return (~chksum + 1) & 0xFFFF;
>> +}
>> +
>> +static u32 verify_checksum(struct spi_device *spi, char *buf, u32 len)
> 
> ... and "len" is sometimes "int" but other times "u32". Could you please
> use consistent types. I will just add "Check int type" when I'm
> unsure/confused.

Agree, it is inconsistent. I must fix it !

>> +	if ((chksum + received_checksum) & 0xFFFF) {
>> +		dev_err(&spi->dev,
>> +		"Received wrong checksum: computed 0x%04x received 0x%04x\n",
>> +		chksum, received_checksum);
>> +		return -EPROTO;
> 
> Check int type.

ok

>> +
>> +	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
> 
> 	tx_pkt = kzalloc(*tx_pkt, GFP_KERNEL);

ok, thanks, more elegant !

>> +	if (!tx_pkt) {
>> +		dev_err(&dev->dev, "out of memory");
>> +		return -ENOMEM;
>> +	}
>> +	tx_pkt->channel = priv->channel;
>> +	tx_pkt->enabled = enabled;
>> +	tx_pkt->type = SPI_MSG_CFG;
>> +
>> +	priv->devstatus = enabled;
>> +
>> +	spin_lock_irqsave(&spi_priv->lock, flags);
>> +	list_add_tail(&(tx_pkt->list), &(spi_priv->msgtx.list));
>> +	spi_priv->messages_in_queue++;
>> +	spin_unlock_irqrestore(&spi_priv->lock, flags);
>> +
>> +	/*  Wakeup thread */
>> +	wake_up_interruptible(&spi_priv->wait);
>> +
>> +	return 0;
>> +}
>> +
>> +static int spi_can_open(struct net_device *dev)
>> +{
>> +	int ret;
>> +
>> +	ret = open_candev(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = insert_cfg_msg(dev, CAN_CHANNEL_ENABLED);
>> +	if (ret)
>> +		return ret;
> 
> close_candev() is missing.

I see, thanks !

> 
>> +
>> +	netif_start_queue(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int spi_can_close(struct net_device *dev)
>> +{
>> +	netif_stop_queue(dev);
>> +
>> +	insert_cfg_msg(dev, CAN_CHANNEL_DISABLED);
>> +
>> +	close_candev(dev);
>> +
>> +	return 0;
>> +}
> 
>> +
>> +static int spi_can_hwtstamp_ioctl(struct net_device *netdev,
>> +	struct ifreq *ifr, int cmd)
>> +{
>> +	struct hwtstamp_config config;
>> +
>> +	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
>> +		return -EFAULT;
>> +
>> +	if (config.flags)
>> +		return -EINVAL;
>> +
>> +	switch (config.tx_type) {
>> +	case HWTSTAMP_TX_OFF:
>> +		break;
>> +	case HWTSTAMP_TX_ON:
>> +		break;
>> +	default:
>> +		return -ERANGE;
>> +	}
>> +
>> +	switch (config.rx_filter) {
>> +	case HWTSTAMP_FILTER_NONE:
>> +		break;
>> +	default:
>> +		config.rx_filter = HWTSTAMP_FILTER_ALL;
>> +		break;
>> +	}
>> +
>> +	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
>> +		-EFAULT : 0;
>> +}
>> +
>> +static int spi_can_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>> +{
>> +	if (!netif_running(dev))
>> +		return -EINVAL;
>> +
>> +	if (cmd == SIOCSHWTSTAMP)
>> +		return spi_can_hwtstamp_ioctl(dev, rq, cmd);
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int spi_can_set_mode(struct net_device *dev, enum can_mode mode)
>> +{
>> +	int err;
>> +
>> +	switch (mode) {
>> +	case CAN_MODE_START:
>> +		err =  0;
>> +		if (err)
>> +			return err;
>> +
>> +		netif_wake_queue(dev);
>> +		break;
>> +
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> This function is never called because the state never changes to
> CAN_BUS_OFF.

That is right. It was my intention to manage such situation, but they
must be done on the microcontroller. At the moment, it is dead code. I
suggest to drop it, adding maybe later if there will be a use case for
bus-off handled by the microcontroller.

> 
>> +static int spi_can_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	struct spi_can_priv *priv = netdev_priv(dev);
>> +	struct spi_can_data	*spi_priv = priv->spi_priv;
>> +	struct msg_queue_tx *tx_pkt;
>> +	unsigned long flags;
>> +
>> +	if (can_dropped_invalid_skb(dev, skb))
>> +		return NETDEV_TX_OK;
>> +
>> +	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
>> +	tx_pkt->channel = priv->channel;
>> +	tx_pkt->skb = skb;
>> +	tx_pkt->type = SPI_MSG_SEND_DATA;
>> +	INIT_LIST_HEAD(&(tx_pkt->list));
>> +
>> +	/* Add the incoming message to the end of the list */
>> +	spin_lock_irqsave(&spi_priv->lock, flags);
>> +	list_add_tail(&(tx_pkt->list), &(spi_priv->msgtx.list));
>> +	spi_priv->messages_in_queue++;
> 
> You probabley may want to limit the number of TX messages to be queued.
> Otherwise the system may even run out of memory... if I understand the
> code correctly

You understand right. In my tests, I observed the evolution of
messages_in_queue to be sure that it does not increase indefinetely
under heavier bus load, without setting a limit. Agree we need a higher
limit, I will do it.

>> +static void spi_can_initialize(struct spi_device *spi, u32 freq)
>> +{
>> +	/* Configure the SPI bus */
>> +	spi->mode = SPI_MODE_1;
>> +	spi->bits_per_word = BITS_X_WORD;
>> +	spi_setup(spi);
> 
> "freq" is not used.

ok

>> +static int spi_can_transfer(struct spi_can_data *priv,
>> +				u32 bufindex, int len)
>> +{
>> +	struct spi_device *spi = priv->spi;
>> +	struct spi_message m;
>> +	struct spi_transfer t;
>> +	int ret = 0;
>> +
>> +	memset(&t, 0, sizeof(struct spi_transfer));
> 
> 	memset(&t, 0, sizeof(t));

ok

>> +
>> +	if (priv->devstatus != CAN_CHANNEL_ENABLED) {
>> +		dev_err(&dev->dev, "frame received when CAN deactivated\n");
>> +		return 1;
> 
> Normally you return a negative value as error. "-ENOMEM" would be even
> better.

Normally, I did it better ;-). This is wrong, I will fix it !

> 
>> +	}
>> +	skb = alloc_can_skb(dev, &cf);
>> +	if (unlikely(!skb)) {
>> +		stats->rx_dropped++;
>> +		return 1;
> 
> Ditto.
> 
>> +	}
>> +
>> +	cf->can_id = pcan->can_id;
>> +	cf->can_dlc = pcan->dlc;
>> +	memcpy(cf->data, pcan->data,  pcan->dlc);
>> +
>> +	/* Set HW timestamps */
>> +	shhwtstamps = skb_hwtstamps(skb);
>> +	memset(shhwtstamps, 0, sizeof(*shhwtstamps));
>> +	ns = MS_TO_US(pcan->timestamp);
>> +	tstamp = ktime_add_us(timeval_to_ktime(*timeref), ns);
>> +	shhwtstamps->hwtstamp = tstamp;
>> +	skb->tstamp = tstamp;
>> +
>> +	netif_receive_skb(skb);
>> +	stats->rx_packets++;
>> +	stats->rx_bytes += cf->can_dlc;
> 
> Should go before netif_receive_skb(skb). It's actually a bug reported by
> tlx.
> 

I will fix it, of course


>> +/* This is called in overload condition to process a siongle frame and
>> + * free a SPI frame for transfer
>> + * This is called by the thread
>> + */
>> +static void spi_can_process_single_frame(struct spi_can_data *spi_data,
>> +	u32 index)
>> +{
>> +	struct list_head *pos;
>> +	struct msg_queue_rx *msg;
>> +	u32 found = 0, freed;
> 
> Why is "int" not just fine.

For what ? Both are used as boolean, unsigned is right.

>> +static u32 spi_can_receive(struct spi_can_data *spi_data,
>> +	int len, int bufindex, u16 *req_bytes)
>> +{
> 
> Check int type. Above "bufindex" is u32.

Right

>> +				return -EPROTO;
> 
> Check int type.
> 
>> +			}
>> +			if (verify_checksum(spi, (char *)frame,
>> +				rx_len + sizeof(frame->header)) < 0)
>> +				return -EPROTO;
> 
> Ditto.

Ok, I have definetely a very "naive" usage of "int" and "u32". I must
fix all of them !

> 
>> +			pbuf = frame->data;
>> +
>> +			/* Put the recognized frame into the receive list
>> +			 * to be processed by the workqueue
>> +			 */
>> +			rxmsg = kzalloc(sizeof(struct msg_queue_rx),
> 
> 			rxmsg = kzalloc(sizeof(*rxmsg),

ok

>> +#ifdef CONFIG_OF
>> +static const struct spi_device_id spi_can_ids[] = {
>> +	{ "spican", 0},
>> +	{ "canoverspi", 0},
> 
> Why two names?

Already fixed in V3.

> 
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(spi, spi_can_ids);
>> +#endif
>> +
>> +static int spi_can_probe(struct spi_device *spi)
>> +{
>> +	struct net_device *dev;
>> +	struct spi_can_platform_data *pdata = spi->dev.platform_data;
>> +	int ret = -ENODEV;
>> +	struct spi_can_data *spi_data;
>> +	struct spi_can_priv *priv;
>> +	int index, i;
>> +	u32 can_channels;
>> +	u32 active = GPIO_ACTIVE_LOW;
>> +	int data_gpio;
>> +	u32 flags;
>> +
>> +	if (spi->dev.of_node) {
>> +		if (of_property_read_u32(spi->dev.of_node,
>> +			    "channels", &can_channels))
>> +			return -ENODEV;
>> +		if (!slow_freq) {
>> +			of_property_read_u32(spi->dev.of_node,
>> +			    "slowfreq", &slow_freq);
>> +		}
>> +		if (!freq) {
>> +			of_property_read_u32(spi->dev.of_node,
>> +			    "freq", &freq);
>> +		}
>> +		data_gpio = of_get_gpio_flags(spi->dev.of_node,
>> +				0, &flags);
>> +		active = (flags & GPIO_ACTIVE_LOW) ? 0 : 1;
>> +	} else {
>> +		if (!pdata || (pdata->can_channels < 0) ||
>> +			(pdata->can_channels > MAX_CAN_CHANNELS))
>> +			return -ENODEV;
>> +		if (pdata->slow_freq)
>> +			slow_freq = pdata->slow_freq;
>> +		data_gpio = pdata->gpio;
>> +		active = pdata->active;
>> +		can_channels = pdata->can_channels;
>> +	}
>> +
>> +	if (!gpio_is_valid(data_gpio)) {
>> +		dev_err(&spi->dev,
>> +			"Wrong data valid GPIO: %d\n",
>> +			data_gpio);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_info(&spi->dev, "Channels: %d, gpio %d active %s\n",
>> +				can_channels,
>> +				data_gpio,
>> +				active ? "high" : "low");
>> +	/* It is possible to adjust frequency at loading time
>> +	 * if the driver is compiled as module
>> +	 */
>> +	if (freq) {
>> +		if (freq > spi->max_speed_hz) {
>> +			dev_err(&spi->dev,
>> +				"Frequency too high: %d Hz > %d Hz. Falling back to %d\n",
>> +				freq,
>> +				spi->max_speed_hz,
>> +				spi->max_speed_hz);
>> +			freq = spi->max_speed_hz;
>> +		}
>> +	}
>> +
>> +	/* Check if the supervisor frequency is passed as parameter
>> +	 * Fallback to 1 Mhz
>> +	 */
>> +	if (!slow_freq)
>> +		slow_freq = SLAVE_SUPERVISOR_FREQ;
>> +
>> +	if ((freq && (slow_freq > freq)) ||
>> +		(slow_freq > SLAVE_SUPERVISOR_FREQ)) {
>> +		dev_err(&spi->dev,
>> +			"Supervisor frequency too high: %d Hz > %d Hz. Falling back to %d\n",
>> +			slow_freq,
>> +			min(freq, SLAVE_SUPERVISOR_FREQ),
>> +			min(freq, SLAVE_SUPERVISOR_FREQ));
>> +			slow_freq = min(freq, SLAVE_SUPERVISOR_FREQ);
>> +	}
>> +
>> +	ret = gpio_request(data_gpio, "spican-irq");
>> +	if (ret) {
>> +		dev_err(&spi->dev,
>> +			"gpio %d cannot be acquired\n",
>> +			data_gpio);
>> +		return -ENODEV;
> 
> Please use goto for cleanup...

I can do it. Anyway, at this level in probe I have not yet reserved any
resource, and returning with an error is not wrong. I have nothing to
free in the cleanup at this point.

>> +	spi_data->num_channels = can_channels;
>> +	spi_data->gpio = data_gpio;
>> +	spi_data->gpio_active = active;
>> +	spi_data->spi = spi;
>> +	spi_data->messages_in_queue = 0;
>> +	spi_data->average_length = 0;
>> +	spi_data->current_length = 0;
>> +	spi_data->short_frames = 0;
>> +	spi_data->spi_sent_frames = 0;
> 
> You use kzalloc() above therefore the values above should already be zero.

This is already fixed.


>> +		/* Set CAN specific parameters */
>> +		priv->can.clock.freq = SLAVE_CLK_FREQ;
>> +		priv->can.bittiming_const = &spi_can_bittiming_const;
>> +		priv->can.do_set_mode = spi_can_set_mode;
>> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>> +			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;
> 
> Not used anywhere in this file.
> 
>> +		for (i = 0; i < SPI_CAN_ECHO_SKB_MAX; i++)
>> +			priv->echo_index[i] = SPI_CAN_ECHO_SKB_MAX;
> 
> Not used.
> 
>> +
>> +failed_register:
>> +	free_candev(spi_data->can_dev[index]);
>> +
>> +failed_candev_alloc:
>> +	for (i = 0; i < index; i++) {
>> +		unregister_candev(spi_data->can_dev[i]);
>> +		free_candev(spi_data->can_dev[index]);
>> +	}
> 
> What about free_irq() and free_gpio().

Thanks, missed, I'll fix it !

>> + * struct hcs12_imx_platform_data - i.MX to HCS12 CAN controller platform data
>> + */
> 
> This is an unrelated comment.

Right, already fixed in V3.

> 
>> +struct spi_can_platform_data {
>> +	unsigned int can_channels;
>> +	unsigned int gpio;
>> +	unsigned int active;
> 
> Check int types. In the code above these are u32 (in most cases).

Mixing int and u32 is defitely my favourite mistake !

Thanks for reviewing,

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
