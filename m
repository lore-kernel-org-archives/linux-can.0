From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Thu, 12 Dec 2013 07:13:07 +0100
Message-ID: <52A953F3.3000605@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <52831FC7.3040509@hartkopp.net> <f323c29b9730c877729322453b9e4ec9@grandegger.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.
 net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:15496 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab3LLGNK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Dec 2013 01:13:10 -0500
In-Reply-To: <52A8BC94.6010805@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

On 11.12.2013 20:27, Wolfgang Grandegger wrote:
> On 12/11/2013 05:59 PM, Oliver Hartkopp wrote:
>> Bad news.
>>
>> Unfortunately the patch did not have the wanted effect and the interrupt #19
>> dropped again the late evening.
> 
> Then it was pure luck that it ran that much longer?
> 

Not sure about that. The time to failure is varying pretty much.

>> I'm currently running the setup overnight with the same kernel but only
>> without -rt to make sure it definitely is a -rt issue.
>>

It is. The setup with the mainline kernel is still running this morning.

> 
> BTW, does the problem show up if only one can is active? Austin tests
> did just RX on can1, but can0 was obviously up (but no traffic).

There was a case that the IRQ line from can9, can10, can11, can12 failed with
an error messaged pointing to can10. All four interfaces where up but only
can9 had traffic at that time.

Regards,
Oliver
