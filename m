From: Marek Vasut <marex@denx.de>
Subject: [PATCH] can: m_can: Set pinmux into "default" state on start
Date: Sun, 31 May 2020 20:13:24 +0200
Message-ID: <20200531181324.383930-1-marex@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:59120 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaSNc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 May 2020 14:13:32 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Alexandre Torgue <alexandre.torgue@st.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On systems like stm32mp1 where pins have both "default" and "sleep" pinmux
states in DT, the pins are in "sleep" state by default. Switch the pins into
the "default" state when bringing the interface up in m_can_start(), because
otherwise no CAN communication is possible. This replicates the behavior of
the resume path, which does the same.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
To: linux-can@vger.kernel.org
---
 drivers/net/can/m_can/m_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..76fadf2b8ac2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1247,6 +1247,8 @@ static void m_can_start(struct net_device *dev)
 	/* basic m_can configuration */
 	m_can_chip_config(dev);
 
+	pinctrl_pm_select_default_state(cdev->dev);
+
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	m_can_enable_all_interrupts(cdev);
-- 
2.25.1
