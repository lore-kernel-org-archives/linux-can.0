From: Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH v2] can: tcan4x5x: tcan4x5x_clear_interrupts: remove redundant if statement
Date: Fri,  3 Apr 2020 17:08:13 +0200
Message-ID: <20200403150813.10711-1-daniels@umanovskis.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.weplayciv.com ([162.221.200.53]:50506 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404081AbgDCPIa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 11:08:30 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: dmurphy@ti.com, Daniels Umanovskis <daniels@umanovskis.se>

The redundant statement seems to be a copy-paste error from other places
in the file where the same pattern is used

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 drivers/net/can/m_can/tcan4x5x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index eacd428e07e9..07f1d4a627fa 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -328,12 +328,8 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
+	return tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
 				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
-
-	return ret;
 }
 
 static int tcan4x5x_init(struct m_can_classdev *cdev)
-- 
2.20.1
