From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] peak_usb: fix clang build warning
Date: Thu,  7 Mar 2019 11:31:55 +0100
Message-ID: <20190307103219.1539316-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Clang points out undefined behavior when building the pcan_usb_pro driver:

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]

Changing the function prototype to avoid argument promotion in the
varargs call avoids the warning, and should make this well-defined.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index d516def846ab..b388406ac0f5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -127,7 +127,7 @@ static u8 *pcan_msg_init_empty(struct pcan_usb_pro_msg *pm,
 /*
  * add one record to a message being built
  */
-static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
+static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, int id, ...)
 {
 	int len, i;
 	u8 *pc;
-- 
2.20.0
