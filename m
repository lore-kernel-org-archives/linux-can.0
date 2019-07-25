From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: kvaser_pciefd: Remove unused including <linux/version.h>
Date: Thu, 25 Jul 2019 07:02:17 +0000
Message-ID: <20190725070217.3569-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Henning Colliander <henning.colliander@evidente.se>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
List-Id: linux-can.vger.kernel.org

Remove including <linux/version.h> that don't need it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/kvaser_pciefd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 3af747cbbde4..952a022b8343 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/pci.h>
