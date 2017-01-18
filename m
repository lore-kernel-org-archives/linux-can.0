From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 00/16] can: rx-offload and flexcan
Date: Wed, 18 Jan 2017 15:52:11 +0100
Message-ID: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46069 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753183AbdARPES (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:18 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com

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

changes since v2:
- rx-offload: get rid of pre and post read handler in the NAPI poll loop, that
  were reviously used for CAN error frames and state change handling.
- rx-offload: add can_rx_offload_irq_queue_err_skb() that can be used from IRQ
  to queue error frames
- flexcan: move the CAN error frames and state change handling directly into
  the driver's IRQ routine


