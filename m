From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Tue, 04 Oct 2016 13:57:33 +0200
Message-ID: <12311540.OPjVtcIYq6@ws-stein>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52844 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753942AbcJDL5l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Oct 2016 07:57:41 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, david@protonic.nl, Martin =?ISO-8859-1?Q?D=E4umler?= <martin.daeumler@systec-electronic.com>, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

Hi,

On Monday 04 July 2016 20:32:05, Marc Kleine-Budde wrote:
> this patch takes up the idea to read the CAN frames in IRQ context and send
> them later in NAPI. The first two patches add each an offloading scheme.
> 
> The first one is for hardware FIFO based cores, like the flexcan in FIFO
> mode. The second one requires mailboxes with timestamps. The mailboxes are
> read and sorted by timestamp in IRQ context, sending is done later in NAPI
> aswell.
> 
> The remaining patches modify the flexcan driver to make use of it. imx6 and
> vf610 SoCs can make use of the 64 mailbox software FIFO, while older SoCs
> still use flexcan's 6 mailbox deep hardware FIFO.
> 
> Testing on any flexcan core is highly appreciated.

We did some tests on our custom i.MX35 based board. This means we are stuck at the 6 mailbox deep hardware FIFO.
This is how our test works:
* Send 2 * 250000 CAN frames to the i.MX board, in 2 * 250 burst sizes at 1MBit/s
* Running iperf in parallel

Originally we used 3.10.95-rt102 (RT enabled) and lost CAN frames. The CAN-IRQ-Thread has been prioritized to SCHED_FIFO 91.
Then we updated to 4.6.7-rt13. Without those patches in either case, RT enabled or not, the hardware FIFO still overran.
When this patchset is applied the non-RT configuration successfully received all CAN frames without any drop. Unfortunately when RT is enabled there are still hardware overruns. A first try on the newly released 4.6.7-rt14 improved the situation, there are less overruns, but they still exist.

In summary the non-RT case seems fine now, but I wonder what causes the delays on RT to the CAN-IRQ-Thread which seem to be about 500us (bus time of 6 4Byte CAN frames).

Best regards,
Alexander

