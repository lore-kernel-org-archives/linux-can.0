From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 8 Dec 2015 11:21:26 +0100
Message-ID: <5666AF26.2080806@peak-system.com>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net> <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net> <56602B1D.90601@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57708 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbbLHKVs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2015 05:21:48 -0500
In-Reply-To: <56602B1D.90601@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi!

Don't know atm what is buggier, but:

- the issue isn't reproducible with our Windows drivers,
- the issue isn't reproducible with the pcan driver,

IMHO, and after having read and compared the sja1000 and the pcan code,=
=20
I would like clarification on:

- the sja1000_start_xmit() function: what about two (or more) tasks=20
running this function on a SMP system, and, of course, writing to the=20
same SJA1000? Especially, running the (non-protected) sequence of=20
several consecutive "priv->write_reg()" ?

- in the same vein, what happens when an IRQ occurs in the middle of th=
e=20
_xmit()  (non-protected) write_reg() sequence?

=46YI, I have surrounded the _xmit() function as well as the ISR with=20
couples of spin_lock/spin_unlock instructions, rebuild everything and=20
have ran Andri's testbed... and guess what?

So, my question is: I'm far from getting the whole knowledge of how the=
=20
net/can core handles multiple access to the same hardware (maybe=20
concurrent access is managed somewhere else in the network stack, never=
=20
know), but I don't explain how things can run correctly without=20
guaranteeing at least the writing sequences to the SJA1000 registers...

Once again, maybe I'm wrong. ATM, the testbed always runs as it should.=
=2E.

Regards,

St=C3=A9phane


Le 03/12/2015 12:44, Marc Kleine-Budde a =C3=A9crit :
> On 12/03/2015 12:23 PM, Andri Yngvason wrote:
>> I tried it and it's not enough. The sja1000 on the peak pci is an FP=
GA
>> implementation that claims to be sja1000 compatible. Is it possible =
that peak's
>> FPGA implementation is slower than the original sja1000?
> Maybe buggier :)
>
> Marc
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
