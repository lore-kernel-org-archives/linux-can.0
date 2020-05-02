From: Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] can: mscan: mpc5xxx_can: update contact email
Date: Sat,  2 May 2020 16:26:56 +0200
Message-ID: <20200502142657.19199-1-wsa@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 drivers/net/can/mscan/mpc5xxx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index e4f4b5c9ebd6..e254e04ae257 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2004-2005 Andrey Volkov <avolkov@varma-el.com>,
  *                         Varma Electronics Oy
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- * Copyright (C) 2009 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ * Copyright (C) 2009 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
  */
 
 #include <linux/kernel.h>
-- 
2.20.1
