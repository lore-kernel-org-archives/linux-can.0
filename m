From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/17] can: m_can: add CONFIG_HAS_IOMEM dependence
Date: Tue, 18 Nov 2014 21:37:41 +0100
Message-ID: <1416343067-9810-12-git-send-email-mkl@pengutronix.de>
References: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47336 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbaKRUiG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Nov 2014 15:38:06 -0500
In-Reply-To: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, David Cohen <david.a.cohen@linux.intel.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: David Cohen <david.a.cohen@linux.intel.com>

m_can uses io memory which makes it not compilable on architectures
without HAS_IOMEM such as UML:

drivers/built-in.o: In function `m_can_plat_probe':
m_can.c:(.text+0x218cc5): undefined reference to `devm_ioremap_resource'
m_can.c:(.text+0x218df9): undefined reference to `devm_ioremap'

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index fca5482c09ac..04f20dd39007 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -1,4 +1,5 @@
 config CAN_M_CAN
+	depends on HAS_IOMEM
 	tristate "Bosch M_CAN devices"
 	---help---
 	  Say Y here if you want to support for Bosch M_CAN controller.
-- 
2.1.3

