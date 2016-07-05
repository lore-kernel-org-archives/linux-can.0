From: David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp
 based irq offloading
Date: Tue, 5 Jul 2016 08:31:09 +0200
Message-ID: <20160705083109.1c8d44a8@erd980>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
	<1467657137-18891-3-git-send-email-mkl@pengutronix.de>
	<3035212.Yo4Bos9bxC@ws-stein>
	<9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:10594 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcGEGyP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 02:54:15 -0400
In-Reply-To: <9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

On Tue, 5 Jul 2016 08:19:31 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 07/05/2016 07:46 AM, Alexander Stein wrote:
> > On Monday 04 July 2016 20:32:07, Marc Kleine-Budde wrote:  
> >> Some CAN controllers don't implement a FIFO in hardware, but fill their
> >> mailboxes in a particular order (from lowest to highest or highest to
> >> lowest). This makes problems to read the frames in the correct order from
> >> the hardware, as new frames might be filled into just read (low) mailboxes.
> >> This gets worse, when following new frames are received into not read
> >> (higher) mailboxes.
> >>
> >> On the bright side some these CAN controllers put a timestamp on each
> >> received CAN frame. This patch adds support to offload CAN frames in
> >> interrupt context, order them by timestamp and then transmitted in a NAPI
> >> context.
> >>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>  
> > 
> > How is this supposed to work with CAN controllers without tmestamps, e.g. 
> > CCAN/DCAN? Do you need to set the timestamp manually using ktime_get() or 
> > similar when reading each mailbox? IMHO especially those controllers are prone 
> > to ordering issues under heavy load as the hardware doesn't ensure ordering by 
> > itself and there is no hardware based timestamp.  
> 
> The algorithm added in this patch only supports controllers that add
> timestamps to the mailbox on reception in hardware (like flexcan, at91
> and hecc). However the other algorithm we implemented didn't make use of
> timestamps and targeted controllers that fill mailboxes in a particular
> order. It can be ported to the current framework and the c_can/d_can
> driver to it.

I originally wrote order-based FIFO simulation for the flexcan, that didn't
use the timestamps. It turned out that flexcan has some hardware issues that
prevented this implementation from working reliably on the flexcan controller.
In fact, the whole ordered reception mechanism is useless on flexcan without
timestamps.
Marc: did you throw away the original implementation for good, or are you
planning to add it again, in order to use it for CCAN/DCAN and similar
controllers?

Best regards,

-- 
David Jander
Protonic Holland.
