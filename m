From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 1 Oct 2014 11:34:32 +0200
Message-ID: <20141001113432.18ec8bed@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<4712537.n1vM034J9B@ws-stein>
	<20141001110741.0e8e5ffb@archvile>
	<5856354.jaFqUxgnZF@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10828 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaJAJe3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 05:34:29 -0400
In-Reply-To: <5856354.jaFqUxgnZF@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


Dear Alexander,

On Wed, 01 Oct 2014 11:19:54 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> Hello David,
> 
> On Wednesday 01 October 2014 11:07:41, David Jander wrote:
> > On Wed, 01 Oct 2014 10:29:41 +0200
> > Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> > 
> > > On Wednesday 01 October 2014 09:15:46, Marc Kleine-Budde wrote:
> > > > On 10/01/2014 09:11 AM, Alexander Stein wrote:
> > > > > BTW: You posted a patch for at91_can in June (Din't get opportunity
> > > > > to try it yet), where you use a kfifo to accomplish the same, why not
> > > > > here?
> > > > 
> > > > The cyclic buffer approach is okay, from my point of view.
> > > 
> > > I'M just wondering why 2 different approaches have been chosen.
> > 
> > Good question.... I did the at91_can modification a long time ago, and the
> > initial approach was more or less guided by the current architecture of the
> > at91_can driver. I also probably got better ideas when doing something very
> > similar for the second time (flexcan).
> > Also, I can imagine that there are more CAN drivers that have similar
> > problems, and maybe we should think about a solution in the SocketCAN
> > framework itself instead.
> 
> Sounds reasonable too. If someone ever wants to support flexcan on coldfire
> (m68k) there is only a single message box (+ a shift register), there you
> will need this feature for sure :) But I'm still curious which approach is
> better: Implement an own cyclic buffer or use kfifo (which might be a cyclic
> buffer itself, dunno)?

I guess the cyclic-buffer with power-of-2 size might be more efficient...
also I think the kfifo uses a spin-lock, which is not always necessary if you
are careful with the cyclic-buffer.

> > Talking about at91_can... I have posted that patch twice already and had
> > no reaction so far. Unfortunately now I don't have the hardware anymore,
> > so I doubt I can pick this up again, let alone re-write that patch, unless
> > someone is willing to help with testing...
> 
> It is on my TODO, but did not get chance to test it yet. There is the
> statement that a proprietary driver here is better that it doesn't drop any
> frames under heavy load while socketcan one does. So it might actually
> improve the situation.

I think so.
I just wrote that patch in a two-day marathon to help a desperate customer
with a platform that is not even ours (hence I don't have the hardware
anymore). I also heard that story about the closed-source alternative and
thought it was unconceivable to have someone say that SocketCAN is in any way
inferior to a commercial product! That thought alone made me finish the patch
in two days and send it out to linux-can.... cooling down came when no one
reacted to it :-)

Back to topic: Can one of the maintainers (Wolfgang, Marc) give an opinion on
how to best solve the following two issues:

1.- Using MB area instead of FIFO for flexcan breaks RTR reception on older
SoC's. My proposal is to modify my approach as to have two different IRQ
handling paths: One that off-loads the RX-FIFO into the cyclic-buffer for
older chips and one that uses the whole MB area and off-loads it into the same
cyclic buffer for i.MX6, Vybrid and newer chips.

2.- Since the problem addressed by my patch to at91_can is very similar, what
about solving these problems in the SocketCAN framework (if that is possible)?

Best regards,

-- 
David Jander
Protonic Holland.
