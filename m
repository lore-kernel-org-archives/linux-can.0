From: Hans L <thehans@gmail.com>
Subject: Re: Please explain berr-reporting
Date: Thu, 9 Mar 2017 14:42:43 -0600
Message-ID: <CAFoRp-PZwFnh4RVocgacb1+tGATqw+OwMVjdypExOZqgoyzopQ@mail.gmail.com>
References: <CAFoRp-PrdJvfmTUTBVcRgE+kSwggoObt3K=04qRfD2PWus+ZNA@mail.gmail.com>
 <4cd61057-bc22-02ec-7a01-3c8827e94008@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35339 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdCIUnZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 15:43:25 -0500
Received: by mail-ua0-f178.google.com with SMTP id q7so78062594uaf.2
        for <linux-can@vger.kernel.org>; Thu, 09 Mar 2017 12:43:24 -0800 (PST)
In-Reply-To: <4cd61057-bc22-02ec-7a01-3c8827e94008@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

So it doesn't have any effect on whether or not "Error frames" are created?

I don't think my application is using the SJA1000 driver, how can I
figure out which one is being used?

The chip I am using is this: http://www.ti.com/product/TMS320DM8148
which has a CAN interface built in.
They just call it "DCAN", but I don't see any driver file with "dcan"
in the name, from the directory tree on the site you linked.

Hans


On Thu, Mar 9, 2017 at 2:20 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hello Hans,
>
> Am 09.03.2017 um 20:31 schrieb Hans L:
>>
>> I tried asking this as a part of a larger issue a few months ago and
>> didn't get any explanation, so I'm trying again, focusing specifically
>> on this single issue.
>>
>> Can anyone tell me what enabling berr-reporting does?
>>
>> It is only mentioned once in this documentation, in the list of ip
>> link options: https://www.kernel.org/doc/Documentation/networking/can.txt
>>
>> There seems to be absolutely zero documentation of what this is
>> supposed to do.  Does anyone know?  Does it really do anything?
>
>
> I think it can easily be understood by looking to the SJA1000 driver:
>
> http://lxr.free-electrons.com/source/drivers/net/can/sja1000/sja1000.c#L152
>
>         if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>                 priv->write_reg(priv, SJA1000_IER, IRQ_ALL);
>         else
>                 priv->write_reg(priv, SJA1000_IER,
>                                 IRQ_ALL & ~IRQ_BEI);
>
> If bus error reporting is enabled via "ip link set canX type can ...
> *berr-reporting on* ...", the bus error interrupt (IRQ_BEI) of the SJA1000
> will be enabled. Then any bus error will trigger an interrupt and deliver an
> error message. The problem is that bus errors can occur at a very high rate.
> E.g. if no cable is connected it will flood the system with these
> interrupts. On slow systems it can overload/hang it. Therefore bus error
> reporting is disabled by default. Unfortunately disabling bus errors is not
> on all controllers that easy to achieve then on the SJA1000.
>
> Wolfgang.
