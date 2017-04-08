From: =?UTF-8?q?Mario=20H=C3=BCttel?= <mario.huettel@gmx.net>
Subject: [PATCH v4 1/7] can: m_can: Disabled Interrupt Line 1
Date: Sat,  8 Apr 2017 14:10:09 +0200
Message-ID: <20170408121015.11428-1-mario.huettel@gmx.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:65488 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752080AbdDHMKb (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 8 Apr 2017 08:10:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Mario Huettel <mario.huettel@gmx.net>

From: Mario Huettel <mario.huettel@gmx.net>

* Disabled interrupt line 1. The driver didn't use it.

Signed-off-by: Mario Huettel <mario.huettel@gmx.net>
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

