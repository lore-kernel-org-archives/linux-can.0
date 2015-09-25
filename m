From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 2/2] can: sunxi: Allwinner A10/A20 CAN Controller
Date: Fri, 25 Sep 2015 18:58:39 +0200
Message-ID: <1443200319-16655-2-git-send-email-info@gerhard-bertelsmann.de>
References: <1443200319-16655-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:33535 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558AbbIYQ6q (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Sep 2015 12:58:46 -0400
In-Reply-To: <1443200319-16655-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

change description of the module.

ef9bd57 general: fix driver info

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---

 drivers/net/can/sun4i_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 67bdf6d..d9a42c6 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -854,4 +854,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION(DRV_NAME "CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
