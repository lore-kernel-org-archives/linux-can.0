From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: CAN question: how to trace frame errors?
Date: Thu, 25 Jun 2015 18:37:26 +1000
Message-ID: <558BBDC6.90107@optusnet.com.au>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>	<557AA7BE.6040004@pengutronix.de>	<CAOpc7mH-xD+eesJNjhpFwUSeMwGCdsRK8Q9AZSjmE2uw=cBgsw@mail.gmail.com>	<557AD18D.8010807@optusnet.com.au>	<CAOpc7mG5nD1daKSkGdqoR84=W_A11s+oQfzc_i4pUsHoVd42Tw@mail.gmail.com>	<557C4C83.3020501@optusnet.com.au>	<CAOpc7mHYiX3SAJSEHM32PA1gRFA+BQ0DxCC3U6Aux15Swy06sQ@mail.gmail.com>	<557CEA2E.5060904@optusnet.com.au>	<CAOpc7mGxpjUoV1iMcU0CAfaPYf0z-9ZjHgenH+ocSdBykfnutA@mail.gmail.com>	<55880A8A.7010903@pengutronix.de> <CAOpc7mHta0KMM-psYtXD-1OrBXpQwo39KSkPL7nf2Bcgp6V5+Q@mail.gmail.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:35860 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751207AbbFYIha (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Jun 2015 04:37:30 -0400
In-Reply-To: <CAOpc7mHta0KMM-psYtXD-1OrBXpQwo39KSkPL7nf2Bcgp6V5+Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 25/06/15 00:29, Holger Schurig wrote:
> Okay, I'm now switched to Linux to 4.0.6, applied CONFIG_PREEMPT_RT
> 4.0.5-rt4 on top of it and enabled PREEMPT_RT_FULL. I had to disable
> CPU_FREQ, otherwise I had weird errors (despite using the performance
> governor). The system booted, but systemd said that a call to loadkeys
> failed. I got the idea to remove CPU_FREQ from the Xinomai project :-)

Huge amount of work to make it less stable.

I would strongly suggest you put some more time on on FTRACE.

Linux really isn't meant to be locking interrupts out for that long. It isn't 
meant to be locking NAPI out for that long either.

There's a broken or at least severely inconsiderate driver or something 
locking out interrupts for a very long time. It would be very well worth 
finding this, and not just for the sake of CAN. It should be affecting other 
things too.

The trick is enabling the right tracer. Or just enable more of them than you 
have already. Then getting the trigger right (CAN saying it has overflowed).

Tom

