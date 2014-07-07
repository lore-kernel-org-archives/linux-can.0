From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Sun, 6 Jul 2014 21:11:42 -0700
Message-ID: <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
 <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com>
 <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
 <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net> <53B9A5AD.8050403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:59044 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaGGEMD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jul 2014 00:12:03 -0400
Received: by mail-ig0-f173.google.com with SMTP id uq10so10354924igb.12
        for <linux-can@vger.kernel.org>; Sun, 06 Jul 2014 21:12:02 -0700 (PDT)
In-Reply-To: <53B9A5AD.8050403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Sun, Jul 6, 2014 at 12:38 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 07/06/2014 06:13 PM, Oliver Hartkopp wrote:
>> Answering myself:
>>
>> I tested the latest 3.16.0-rc3-00149-g034a0f6 with tst-packet.c and it works
>> like charm. Receiving and sending with tst-packet is no problem.
>> I was using the SJA1000 based EMS PCMCIA card in my laptop for this test.
>>
>> So I really wonder why (obviously) a CAN frame is processed by the PF_PACKET
>> reception handler at the start of your system?!?
>
> What about a dhcp client or the kernel's autoip functionality?
>
> Marc

That is a good hypothesis.  DHCP is enabled on the machine with the
problem, and the machine at my desk which isn't reproducing the panic
has it disabled.  I'll enable it tomorrow and try it.

Austin
