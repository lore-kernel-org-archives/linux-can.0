From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 03 Dec 2015 07:37:17 +0100
Message-ID: <565FE31D.8060606@hartkopp.net>
References: <20151118145121.32487.38169@maxwell.marel.net> <20151202180937.19023.96078@maxwell.marel.net> <565F4439.3050309@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:26477 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbLCGhV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2015 01:37:21 -0500
In-Reply-To: <565F4439.3050309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, s.grosjean@peak-system.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Some more details:

On 12/02/2015 08:19 PM, Oliver Hartkopp wrote:
> On 12/02/2015 07:09 PM, Andri Yngvason wrote:
>> Quoting Andri Yngvason (2015-11-18 14:51:21)
>> [...]
>>> We've been experiencing frame loss on transmission in the peak_pci netdev
>>> driver.
>> [...]


>>  I tried adding a delay to test my theory:
>> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
>> index f968d1e..b5115c2 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>> @@ -93,6 +93,7 @@ static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
>>  	spin_lock_irqsave(&priv->cmdreg_lock, flags);
>>  	priv->write_reg(priv, SJA1000_CMR, val);
>>  	priv->read_reg(priv, SJA1000_SR);
>> +	udelay(10);
>>  	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
>>  }
> 
> Hi Andri,
> 
> looking at the code above I wonder whether the
> 
> 	priv->read_reg(priv, SJA1000_SR);
> 
> is a bad hack anyway.
> 
> The read_reg() becomes readb(priv->reg_base + (port << 2)) in peak_pci.c and
> the result is never used.
> 
> What if the entire operation gets 'optimized' at some point?
> 
> Can you check what happens if you just replace the priv->read_reg() with your
> udelay(10) call?
> 

In fact I contributed the first SJA1000 SMP fix myself.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=57c8a456640fa3ca777652f11f2db4179a3e66b6

As we only picked the code suggestion from Klaus the delay was introduced by
priv->read_reg() - which is obviously not the proper way.

The data sheet says:

"Between two commands at least one internal clock cycle is needed in order to
proceed. The internal clock is half of the external oscillator frequency."

The SJA1000 accepts external clocks from 0 to 24 MHz - all our drivers have an
external clock of 16 MHz which leads to an internal clock of 8 MHz.

If we need an additional internal clock cycle we can calculate this with
4 MHz and 1/4.000.000 = 0.000,000,25 => 250ns = 0.25us

Even if someone would use an external clock of 8 MHz a udelay(1) should be enough.

Can you please make a test where you replace the priv->read_reg() just with
udelay(1)?

If it works I would like to contribute a patch to fix my former attempt with a
Reported-by: and Tested-by: tag from you.

Many thanks,
Oliver


