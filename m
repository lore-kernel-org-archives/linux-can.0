From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v3 1/6] can: m_can: Disabled Interrupt Line 1
Date: Fri, 24 Mar 2017 17:49:26 +0100
Message-ID: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39177 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966723AbdCXQtp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2017 12:49:45 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id DEE031580015
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:37 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id 94C292E405A1
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:37 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

* Disabled interrupt line 1. The driver didn't use it.

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7a6554e..6797977 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -349,7 +349,8 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
 
 static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
 {
-	m_can_write(priv, M_CAN_ILE, ILE_EINT0 | ILE_EINT1);
+	/* Only interrupt line 0 is used in this driver */
+	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
 }
 
 static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
-- 
1.9.1

