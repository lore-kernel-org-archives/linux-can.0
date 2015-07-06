From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Mon, 06 Jul 2015 16:50:04 +1000
Message-ID: <559A251C.8030307@optusnet.com.au>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net> <559885DC.8040208@optusnet.com.au> <559975A2.9020300@hartkopp.net> <559A15D6.2010704@hartkopp.net>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:32924 "EHLO
	mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753149AbbGFGuL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jul 2015 02:50:11 -0400
In-Reply-To: <559A15D6.2010704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>

On 06/07/15 15:44, Oliver Hartkopp wrote:
> /me again
>
> On 05.07.2015 20:21, Oliver Hartkopp wrote:
>
>> With
>>
>> # echo 1 > /proc/irq/28/smp_affinity
>> ..
>> and all the out-of-order receptions were totally gone! \o/
>>
>
> I ran the test for 11 hours now (3 x 8000 = 24.000 frames/s).
>
> No single out-of-order frame this time - not even with the PCAN-USB.

I don't think you can force a specific "CPU Affinity Requirement" on this driver.

CPU Affinity may fix this problem, but I suspect there should be a more 
"standard" fix. This sort of problem (multiple CPUs fielding interrupts and 
getting them out of order) should show up elsewhere. It might even swap bytes 
from a UART.

There must be a "standard synchronization technique" of some sort that 
provides the proper sequencing here. Can anyone else reading this thread who 
knows if this is right please chime in?

Google finds:

http://www.alexonlinux.com/why-interrupt-affinity-with-multiple-cores-is-not-such-a-good-thing

     Moreover, assuming TCP connection object is properly
     protected using synchronization techniques, one of
     the cores will inevitably have to wait for the other,
     adding unnecessary delay to packet processing.

It seems to me that the "CAN connection object" is not "properly protected" in 
the existing driver. That CAN driver may not have had the "SMP Magic Wand" 
waved over it.

Tom

