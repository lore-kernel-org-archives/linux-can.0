From: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Subject: Re: at91_can.c: Data transmission stops
Date: Wed, 28 Nov 2012 16:09:59 +0100
Message-ID: <50B62947.4090300@rosetechnology.dk>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk> <50B4EAE1.6070400@grandegger.com> <50B61E1B.8040904@rosetechnology.dk> <50B61FE4.5090905@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040600060401000204060600"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([95.154.61.7]:47505 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2K1PKB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:10:01 -0500
In-Reply-To: <50B61FE4.5090905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600060401000204060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/2012 03:29 PM, Marc Kleine-Budde wrote:
> On 11/28/2012 03:22 PM, Henrik Bork Steffensen wrote:
>> On 11/27/2012 05:31 PM, Wolfgang Grandegger wrote:
>>> On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
>>> Hm, could you show your diffs.
>> Do You mean a diff on these 7 lines, or a diff to the original file?
>>
>>>> I this case "at91_poll" is basicly the same as "c_can_poll", in both
>>>> cases they call the function with the spinlock in the rx chain.
>>> You don't need to protect against RX. Sorry, forgot that. On the c_can
>>> this is necessary due to concurrent accesses to the same message RAM.
>> Ok, I think that at91_can.c might have an issue in register access.
>> I am not sure, but I will look into it.
>>
>>>> Looking at the patch Wolfgang sugested, I became uncertain of what this
>>>> patch actually wants to protect.
>>>> Is it the registers in the cpu can interface? (mailboxes and control
>>>> regs, i don't know the hw)
>>> As mentioned above, on the c_can there is definitely a race with the
>>> message ram due to the busy wait after accessing it. See:
>>>
>>>     http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237
>>>
>>>> Or is it the potential race between "c_can_start_xmit" and
>>>> "c_can_do_tx" ?
>>>> Or even the access to the net api?
>>>>
>>>> Would someone care to explain?
>>> I will try. In at91_start_xmit, if we get interrupted
>>>
>>>      if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv)))&
>>>                 AT91_MSR_MRDY) ||
>>>                (priv->tx_next&   get_next_mask(priv)) == 0)
>>>
>>>          /* HERE */
>>>
>>>          netif_stop_queue(dev);
>>>
>>> and then at91_irq_tx() is called executing netif_wake_queue() we may end
>>> up with a stopped tx queue. But I'm not yet 100% sure.
>> Ok, thanks a lot.
>>
>> In my case i changed the driver to only use one mailbox for transmission.
>> Which means that the "net_stop_queue" will be called every time a packet
>> is tx'ed.
>> And the "net_wake_queue" will be called after the packet is actually
>> transmitted.
> In your first mail you've written that using only one mailbox increases
> the probability for a lockup.
>
>> This is as far as i can see this is 100% safe, provided that no further
>> "ndo_start_xmit"
>> calls come before the wake_queue call.
>>
>>
>> Anyway, after removing the spin_lock from rx, it loads fine and seems to
>> work.
>> I will do a test with the suggested changes to the tx chain and get to
>> the list
>> if anything interesting appears.
>>
>> Thank You very much for Your help so far :-)
> Can you send me a diff of your current changes?

Hi,

Please note that i have not yet tested it for lockup.
So far i just did a simple rx/tx test.

Patch attached.
Expect large offsets in line numbers.

I have a few other small changes to at91_can.c which might be interesting.
I will get back with them, after checking them against a recent kernel 
version.

regards,
Henrik





--------------040600060401000204060600
Content-Type: text/x-patch;
 name="at91_can.c.tx_race_protection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="at91_can.c.tx_race_protection.patch"

--- drivers/net/can/at91_can.c_org	2012-11-27 09:24:01.410683785 +0100
+++ drivers/net/can/at91_can.c	2012-11-28 15:44:45.786660609 +0100
@@ -149,6 +149,7 @@ struct at91_priv {
 	struct clk		*clk;
 	struct at91_can_data	*pdata;
 	canid_t			mb0_id;
+	spinlock_t lock;	/* to protect against race beetween "netif_stop_queue" and "netif_wake_queue" */
 };
 
 static struct can_bittiming_const at91_bittiming_const = {
@@ -340,9 +341,11 @@ static netdev_tx_t at91_start_xmit(struc
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 reg_mid, reg_mcr, reg_msr;
+	unsigned long flags;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
+	spin_lock_irqsave(&priv->lock, flags);
 
 	/* We nee to read MSR only once - because reading it clear MMI bits */
     reg_msr=at91_read(priv, AT91_MSR(AT91_MB_TX_SINGLE_MB_NUM));
@@ -350,6 +353,7 @@ static netdev_tx_t at91_start_xmit(struc
 	if (unlikely(!(reg_msr & AT91_MSR_MRDY))) {
 		netif_stop_queue(dev);
 		dev_err(dev->dev.parent, "TX buffer full when queue awake!\n");
+		spin_unlock_irqrestore(&priv->lock, flags);
 		return NETDEV_TX_BUSY;
 	}
 	reg_mid = at91_can_id_to_reg_mid(cf->can_id);
@@ -377,6 +381,7 @@ static netdev_tx_t at91_start_xmit(struc
 
 	/* Enable interrupt for this mailbox */
 	at91_write(priv, AT91_IER, 1 << AT91_MB_TX_SINGLE_MB_NUM);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return NETDEV_TX_OK;
 }
@@ -621,7 +626,9 @@ static void at91_irq_tx(struct net_devic
 	struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_msr;
 	unsigned int mb;
+	unsigned long flags;
 
+	spin_lock_irqsave(&priv->lock, flags);
 	/* masking of reg_sr not needed, already done by at91_irq */
 	mb=AT91_MB_TX_SINGLE_MB_NUM;
 	/* event in mailbox? */
@@ -647,6 +654,8 @@ static void at91_irq_tx(struct net_devic
 
 	/* Restart que */
 	netif_wake_queue(dev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static void at91_irq_err_state(struct net_device *dev,
@@ -1050,7 +1059,7 @@ static int __init at91_can_probe(struct
 	
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
 		 priv->reg_base, dev->irq);
-
+	spin_lock_init(&priv->lock);
 	return 0;
 
  exit_free:

--------------040600060401000204060600--
