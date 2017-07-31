From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: reading from socket can
Date: Mon, 31 Jul 2017 18:34:03 +0200
Message-ID: <d108399b-5a25-7a0e-f3c4-8b8c1f55eedd@hartkopp.net>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
 <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
 <alpine.LNX.2.21.1707280839520.1663@mpslxdressel.desy.de>
 <6ea8486b-f87c-566d-6a1a-10ef451d6574@hartkopp.net>
 <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:18004 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaQeN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jul 2017 12:34:13 -0400
In-Reply-To: <alpine.LNX.2.21.1707311317460.14130@mpslxdressel.desy.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Dressel <michael.dressel@desy.de>
Cc: linux-can@vger.kernel.org

Hi Michael,

On 07/31/2017 01:33 PM, Michael Dressel wrote:

> I tried provoking an error by calling read() with less
> than sizeof(struct can_frame) bytes intentionally. The
> intention was to corrupt the data this way.
> 
> This I did after reading the first 5000 frames properly and than every 300
> frames.
> 
> I expected to get out of synch after corrupting the reading.
> 
> When I read only two bytes no interpretation is done because
> two bytes are not a multiple of sizeof(struct can_frame).
> 
> During the next read I expected the read to put the remaining
> bytes (not red by the previous call to read) in the beginning
> of the buffer handed into read. Now the data should be corrupted.
> 
> But that is not the case.
> 
> The next frame read already seams to be correct.
> 
> My question here is if already the socket can driver prevents
> corrupting data this way?

The CAN driver puts struct can(fd)_frames into the socket buffer (skb).

That you don't get 'the rest' of the truncated read() is ensured in the 
function raw_recvmsg() in linux/net/can/raw.c.

When the given buffer in the userspace is smaller than the skb->size (== 
sizeof(struct can_frame)) there's only the MSG_TRUNC flag set.

At the end of raw_recvmsg() the skb is free'd and there's no more action 
on this skb. At the next call of raw_recvmsg() you have new skb and a 
new CAN frame, see:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/net/can/raw.c?h=linux-4.12.y#n796

Best regards,
Oliver

