From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RFC: (optional) software filtering in candump
Date: Fri, 14 Jun 2013 20:05:52 +0200
Message-ID: <51BB5B80.9060109@hartkopp.net>
References: <190D92B052C049F4B059DCFE8F841940@laptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:63954 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab3FNSF4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Jun 2013 14:05:56 -0400
In-Reply-To: <190D92B052C049F4B059DCFE8F841940@laptop2>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Janusz Uzycki <janusz.uzycki@elproma.com.pl>
Cc: linux-can@vger.kernel.org

On 14.06.2013 10:29, Janusz Uzycki wrote:
> Hi.
>  
> I read the discussion. I agree the documentation should better explain
> multifilter filter policy. I think good workaround could be duplicated
> timestamp filtering - it seems simple to realize in userspace.

Did you see my patch to remove duplicates by matching the CAN-ID and the
timestamp for the raw socket?

> The problem
> could be a lot of frames in short time. Then additional field in can_frame
> struct with packet_id in queue would be useful.

No. For two reasons:

1. The struct can_frame contains the content of a CAN frame, which is
   - a CAN Identifier
   - a data length
   - CAN payload data

   all other stuff is not really CAN specific.

2. The struct can_frame is set in stone with Linux 2.6.25. Any change breaks
   the binary API

> The timestamp could be also
> added in the same way. How SIOCGSTAMP works now?

Use ioctl(s, SIOCGSTAMP, &tv) after read/recvmsg:

See e.g. for a read() syscall
https://gitorious.org/linux-can/can-utils/blobs/master/isotpdump.c#line214

See e.g. for a recvmsg() syscall
https://gitorious.org/linux-can/can-utils/blobs/master/candump.c#line663

> What is difference in
> SO_TIMESTAMP? 

It *is* SO_TIMESTAMP. The standard established programming interface in POSIX
systems. Therefore puting the timestamp into struct can_frame would have been
a mistake.


> Where in kernel (socket layer or low level CAN driver, eq. irq)
> the timestamp is generated?

See netif_receive_skb() (softirq context)
http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L3547

Or netif_rx() (irq context)
http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L3116

These call net_timestamp_check() at
http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L1571

which sets the timestamp if enabled and needed.

So it's at irq level (e.g. for SJA1000 driver)

Additional a hardware timestamp can be retrieved from the hardware and passed
to the userspace. (HW timestamps)

Best regards,
Oliver

