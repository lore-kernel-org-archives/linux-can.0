From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 12:05:45 +0200
Message-ID: <CAOpc7mEASyHXnCWGCAgTcagb_CdgT3ksrtv-cmWpiVLL2E336A@mail.gmail.com>
References: <559D35CA.2050402@uweschneider.de>
	<559E25FD.6030904@optusnet.com.au>
	<559E437E.308@uweschneider.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33004 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbbGIKFr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 06:05:47 -0400
Received: by wiwl6 with SMTP id l6so13731905wiw.0
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2015 03:05:46 -0700 (PDT)
In-Reply-To: <559E437E.308@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

2015-07-09 11:48 GMT+02:00 Torsten Lang <torsten.lang@uweschneider.de>:

> From what I found during my search in the net the interrupt handling
> implementation in Linux for the Freescale range of SoCs seems to
> suck because it does not configure any interrupt priorization and
> the interrupt handler "prefers" to handle interrupts just by the bit
> order in the interrupt controller could lead to very high latencies
> in case of FlexCAN interrupts.

The thing about the prioritization is true .. but it's not the reason.
Because even when you give the IRQs for the FlexCAN the highest
priority (I have a patch for this), then this will only trigger if two
interrupts arrive at the same time. This is almost never.

The main reason is that on ARM, IRQs are not preemptible. When an ISR
is running, no other ISR (higher priority or not) can interrupt the
first one. On the other side, this pretty much guarantees that the
stack won't overflow :-)

I wonder how SJA CAN drivers do it, their RxFIFO equivalent is much smaller.


PS: Patch for IRQ prioritization in the GIC:
https://drive.google.com/file/d/0B-OEhM3f0eCtZjhueTdKdXYzMjg/view?usp=sharing
 Deliberately no Signed-off-there, because a) it doesn't help and b)
it still contains debug output :-)
