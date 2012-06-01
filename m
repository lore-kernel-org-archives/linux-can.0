From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Fri, 01 Jun 2012 13:22:48 +0200
Message-ID: <4FC8A608.1050303@volkswagen.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de> <jq53rt$uqu$1@dough.gmane.org> <4FC61545.2020504@pengutronix.de> <jq5530$ag8$1@dough.gmane.org> <4FC61E27.6040309@pengutronix.de> <jq5760$sur$1@dough.gmane.org> <4FC62C3D.2000107@pengutronix.de> <jq7rnt$acc$1@dough.gmane.org> <4FC7755F.7020403@pengutronix.de> <4FC79C20.5070600@hartkopp.net> <jq9ti4$hur$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:39220 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2FALX6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Jun 2012 07:23:58 -0400
In-Reply-To: <jq9ti4$hur$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 01.06.2012 10:12, Martin Kozusky wrote:
> Dne 31.5.2012 18:28, Oliver Hartkopp napsal(a):
>>
>>>>>>>> No, CAN has it's own thread, which is just making struct from can
>>>>>>>> messages (reading via select() ) and writes them into another buffer.
>>>>>>>> Then the main thread reads this buffer and writes to SD card. Now I
>>>>>>>> changed it so that this buffer is 30MB big, so I first store all the
>>>>>>>> messages into RAM, and when I don't need to record CAN frames
>>>>>>>> anymore, I
>>>>>>>> write all of them to card from this big buffer.
>>>>>>>> But this is just limited workaround because I'm limited with the RAM
>>>>>>>> size (so I had to make the buffer cyclic and just latest xxxx messages
>>>>>>>> are stored, older are overwritten when the buffer is full).
>>>>>>>
>>>>>>> Have you setup realtime priorities for you CAN thread?
>>>>>> No, I did't set up any special attributes. Do you mean I should use
>>>>>> pthread_attr_setschedpolicy(ptr,SCHED_RR) or something else?
>>>>>
>>>>> or better SCHED_FIFO for your can thread.
>>>> Hello Marc,
>>>> I tried that and still when I write
>>>> dd if=/dev/zero of=/mnt/mmcblk0p1/test bs=512 count=10000 (copy 5MB to
>>>> SD card) around 300 CAN frames (from 68500 frames) are lost :(
>>>
>>> http://man7.org/linux/man-pages/man2/recvmmsg.2.html
>>>
>>> Maybe you can use recvmmsg(). I don't know if it works already on can
>>> sockets.
>>
>>
>> I wonder, if accessing the MMC/SD card leads to a long-time blocking of
>> interrupts and therefore lost frames on controller level.
>>
>> Looks like the flexcan RX FIFO overflow is documented here:
>> http://lxr.linux.no/#linux+v3.4/drivers/net/can/flexcan.c#L603
>>
>> Martin, can you check the overflow counters with
>>
>> ifconfig can0
>>
>> or
>>
>> ip -statistics link show can0
>>
>> after the problem with writing to the MMC/SD card showed up?
> 
> Hello Oliver,
> I just configured can0 with canconfig (speed to 250kbs) and canconfig can0 start
> (BTW: what does "can0 state: ERROR-ACTIVE" mean after I write canconfig can0 
> start? )
> 
> Then I started sending CAN packets. I sent 39660 packets to CAN, but only 
> 35734 were received by the CAN layer?
> 
> this is what is shown (without any app running)
> 
> root@vmx25 /opt$ ./ip -statistics link show can0
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
>     link/can
>     RX: bytes  packets  errors  dropped overrun mcast
>     280440     35734    6       0       6       0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        0       0       0       0 
> 
> And this is show when I copy 5MB to SD card with dd. This time 39347 packets 
> where sent from my app.
> 
> 2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT qlen 10
>     link/can
>     RX: bytes  packets  errors  dropped overrun mcast
>     152197     19335    21      0       21      0
>     TX: bytes  packets  errors  dropped carrier collsns
>     0          0        0       0       0       0 
> 

Well this seems to prove my assumption that you get overruns in the flexcan RX FIFO
when you access the SD card :-(

> Should I try to backport the latest flexcan.c to my 2.6.39 kernel and see if 
> it helps?

In general a backport is a good idea (and should be pretty easy) - there are
only four fixes to apply - especially the irq flooding fix is recommended:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=history;f=drivers/net/can/flexcan.c

But i think you will still have the overruns shown up in your output above.
No matter if you use the Mainline flexcan driver or if you would use any
other flexcan driver. :-(

It really looks like the the SD card access blocks the interrupts in a way
the the frames are overwritten inside the controller itself as no-one gets
the CAN frames from the RX FIFO in time.

Don't know if there's anything that could be done with the interrupt
subsystem in Linux to solve this.

@Marc: Is there something that can be done ...
- with or without NAPI
- by increasing the flexcan RX FIFO
- with interrupt priorities on the i.mx25 ??

Regards,
Oliver
