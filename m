From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Mon, 07 Apr 2014 11:34:51 +0200
Message-ID: <5342713B.4000605@grandegger.com>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <534170AD.50506@grandegger.com> <534261D0.8060802@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49908 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaDGJfT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 05:35:19 -0400
In-Reply-To: <534261D0.8060802@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, Marc Kleine-Budde <mkl@pengutronix.de>

On 04/07/2014 10:29 AM, Stefano Babic wrote:
> Hi Wolfgang,
> 
> On 06/04/2014 17:20, Wolfgang Grandegger wrote:
>> Hi Stefan,
>>
>> sorry for jumping in late...
> 
> No problem..but you picked up V2. Some of the issues you see are already
> solved in V3, some not, and some are new. I add here some comments when
> there are still unsolved issues.

My bad. I picked an old version.

>> This driver is rather special in various
>> respects. As I see it, it does not support:
>>
>>   - loopback (echo_skbs)
>>   - error state handling
>>   - any error reporting (CAN error messages)
>>   - any error counting (net and CAN stats)
>>   - recovery from bus-off
>>
>> Any chance to improve on that? At least some kind of error reporting
>> would be nice otherwise the app does not realize any problems. Or how
>> does your app handle error cases.
> 
> About IFF_ECHO: in my understanding, by enabling IFF_ECHO the driver
> should sent messages back to the upper layer as fast as these messages
> are put on the bus. As I see in most drivers, can_put_echo() is called
> directly into the ISR for most drivers.

Yes, actually when TX is done.

http://lxr.linux.no/#linux+v2.6.37/Documentation/networking/can.txt#L176

> This driver implements a sort of "remote CAN". I do not know when
> messages are really put on the bus, because this is done by the
> microcontroller and not by the Main Controller. There is always a
> latency due to the fact that I can only enqueue messages on the SPI Bus
> using the SPI framework, letting the microcontroller doing the rest.
> Because I do not know when messages are really sent, I thought it makes
> little sense to implement echo_skbs. I did it during the development
> (you have found tracks of it), but I dropped later. IMHO this driver
> should not turn on IFF_ECHO.

To get that working the firmware must send some notification when TX is
done... which will be delayed, of course. It's still regarded to be
better than the loopback done by the protocol layer anyway. The GS_USB
driver does it for example. But I understand your concerns. Also the TX
done notification requires resources and bandwidth especially when the
firmware must handle 5 CAN buses concurrently.  It would reduce the TX
rate for sure.
BTW: does the work-queue handling limit the maximum TX rate? If yes,
threaded interrupts might be the better solution.

> Agree that it should be nice to have some error reporting from the
> microcontroller. However, it seeems quite difficult for the firmware
> developers to get it. There is currently no error reporting to the main
> controller, and if I do something in this direction, it remains untested
> because I cannot get the related firmware. I will really prefer to let
> the driver in, even if this feature is not implemented, and add it later
> when there is a use case for it.

OK, thinking more about it, a simple state handling is more important
than error reporting and it should be rather simple to implement in
firmware. It also does not require a lot of resources.

>>> +/* Default Values */
>>> +static struct can_bittiming_const spi_can_bittiming_const = {
>>> +	.name = DRV_NAME,
>>> +	.tseg1_min = 4,
>>> +	.tseg1_max = 16,
>>> +	.tseg2_min = 2,
>>> +	.tseg2_max = 8,
>>> +	.sjw_max = 4,
>>> +	.brp_min = 1,
>>> +	.brp_max = 64,
>>> +	.brp_inc = 1,
>>> +};
>>
>> Hm, this is specific to the hardware and should not be set globally. Do
>> you need/use it at all. Typically CAN handled by firmware does use
>> rather fixed bit timing parameters. Just the bit-rate can usually be
>> specified.
> 
> Changed in V3, but with the goal in V4 to query the microcontroller at
> the start for the timing.

There is no need for that. Just the bit-rate should be reported properly.

...

