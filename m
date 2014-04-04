From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 00/10] can: c_can: Another pile of fixes and improvements
Date: Fri, 04 Apr 2014 15:24:22 -0000
Message-ID: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41511 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbaDDPYL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:11 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

This series is on top of linux-can-fixes-for-3.15-20140401.

It contains a bunch of fixes for fatal wreckage and a few improvements
including a new version of the interrupt reduction patch. The observed
stall is gone now.

One fix is for a pattern copied all over drivers/net/can/

        netif_receive_skb(skb);
        stats->rx_packets++;
        stats->rx_bytes += frame->can_dlc;

After handing off the skb to the network stack, we cannot access it
anymore as netif_receive_skb() might free it. I have no time to fix
that all up now, but it's trivial enough to do.

Thanks,

	tglx

