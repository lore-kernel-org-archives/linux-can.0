From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 22 Dec 2015 09:13:25 +0100
Message-ID: <56790625.6060908@peak-system.com>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net> <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net> <56602B1D.90601@pengutronix.de>
 <5666AF26.2080806@peak-system.com> <20151208105026.GA13146@maxwell.marel.net>
 <5666C242.8090506@peak-system.com> <20151208122455.GA16567@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41150 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbbLVINm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Dec 2015 03:13:42 -0500
In-Reply-To: <20151208122455.GA16567@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi Andri,

We're currently investigating hard onto this issue. On my side, I'm=20
checking the software part and I'd like to discuss with you about one=20
point:

AFAIK the "sja1000_start_xmit()" function calls are really serialized b=
y=20
the network core. So there's actually no need of any lock to share the=20
access of the SJA1000 registers, regarding the Tx path. Right. But I=20
don't see in this function any test condition over the Transmit Status=20
bit before writing the outgoing CAN frame (aka "reg[SJA1000_SR] & SR_TS=
").

Without testing the Transmit Status bit before writing, wouldn't it be=20
possible that any 2nd task overwrite a 1st frame written by a 1st task=20
before it has been really sent by the SJA1000?

Regards,

St=E9phane

Le 08/12/2015 13:24, Andri Yngvason a =E9crit :
> Hi Stephane,
>
> On Tue, Dec 08, 2015 at 12:42:58PM +0100, Stephane Grosjean wrote:
>> Hi Andri,
>>
>> So, you mean that, for example, the below sequence (extract from _xm=
it()):
>>
>>                  priv->write_reg(priv, SJA1000_FI, fi);
>>                  priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8=
) >> 3);
>>                  priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007=
) << 5);
>>                  ...
>>                  (1)
>>                  ...
>>                  sja1000_write_cmdreg(priv, CMD_TR);
>>
>> can't be interrupted at all (especially at (1)), by any IRQ which IS=
R could
>> write (again) some new ID?
>> I mean, shouldn't the SJA1000 and the sequence order of the cmds be
>> considered as shared resource?
>>
> AFAIK only _xmit() writes to these registers and I think the _xmit() =
function is
> only ever executed on one core at a time. Executing two of them at th=
e same time
> wouldn't make much sense. It would just cause out-of-order transmissi=
on.
>
> Also, the interrupt routine does not call _xmit() directly. It just c=
alls
> netif_wake_queue() which AFAIK schedules the _xmit() routine to be ca=
lled later.
>
> I'm just saying that we shouldn't place locks where they are not need=
ed because
> it really just obfuscates the real issue. It's the equivalent of leav=
ing the
> mess on the ground and just walking around it instead of cleaning it =
up. Someone
> else will step into it.
>
> Besides, ftrace does not show _xmit() being called concurrently for t=
he frames
> that are lost.
>
> By the way, I'm not sure that I understood you correctly. Did placing=
 the spin
> locks prevent the issue? I'm not sure this "guess what" rhetoric work=
s well on a
> mailing list. ;)
>
> Thanks,
> Andri

--

We hereby inform you that PEAK-System Europe will be closed from 24 Dec=
ember 2015 untill 4 January 2016.=20
During this period there will be only limited software and technical su=
pport available.

 We wish you all a merry christmas and a happy new year!

 -The PEAK-System Europe  Team -

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
