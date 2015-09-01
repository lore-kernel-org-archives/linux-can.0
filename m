From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 00/12] RFC: cleanup flexcan driver, introduce and make use of IRQ offloading
Date: Tue,  1 Sep 2015 11:29:03 +0200
Message-ID: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl

Hello,

this series picks up David Jander's idea to introduce a simple IRQ offloading
mechanism. The idea is to offer a mechanism for  hardware FIFO (or single RX
buffer) based CAN cores to read the CAN frames in the interrupt handler but
defer sending into normal NAPI context.

This series first cleans up the flexcan driver, then adds the generic IRQ
offloading code and finally switches the flexcan driver to use it.

Testing and feedback welcome.

regards,
Marc

