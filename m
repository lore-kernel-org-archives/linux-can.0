From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Wed, 9 Jul 2014 17:07:12 -0700
Message-ID: <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
 <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com>
 <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
 <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net>
 <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32801 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbaGJAHd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 20:07:33 -0400
Received: by mail-ie0-f170.google.com with SMTP id lx4so5967341iec.29
        for <linux-can@vger.kernel.org>; Wed, 09 Jul 2014 17:07:32 -0700 (PDT)
In-Reply-To: <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Sun, Jul 6, 2014 at 9:11 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> On Sun, Jul 6, 2014 at 12:38 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>> On 07/06/2014 06:13 PM, Oliver Hartkopp wrote:
>>> Answering myself:
>>>
>>> I tested the latest 3.16.0-rc3-00149-g034a0f6 with tst-packet.c and it works
>>> like charm. Receiving and sending with tst-packet is no problem.
>>> I was using the SJA1000 based EMS PCMCIA card in my laptop for this test.
>>>
>>> So I really wonder why (obviously) a CAN frame is processed by the PF_PACKET
>>> reception handler at the start of your system?!?
>>
>> What about a dhcp client or the kernel's autoip functionality?
>>
>> Marc
>
> That is a good hypothesis.  DHCP is enabled on the machine with the
> problem, and the machine at my desk which isn't reproducing the panic
> has it disabled.  I'll enable it tomorrow and try it.
>
> Austin

Turns out reproducing this bug at my desk is a bit of a pain.  It
takes 10 reboots, with a standard deviation of 9 to reproduce the bug.

With Oliver's patch, I'm able to get to 60 reboots and counting, so it
looks like that was the problem.  I'll leave it rebooting over night
to be sure.

Austin


For my future reference/anyone else who is interested, here is the
number of reboots until failure without the patch
27 successful reboots
1 failed reboot
2 successful reboots
1 failed reboot
13 successful
1 failed
5 successful
2 failed
10 successful
2 failed
3 successful
1 failed
4 successful
1 failed
19 successful
1 failed
