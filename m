From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support part 1 - uncommented source
Date: Thu, 03 May 2012 13:43:33 +0200
Message-ID: <4FA26F65.5020804@hartkopp.net>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:16938 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab2ECLnm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 07:43:42 -0400
In-Reply-To: <4FA26D28.80307@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 13:34, Wolfgang Grandegger wrote:

>> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
>> index ea2d942..bddbafb 100644
>> --- a/drivers/net/can/vcan.c
>> +++ b/drivers/net/can/vcan.c
>> @@ -74,9 +74,8 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>>  	struct net_device_stats *stats = &dev->stats;
>>  
>>  	stats->rx_packets++;
>> -	stats->rx_bytes += cf->can_dlc;
>> +	stats->rx_bytes += can_dlc2len(cf->can_dlc);
> 
> Hm, I think "cf->can_dlc" should contain the *real* length. That would
> simplify things a lot. The conversion is done when the corresponding DLC
> registers are read or written.


I thought about this idea some time too.

My problem was that 'can_dlc' says

"CAN data length *code*"

And the dlc for CAN is already well defined.

From a todays view cf->len would indeed be a better expression :-/

We could generally think about a union of 'can_dlc' and 'len' though, where
can_dlc would not be part of struct canfd_frame but only the len value.

As you can see here, i also had the idea of providing both values:

https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next/commit/dc730b789cc1a6a3c04aaacde02c6a5a81988869

But is was a bad design, as you have two APIs modifying one value - you
never know what to trust ... it was a sanity check hell.

Regards,
Oliver
