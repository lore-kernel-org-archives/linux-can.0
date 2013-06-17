From: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
Subject: Re: RFC: (optional) software filtering in candump
Date: Mon, 17 Jun 2013 13:27:57 +0200
Message-ID: <D1C57559EF7B4FA8A6C669A1BF05CFDB@laptop2>
References: <190D92B052C049F4B059DCFE8F841940@laptop2> <51BB5B80.9060109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout12.mailmx.agnat.pl ([193.239.45.92]:57698 "EHLO
	mailmxout12.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932295Ab3FQL2d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 07:28:33 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

> Did you see my patch to remove duplicates by matching the CAN-ID and the
> timestamp for the raw socket?

I read comments about the patch. Now I see the code and timestamp matching 
:)
Before I thought that each CAN frame is stamped by frame's circular id 
(in/after a queue). Then the filter would be even simpler (id filtering 
instead of can_id and timestamp).

>> The problem
>> could be a lot of frames in short time. Then additional field in 
>> can_frame
>> struct with packet_id in queue would be useful.
>
> No. For two reasons:
>
> 1. The struct can_frame contains the content of a CAN frame, which is
>   - a CAN Identifier
>   - a data length
>   - CAN payload data
>
>   all other stuff is not really CAN specific.

It is not CAN frame data, right, but important information about frame and 
the best timestamp could be used (eg. HW if available).

> 2. The struct can_frame is set in stone with Linux 2.6.25. Any change 
> breaks
>   the binary API

If the field member is added at the end of structure it is extention not 
breaker. On the other hand kernel has well defined API for timestamping.

>> The timestamp could be also
>> added in the same way. How SIOCGSTAMP works now?
>
> Use ioctl(s, SIOCGSTAMP, &tv) after read/recvmsg:
>
> See e.g. for a read() syscall
> https://gitorious.org/linux-can/can-utils/blobs/master/isotpdump.c#line214
>
> See e.g. for a recvmsg() syscall
> https://gitorious.org/linux-can/can-utils/blobs/master/candump.c#line663
>
>> What is difference in
>> SO_TIMESTAMP?
>
> It *is* SO_TIMESTAMP. The standard established programming interface in 
> POSIX
> systems. Therefore puting the timestamp into struct can_frame would have 
> been
> a mistake.
>
>
>> Where in kernel (socket layer or low level CAN driver, eq. irq)
>> the timestamp is generated?
>
> See netif_receive_skb() (softirq context)
> http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L3547
>
> Or netif_rx() (irq context)
> http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L3116
>
> These call net_timestamp_check() at
> http://lxr.linux.no/#linux+v3.9.6/net/core/dev.c#L1571
>
> which sets the timestamp if enabled and needed.
>
> So it's at irq level (e.g. for SJA1000 driver)
>
> Additional a hardware timestamp can be retrieved from the hardware and 
> passed
> to the userspace. (HW timestamps)

Thanks Oliver for the explanation. It's clean now.
Shouldn't hardware timestamping option be implemented like PTP? 
http://lxr.linux.no/linux+v3.9.6/net/core/timestamping.c#L104  (I don't need 
it but I couldn't find HW timestamp code for SJA1000 or MCP2515)

best regards
Janusz

