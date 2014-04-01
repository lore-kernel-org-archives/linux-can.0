From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 0/4] can: mcp251x: various improvements
Date: Tue,  1 Apr 2014 23:02:15 +0200
Message-ID: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55433 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaDAVCV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:02:21 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=hardanger.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1WV5p7-0005iX-1e
	for linux-can@vger.kernel.org; Tue, 01 Apr 2014 23:02:21 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I've picked up Alexander Shiyan's work.

Changes since v1:
- 1/4: mcp251x_can_probe(): do cleanup in case of spi_setup() fails
- 2/4: mcp251x_hw_reset(): convert ternary-? to if (err) return
- 3/4: mcp251x_hw_probe(): convert ternary-? to if (err) return


