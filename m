From: David Jander <david@protonic.nl>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of
 RX overruns
Date: Fri, 3 Oct 2014 11:01:41 +0200
Message-ID: <20141003110141.0ba3c33d@archvile>
References: <1403775686-19352-1-git-send-email-david@protonic.nl>
	<1547907.ZK2VXCpURP@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17974 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaJCJBg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Oct 2014 05:01:36 -0400
In-Reply-To: <1547907.ZK2VXCpURP@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>


Dear Alexander,

On Thu, 02 Oct 2014 14:41:25 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> finally I got the chance to test your patch. I originally expected to test
> it on a AT91SAM9263, but I did it now on a AT91SAM9X35. The tests were done
> on a v3.17-rc7 kernel + a DT patch. If I only run my CAN burst test without
> any other load on the ARM everything works fine, on the unpatched kernel,
> with your patch and also with rx-fifo branch of
> https://gitorious.org/linux-can/linux-can-next. When running an iperf
> (client on PC) in parallel, the situation is as follows: unpatched kernel:
> driver hangs after ~15s. No messages are received again while the kernel is
> still running. your patch: 37346 of 500000 msg lost rx-fifo: 36806 of 500000
> msg lost

Thanks a lot for taking the time to look at this.
I just looked at the rx-fifo patch, but I still don't understand how it is
supposed to improve the situation of this driver.... beats me.
Nevertheless you just proved that it is at least as good as my patch.
AFAIK, there is nothing that should work as well as off-loading the CAN
controller in the IRQ handler by a far margin. But the rx-fifo patch does not
do that, so it is hard for me to believe it is really that good.
Could you repeat your test at a lower bitrate? The only thing I can think of
is that 37000 out of 500000 messages the latency has spiked on your system,
but that spike should be a lot more contained with my patch than with rx-fifo,
so if I'm right, then lowering the bitrate we might see a situation in which
rx-fifo still loses a message here and there, while my patch doesn't.
Other than that, I am tempted to think my patch is simply broken.

Or, maybe Marc can explain what he did... because I don't really get it :-(

> The CAN burst test:
> This is done by 2 external embedded boards starting to sent CAN frames once
> they receive a start CAN frame from the ARM board. Each one sents frames at
> 1MBit/s including their own individual CAN ID with 4 data bytes containing a
> counter. Every 200ms each device starts sending a burst of 250 frames. Using
> two devices ensures that there is no space bewteen messages. They are sent
> as fast as possible. All received frames are evaluated on ARM for message
> losts and reorderings.
> 
> I can't say which implementation is actually better, read as how much is
> improved. But as the driver doesn't lockup at least one of those should be
> added. A problem on AT91SAM9X5 for the performance is it only has 8
> mailboxes, compared to 16 on 9263.

Yes, it seems Atmel is going the other way around compared to Freescale, they
are making newer implementations actually more crippled than older ones :-(

Best regards,

-- 
David Jander
Protonic Holland.
