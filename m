From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can: replace timestamp as unique skb attribute
Date: Sat, 04 Jul 2015 18:00:28 +0200
Message-ID: <5598031C.1020505@hartkopp.net>
References: <1435312699-25999-1-git-send-email-socketcan@hartkopp.net> <55939E4E.8050908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:36553 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbbGEJAs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jul 2015 05:00:48 -0400
In-Reply-To: <55939E4E.8050908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: manfred.schlaegl@gmx.at, tom_usenet@optusnet.com.au, s.grosjean@peak-system.com

On 01.07.2015 10:01, Marc Kleine-Budde wrote:
> On 06/26/2015 11:58 AM, Oliver Hartkopp wrote:
>> Commit 514ac99c64b "can: fix multiple delivery of a single CAN frame for
>> overlapping CAN filters" requires the skb->tstamp to be set to check for
>> identical CAN skbs.
>>
>> Without timestamping to be required by user space applications this timestamp
>> was not generated which lead to commit 36c01245eb8 "can: fix loss of CAN
>> frames in raw_rcv" - which forces the timestamp to be set in all CAN related
>> skbuffs by introducing several __net_timestamp() calls.
>>
>> This forces e.g. out of tree drivers to add __net_timestamp() after skbuff
>> creation to prevent the frame loss fixed in mainline Linux.
>>
>> This patch removes the timestamp dependency and uses an atomic counter to
>> create an unique identifier together with the skbuff pointer.
>>
>> Btw. the new skbcnt element introduced in struct can_skb_priv has to be
>> initialized with zero in out-of-tree drivers too.
>
> ...but only if they don't use alloc_can{,fd}_skb().	

Right. Is it possible to add this fact to the commit message?

>
> Looks much better than the timestamp approach. I'll apply it to
> can/master if there aren't any objections. What about stable?

Yes. I definitely would like to have it in 4.1.x.

Currently GregKH has commit 514ac99c64b queued up for 4.1.2:

http://git.kernel.org/cgit/linux/kernel/git/stable/stable-queue.git/commit/?id=d722d86cbddfbe6442cbb548a548344d1e3e441a

So my favourite would be to have it in 4.1.2 too to have only 4.1.0 and 4.1.1 
dysfunctional and a proper requirement with can_skb_prv(skb)->skbcnt to be set 
in 4.1.2+

Best regards,
Oliver
