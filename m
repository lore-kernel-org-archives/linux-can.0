From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: CAN question: how to trace frame errors?
Date: Wed, 24 Jun 2015 16:29:12 +0200
Message-ID: <CAOpc7mHta0KMM-psYtXD-1OrBXpQwo39KSkPL7nf2Bcgp6V5+Q@mail.gmail.com>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
	<557AA7BE.6040004@pengutronix.de>
	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
	<557AD18D.8010807@optusnet.com.au>
	<CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
	<557C4C83.3020501@optusnet.com.au>
	<CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
	<557CEA2E.5060904@optusnet.com.au>
	<CAOpc7mGxpjUoV1iMcU0CAfaPYf0z-9ZjHgenH+ocSdBykfnutA@mail.gmail.com>
	<55880A8A.7010903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37913 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbFXO3O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Jun 2015 10:29:14 -0400
Received: by wibdq8 with SMTP id dq8so48471610wib.1
        for <linux-can@vger.kernel.org>; Wed, 24 Jun 2015 07:29:12 -0700 (PDT)
In-Reply-To: <55880A8A.7010903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

Okay, I'm now switched to Linux to 4.0.6, applied CONFIG_PREEMPT_RT
4.0.5-rt4 on top of it and enabled PREEMPT_RT_FULL. I had to disable
CPU_FREQ, otherwise I had weird errors (despite using the performance
governor). The system booted, but systemd said that a call to loadkeys
failed. I got the idea to remove CPU_FREQ from the Xinomai project :-)

Unfortuantely, removing CPU_FREQ also took IMX_THERMAL with it. So I
can't see the die temperature anymore in /sys/.

This time the system seems to behave more stable. I had however once a
hard lock when I started X11. Keyboard didn't work anymore, mouse
neither. Unfortunately I had not redirected output to the serial port.
And it only happened once so far. Still not convincing.

With that, I still had CAN frame losses until I applied the
flexcan-kfifo patch that I posted. I think that with a pristine
flexcan.c, the the latency [IRQ, flexcan_irq(), flexcan_poll()] is
still to long.



I'm not really fond of adding a 771 kB long patch (CONFIG_PREEMPT_RT)
to my system that worked stable since at least half a year. So I
pondered about using the FIQ. There's no other driver using a FIQ on
my system (e.g. I don't use sound/soc/imx-fiq-pcm.c for sound over
SSI). I think writing a ringbuffer in ARM assembly is doable. The FIQ
ISR would then read the FlexCAN registers and write them into the
ringbuffer. And in case of data in the RxFIFO, it would empty it and
write it to the ringbuffer as well. Emptying this ringbuffer could
then again happen in flexcan_poll(). One building block that I'm still
missing for this would be how the FIQ-ISR could signal from
FIQ-context back to the normal Linux context that there is now data in
the ringbuffer.

This sound like lots of hoops, but such a change would make FlexCAN be
able to receive CAN packets even with 100% busload and very small
package sizes. And I wouldn't have to deal with the complexity of the
realtime kernel. They are frankly over my head ...
