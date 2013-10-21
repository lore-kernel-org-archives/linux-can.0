From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: Flexcan - timestamp from message buffer to userspace
Date: Mon, 21 Oct 2013 08:54:30 +0200
Message-ID: <5264CFA6.9050805@kkmicro.cz>
References: <l3r0ki$hde$1@ger.gmane.org> <526113A1.8020403@kkmicro.cz> <526148E9.4040406@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42271 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab3JUGyo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Oct 2013 02:54:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VY9Nx-0007K0-N3
	for linux-can@vger.kernel.org; Mon, 21 Oct 2013 08:54:41 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 21 Oct 2013 08:54:41 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 21 Oct 2013 08:54:41 +0200
In-Reply-To: <526148E9.4040406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 18.10.2013 16:42, Oliver Hartkopp napsal(a):
> On 18.10.2013 12:55, Martin Kozusky wrote:
>>
>> Dne 18.10.2013 11:56, Martin Kozusky napsal(a):
>>> Hello,
>>> is there any official way how to read timestamp from flexcans message
>>> buffer?
>>> I see there is a macro defined FLEXCAN_MB_CNT_TIMESTAMP in flexcan.c,
>>> but not used.
>>> I would modify function flecan_read_fifo like
>>>
>>> + u32 timestamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);
>>
>> sorry, u32 should be just u16
>>
>>> but what to do with timestamp variable next and how to read it in
>>> userspace? :) I could change structure can_frame and add  u32 timestamp
>> also u16, not u32
>>
>>> into it, but it wouldn't be very nice hack I think.
>>>
>>> BTW: is timestamp read with SO_TIMESTAMP  actualy taken when CAN message
>>> arrives?
>>>
>
> Hello Martin,
>
> with SO_TIMESTAMP you get the system timestamp in nanosec resolution.
>
> It is set at the time when the CAN frame is pushed to the network layer by
> the CAN drivers interrupt routine.
>
> See net_timestamp_check() in netif_rx():
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/core/dev.c#n3228
Hello Oliver,
I'm already using SO_TIMESTAMP with recvmmsg so may be I should switch 
to SO_TIMESTAMPNS for better times, right?

> You may get this timestamp via ioctl() or recvmsg().
>
> To pass hardware timestamps there's some infrastructure for ethernet devices in the
> mainlaine kernel, which is configured with "ethtool":
>
>     ethtool -T|--show-time-stamping DEVNAME    Show time stamping capabilities
>
> See details at
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping.txt
>
> And some example source code at
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/timestamping/timestamping.c
>
> There needs to be added some infrastructure to the network devices to query
> and configure the timestamping possibilities.
>
> This is currently missing for CAN devices ...
>
> Even if I moved a wrongly assigned hardware timestamp to another place here:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/usb/peak_usb?id=c9faaa09e2a1335678f09c70a0d0eda095564bab
>
> the rest of the hardware timestamping (& configuration) is still missing.

So I could just do

  struct skb_shared_hwtstamps *hwts;
  hwts = skb_hwtstamps(skb);
  hwts->hwtstamp = FLEXCAN_MB_CNT_TIMESTAMP(reg_ctrl);

in  flecan_read_fifo ?

And then how to read it?

Or will it be easier for me just to change can_frame structure? :)

Thanks,
Martin

> Regards,
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


