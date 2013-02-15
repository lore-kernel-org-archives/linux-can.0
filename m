From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Fwd: can-utils at http://gitorious.org/+linux-can-developers/linux-can/can-utils
Date: Fri, 15 Feb 2013 17:13:23 +0100
Message-ID: <511E5EA3.70804@hartkopp.net>
References: <7073D121A5DFE9448648C0E083BEA9C96C7AA63220@vsrv6.tele-radio.ad> <511E1170.6040409@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:43699 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675Ab3BOQNZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Feb 2013 11:13:25 -0500
In-Reply-To: <511E1170.6040409@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, H.Engblom@tele-radio.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Hakan,

On 15.02.2013 11:44, Marc Kleine-Budde wrote:

> let's wait for Oliver to say something to the length. As far as I know
> the canutils already support can-fd, which can send up to 64 bytes. I
> don't know the standard for sure, but maybe they got rid of the RTR in
> canfd.


Yes. CAN FD does not support RTR.


> Anyway, I think I found a small bug in cansend, when sedning Remote
> Frames. The syntax is (an example):
> 
> 
> 
> $ cansend can0 181#R
> 
> 
> 
> But according to the standard, the dlc field should be set to how much
> data that is expected in the expected tpdo. So I did the change in the
> attached patch, and the syntax now is
> 
> 
> 
> $ cansend can0 181#R8
> 
> 
> 
> to indicate that 8 bytes of process data is expected.
> 


In general RTR are declared to be bad by several CAN related papers.

The CAN Spec states for RTR frames:

	There is no DATA FIELD, independent of the values of the DATA LENGTH
	CODE which may be signed any value within the admissible range 0...8.
	The value is the DATA LENGTH CODE of the corresponding DATA FRAME.

Which probably contains the problem WHY it is declared to be bad, as you would
need a DLC check in the CAN controller for RTR frames, etc.

Btw. you are right, that RTR frames can contain a DLC value: 0 .. 8 - as CAN
FD is not supported anyway.

Looking into the CAN drivers in linux/drivers/net/can it looks like that no
data is copied from the registers in the case of a received RTR frame. But it
also looks like that the can_dlc is set from the controller registers value in
a correct way. I need to doublecheck, if really all drivers handle the can_dlc
correctly in the case of RTR frames.

E.g. the CC770 handles the RTR frames with some local intelligence, and does
not even provide the CAN ID ... and the can_dlc is set to zero in any case:

http://lxr.linux.no/#linux+v3.7.8/drivers/net/can/cc770/cc770.c#L477

In general you idea is ok to support the can_dlc values in CAN 2.0B frames:

$ cansend can0 181#R8

BUT if we add this can_dlc option for RTR frames, it should be *optional* to
be able to ...

- indicate that the can_dlc was not valid
- be backwards compatible to older log files

The RTR stuff in conjunction with can_dlc is not always consistent.

Would this *optional* can_dlc value approach be fine to you?

> @@ -141,6 +141,9 @@
>         if((cs[idx] == 'R') || (cs[idx] == 'r')){ /* RTR frame */
>                 cf->can_id |= CAN_RTR_FLAG;
> +               if ((tmp = asc2nibble(cs[++idx])) > 0x08) /* 8 is max dlc */
> +                       return 1;


This error condition exit would be too hard for an optional value then.

> +               cf->can_dlc = tmp;
>                 return 0;
>         }



Regards,
Oliver

