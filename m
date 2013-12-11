From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Wed, 11 Dec 2013 20:27:16 +0100
Message-ID: <52A8BC94.6010805@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.
 net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46232 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab3LKT1S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Dec 2013 14:27:18 -0500
In-Reply-To: <52A89A0A.7010803@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On 12/11/2013 05:59 PM, Oliver Hartkopp wrote:
> Bad news.
> 
> Unfortunately the patch did not have the wanted effect and the interrupt #19
> dropped again the late evening.

Then it was pure luck that it ran that much longer?

> I'm currently running the setup overnight with the same kernel but only
> without -rt to make sure it definitely is a -rt issue.
> 
> On 10.12.2013 22:12, Wolfgang Grandegger wrote:
> 
>>>  
>>>  	for (i = 0; i < channels; i++) {
>>> +
>>
>> Please do not add unrelated changes.
>>
> 
> Was not intended. I added/removed some code here ...
> 
>>
>> BTW: while browsing Austin's function trace I realized that we do access
>> also the inactive device if interrupts are shared. I think we should use
>> a shadow register variable for SJA1000_IR. Hope to find some time over
>> the weekend to provide a patch.
> 
> ??
> 
> AFAIK the interrupt is registered in sja1000_open (=> ifconfig up).
> So why do we access an inactive (ifconfig down) device then?

You are right. Sorry for the noise.

BTW, does the problem show up if only one can is active? Austin tests
did just RX on can1, but can0 was obviously up (but no traffic).

Wolfgang.

Wolfgang.

