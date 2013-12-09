From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 9 Dec 2013 11:48:27 -0800
Message-ID: <CANGgnMYPm7yJOrhb-6Jg1LANk4D40p=UhCBx0Nu=JEbAaUuAeg@mail.gmail.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
	<52931051.90502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62864 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3LITs1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 14:48:27 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so6971687ief.38
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 11:48:27 -0800 (PST)
In-Reply-To: <52931051.90502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

I have applied the patch.  I ran a test with 75% bus load @500000
bits/sec (15% sending from the SJA1000 and 60% from another device on
the bus, running candump can1 to grab the data).  It failed within
minutes.  I'll add the code back in to disable tracing when the IRQ
gets disabled.

Austin

On Mon, Nov 25, 2013 at 12:54 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 11/25/2013 12:03 AM, Marc Kleine-Budde wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> It has been reported that on PREEMPT_RT enabled system the peak SJA1000
>> hardware can trigger "irq X: nobody cared" errors.
>>
>> This patch fixes the issue that the sja1000_interrupt() function may have
>> returned IRQ_NONE without processing the optional pre_irq() and post_irq()
>> function before. Further the irq processing counter 'n' is moved to the end of
>> the while statement to return correct IRQ_[NONE|HANDLED] values at error
>> conditions.
>
> Austin, can you test if this patch solves your problem.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
