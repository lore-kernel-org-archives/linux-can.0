From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: c_can: improve error checking
Date: Tue, 18 Mar 2014 19:23:59 +0100
Message-ID: <1395167041-6618-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39992 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818AbaCRSYH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Mar 2014 14:24:07 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: tglx@linutronix.de, b.spranger@linutronix.de, kernel@pengutronix.de

Hello Thomas,

as mentioned in the other mail, a patch that adds return value checking to all
users of c_can_set_bittiming(). Another patch adds the missing
netif_napi_del(). Feel free to include the patches in your series or use the
testing-c_can branch [1] as your git base.

regards,
Marc

[1] git://gitorious.org/linux-can/linux-can-next.git testing-c_can

