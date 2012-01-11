From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Add support for PEAK PCMCIA PCAN-PC card
Date: Wed, 11 Jan 2012 19:35:49 +0100
Message-ID: <4F0DD685.9070002@grandegger.com>
References: <691329.168246256-sendEmail@ubuntu-i386> <4F0C4020.8010304@grandegger.com> <4F0DC27A.70202@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58200 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933750Ab2AKSfw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 13:35:52 -0500
In-Reply-To: <4F0DC27A.70202@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 01/11/2012 06:10 PM, Grosjean Stephane wrote:
> Hi Wolfgang,

>>> +    /* wait until write enable */
>>> +    for (i = 0; i<  DRV_WRITE_MAX_LOOP; i++) {
>>> +        /* RDSR */
>> This comment does not tell me anything.
> 
> Ok, what about these one?
> 
> /* write command reading the status register */
> ...
> /* get the status register and check write enable bit */
> 
> then;
> 
> /* write command reading the status register */
> ...
> /* get the status register and check write in progress bit */

I don't know what RDSR means, sorry. Just put something human readable.
With some meaningful macro definitions the comment might even be
obsolete/redundant.

..

>>> +/*
>>> + * interrupt service routine
>>> + */
>>> +static irqreturn_t pcan_isr(int irq, void *dev_id)
>>> +{
>>> +    struct pcan_pccard *card = dev_id;
>>> +    struct net_device *netdev;
>>> +    irqreturn_t retval = IRQ_NONE;
>>> +    int i, again;
>>> +
>>> +    do {
>>> +        again = 0;
>>> +
>>> +        /* Check interrupt for each channel */
>>> +        for (i = 0; i<  card->chan_count; i++) {

s/i</i </

>>> +            netdev = card->channel[i].netdev;
>>> +            if (!netdev)
>>> +                continue;
>>> +
>>> +            if (sja1000_interrupt(irq, netdev) == IRQ_HANDLED)
>>> +                again = 1;
>>> +        }
>>> +
>>> +        /* At least one channel handled the interrupt */
>>> +        if (again)
>>> +            retval = IRQ_HANDLED;
>>> +
>>> +    } while (again);
>> I wonder if it makes sense to limit the loop count.
> 
> Had a look to sja1000_interrupt(): you're right, could enter in an
> infinite loop if one of the sja1000 failed into always sending interrupt
> signals...
> On my side, I wonder why entering such a do { } while (again) loop?

Is it an edge or level sensitive interrupt? This custom interrupt
handling was introduced to handle hardware which does not allow to
handle the interrupt per device and the loop is required to avoid
interrupt losses, IIRC. The corresponding PEAK PCAN driver has a similar
for loop:

        loop_count = 0; // restart, since all channels must respond in
                           one pass with no interrupt pending

>>> +    card = kzalloc(sizeof(struct pcan_pccard), GFP_KERNEL);
>>> +    if (!card) {
>>> +        dev_err(&dev->dev, "kzalloc() failure\n");
>> Please be more specific, e.g.: "couldn't allocated card memory".
> 
> As you want, you're (one of) the chief(s) ;-)
> Closed.

Well, the messages should make sense for the user of that driver, and
not for the developer.

Wolfgang
