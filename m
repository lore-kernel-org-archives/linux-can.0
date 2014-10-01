From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Wed, 01 Oct 2014 11:19:54 +0200
Message-ID: <5856354.jaFqUxgnZF@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <4712537.n1vM034J9B@ws-stein> <20141001110741.0e8e5ffb@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46305 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbaJAJTJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 05:19:09 -0400
In-Reply-To: <20141001110741.0e8e5ffb@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

Hello David,

On Wednesday 01 October 2014 11:07:41, David Jander wrote:
> On Wed, 01 Oct 2014 10:29:41 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > On Wednesday 01 October 2014 09:15:46, Marc Kleine-Budde wrote:
> > > On 10/01/2014 09:11 AM, Alexander Stein wrote:
> > > > BTW: You posted a patch for at91_can in June (Din't get opportunity
> > > > to try it yet), where you use a kfifo to accomplish the same, why not
> > > > here?
> > > 
> > > The cyclic buffer approach is okay, from my point of view.
> > 
> > I'M just wondering why 2 different approaches have been chosen.
> 
> Good question.... I did the at91_can modification a long time ago, and the
> initial approach was more or less guided by the current architecture of the
> at91_can driver. I also probably got better ideas when doing something very
> similar for the second time (flexcan).
> Also, I can imagine that there are more CAN drivers that have similar
> problems, and maybe we should think about a solution in the SocketCAN
> framework itself instead.

Sounds reasonable too. If someone ever wants to support flexcan on coldfire (m68k) there is only a single message box (+ a shift register), there you will need this feature for sure :)
But I'm still curious which approach is better: Implement an own cyclic buffer or use kfifo (which might be a cyclic buffer itself, dunno)?

> Talking about at91_can... I have posted that patch twice already and had
> no reaction so far. Unfortunately now I don't have the hardware anymore, so I
> doubt I can pick this up again, let alone re-write that patch, unless someone
> is willing to help with testing...

It is on my TODO, but did not get chance to test it yet. There is the statement that a proprietary driver here is better that it doesn't drop any frames under heavy load while socketcan one does. So it might actually improve the situation.

Best regards,
Alexander

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

