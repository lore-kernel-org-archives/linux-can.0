From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] can: mcp251x: Remove redundant spi driver bus initialization
Date: Tue, 12 Mar 2013 13:13:51 +0100
Message-ID: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1114 "EHLO
	smtp-out-038.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3CLMSv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Mar 2013 08:18:51 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

In ancient times it was necessary to manually initialize the bus field of an
spi_driver to spi_bus_type. These days this is done in spi_driver_register() so
we can drop the manual assignment.

The patch was generated using the following coccinelle semantic patch:
// <smpl>
@@
identifier _driver;
@@
struct spi_driver _driver = {
	.driver = {
-		.bus = &spi_bus_type,
	},
};
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index f32b9fc..05e93e8 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1207,7 +1207,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 
-- 
1.8.0

