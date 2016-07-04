From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 00/12] can: rx-offload: add implmentation and switch flexcan driver to use it
Date: Mon,  4 Jul 2016 20:32:05 +0200
Message-ID: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57695 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553AbcGDScW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:32:22 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl

Hello,

this patch takes up the idea to read the CAN frames in IRQ context and send
them later in NAPI. The first two patches add each an offloading scheme.

The first one is for hardware FIFO based cores, like the flexcan in FIFO mode.
The second one requires mailboxes with timestamps. The mailboxes are read and
sorted by timestamp in IRQ context, sending is done later in NAPI aswell.

The remaining patches modify the flexcan driver to make use of it. imx6 and
vf610 SoCs can make use of the 64 mailbox software FIFO, while older SoCs still
use flexcan's 6 mailbox deep hardware FIFO.

Testing on any flexcan core is highly appreciated.

regards,
Marc

