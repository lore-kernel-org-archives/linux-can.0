From: Mark <mark5@del-llc.com>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 04 Apr 2014 12:17:58 -0400
Message-ID: <533EDB36.6060404@del-llc.com>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.roboticresearch.com ([198.207.29.151]:46545 "EHLO
	mail.roboticresearch.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbaDDQZa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 12:25:30 -0400
In-Reply-To: <20140404134858.173427806@linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

Thomas:  a few comments on my experience with the CAN driver:

I think I agree with your approach -- I had the same problem losing a 
packet when running through the clearing of the newdat flags.

About a month ago, I re-wrote pch_can.c  (before I discovered this 
mailing list) and got it to work successfully sending / receiving CAN 
data at 1 MBIT with 25% load on the bus.   We wrote a lot of test code, 
sending/receiving messages over several days looking for mistakes, and 
found none.  Running at 1 MBIT definitely helped find the problems in 
the driver....things show up a lot quicker.
The change you describe below (clearing newdat as you go) was one of my 
major changes -- and yes, it allows for potential packet re-ordering.  
But I was happy to live with that in my application -- as opposed to 
dropping packets.

The other major change was to separate the use of ifregs[0] and 
ifregs[1] by task...not by function.  So _xmit()-related functions used 
one.   And _poll()-related functions used the other.  This meant I 
didn't have to use spinlock()'s to ensure mutual exclusion to those 
buffers.  It appears you took the spinlock() path...which should work as 
well (assuming you can spinlock both tasks that would access those 
registers).   I do believe splitting them by task instead of tx vs. rx 
is a better approach however.

Last:  I changed the _poll() routine to run through a "while" loop on 
INTSTAT  (irqstatus) and service all the pending interrupts at once.  
That makes it less likely that packets will arrive out of order, and I 
think reduces processor load.

Mark




On 4/4/2014 11:24 AM, Thomas Gleixner wrote:
> The RX buffer split causes packet loss in the hardware:
>
> What happens is:
>
> RX Packet 1 --> message buffer 1 (newdat bit is not cleared)
> RX Packet 2 --> message buffer 2 (newdat bit is not cleared)
> RX Packet 3 --> message buffer 3 (newdat bit is not cleared)
> RX Packet 4 --> message buffer 4 (newdat bit is not cleared)
> RX Packet 5 --> message buffer 5 (newdat bit is not cleared)
> RX Packet 6 --> message buffer 6 (newdat bit is not cleared)
> RX Packet 7 --> message buffer 7 (newdat bit is not cleared)
> RX Packet 8 --> message buffer 8 (newdat bit is not cleared)
>
> Clear newdat bit in message buffer 1
> Clear newdat bit in message buffer 2
> Clear newdat bit in message buffer 3
> Clear newdat bit in message buffer 4
> Clear newdat bit in message buffer 5
> Clear newdat bit in message buffer 6
> Clear newdat bit in message buffer 7
> Clear newdat bit in message buffer 8
>
> Now if during that clearing of newdat bits, a new message comes in,
> the HW gets confused and drops it.
>
> It does not matter how many of them you clear. I put a delay between
> clear of buffer 1 and buffer 2 which was long enough that the message
> should have been queued either in buffer 1 or buffer 9. But it did not
> show up anywhere. The next message ended up in buffer 1. So the
> hardware lost a packet of course without telling it via one of the
> error handlers.
>
> That does not happen on all clear newdat bit events. I see one of 10k
> packets dropped in the scenario which allows us to reproduce. But the
> trace looks always the same.
>
> Not splitting the RX Buffer avoids the packet loss but can cause
> reordering. It's hard to trigger, but it CAN happen.
>
> With that mode we use the HW as it was probably designed for. We read
> from the buffer 1 upwards and clear the buffer as we get the
> message. That's how all microcontrollers use it. So I assume that the
> way we handle the buffers was never really tested. According to the
> public documentation it should just work :)
>
> Let the user decide which evil is the lesser one.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/net/can/c_can/Kconfig |    6 ++++++
>   drivers/net/can/c_can/c_can.c |    7 ++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> Index: linux-can/drivers/net/can/c_can/Kconfig
> ===================================================================
> --- linux-can.orig/drivers/net/can/c_can/Kconfig
> +++ linux-can/drivers/net/can/c_can/Kconfig
> @@ -14,6 +14,12 @@ config CAN_C_CAN_PLATFORM
>   	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
>   	  boards like am335x, dm814x, dm813x and dm811x.
>   
> +config CAN_C_CAN_NO_RX_SPLIT
> +	bool "Disable RX Split buffer"
> +	---help---
> +	  RX Split buffer prevents packet reordering but can cause packet
> +	  loss. Select the less of the two evils.
> +
>   config CAN_C_CAN_PCI
>   	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
>   	depends on PCI
> Index: linux-can/drivers/net/can/c_can/c_can.c
> ===================================================================
> --- linux-can.orig/drivers/net/can/c_can/c_can.c
> +++ linux-can/drivers/net/can/c_can/c_can.c
> @@ -797,8 +797,12 @@ static int c_can_read_objects(struct net
>   	while ((obj = ffs(pend)) && quota > 0) {
>   		pend &= ~BIT(obj - 1);
>   
> +#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
>   		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
>   			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
> +#else
> +		mcmd = IF_COMM_RCV_HIGH;
> +#endif
>   
>   		c_can_object_get(dev, IF_RX, obj, mcmd);
>   		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> @@ -822,6 +826,7 @@ static int c_can_read_objects(struct net
>   		/* read the data from the message object */
>   		c_can_read_msg_object(dev, IF_RX, ctrl);
>   
> +#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
>   		if (obj < C_CAN_MSG_RX_LOW_LAST)
>   			priv->rxmasked |= BIT(obj - 1);
>   		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
> @@ -829,7 +834,7 @@ static int c_can_read_objects(struct net
>   			/* activate all lower message objects */
>   			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
>   		}
> -
> +#endif
>   		pkts++;
>   		quota--;
>   	}
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

