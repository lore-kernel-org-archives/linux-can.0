From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Thu, 03 Apr 2014 21:28:35 +0200
Message-ID: <533DB663.3030408@hartkopp.net>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <533D774C.4050703@pengutronix.de> <alpine.DEB.2.02.1404031703120.14882@ionos.tec.linutronix.de> <1497730.QLQMESBtqQ@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:63369 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbaDCT2i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 15:28:38 -0400
In-Reply-To: <1497730.QLQMESBtqQ@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Alexander,

one of the differences of the SMP patch from Thomas

	http://marc.info/?l=linux-can&m=139638860032202&w=2

and your patch

	http://marc.info/?l=linux-can&m=139403248814172&w=2

is that you introduced a

	spin_lock_irqsave(&priv->lock, flags);

additionally to the usage of the two different message interfaces.

Could this probably help to fix the concurrent access?

Regards,
Oliver

On 03.04.2014 17:47, Alexander Stein wrote:
> On Thursday 03 April 2014 17:11:18, Thomas Gleixner wrote:
>>>> based on tag 'linux-can-fixes-for-3.15-20140401' on repository git://gitorious.org/linux-can/linux-can I have noticed message losts(only one message each time). Interestingly 'candump any,0~0,#FFFFFFFF' didn't show yn error frames.
>>>> From 500000 CAN frames I lost 72 frames.
>>
>> The split RX buffer handling is causing the hardware to drop frames
>> without giving any notice. We debugged that in the last days and can
>> prove that it is an hardware issue. Fun, isn't it ?
>>
>> The package drop happens always at the point where the 8th message
>> buffer is read out and all the lower buffers are reenabled. So
>> something confuses the state machine of the message handler here.
>>
>> If we disable the split buffer handling, then the drop out stops. That
>> might cause packet reordering though. Find below a test patch.
> 
> I had to modify your patch slightly, but It didn't show any reordering though. Just the lost messages as before.
> Regarding http://marc.info/?l=linux-can&m=139403207713987&w=2 it seems there is a race, when reenabling the lower buffers, bewteen reading current state and hardware inserting new message.
> 
> Alexander
> 
> Here is my used patch:
> diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
> index 61ffc12..fdca6a9 100644
> --- a/drivers/net/can/c_can/Kconfig
> +++ b/drivers/net/can/c_can/Kconfig
> @@ -14,6 +14,12 @@ config CAN_C_CAN_PLATFORM
>  	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
>  	  boards like am335x, dm814x, dm813x and dm811x.
>  
> +config CAN_C_CAN_NO_RX_SPLIT
> +	bool "Disable RX Split buffer"
> +	---help---
> +	  RX Split buffer prevents packet reordering but can cause packet
> +	  loss. Select the lesser of the two evils.
> +
>  config CAN_C_CAN_PCI
>  	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
>  	depends on PCI
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 01dc494..d9dbac4 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -808,8 +808,12 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  	while ((obj = ffs(pend)) && quota > 0) {
>  		pend &= ~BIT(obj - 1);
>  
> +#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
>  		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
>  			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
> +#else
> +		mcmd = IF_COMM_RCV_HIGH;
> +#endif
>  
>  		c_can_object_get(dev, IF_RX, obj, mcmd);
>  		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> @@ -833,10 +837,11 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  		/* read the data from the message object */
>  		c_can_read_msg_object(dev, IF_RX, ctrl);
>  
> +#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
>  		if (obj == C_CAN_MSG_RX_LOW_LAST)
>  			/* activate all lower message objects */
>  			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX, ctrl);
> -
> +#endif
>  		pkts++;
>  		quota--;
>  	}
> 
