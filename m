From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH can-next] can: tcan4x5x: Rename parse_config function
Date: Wed, 26 Feb 2020 08:03:58 -0600
Message-ID: <20200226140358.30017-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37238 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2020 09:09:26 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>

Rename the tcan4x5x_parse_config function to tcan4x5x_get_gpios since
the function retrieves the gpio configurations from the firmware.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

API name change request - https://lore.kernel.org/patchwork/patch/1165091/

 drivers/net/can/m_can/tcan4x5x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index 9821babef55e..37d53ecc560b 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -381,7 +381,7 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev->device_data;
 	int ret;
@@ -507,7 +507,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_parse_config(mcan_class);
+	ret = tcan4x5x_get_gpios(mcan_class);
 	if (ret)
 		goto out_power;
 
-- 
2.25.0
