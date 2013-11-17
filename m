From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Sun, 17 Nov 2013 15:27:02 +0100
Message-ID: <5288D236.403@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:51368 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3KQO1E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Nov 2013 09:27:04 -0500
In-Reply-To: <85256584a266750b1330cfae8bebd55c@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Austin Schuh <austin@peloton-tech.com>, linux-can@vger.kernel.org



On 17.11.2013 09:18, Wolfgang Grandegger wrote:
> 
> On Sat, 16 Nov 2013 22:42:10 +0100, Oliver Hartkopp


>> Btw. I would try two more things with the sja1000.c driver:
> 
>>
> 
>> 1. Print the corresponding CAN device name and the point in the code
> 
> before
> 
>> returning IRQ_NONE to catch the problematic return site.
> 
>>
> 
>> 2. Replace all IRQ_NONE with IRQ_HANDLED for a test ...
> 
>>
> 
>> Any other ideas?
> 
> 
> 
> A function trace is still the first thing to take. Be aware that the
> 
> tasks are running on more than one CPU. It's just to establish a good
> 
> trigger.
> 

Yes. But so far the function trace only showed the fact of simultaneous irq
treads for the two CAN interfaces - what we were expecting :-)

IMO it's interesting to get the concrete return site from where the IRQ_NONE
is returned. Maybe one of the other interfaces / bits in PITA are enabled
which we did not see so far.

> 
> 
> Anyway, I think the direct "return IRQ_NONE" are wrong because they
> 
> do not call the "irq_post" handler.
> 

That's true. I just sent a patch to fix this issue.

Tnx,
Oliver
