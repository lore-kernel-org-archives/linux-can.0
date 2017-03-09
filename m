From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Please explain berr-reporting
Date: Thu, 9 Mar 2017 21:20:50 +0100
Message-ID: <4cd61057-bc22-02ec-7a01-3c8827e94008@grandegger.com>
References: <CAFoRp-PrdJvfmTUTBVcRgE+kSwggoObt3K=04qRfD2PWus+ZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:40408 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdCIUUy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 15:20:54 -0500
In-Reply-To: <CAFoRp-PrdJvfmTUTBVcRgE+kSwggoObt3K=04qRfD2PWus+ZNA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hans L <thehans@gmail.com>, linux-can@vger.kernel.org

Hello Hans,

Am 09.03.2017 um 20:31 schrieb Hans L:
> I tried asking this as a part of a larger issue a few months ago and
> didn't get any explanation, so I'm trying again, focusing specifically
> on this single issue.
>
> Can anyone tell me what enabling berr-reporting does?
>
> It is only mentioned once in this documentation, in the list of ip
> link options: https://www.kernel.org/doc/Documentation/networking/can.txt
>
> There seems to be absolutely zero documentation of what this is
> supposed to do.  Does anyone know?  Does it really do anything?

I think it can easily be understood by looking to the SJA1000 driver:

http://lxr.free-electrons.com/source/drivers/net/can/sja1000/sja1000.c#L152

	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
		priv->write_reg(priv, SJA1000_IER, IRQ_ALL);
	else
		priv->write_reg(priv, SJA1000_IER,
				IRQ_ALL & ~IRQ_BEI);

If bus error reporting is enabled via "ip link set canX type can ... 
*berr-reporting on* ...", the bus error interrupt (IRQ_BEI) of the 
SJA1000 will be enabled. Then any bus error will trigger an interrupt 
and deliver an error message. The problem is that bus errors can occur 
at a very high rate. E.g. if no cable is connected it will flood the 
system with these interrupts. On slow systems it can overload/hang it. 
Therefore bus error reporting is disabled by default. Unfortunately 
disabling bus errors is not on all controllers that easy to achieve then 
on the SJA1000.

Wolfgang.
