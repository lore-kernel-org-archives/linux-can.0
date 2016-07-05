From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based irq offloading
Date: Tue, 05 Jul 2016 07:46:12 +0200
Message-ID: <3035212.Yo4Bos9bxC@ws-stein>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de> <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39370 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751004AbcGEFqT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 01:46:19 -0400
In-Reply-To: <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, david@protonic.nl

On Monday 04 July 2016 20:32:07, Marc Kleine-Budde wrote:
> Some CAN controllers don't implement a FIFO in hardware, but fill their
> mailboxes in a particular order (from lowest to highest or highest to
> lowest). This makes problems to read the frames in the correct order from
> the hardware, as new frames might be filled into just read (low) mailboxes.
> This gets worse, when following new frames are received into not read
> (higher) mailboxes.
> 
> On the bright side some these CAN controllers put a timestamp on each
> received CAN frame. This patch adds support to offload CAN frames in
> interrupt context, order them by timestamp and then transmitted in a NAPI
> context.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

How is this supposed to work with CAN controllers without tmestamps, e.g. 
CCAN/DCAN? Do you need to set the timestamp manually using ktime_get() or 
similar when reading each mailbox? IMHO especially those controllers are prone 
to ordering issues under heavy load as the hardware doesn't ensure ordering by 
itself and there is no hardware based timestamp.

Best regards,
Alexander

