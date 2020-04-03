From: Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH] can: tcan4x5x: tcan4x5x_clear_interrupts: remove redundant if statement
Date: Fri,  3 Apr 2020 16:46:02 +0200
Message-ID: <20200403144602.8494-1-daniels@umanovskis.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.weplayciv.com ([162.221.200.53]:49828 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbgDCOxP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 10:53:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: dmurphy@ti.com, Daniels Umanovskis <daniels@umanovskis.se>

The redundant statement seems to be a copy-paste error from other places
in the file where the same pattern is used

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---
 drivers/net/can/m_can/tcan4x5x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
index eacd428e07e9..1065b0518c70 100644
--- a/drivers/net/can/m_can/tcan4x5x.c
+++ b/drivers/net/can/m_can/tcan4x5x.c
@@ -330,8 +330,6 @@ static int tcan4x5x_clear_interrupts(struct m_can_classdev *cdev)
 
 	ret = tcan4x5x_write_tcan_reg(cdev, TCAN4X5X_ERROR_STATUS,
 				      TCAN4X5X_CLEAR_ALL_INT);
-	if (ret)
-		return ret;
 
 	return ret;
 }
-- 
2.20.1
