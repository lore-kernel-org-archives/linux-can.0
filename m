From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-next] Add CAN FD driver infrastructure
Date: Thu, 06 Feb 2014 20:02:11 +0100
Message-ID: <52F3DC33.6080402@hartkopp.net>
References: <52F291D8.90008@hartkopp.net> <52F374DC.3000105@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:26491 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbaBFTCQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 14:02:16 -0500
In-Reply-To: <52F374DC.3000105@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

On 06.02.2014 12:41, Marc Kleine-Budde wrote:
> On 02/05/2014 08:32 PM, Oliver Hartkopp wrote:
>> This is a combined patch to create the CAN FD driver infrastructure.
>>
>> - add a separate configuration for data bittiming (incl. netlink)
>> - the bitrate information is only provided when the bittiming const exist
>> - add the helper to create canfd frame skbs
>> - do not overwrite the skb->protocol in can_put_echo_skb()
> 
> Can you split up the patch into the above mentioned aspects? More
> comments inline.

Yes. Will do.

>>  
>> +struct sk_buff *alloc_canfd_skb(struct net_device *dev,
>> +				struct canfd_frame **cfd)
> 
> Stephane already posted a patch to add this function. I've already
> queued it. Please base you patch on linux-can-next/testing
> 

Oh.

My patch is currently based on Davems net-tree, as this patch

http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=0ae89beb283a0db5980d1d4781c7d7be2f2810d6

is currently not in mainline nor in net-next nor in linux-can-next.

As the above patch clashes with the changes I did, I'll wait for Daves
net-next tree to be opened for development again before sending the patch set.

Btw. nice to see that there are no general problems besides the formal aspect.

Tnx,
Oliver

