From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Tue,  1 Sep 2015 12:31:54 +0200
Message-ID: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56620 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbbIAKcK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 06:32:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl

Hello,

this series adds a software FIFO implementation and switches the flecan and
at91 driver to it. It's intended for CAN cores with a higher number of
mailboxes. The RX-FIFO is basically working, but on flexcan the WARN() in
can_rx_fifo_irq_offload() triggers. I'm currently debugging this issue.

This series depends on the earlier posted series "cleanup flexcan driver,
introduce and make use of IRQ offloading".

The git branch is available on:
    https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?h=flexcan-next

    git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git flexcan-next

Testing and feedback welcome, too.

regards,
Marc

