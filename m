From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [BULK]Re: peak_pci: TX Frame Loss
Date: Tue, 8 Dec 2015 15:12:24 +0100
Message-ID: <5666E548.1090900@peak-system.com>
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
Received: from mail.peak-system.com ([213.157.13.214]:60456 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbbLHOMo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2015 09:12:44 -0500
In-Reply-To: <20151208122455.GA16567@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

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
Ok. If you're right with what you have written above, I do also agree=20
with you: there is no need to lock the _xmit() function nor the ISR.
> Besides, ftrace does not show _xmit() being called concurrently for t=
he frames
> that are lost.
>
> By the way, I'm not sure that I understood you correctly. Did placing=
 the spin
> locks prevent the issue? I'm not sure this "guess what" rhetoric work=
s well on a
> mailing list. ;)

Yes, it did.

St=E9phane
> Thanks,
> Andri
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
