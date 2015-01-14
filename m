From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Wed, 14 Jan 2015 12:35:46 +1100
Message-ID: <54B5C7F2.3060702@optusnet.com.au>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46829 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751389AbbANBft (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 20:35:49 -0500
In-Reply-To: <20150113153243.26859.47218@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Viktor Babrian <babrian.viktor@renyi.mta.hu>
Cc: linux-can@vger.kernel.org

On 14/01/15 02:32, Andri Yngvason wrote:
> Quoting Viktor Babrian (2015-01-13 15:10:29)
>
> Note: The FlexCAN driver does actually respect berr-reporting for i.MX6.
> However, it does not respect it for some older chips.

The flexcan.c driver behaves differently depending on whether it has 
"FLEXCAN_HAS_BROKEN_ERR_STATE" set (on for MX25, MX35, MX53 and off for MX28 
and MX6). I don't think this distinction actually helps, or improves matters 
enough to be worth the CPU loading this causes in these disconnected/solo CAN 
states.

On the "unbroken" chips, the only difference is that you get is interrupts on 
the WARNING transitions. As far as I can see, all that gets you is an 
interrupt when the WARNING state goes away which will trigger a poll that can 
then see that the ERROR_PASSIVE state has cleared in the absence of Receive or 
Transmit interrupts. You get interrupts when the WARNING state sets as well, 
but that happens before the PASSIVE state, so you'll miss that one.

The TXECTR can only decrement on successful transmission which causes a 
transmit interrupt, so the warning interrupt doesn't help here.

The RXECTR only decrements on successful reception, which will cause a receive 
interrupt UNLESS it doesn't match on a filter. But since the driver doesn't 
USE the filters (it accepts everything) that's a moot point too.

Does "FLEXCAN_HAS_BROKEN_ERR_STATE" do anything useful that I've missed? If 
not then that code should be removed. I've done that in the old (Linux 3.4) 
version of the driver I'm using.

> Perhaps, you would like to post your patch? Turning off the
 > interrupts when berr-reporting is off is definitely correct
 > behaviour. Not turning them off seems rather pointless to me.
 > AFAIK the whole point of this flag is to suppress ack-error flood.

There's the load caused by the interrupts, and the additional load caused by 
the call to netif_receive_skb(skb) to report the error up through the stack. 
Getting rid of the latter overhead might have been the intention, or might 
have been "this is the best we can do on this chip".

Tom Evans


