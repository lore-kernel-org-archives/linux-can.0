From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Mon,  9 May 2016 12:52:24 +0200
Message-ID: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40632 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbcEIKwm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:52:42 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=hardanger.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1azino-0004UX-MO
	for linux-can@vger.kernel.org; Mon, 09 May 2016 12:52:40 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

this patch add support for a software bases rx-fifo implementation (patches
1+2). The remaining patches modify the flexcan driver to make use of it. imx6
and vf610 SoCs can make use of the 64 mailbox software FIFO, while older SoCs
still use flexcan's 6 mailbox deep hardware FIFO.

Testing on any flexcan core is highly appreciated.

regards,
Marc