>>> +static int spi_can_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>> +{
>>> +	struct spi_can_priv *priv = netdev_priv(dev);
>>> +	struct spi_can_data	*spi_priv = priv->spi_priv;
>>> +	struct msg_queue_tx *tx_pkt;
>>> +	unsigned long flags;
>>> +
>>> +	if (can_dropped_invalid_skb(dev, skb))
>>> +		return NETDEV_TX_OK;
>>> +
>>> +	tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
>>> +	tx_pkt->channel = priv->channel;
>>> +	tx_pkt->skb = skb;
>>> +	tx_pkt->type = SPI_MSG_SEND_DATA;
>>> +	INIT_LIST_HEAD(&(tx_pkt->list));
>>> +
>>> +	/* Add the incoming message to the end of the list */
>>> +	spin_lock_irqsave(&spi_priv->lock, flags);
>>> +	list_add_tail(&(tx_pkt->list), &(spi_priv->msgtx.list));
>>> +	spi_priv->messages_in_queue++;
>>
>> You probabley may want to limit the number of TX messages to be queued.
>> Otherwise the system may even run out of memory... if I understand the
>> code correctly
> 
> You understand right. In my tests, I observed the evolution of
> messages_in_queue to be sure that it does not increase indefinetely
> under heavier bus load, without setting a limit. Agree we need a higher
> limit, I will do it.

Should be rather simple to implement.

>>> +static void spi_can_process_single_frame(struct spi_can_data *spi_data,
>>> +	u32 index)
>>> +{
>>> +	struct list_head *pos;
>>> +	struct msg_queue_rx *msg;
>>> +	u32 found = 0, freed;
>>
>> Why is "int" not just fine.
> 
> For what ? Both are used as boolean, unsigned is right.

Yes, but there is no need for "u32". "unsigned int" should just be fine.
I use the u32 and friends only when the size is fixed, e.g. due to
hardware requirements. In all other cases I use "[unsigned] int" or
"long". But maybe that's also debatable.

...

>>> +static int spi_can_probe(struct spi_device *spi)
>>> +{
>>> +	struct net_device *dev;
>>> +	struct spi_can_platform_data *pdata = spi->dev.platform_data;
>>> +	int ret = -ENODEV;
>>> +	struct spi_can_data *spi_data;
>>> +	struct spi_can_priv *priv;
>>> +	int index, i;
>>> +	u32 can_channels;
>>> +	u32 active = GPIO_ACTIVE_LOW;
>>> +	int data_gpio;
>>> +	u32 flags;
>>> +
>>> +	if (spi->dev.of_node) {
>>> +		if (of_property_read_u32(spi->dev.of_node,
>>> +			    "channels", &can_channels))
>>> +			return -ENODEV;
>>> +		if (!slow_freq) {
>>> +			of_property_read_u32(spi->dev.of_node,
>>> +			    "slowfreq", &slow_freq);
>>> +		}
>>> +		if (!freq) {
>>> +			of_property_read_u32(spi->dev.of_node,
>>> +			    "freq", &freq);
>>> +		}
>>> +		data_gpio = of_get_gpio_flags(spi->dev.of_node,
>>> +				0, &flags);
>>> +		active = (flags & GPIO_ACTIVE_LOW) ? 0 : 1;
>>> +	} else {
>>> +		if (!pdata || (pdata->can_channels < 0) ||
>>> +			(pdata->can_channels > MAX_CAN_CHANNELS))
>>> +			return -ENODEV;
>>> +		if (pdata->slow_freq)
>>> +			slow_freq = pdata->slow_freq;
>>> +		data_gpio = pdata->gpio;
>>> +		active = pdata->active;
>>> +		can_channels = pdata->can_channels;
>>> +	}
>>> +
>>> +	if (!gpio_is_valid(data_gpio)) {
>>> +		dev_err(&spi->dev,
>>> +			"Wrong data valid GPIO: %d\n",
>>> +			data_gpio);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dev_info(&spi->dev, "Channels: %d, gpio %d active %s\n",
>>> +				can_channels,
>>> +				data_gpio,
>>> +				active ? "high" : "low");
>>> +	/* It is possible to adjust frequency at loading time
>>> +	 * if the driver is compiled as module
>>> +	 */
>>> +	if (freq) {
>>> +		if (freq > spi->max_speed_hz) {
>>> +			dev_err(&spi->dev,
>>> +				"Frequency too high: %d Hz > %d Hz. Falling back to %d\n",
>>> +				freq,
>>> +				spi->max_speed_hz,
>>> +				spi->max_speed_hz);
>>> +			freq = spi->max_speed_hz;
>>> +		}
>>> +	}
>>> +
>>> +	/* Check if the supervisor frequency is passed as parameter
>>> +	 * Fallback to 1 Mhz
>>> +	 */
>>> +	if (!slow_freq)
>>> +		slow_freq = SLAVE_SUPERVISOR_FREQ;
>>> +
>>> +	if ((freq && (slow_freq > freq)) ||
>>> +		(slow_freq > SLAVE_SUPERVISOR_FREQ)) {
>>> +		dev_err(&spi->dev,
>>> +			"Supervisor frequency too high: %d Hz > %d Hz. Falling back to %d\n",
>>> +			slow_freq,
>>> +			min(freq, SLAVE_SUPERVISOR_FREQ),
>>> +			min(freq, SLAVE_SUPERVISOR_FREQ));
>>> +			slow_freq = min(freq, SLAVE_SUPERVISOR_FREQ);
>>> +	}
>>> +
>>> +	ret = gpio_request(data_gpio, "spican-irq");
>>> +	if (ret) {
>>> +		dev_err(&spi->dev,
>>> +			"gpio %d cannot be acquired\n",
>>> +			data_gpio);
>>> +		return -ENODEV;
>>
>> Please use goto for cleanup...
> 
> I can do it. Anyway, at this level in probe I have not yet reserved any
> resource, and returning with an error is not wrong. I have nothing to
> free in the cleanup at this point.

You are right. I thought free_irq() or free_gpio() is missing. Maybe
that was some lines later.

Wolfgang.

