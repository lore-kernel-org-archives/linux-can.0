From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Sat, 21 Dec 2013 09:29:56 +0100
Message-ID: <52B55184.901@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>	<52892B21.9000501@grandegger.com>	<CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>	<CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>	<333c0fd4238558062478212eb0704b04@grandegger.com>	<CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>	<a6b0ff36f65f878d1d6b24b42260ad44@grandegger.com>	<52A71B6C.3050600@hartkopp.net>	<8e5f03acb59e16a0ebcd31499a533f15@grandegger.com>	<52A73BB1.7070701@hartkopp.net>	<52A783B2.5020002@grandegger.com>	<52A89A0A.7010803@hartkopp.net>	<52A8BC94.6010805@grandegger.com>	<52A953F3.3000605@hartkopp.net>	<52A9F491.3060406@hartkopp.net>	<52AA3F16.3070309@grandegger.com>	<52AAD5A9.5030607@hartkopp.net>	<52AADC61.6010807@pengutronix.de>	
 <52AB345A.6020203@hartkopp.net>	<52AB407B.4040700@hartkopp.net>	<52AB78BE.6010905@hartkopp.net>	<52AC2A0A.1040201@hartkopp.net> <CANGgnMZNci8_B6O3JmP85ciGHG5kZvhnrBHhjTjJAN09Eea4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50204 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab3LUIaA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Dec 2013 03:30:00 -0500
In-Reply-To: <CANGgnMZNci8_B6O3JmP85ciGHG5kZvhnrBHhjTjJAN09Eea4TA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Austin,

On 12/21/2013 12:13 AM, Austin Schuh wrote:
> I have applied the fix proposed in https://lkml.org/lkml/2013/3/7/222
> for the note_interrupt function right now, and will run a test this
> weekend to see if it fixes it for sure.  I am now consistently seeing
> only 1 / 100000 of the IRQ handler calls being counted as unhandled,
> which is a lot better.

The patch confirms our observations and I was already thinking of
reporting it on the Linux-RT mailing list (or directly to Thomas). Well,
next time I will hesitate less.

Wolfgang.
