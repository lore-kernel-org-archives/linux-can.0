From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/2] can: flexcan: proposed fixes for v3.12
Date: Fri,  4 Oct 2013 12:48:51 +0200
Message-ID: <1380883733-11995-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59311 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab3JDKs7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2013 06:48:59 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

Hello,

while hacking on a new feature on the flexcan driver I found two problems:

In my last patch on the flexcan dirver I removed the loop from
flexcan_chip_start(), this causes pending TX messages not beeing aborted on
device resart. Lothar, can you please test this patch on mx6.

The second patch fixes the problem, that a DT probed mx28 flexcan core is
detected as p1010. This activaes a workaround in the driver which is not
needed, the bus error interrupt is always active.

Please test, both patches apply to current net/master, latest v3.12-rcX should
work, too.

regards,
Marc

