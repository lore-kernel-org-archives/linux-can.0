From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BUG? candump -x and non CANFD frames
Date: Fri, 24 Jan 2014 17:20:03 +0100
Message-ID: <52E292B3.8010009@hartkopp.net>
References: <52E2754C.9020204@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:28076 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaAXQUI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2014 11:20:08 -0500
In-Reply-To: <52E2754C.9020204@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 24.01.2014 15:14, Marc Kleine-Budde wrote:
> Hello,
> 
> I'm running "candump -x any,0:0,#FFFFFFFF" on standard CAN hardware and
> I see this output:
> 
>   can0  RX - -  222   [7]  00 00 00 00 00 00 00
>   can0  TX - E  111   [1]  00
> 
> The "E" should not be there, as it only makes sense for CANFD frames, as
> it's derived from the "flags" member of the canfd_frame.
> 
>>  68 struct can_frame {
>>  69         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>  70         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
>>  71         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>>  72 };
> 
>> 102 struct canfd_frame {
>> 103         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> 104         __u8    len;     /* frame payload length in byte */
>> 105         __u8    flags;   /* additional flags for CAN FD */
>> 106         __u8    __res0;  /* reserved / padding */
>> 107         __u8    __res1;  /* reserved / padding */
>> 108         __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>> 109 };
> 
> As the software is big and proprietary, I cannot look at the code, if
> the unused 3 bytes in the can_frame are filled with zeros or not. At
> first sight all TX'ed frames have the E flag set.
> 
> What's the correct fix?
> 
> Do we have to fix something in the kernel, is there a possible
> information leak of 3 bytes of kernel memory for TX'ed frames?

I don't assume this. TX frames are usually created by applications (and by
bcm.c and isotp.c which do it correctly).

> Or only a
> cross application information leakage?

Yep.

Someone is sending an uninitialized struct can_frame into the kernel which
comes back this way.

> 
> Another possible solution is to only print the flags member if we
> actually have received CANFD frames.

Yes we could do this based on the maxdlen variable.
But this is just a cosmetic fix which IMO hides possible problems.
Therefore I would tend to leave it as-is which in fact helped to find this
uninitialized application issue.

Regards,
Oliver

