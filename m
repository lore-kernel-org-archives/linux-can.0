From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 1 Oct 2014 11:07:41 +0200
Message-ID: <20141001110741.0e8e5ffb@archvile>
References: <1411995175-13540-1-git-send-email-david@protonic.nl>
	<1952804.jDdF5Ah5L9@ws-stein>
	<542BAA22.7010508@pengutronix.de>
	<4712537.n1vM034J9B@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10737 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaJAJHh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 05:07:37 -0400
In-Reply-To: <4712537.n1vM034J9B@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wed, 01 Oct 2014 10:29:41 +0200
Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> On Wednesday 01 October 2014 09:15:46, Marc Kleine-Budde wrote:
> > On 10/01/2014 09:11 AM, Alexander Stein wrote:
> > > BTW: You posted a patch for at91_can in June (Din't get opportunity
> > > to try it yet), where you use a kfifo to accomplish the same, why not
> > > here?
> > 
> > The cyclic buffer approach is okay, from my point of view.
> 
> I'M just wondering why 2 different approaches have been chosen.

Good question.... I did the at91_can modification a long time ago, and the
initial approach was more or less guided by the current architecture of the
at91_can driver. I also probably got better ideas when doing something very
similar for the second time (flexcan).
Also, I can imagine that there are more CAN drivers that have similar
problems, and maybe we should think about a solution in the SocketCAN
framework itself instead.

Talking about at91_can... I have posted that patch twice already and had
no reaction so far. Unfortunately now I don't have the hardware anymore, so I
doubt I can pick this up again, let alone re-write that patch, unless someone
is willing to help with testing...

Best regards,

-- 
David Jander
Protonic Holland.
