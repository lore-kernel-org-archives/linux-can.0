From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 25 Nov 2013 14:05:18 -0800
Message-ID: <CANGgnMZRo8XW1tGkHqENhMghGq3mY9r5QDp-h54W50ZrAxfK6Q@mail.gmail.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
	<52931051.90502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41386 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3KYWFT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 17:05:19 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so6372713pdj.22
        for <linux-can@vger.kernel.org>; Mon, 25 Nov 2013 14:05:19 -0800 (PST)
In-Reply-To: <52931051.90502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>

I'll test the patch on the the 2nd when I have access to the machine
again.  Thanks!

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
