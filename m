From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: fix sja1000 =?UTF-8?Q?pre=5Firq/post=5Firq=20han?=  =?UTF-8?Q?dling?=
Date: Mon, 18 Nov 2013 08:48:59 +0100
Message-ID: <673f31d86a6b890f45ab63fb3799cbf0@grandegger.com>
References: <5288CFEF.3060701@hartkopp.net>
 <52892C36.8060709@grandegger.com> <5289B0EF.3070507@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:49298 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab3KRHtC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 18 Nov 2013 02:49:02 -0500
In-Reply-To: <5289B0EF.3070507@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, 18 Nov 2013 07:17:19 +0100, Oliver Hartkopp

<socketcan@hartkopp.net> wrote:

> On 17.11.2013 21:51, Wolfgang Grandegger wrote:

>> Hi Oliver,

>> 

>> On 11/17/2013 03:17 PM, Oliver Hartkopp wrote:

>>> The SJA1000 driver provides optional function pointers to handle

>>> specific

>>> hardware setups at interrupt time.

>>>

>>> This patch fixes the issue that the sja1000_interrupt() function may

>>> have

>>> returned IRQ_NONE without processing the post_irq function.

Additionally

>>> an introduced return value from the pre_irq function is checked to

skip

>>> the

>>> entire interrupt handling on pre_irq function errors.

>>>

>>> Reported-by: Wolfgang Grandegger <wg@grandegger.com>

>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

>>>

>>> ---

>>>

>>> diff --git a/drivers/net/can/sja1000/sja1000.c

>>> b/drivers/net/can/sja1000/sja1000.c

>>> index 7164a99..bb20470 100644

>>> --- a/drivers/net/can/sja1000/sja1000.c

>>> +++ b/drivers/net/can/sja1000/sja1000.c

>>> @@ -494,12 +494,12 @@ irqreturn_t sja1000_interrupt(int irq, void

>>> *dev_id)

>>>  	uint8_t isrc, status;

>>>  	int n = 0;

>>>  

>>> +	if (priv->pre_irq && priv->pre_irq(priv))

>>> +		goto out;

>>> +

>> 

>> Well, not sure if we need that. Looks like a fatal error to me.

>> 

> 

> Why?

> Think about a pre_irq() function that can look into hw specific

registers

> and

> which can determine, that there was no interrupt for this CAN device.

> In this case the access to the sja1000 registers might/should be skipped

> depending on the new return value of pre_irq().



OK, I see. But you should add some comments about the valid return values.



> 

> So what's the error here?

> Btw. by now there's no user of priv->pre_irq() anyway.

> 

> 

>>>  	/* Shared interrupts and IRQ off? */

>>>  	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)

>>> -		return IRQ_NONE;

>>> -

>>> -	if (priv->pre_irq)

>>> -		priv->pre_irq(priv);

>>> +		goto out;

>>>  

>>>  	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&

>>>  	       (n < SJA1000_MAX_IRQ)) {

>>> @@ -507,7 +507,7 @@ irqreturn_t sja1000_interrupt(int irq, void

*dev_id)

>>>  		status = priv->read_reg(priv, SJA1000_SR);

>>>  		/* check for absent controller due to hw unplug */

>>>  		if (status == 0xFF && sja1000_is_absent(priv))

>>> -			return IRQ_NONE;

>>> +			goto out;

>> 

>> Be aware that the function will return IRQ_HANDLED if n > 0... which

may

>> happen. Not exactly the same behaviour.

>> 

> 

> Right.

> 

> We should move the 'n++' from the begin to the end of this while

statement.

> 

> Setting 'n=0' before 'goto out' won't be correct either, as you might

have

> processed a number of correct CAN frames before.



I think you code is correct. If at least one interrupt has been handled we

should return IRQ_HANDLED. I just realized that this is another mistake,

apart from not calling "post_irq". Sorry for confusion.



Another thing I don't like is that the device present check is done for

all devices including devices which will never hotplug. I think this

code has been introduced for the PCMCIA/PCcard CAN controllers. I would

prefer somethink like:



         if (priv->hotpluggable && status == 0xFF &&

             sja1000_is_absent(priv)) {

                 ...

         }



What do you think?



Wolfgang.
