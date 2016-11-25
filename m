From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Fri, 25 Nov 2016 12:46:08 +0100
Message-ID: <153c7653-ab74-fd0c-c605-7bafe5e44297@hartkopp.net>
References: <1864402.pXgGBBp51L@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:36293 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbcKYLrB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Nov 2016 06:47:01 -0500
In-Reply-To: <1864402.pXgGBBp51L@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org
Cc: =?UTF-8?Q?Daniel_Kr=c3=bcger?= <daniel.krueger@systec-electronic.com>

Hello Alexander,

On 11/24/2016 04:49 PM, Alexander Stein wrote:
> Back to my CAN problem: Only a single core handles USB IRQs and there is
> apparently no softnet_data race.
> The test about wrong CAN frame ordering was done on kernel 4.8.9-gentoo but I
> was also able to reproduce this problem on 3.14.58-gentoo-r1. 3.12.52-gentoo-
> r1 apparently does not suffer from that problem, at least 3 tries were without
> errors. In buggy kernels this problems occured next to every time.
>
> Any idea what got wrong in the network code about gathering the SKBs
> which might result in wrong order?

I detected a similar issue in some 3.1x kernel and asked this question:

http://marc.info/?l=linux-can&m=143637774606287&w=2

When you follow the entire discussion at

http://marc.info/?t=143637789700002&r=1&w=2

you will see that they pushed me to implement NAPI on all CAN interfaces 
which neither makes no sense for CAN controllers that do not have a RX 
FIFO (e.g. sja1000) nor fixes the issue at it's root cause.

Your findings bring up the problem again - good :-)

When you look at the networking guys that like to speed up TCP traffic 
and also put skbs into percpu queues that are related to the receiving 
socket(!!!) instance then it should be possible to put CAN skbs related 
to their CAN interfaces into a percpu queue (to suppress out-of-order 
reception).

IMO the difference is not to queue the skbs for a specific socket but 
for a specific interface.
The 'endpoint' of CAN frames where they have to be in order is can_rcv() 
in af_can.c and not any TCP instance that needs to reassemble the TCP 
traffic for a specific socket.

Can you check whether my suggestion with skb_set_hash() in 
alloc_can_skb() works for you?

In any way I think we should start a new attempt to make clear that the 
skbs have to be in order for a specific interface at can_rcv().
And we need some solution that is enabled by default and fits to the 
netdev guys mindset.

Regards,
Oliver

