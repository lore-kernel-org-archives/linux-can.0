From: Michael Dressel <michael.dressel@desy.de>
Subject: Re: reading from socket can
Date: Wed, 6 Sep 2017 10:32:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.21.1708241234140.4021@mpslxdressel.desy.de>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de> <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net> <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de> <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de> <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net> <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:36849 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdIFIjG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 6 Sep 2017 04:39:06 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
        by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 8E6CE280317
        for <linux-can@vger.kernel.org>; Wed,  6 Sep 2017 10:32:51 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.21.1708010829350.1508@mpslxdressel.desy.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

now after several weeks we still don't exactly know what causes our
issues. But I think we can exclude it has anything to do with
SocketCAN or the can bus.

Just for information:
We see the problems appear in some older computers but not in computers
that are of the same type but have just slightly different versions of
hardware. There must be some small differences in the
computer hardware that, maybe together with some linux driver, causes
our issues.

Cheers,
Michael


On Tue, 1 Aug 2017, Michael Dressel wrote:

> Hi Oliver,
>
> On Mon, 31 Jul 2017, Oliver Hartkopp wrote:
>
>>  The CAN driver puts struct can(fd)_frames into the socket buffer (skb).
>>
>>  That you don't get 'the rest' of the truncated read() is ensured in the
>>  function raw_recvmsg() in linux/net/can/raw.c.
>>
>>  When the given buffer in the userspace is smaller than the skb->size (==
>>  sizeof(struct can_frame)) there's only the MSG_TRUNC flag set.
>>
>>  At the end of raw_recvmsg() the skb is free'd and there's no more action
>>  on this skb. At the next call of raw_recvmsg() you have new skb and a new
>>  CAN frame, see:
>>
>>  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/net/can/raw.c?h=linux-4.12.y#n796
>> 
> thanks a lot for the explanations. Actually I have no indication for my
> original hypothesis that there is something wrong with the way read() is
> used. So I have to wait and see. At least I have provided for some more
> information to be printed when things go wrong next time.
>
>
> Cheers,
> Michael
>
>
