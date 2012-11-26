From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: PATCH 0/5] can: remove obsolete variable open_time
Date: Mon, 26 Nov 2012 15:24:42 +0100
Message-ID: <1353939887-19552-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56475 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab2KZOYt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 09:24:49 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=hardanger.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1Tczc8-0004dP-Gk
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 15:24:48 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

this series of patches removes the variable open_time from several drivers.

regards, Marc
