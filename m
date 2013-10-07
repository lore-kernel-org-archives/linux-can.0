From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/7] can: berr_limit support
Date: Mon,  7 Oct 2013 16:40:33 +0200
Message-ID: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33006 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab3JGOkp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:45 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello,

this series does first some cleanups in can/dev.c, the implementation of three
functions is sorted by IFLA_CAN_*, that we can see at the first look, that all
needed IFLA_CAN_* are handled and that new code can be added at the end. 

Then the bus error limiting (short: berr_limit) infrastructure + netlink
configuration interface is added. Last patch is an example implementation on
the flexcan hardware.

The CAN bus, like the old 10BASE2 Ethernet, needs bus termination. An open CAN
bus doesn't work and will produce lots of CAN bus errors.

If the user wants to detect an open CAN bus, the CAN bus error interrupts have
to be enabled. This is represented by the control mode
CAN_CTRLMODE_BERR_REPORTING.

On an unterminated CAN bus at 500 kbit/s, this can lead to more then 8000
interrupts/s on some SoCs with integrated CAN cores. These interrupts and the
associated processing in software lead to a significant load and may reader the
system unresponsive and even unusable at CAN bus speeds of 1000 kbit/s.

This patch adds the infrastructure to limit these interrupts. The driver has to
implement the do_berr_restart() callback, which re-enables the bus error
interrupts. The idea is to delay the re-enabling of the interrupts after they
have been served. The delay is configured by berr_limit_delay. A value of 0
means interrupts are restarted immediately, any other other value will start a
timer and call do_berr_restart() when the timer fires.

regards,
Marc

