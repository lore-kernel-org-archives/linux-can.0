From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: CAN question: how to trace frame errors?
Date: Sat, 13 Jun 2015 22:28:28 +0200
Message-ID: <CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
	<557AA7BE.6040004@pengutronix.de>
	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
	<557AD18D.8010807@optusnet.com.au>
	<CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
	<557C4C83.3020501@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33806 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbFMU23 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 13 Jun 2015 16:28:29 -0400
Received: by wibut5 with SMTP id ut5so43581646wib.1
        for <linux-can@vger.kernel.org>; Sat, 13 Jun 2015 13:28:28 -0700 (PDT)
In-Reply-To: <557C4C83.3020501@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org

> and while the CPU supports different interrupt priorities, the 3.4 TZIC code
> simply doesn't provide the functions to change it.

I don't know the i.MX5x and it's TZIC, only the i.MX6 ... and only a
bit. But I think there it's not a limitation in the silicon, but in
the software (Linux in our case, e.g. drivers/irqchips/gic*). The
i.MX6 uses the GIC (described in the ARM MPCORE reference manual). And
there it says:

------------------------
The interrupt distributor centralizes all interrupt sources before
dispatching them to each individual Cortex-A9 processor. The Interrupt
Distributor arbitrates in the following priority order:
1. Highest priority interrupts. These have the lowest value in the
Interrupt Priority Register (ICDIPTR)
2. For interrupts with the same priority value, the Interrupt
Distributor arbitrates on the interrupt ID number. It dispatches the
smaller ID number first
3. For aliased SGI with the same priority value and the same ID
number, the Interrupt Distributor arbitrates on the source CPU number.
It dispatches the smaller CPU number first.
------------------------

This register ICDIPTR is called GIC_DIST_PRI in Linux and they all get
set to a fixed value. So it's the IRQ number that set's the IRQ
priority in current Linux.


And btw, thanks for your patch. I'll probably rewrite it to use kfifo,
which is a ringbuffer already contained in Linux (see
include/linux/kfifo.h), I think that will increase it's chance of
inclusion.
