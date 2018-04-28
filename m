From: Colin King <colin.king@canonical.com>
Subject: [PATCH] can: cc770: fix spelling mistake: "comptibility" -> "compatibility"
Date: Sat, 28 Apr 2018 23:16:00 +0100
Message-ID: <20180428221600.20039-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/can/cc770/cc770.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index d4dd4da23997..da636a22c542 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -73,7 +73,7 @@ MODULE_PARM_DESC(msgobj15_eff, "Extended 29-bit frames for message object 15 "
 
 static int i82527_compat;
 module_param(i82527_compat, int, 0444);
-MODULE_PARM_DESC(i82527_compat, "Strict Intel 82527 comptibility mode "
+MODULE_PARM_DESC(i82527_compat, "Strict Intel 82527 compatibility mode "
 		 "without using additional functions");
 
 /*
-- 
2.17.0
