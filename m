From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 1/5] can: sja1000_platform
Date: Fri,  5 Oct 2012 16:39:02 +0200
Message-ID: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38394 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2JEOjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:17 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com

Hello,

this series ports the device tree bindings from the existing
sja1000_of_platform driver to the sja1000_platform driver. It has been compile
time tested only. I've written the patches to get rid of the
sja1000_of_platform once this in the kernel.

Please test, especially on sparc, powerpc and arm.

You can find this series in the sj1000 branch of the linux-can-next repo on
gitorious[1].

regards, Marc

[1] https://gitorious.org/linux-can/linux-can-next

