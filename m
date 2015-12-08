From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 8 Dec 2015 12:42:58 +0100
Message-ID: <5666C242.8090506@peak-system.com>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net> <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net> <56602B1D.90601@pengutronix.de>
 <5666AF26.2080806@peak-system.com> <20151208105026.GA13146@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:36612 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbLHLnR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2015 06:43:17 -0500
In-Reply-To: <20151208105026.GA13146@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi Andri,

So, you mean that, for example, the below sequence (extract from _xmit(=
)):

                 priv->write_reg(priv, SJA1000_FI, fi);
                 priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >=
> 3);
                 priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) <=
< 5);
                 ...
                 (1)
                 ...
                 sja1000_write_cmdreg(priv, CMD_TR);

can't be interrupted at all (especially at (1)), by any IRQ which ISR=20
could write (again) some new ID?
I mean, shouldn't the SJA1000 and the sequence order of the cmds be=20
considered as shared resource?

Regards,

St=E9phane

Le 08/12/2015 11:50, Andri Yngvason a =E9crit :
> Hi Stephane,
>
> On Tue, Dec 08, 2015 at 11:21:26AM +0100, Stephane Grosjean wrote:
>> Hi!
>>
>> Don't know atm what is buggier, but:
>>
>> - the issue isn't reproducible with our Windows drivers,
>> - the issue isn't reproducible with the pcan driver,
> You have spin locks sprinkled around the pcan driver even where there=
 isn't a
> specific shared resource that's being protected.
>
> However, a nice side-effect of that is that the interrupt routine is =
not allowed
> to run concurrently with the xmit function, so the command register i=
s never
> written to so frequently as in the linux-can driver.
> [...]
>> FYI, I have surrounded the _xmit() function as well as the ISR with =
couples
>> of spin_lock/spin_unlock instructions, rebuild everything and have r=
an
>> Andri's testbed... and guess what?
> I don't know. I'm not sure if you hinted at the answer to this questi=
on. Did the
> problem go away? I guess it did due to the reasons that I mentioned a=
bove.
>
> This does not strike at the core of the issue. A targeted solution is=
 to add a
> delay.
> [...]
>> Le 03/12/2015 12:44, Marc Kleine-Budde a =E9crit :
>>> On 12/03/2015 12:23 PM, Andri Yngvason wrote:
>>>> I tried it and it's not enough. The sja1000 on the peak pci is an =
=46PGA
>>>> implementation that claims to be sja1000 compatible. Is it possibl=
e that peak's
>>>> FPGA implementation is slower than the original sja1000?
>>> Maybe buggier :)
>>>
>>> Marc
>>>
> Regards,
> Andri

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
