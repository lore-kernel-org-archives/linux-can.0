From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [PATCH] net: m_can: add CONFIG_HAS_IOMEM dependence
Date: Wed, 15 Oct 2014 14:41:50 -0700
Message-ID: <1413409310-14117-1-git-send-email-david.a.cohen@linux.intel.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50599 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbaJOVlQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 15 Oct 2014 17:41:16 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, David Cohen <david.a.cohen@linux.intel.com>

m_can uses io memory which makes it not compilable on architectures
without HAS_IOMEM such as UML:

drivers/built-in.o: In function `m_can_plat_probe':
m_can.c:(.text+0x218cc5): undefined reference to `devm_ioremap_resource'
m_can.c:(.text+0x218df9): undefined reference to `devm_ioremap'

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
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
2.1.0

