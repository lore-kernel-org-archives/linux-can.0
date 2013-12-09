From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 9 Dec 2013 15:50:02 -0800
Message-ID: <CANGgnMYvcaHH9Nm5er1ScKxukyq2NmtRS5+ieXQXigK_tRQctA@mail.gmail.com>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
	<52931051.90502@pengutronix.de>
	<CANGgnMYPm7yJOrhb-6Jg1LANk4D40p=UhCBx0Nu=JEbAaUuAeg@mail.gmail.com>
	<52A6310C.1000703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:55506 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab3LIXuD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 18:50:03 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so7556164iec.9
        for <linux-can@vger.kernel.org>; Mon, 09 Dec 2013 15:50:03 -0800 (PST)
In-Reply-To: <52A6310C.1000703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>

If anything, it increased the frequency of failure (on my RT kernel).
It took 14 minutes to fail the first time, and a little under 2 hours
the second time.

That doesn't mean that it doesn't fix another problem, just that it
doesn't fix the problem that I am having.  I don't see any obvious new
problems caused by the patch.

Austin

On Mon, Dec 9, 2013 at 1:07 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 12/09/2013 08:48 PM, Austin Schuh wrote:
>> Hi Marc,
>>
>> I have applied the patch.  I ran a test with 75% bus load @500000
>> bits/sec (15% sending from the SJA1000 and 60% from another device on
>> the bus, running candump can1 to grab the data).  It failed within
>> minutes.  I'll add the code back in to disable tracing when the IRQ
>> gets disabled.
>
> Does the patch make any difference at all?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
