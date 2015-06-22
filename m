From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: CAN question: how to trace frame errors?
Date: Mon, 22 Jun 2015 14:17:04 +0200
Message-ID: <CAOpc7mGxpjUoV1iMcU0CAfaPYf0z-9ZjHgenH+ocSdBykfnutA@mail.gmail.com>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
	<557AA7BE.6040004@pengutronix.de>
	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>
	<557AD18D.8010807@optusnet.com.au>
	<CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>
	<557C4C83.3020501@optusnet.com.au>
	<CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>
	<557CEA2E.5060904@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36046 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbFVMRG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2015 08:17:06 -0400
Received: by wguu7 with SMTP id u7so67620090wgu.3
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2015 05:17:04 -0700 (PDT)
In-Reply-To: <557CEA2E.5060904@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org

Just a little feedback. Tom sent me his flexcan-ringbuffer patch. I
modified this patch to use not a self-written ringbuffer, but kfifo.
If someone wants it, I can post that here. However, this only helped a
little bit. I had less frame loss, but not zero frame loss for 80% CAN
bus utilization. For example, when I updated my image (on eMMC, via
i.MX6 SDHCI) over ethernet (i.MX6 FEC), I still had frame losses. I
even modified the GIC to give the IRQs 182/183 more priority, but
because an IRQ doesn't preempt another IRQ this wasn't even noticable.

Then I tried 3.18-rt10 (CONFIG_PREEMPT_RT). That completely removed
the CAN frame losses.

Success?

Not at all. A Linux with CONFIG_PREMEMPT_RT is basically another Linux
that behaves a bit like Linux, but really isn't. And it's a lot more
unstable. I had problems with eth0 (FEC), e.g. it didn't survive a
flood ping. One time logging in at the text console hanged. And after
an rsync update of the image the ext4 filesystem was corrupt. So my
CONFIG_PREEMPT_RT attempt just showed that really the latency is the
killer, due to the very small RxFIFO with only 6 places.

I tried to find out with FTRACE to see who creates the most latency,
but results where incongruent. I now forgot the name of the function,
but it showed to me that some sleep mode function was creating the
most latency. Changing things like NOHZ to 1000 Hz polling didn't help
either.
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
