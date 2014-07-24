From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 24 Jul 2014 20:44:15 +0530
Message-ID: <53D122C7.4020504@gmail.com>
References: <1406196706-4548-1-git-send-email-sbabic@denx.de> <1406196706-4548-4-git-send-email-sbabic@denx.de> <53D0ED0C.4080400@gmail.com> <53D11E25.6010704@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33053 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbaGXPOU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Jul 2014 11:14:20 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so3780091pde.4
        for <linux-can@vger.kernel.org>; Thu, 24 Jul 2014 08:14:20 -0700 (PDT)
In-Reply-To: <53D11E25.6010704@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Stefano,

On Thursday 24 July 2014 08:24 PM, Stefano Babic wrote:
> Hi Varka,
>
> thanks for review. Just a couple of questions..
>
> On 24/07/2014 13:25, Varka Bhadram wrote:
>> On 07/24/2014 03:41 PM, Stefano Babic wrote:
>>
>> (...)
>>
>>> +#include <linux/netdevice.h>
>>> +#include <linux/can.h>
>>> +#include <linux/can/dev.h>
>>> +#include <linux/can/error.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/list.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/wait.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/kthread.h>
>>> +#include <linux/workqueue.h>
>>> +#include <linux/can/platform/spi_can.h>
>>> +#include <linux/spi/spi.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/net_tstamp.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of_gpio.h>
>>> +
>> It looks good if all headers sorted in alphabetical order..  :-)
> I will do it.
>
>>> +};
>>> +
>> better to move all these into new local header file ...
>>
> I agree with Mark. All structures are used only by this driver, there is
> no need for a header file.

Agree...

>>> +static void spi_can_set_timestamps(struct sk_buff *skb,
>>> +    struct msg_channel_data *msg)
>> good if match open parenthesis
>> static void spi_can_set_timestamps(struct sk_buff *skb,
>>                     struct msg_channel_data *msg)
> I will fix it globally.
>
>
>>> +    tx_pkt = kzalloc(sizeof(*tx_pkt), GFP_KERNEL);
>>> +    if (!tx_pkt) {
>>> +        dev_err(&dev->dev, "out of memory");
>> missed terminating new line...
> Thanks ! I will fix it.
>
>>> +
>>> +    tx_pkt = kzalloc(sizeof(struct msg_queue_tx), GFP_KERNEL);
>> sizeof(*tx_pkt)...?
> Agree.
>
>>> +    tx_pkt->channel = priv->channel;
>>> +    tx_pkt->skb = skb;
>>> +
>> (...)
>>
>>> +static irqreturn_t spi_can_irq(int irq, void *pdata)
>>> +{
>>> +    struct spi_can_data *spi_priv = (struct spi_can_data *)pdata;
>>> +    int val;
>>> +
>>> +    val = gpio_get_value(spi_priv->gpio);
>>> +
>> Where did you use 'val' ?
> A corpse from debugging. I will drop it ;-)
>
>>> +#ifdef CONFIG_OF
>>> +static const struct spi_device_id spi_can_ids[] = {
>>> +    { "spican", 0},
>>> +    { "canoverspi", 0},
>>> +    { },
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, spi_can_ids);
>>> +#endif
>>> +
>> Move these device ids after probe/remove functionalities... Every driver
>> follows
>> same concept.
>>
>> Here you used #ifdef CONFIG_OF... What is the use ..?
> The driver can be used with targets supporting DT as well as with
> targets where there is not (yet) DT.

Yes.. Fine

>   In last case CONFIG_OF is not set
> and a platform device sets the data.

In our case we can load the driver by DT or Non-DT way.

If the DT approach is not used means CONFIG_OF is not set. In this case
the device ids wont be added in the kernel device ids. For this we have
to define spi_device_ids and update .id_table in struct spi_driver.

For DT approach(CONFIG_OF = y) we have to define of_device_ids
and update .driver.of_match_table with this ids.


Please see:http://lxr.free-electrons.com/source/drivers/net/can/mcp251x.c#L1253

> There are multiple drivers in
> kernel doing in this way to support both worlds.
>
>>> +        .owner = THIS_MODULE,
>> this field updated automatically...
> ok, I was used to add it in any case. A bad habit, then.
>

-- 
-Varka Bhadram

