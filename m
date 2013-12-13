From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Fri, 13 Dec 2013 17:22:50 +0100
Message-ID: <52AB345A.6020203@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <201311131008.55018.pisa@cmp.felk.cvut.cz> <5287E6B2.8020709@hartkopp.net> <85256584a266750b1330cfae8bebd55c@grandegger.com> <5288D236.403@hartkopp.net> <5288FB91.9050703@grandegger.com> <52892B21.9000501@grandegger.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6
 010805@grandegger.com> <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net> <52AA3F16.3070309@grandegger.com> <52AAD5A9.5030607@hartkopp.net> <52AADC61.6010807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:63398 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab3LMQWv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Dec 2013 11:22:51 -0500
In-Reply-To: <52AADC61.6010807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Austin Schuh <austin@peloton-tech.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org



On 13.12.2013 11:07, Marc Kleine-Budde wrote:
> On 12/13/2013 10:38 AM, Oliver Hartkopp wrote:


>> +#if 0
>>  	u16 icr;
>>  
>>  	/* Select and clear in PITA stored interrupt */
>>  	icr = readw(chan->cfg_base + PITA_ICR);
>>  	if (icr & chan->icr_mask)
>>  		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
>> +#else
>> +	while (readw(chan->cfg_base + PITA_ICR) & chan->icr_mask)
>> +		writew(chan->icr_mask, chan->cfg_base + PITA_ICR);
>> +#endif

>>
>> This should usually not have any effect, right?
>> But what happened was a big crash after a pretty short time:
>>
>> [  760.718091] INFO: rcu_preempt self-detected stall on CPU { 1}  (t=84015 jiffies g=482 c=481 q=2688)
> 
> For me it seems that the new while loop keeps spinning and then the rcu
> subsystem detects some stalls.
> 
> Maybe it's time to get in touch with the hardware engineers at peak.
> 

I personally do not expect this to be a PEAK problem as the usual case with
mainline Linux (non -rt) works fine.

Maybe it's time to look into other implementations than PEAK/mainline ...

If they all do it the same way I would assume it's a plain -rt irq thread issue.

Regards,
Oliver
