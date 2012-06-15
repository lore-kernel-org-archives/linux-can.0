From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can: 2012-06-15
Date: Fri, 15 Jun 2012 12:20:43 +0200
Message-ID: <1339755644-6686-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46317 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab2FOKUy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 Jun 2012 06:20:54 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org

Hello David,

here is a patch intended for v3.5, targeting net/master.

Dan Carpenter found a precedence error in c_can_chip_config() function
in the c_can driver, preventing that listen only + loop back mode can be
activated.

regards,
Marc

