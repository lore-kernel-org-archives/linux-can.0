From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make use of IRQ offloading
Date: Thu, 10 Dec 2015 13:33:46 +0100
Message-ID: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47984 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbbLJMdp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:33:45 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, bhupesh.sharma@freescale.com

Hello,

this series picks up David Jander's idea to introduce a simple IRQ offloading
mechanism. The idea is to offer a mechanism for  hardware FIFO (or single RX
buffer) based CAN cores to read the CAN frames in the interrupt handler but
defer sending into normal NAPI context.

This series first cleans up the flexcan driver, then adds the generic IRQ
offloading code and finally switches the flexcan driver to use it.

Testing and feedback welcome.

Known issues:
- on mx6 the flexcan IP core receives CAN frames in wrong order.
  "SR# 1-4074792564 : CAN Ordering Issues"

Proposed solution:
- Add support for timestamps to rx-fifo

regards,
Marc

