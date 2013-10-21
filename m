From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Mon, 21 Oct 2013 10:00:28 +0200
Message-ID: <07b96b822a3778b2279d78b90cda3908@grandegger.com>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz>
 <526148E9.4040406@hartkopp.net> <5264CFA6.9050805@kkmicro.cz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:56253 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab3JUIAa (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Oct 2013 04:00:30 -0400
In-Reply-To: <5264CFA6.9050805@kkmicro.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

On Mon, 21 Oct 2013 08:54:30 +0200, Martin Kozusky <mkozusky@kkmicro.cz>

wrote:

> Dne 18.10.2013 16:42, Oliver Hartkopp napsal(a):

>> On 18.10.2013 12:55, Martin Kozusky wrote:

>>>

>>> Dne 18.10.2013 11:56, Martin Kozusky napsal(a):

>>>> Hello,

>>>> is there any official way how to read timestamp from flexcans message

>>>> buffer?

>>>> I see there is a macro defined FLEXCAN_MB_CNT_TIMESTAMP in flexcan.c,

>>>> but not used.

>>>> I would modify function flecan_read_fifo like

>>>>

>>>> + u32 timestamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);

>>>

>>> sorry, u32 should be just u16

>>>

>>>> but what to do with timestamp variable next and how to read it in

>>>> userspace? :) I could change structure can_frame and add  u32

timestamp

>>> also u16, not u32

>>>

>>>> into it, but it wouldn't be very nice hack I think.

>>>>

>>>> BTW: is timestamp read with SO_TIMESTAMP  actualy taken when CAN

>>>> message

>>>> arrives?

>>>>

>>

>> Hello Martin,

>>

>> with SO_TIMESTAMP you get the system timestamp in nanosec resolution.

>>

>> It is set at the time when the CAN frame is pushed to the network layer

>> by

>> the CAN drivers interrupt routine.

>>

>> See net_timestamp_check() in netif_rx():

>>

>>

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/core/dev.c#n3228

> Hello Oliver,

> I'm already using SO_TIMESTAMP with recvmmsg so may be I should switch 

> to SO_TIMESTAMPNS for better times, right?

> 

>> You may get this timestamp via ioctl() or recvmsg().

>>

>> To pass hardware timestamps there's some infrastructure for ethernet

>> devices in the

>> mainlaine kernel, which is configured with "ethtool":

>>

>>     ethtool -T|--show-time-stamping DEVNAME    Show time stamping

>>     capabilities

>>

>> See details at

>>

>>

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping.txt

>>

>> And some example source code at

>>

>>

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping/timestamping.c

>>

>> There needs to be added some infrastructure to the network devices to

>> query

>> and configure the timestamping possibilities.

>>

>> This is currently missing for CAN devices ...

>>

>> Even if I moved a wrongly assigned hardware timestamp to another place

>> here:

>>

>>

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/usb/peak_usb?id=c9faaa09e2a1335678f09c70a0d0eda095564bab

>>

>> the rest of the hardware timestamping (& configuration) is still

missing.

> 

> So I could just do

> 

>   struct skb_shared_hwtstamps *hwts;

>   hwts = skb_hwtstamps(skb);



>   hwts->hwtstamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);

> 

> in  flecan_read_fifo ?

> 

> And then how to read it?



See:



http://lxr.free-electrons.com/source/Documentation/networking/timestamping/



> 

> Or will it be easier for me just to change can_frame structure? :)



No. 



> Thanks,

> Martin

> 

>> Regards,

>> Oliver

>>

>> --

>> To unsubscribe from this list: send the line "unsubscribe linux-can" in

>> the body of a message to majordomo@vger.kernel.org

>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

>>

> 

> 

> --

> To unsubscribe from this list: send the line "unsubscribe linux-can" in

> the body of a message to majordomo@vger.kernel.org

> More majordomo info at  http://vger.kernel.org/majordomo-info.html
