From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 3 Dec 2015 17:37:26 +0100
Message-ID: <56606FC6.8030804@peak-system.com>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net> <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:53479 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbbLCQhr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2015 11:37:47 -0500
In-Reply-To: <20151203112319.GA5230@maxwell.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi,

The question has been forwarded to our hw engineers.
I will give you any feedback I'll have about that.

Regards,

St=E9phane

Le 03/12/2015 12:23, Andri Yngvason a =E9crit :
> On Thu, Dec 03, 2015 at 07:37:17AM +0100, Oliver Hartkopp wrote:
>> Some more details:
>>
>> On 12/02/2015 08:19 PM, Oliver Hartkopp wrote:
>>> On 12/02/2015 07:09 PM, Andri Yngvason wrote:
>>>> Quoting Andri Yngvason (2015-11-18 14:51:21)
>>>> [...]
>>>>> We've been experiencing frame loss on transmission in the peak_pc=
i netdev
>>>>> driver.
>>>> [...]
>>
>>>>   I tried adding a delay to test my theory:
>>>> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/s=
ja1000/sja1000.c
>>>> index f968d1e..b5115c2 100644
>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>> @@ -93,6 +93,7 @@ static void sja1000_write_cmdreg(struct sja1000_=
priv *priv, u8 val)
>>>>   	spin_lock_irqsave(&priv->cmdreg_lock, flags);
>>>>   	priv->write_reg(priv, SJA1000_CMR, val);
>>>>   	priv->read_reg(priv, SJA1000_SR);
>>>> +	udelay(10);
>>>>   	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
>>>>   }
>>> Hi Andri,
>>>
>>> looking at the code above I wonder whether the
>>>
>>> 	priv->read_reg(priv, SJA1000_SR);
>>>
>>> is a bad hack anyway.
>>>
>>> The read_reg() becomes readb(priv->reg_base + (port << 2)) in peak_=
pci.c and
>>> the result is never used.
>>>
>>> What if the entire operation gets 'optimized' at some point?
> Hi Oliver,
>
> According to ftrace it takes at least 1us to execute.
>
>>> Can you check what happens if you just replace the priv->read_reg()=
 with your
>>> udelay(10) call?
>>>
>> In fact I contributed the first SJA1000 SMP fix myself.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it?id=3D57c8a456640fa3ca777652f11f2db4179a3e66b6
>>
>> As we only picked the code suggestion from Klaus the delay was intro=
duced by
>> priv->read_reg() - which is obviously not the proper way.
>>
>> The data sheet says:
>>
>> "Between two commands at least one internal clock cycle is needed in=
 order to
>> proceed. The internal clock is half of the external oscillator frequ=
ency."
> The upper bound would have been more useful information here. ;)
>
>> The SJA1000 accepts external clocks from 0 to 24 MHz - all our drive=
rs have an
>> external clock of 16 MHz which leads to an internal clock of 8 MHz.
>>
>> If we need an additional internal clock cycle we can calculate this =
with
>> 4 MHz and 1/4.000.000 =3D 0.000,000,25 =3D> 250ns =3D 0.25us
>>
>> Even if someone would use an external clock of 8 MHz a udelay(1) sho=
uld be enough.
>>
>> Can you please make a test where you replace the priv->read_reg() ju=
st with
>> udelay(1)?
> I tried it and it's not enough. The sja1000 on the peak pci is an FPG=
A
> implementation that claims to be sja1000 compatible. Is it possible t=
hat peak's
> FPGA implementation is slower than the original sja1000?
>
> St=E9phane, what do you think?
>
>> If it works I would like to contribute a patch to fix my former atte=
mpt with a
>> Reported-by: and Tested-by: tag from you.
>>
> Sure, whatever gets this fixed is fine by me. ;)
>
> Thanks,
> Andri

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
