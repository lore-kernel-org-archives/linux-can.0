From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8 0/8] can: c_can: Use syscon regmap for TI specific RAMINIT register
Date: Fri, 14 Nov 2014 19:09:43 +0100
Message-ID: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51575 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161175AbaKNSJz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Nov 2014 13:09:55 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, rogerq@ti.com, kernel@pengutronix.de

Picking up Roger's work:

Changes since v7:
- combined raminit start and done bit into a struct (3/8, 7/8, 8/8)
- constified struct c_can_driver_data (2/8, 7/8, 8/8)
- silenced compiler warning in c_can_hw_raminit_{wait,}_syscon (4/8)
- use platform_get_device_id in probe() instead of open coding it (2/8)

Marc

