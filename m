From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 00/12] can: don't touch skb after netif_receive_skb()/netif_rx()
Date: Sun, 12 Jul 2015 21:54:01 +0200
Message-ID: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbGLTyQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jul 2015 15:54:16 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=hardanger.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1ZELSR-0006ka-I2
	for linux-can@vger.kernel.org; Sun, 12 Jul 2015 19:54:31 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This series fixes the usage of the skb after netif_receive_skb()/netif_rx().
I'll send a pull reqeust to David in a few days.

Marc

