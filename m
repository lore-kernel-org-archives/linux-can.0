From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Wed, 30 Nov 2016 15:22:45 +0100
Message-ID: <9395350.5JPxc1DQSq@ws-stein>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39142 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755449AbcK3OWt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Nov 2016 09:22:49 -0500
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On Monday 04 July 2016 20:32:05, Marc Kleine-Budde wrote:
> Hello,
> 
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

What is the status of this patchset?

Best regards,
Alexander

