From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Thu, 31 May 2012 18:28:16 +0200
Message-ID: <4FC79C20.5070600@hartkopp.net>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org> <4FC61E27.6040309@pengutronix.de> <jq5760$sur$1@dough.gmane.org> <4FC62C3D.2000107@pengutronix.de> <jq7rnt$acc$1@dough.gmane.org> <4FC7755F.7020403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:19957 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab2EaQ2T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 May 2012 12:28:19 -0400
In-Reply-To: <4FC7755F.7020403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org


>>>>>> No, CAN has it's own thread, which is just making struct from can
>>>>>> messages (reading via select() )  and writes them into another buffer.
>>>>>> Then the main thread reads this buffer and writes to SD card. Now I
>>>>>> changed it so that this buffer is 30MB big, so I first store all the
>>>>>> messages into RAM, and when I don't need to record CAN frames
>>>>>> anymore, I
>>>>>> write all of them to card from this big buffer.
>>>>>> But this is just limited workaround because I'm limited with the RAM
>>>>>> size (so I had to make the buffer cyclic and just latest xxxx messages
>>>>>> are stored, older are overwritten when the buffer is full).
>>>>>
>>>>> Have you setup realtime priorities for you CAN thread?
>>>> No, I did't set up any special attributes. Do you mean I should use
>>>> pthread_attr_setschedpolicy(ptr,SCHED_RR) or something else?
>>>
>>> or better SCHED_FIFO for your can thread.
>> Hello Marc,
>> I tried that and still when I write
>> dd if=/dev/zero of=/mnt/mmcblk0p1/test bs=512 count=10000 (copy 5MB to
>> SD card)  around 300 CAN frames (from 68500 frames) are lost :(
> 
> http://man7.org/linux/man-pages/man2/recvmmsg.2.html
> 
> Maybe you can use recvmmsg(). I don't know if it works already on can
> sockets.


I wonder, if accessing the MMC/SD card leads to a long-time blocking of
interrupts and therefore lost frames on controller level.

Looks like the flexcan RX FIFO overflow is documented here:
http://lxr.linux.no/#linux+v3.4/drivers/net/can/flexcan.c#L603

Martin, can you check the overflow counters with

ifconfig can0

or

ip -statistics link show can0

after the problem with writing to the MMC/SD card showed up?

Regards,
Oliver
