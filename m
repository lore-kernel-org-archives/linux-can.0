From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Mon, 23 Dec 2013 16:58:55 +0100
Message-ID: <52B85DBF.5050507@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com> <CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com> <333c0fd4238558062478212eb0704b04@grandegger.com> <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com> <a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com> <52A71B6C.3050600@hartkopp.net> <8e5f03acb59e16a0ebcd31499a533f15@grandegger.com> <52A73BB1.7070701@hartkopp.net> <52A783B2.5020002@grandegger.com> <52A89A0A.7010803@hartkopp.net> <52A8BC94.6010805@grandegger.com> <52A953F3.3000605@hartkopp.net> <52A9F491.3060406@hartkopp.net> <52AA3F16.3070309@grandegger.com> <52AAD5A9.5030607@hartkopp.net> <52AADC61.6010807@pengutronix.de> <52AB345A.6020203@hartkopp.net> <5
 2AB407B.4040700@hartkopp.net> <52AB78BE.6010905@hartkopp.net> <52AC2A0A.1040201@hartkopp.net> <CANGgnMZNci8_B6O3JmP85ciGHG5kZvhnrBHhjTjJAN09Eea4TA@mail.gmail.com> <52B58FC3.50400@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:60833 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab3LWP67 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Dec 2013 10:58:59 -0500
In-Reply-To: <52B58FC3.50400@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi all,

my tests at these targets:

- Core i7 / 5x PEAK cPCI with linux-3.10.25 (stable)
- Core i7 / 5x PEAK cPCI with linux-3.10.11-rt7 (rt)
- Core i7 / Dell 6510 Laptop linux-3.13.0-rc4 (mainline head)

are all successful so far (Intel i7 M640@2.80GHz).

There was no irq thread issue on the -rt kernel (for at least 4 hours under
heavy load) and my USB mouse worked every time when booting my Laptop (at
least 10 times).

I'll continue applying the patch on my machines to check for any issues. But
so far it looks great.

Best regards,
Oliver

> On 21.12.2013 00:13, Austin Schuh wrote:
>> I have applied the fix proposed in https://lkml.org/lkml/2013/3/7/222
>> for the note_interrupt function right now, and will run a test this
>> weekend to see if it fixes it for sure.  I am now consistently seeing
>> only 1 / 100000 of the IRQ handler calls being counted as unhandled,
>> which is a lot better.

