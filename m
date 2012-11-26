From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/5] prepare for release + add more clocks to can-calc-bit-timing
Date: Mon, 26 Nov 2012 21:44:44 +0100
Message-ID: <1353962689-18669-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57740 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab2KZUov (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:44:51 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=hardanger.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1Td5Xu-00046K-FD
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 21:44:50 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

this patch series prepares configure.ac for a release (adjusting bug report
address  + enabling silent rules in autoools). Then some more refclocks for
flexcan and mscan are added and support for ti_hecc to can-calc-bit-timing.

regards,
Marc
