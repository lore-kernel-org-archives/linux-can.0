From: Viktor Babrian <babrian.viktor@renyi.mta.hu>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Tue, 13 Jan 2015 16:10:29 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1501131523290.12789@login>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.renyi.hu ([193.224.79.18]:44682 "EHLO smtp.renyi.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbAMPKe (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 13 Jan 2015 10:10:34 -0500
In-Reply-To: <54B472B2.4010300@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org

> Maybe you can turn the error interrupts off and still have it function. Maybe 
> it won't (may be required for bus off recovery).

Thanks for the detailed answer. I read the pages and took a look into the 
code.

Regarding state-change behavior, DCAN controller is similar to the one in 
i.MX6. (It has explicit interrupt source for Act->Warn and Pass->BOFF 
transitions).
Although as I understand CAN, you have to have a successful RX or TX event 
to have the counters decrease. That  means that you will have an immediate 
report (i.e. interrupt) on Warn->Active, Pass->Warn and BOFF->Active. As 
far as I see, this latter is explicitly handled by upper layers so driver 
will have to know it anyway.
This means that if I turn off bus error monitoring, the only event I will 
not get immediate report of is Warn->Pass. (Pass->Warn can be reported on 
successful message events if the driver is implemented accordingly. 
Currently it isn't). However it could be reported later upon the first 
successful message event. I beleive missing an accurate report of 
active->passive state change is far better than having a non-responding 
system in the field in scenarios that do happen.

Anyway I modified the code so that state change interrupt is not 
enabled when user sets berr-reporting off (as you kindly suggested). It 
solves the load issue. Bus-off recovery behavior did not change (I made a 
few tests only). Btw the driver disables all interrupts in bus off so I 
guess it does not matter what exact flags were set.

> The consequence (depending on the CPU and Linux build options) is 10%-100% 
> CPU utilisation when there's nothing to ACK the packet, and a higher figure 
> again when the bus isn't terminated.
>
> CAN is meant to be used in cars or factories. Running with only one node or a 
> disconnected bus is not a "normal" condition, so the hardware and drivers 
> don't handle those conditions well.
Well error states are defined by the spec so they ARE normal. What is not 
normal is to bring down system performace when they happen.


I alose added a line to put the controller in init mode in 
c_can_stop() so that bringing the bus down will actually cause the 
controller stop transmitting. I hope it's the way to do this, it would be 
nice if some expert could verify this.

Thanks,
Best Regards,
Viktor

