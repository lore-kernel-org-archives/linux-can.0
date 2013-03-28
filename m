From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BCM periodic send
Date: Thu, 28 Mar 2013 22:18:07 +0100
Message-ID: <5154B38F.5080404@hartkopp.net>
References: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:57598 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab3C1VSL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Mar 2013 17:18:11 -0400
In-Reply-To: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Boris Baskevitch <boris.baskevitch@annecy-elec.fr>
Cc: linux-can@vger.kernel.org

On 28.03.2013 17:11, Boris Baskevitch wrote:

> I need some help on 2 issues, I'm using Socket-CAN BCM feature to send and
> receive periodic messages:
> I configured some periodic TX messages as shown below. It works great except
> the fact that the actual period on the bus doesn't exactly match the
> programmed period, it's a little slower, so I need to add a correction
> factor to get the right period. I guess it's my system timer which is
> incorrectly configured (I use a Fujitsu SoC with ARM Cortex A9). I don't set
> the Jiffie parameter during the boot, so it's recalculated each time I
> power-up the board. I don't know what is the time reference for Socket-CAN
> (jiffies or something else?), do you know where should I look to correct it
> ?


The BCM has been moved from jiffies to Linux hrtimers a long time ago in 2.6.26.

What Linux kernel version do you use?

Btw. have you tried a virtual CAN interface? Do you have similar problems there?

> Second point, I would like to change the content of the periodic frames at
> runtime without reconfiguring the timer, ID and flags. What is the most
> elegant way to do it ?


Send a TX_SETUP without "SETTIMER|STARTTIMER" in msg_head.flags, is the really
most elegant way :-)

The flags are parsed when TX_SETUP is consumed.

But the CAN frame content has to be complete, so you can modify your second
TX_SETUP like this:


>>     msg.msg_head.opcode = TX_SETUP;
>>     msg.msg_head.flags = TX_CP_CAN_ID;

// you even do not need TX_CP_CAN_ID as you set both values below.

>>     msg.msg_head.count = 0;

// When count is zero, there's no use of TX_COUNTEVT

>>     msg.msg_head.ival1.tv_sec = 0;
>>     msg.msg_head.ival1.tv_usec = 0;
>>     msg.msg_head.ival2.tv_sec = 0;
>>     msg.msg_head.ival2.tv_usec = 0;

// These values are not used as SETTIMER is not set

>>     msg.msg_head.can_id = CAN_ID_ETAT_COMB;
>>     msg.msg_head.nframes = 1;
>>     msg.frame[0].can_id = CAN_ID_ETAT_COMB;

// Setting this value can be omitted when TX_CP_CAN_ID is set, which takes it
from msg.msg_head.can_id then.

>>     msg.frame[0].can_dlc = 8;
>>     msg.frame[0].data[0] = 0;
>>     msg.frame[0].data[1] = 0;
>>     msg.frame[0].data[2] = 0;
>>     msg.frame[0].data[3] = 0;
>>     msg.frame[0].data[4] = 0;
>>     msg.frame[0].data[5] = 0;
>>     msg.frame[0].data[6] = 0;
>>     msg.frame[0].data[7] = 0;

Regards,
Oliver

> Thanks for your help !
> 
> Here's my periodic TX frame setup:
> 
> void CanBus::StartPeriodicSend(void)
> {
>      struct {
> 	struct bcm_msg_head msg_head;
> 	struct can_frame frame[1];
>      } msg;
>     
>      
>     msg.msg_head.opcode = TX_SETUP;
>     msg.msg_head.flags = SETTIMER|STARTTIMER|TX_CP_CAN_ID|TX_COUNTEVT;
>     msg.msg_head.count = 0;
>     msg.msg_head.ival1.tv_sec = 0;
>     msg.msg_head.ival1.tv_usec = 0;
>     msg.msg_head.ival2.tv_sec = 0;
>     msg.msg_head.ival2.tv_usec = 450000*0.979;		/* interval for the
> following frames with correction factor */
>     msg.msg_head.can_id = CAN_ID_ETAT_COMB;
>     msg.msg_head.nframes = 1;
>     msg.frame[0].can_id = CAN_ID_ETAT_COMB;
>     msg.frame[0].can_dlc = 8;
>     msg.frame[0].data[0] = 0;
>     msg.frame[0].data[1] = 0;
>     msg.frame[0].data[2] = 0;
>     msg.frame[0].data[3] = 0;
>     msg.frame[0].data[4] = 0;
>     msg.frame[0].data[5] = 0;
>     msg.frame[0].data[6] = 0;
>     msg.frame[0].data[7] = 0;
> 
>     if (write(m_fd, &msg, sizeof(msg)) < 0){
> 	DiagnosticPlatform::ConsoleOut("CAN: ERROR: send BCM message !\n");
>     }
> }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


