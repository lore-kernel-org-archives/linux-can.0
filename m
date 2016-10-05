From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Wed, 05 Oct 2016 14:37:20 +0200
Message-ID: <1506116.7yduGgf9eG@ws-stein>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de> <12311540.OPjVtcIYq6@ws-stein> <20161004143315.23423e56@erd980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59780 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752328AbcJEMhy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2016 08:37:54 -0400
In-Reply-To: <20161004143315.23423e56@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Martin =?ISO-8859-1?Q?D=E4umler?= <martin.daeumler@systec-electronic.com>, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

Hi David,

On Tuesday 04 October 2016 14:33:15, David Jander wrote:
> > In summary the non-RT case seems fine now, but I wonder what causes the
> > delays on RT to the CAN-IRQ-Thread which seem to be about 500us (bus time
> > of 6 4Byte CAN frames).
> 
> Thanks for testing!
> Well, in -RT I guess anything with a higher priority than the CAN-IRQ can
> cause a delay... but since going from -rt13 to -rt14 improved the situation,
> this sounds like bugs in the -rt code. Are you running any code in
> SCHED_FIFO that you don't run in the non-RT case?

AFAIK no userspace process is put into SCHED_FIFO and only the priority of 
CAN-IRQ-Thread is increased to 91. Userspace runs with unchanged priority. So 
yes I guess there is still problem in -rt code.

> It's nevertheless very nice to see that for non-RT, you got from losing
> messages to not losing any message with this patchset, even on a lowly
> i.MX35 at 1Mbit/s! This proves that the patchset is certainly worth it.

I would expect the same from running with RT enabled, especially as the CAN-
IRQ-Thread has SCHED_FIFO wuth priority 91. There shouldn't be much code which 
can delay that thread.

Best regards,
Alexander

