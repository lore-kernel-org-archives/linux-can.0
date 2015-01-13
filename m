From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Tue, 13 Jan 2015 12:19:46 +1100
Message-ID: <54B472B2.4010300@optusnet.com.au>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:42048 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850AbbAMBjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Jan 2015 20:39:17 -0500
In-Reply-To: <alpine.DEB.2.02.1501121948370.28201@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>, =?UTF-8?B?SGVpbnotSsO8cg==?= =?UTF-8?B?Z2VuIE9lcnRlbA==?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

On 13/01/15 05:50, Viktor Babrian wrote:
> Hi there,
>
> thanks for the quick answer
>> please check
>> http://www.can-wiki.info/doku.php?id=can_faq:problem_solving_questions
> checks out, thanks
>
>> Yes, retransmission is what the CAN controller always does if no other node
>> is connected and gives a ACK to a correct received message
>
> my main concern is the high system load it causes

You're using a "am3359 board (having DCAN CAN controller)". I'm not familiar 
with that chip.

 > # ip link set can1 type can bitrate 500000 triple-sampling on

Does it have a "berr-reporting" option, can you turn it off and does it make 
it any better?

Searching ... you're probably using:

http://lxr.free-electrons.com/source/drivers/net/can/c_can/c_can.c

It has "CAN_CTRLMODE_BERR_REPORTING", but turning that off doesn't prevent the 
interrupts. It just prevents it from calling "netif_receive_skb(skb)" with the 
error information from the poll. It configures the interrupts this way:

     /* enable status change, error and module interrupts */
     #define CONTROL_IRQMSK  (CONTROL_EIE | CONTROL_IE | CONTROL_SIE)

Maybe you can turn the error interrupts off and still have it function. Maybe 
it won't (may be required for bus off recovery).

I'm familiar with the problems with Freescale FlexCAN controllers. They can't 
generate interrupts on CAN state-changes, so the driver writers enable *ALL* 
error interrupts so as to track the state changes. Not many people use or need 
this facility.

The consequence (depending on the CPU and Linux build options) is 10%-100% CPU 
utilisation when there's nothing to ACK the packet, and a higher figure again 
when the bus isn't terminated.

CAN is meant to be used in cars or factories. Running with only one node or a 
disconnected bus is not a "normal" condition, so the hardware and drivers 
don't handle those conditions well.

I'd recommend running a shell script that periodically monitors the CAN 
interrupt rate (or opens an error socket and monitors the error rate) and if 
it detects this situation to just disables the CAN bus for a while or until 
the user fixes the problem.

If you read through the following it might give you enough understanding to 
change your driver, or find another solution.

https://community.freescale.com/thread/333839

Read my final post in that thread.

Search the linux-can list for the series of posts titled "[PATCH] Consolidate 
and unify state change handling" starting 2014-10-20:

http://article.gmane.org/gmane.linux.can/7165

There have also been proposed patches to recognise when there's a "flood" of 
error interrupts and to limit the rate, but possibly not for your driver.

Tom

