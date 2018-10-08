From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 3/5] can: add socket type for CAN_J1939
Date: Mon,  8 Oct 2018 11:48:34 +0200
Message-ID: <20181008094836.14080-4-o.rempel@pengutronix.de>
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This patch is a preparation for SAE J1939 and adds CAN_J1939
socket type.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/can.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 0afb7d8e867f..06d92d6be6e6 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -157,7 +157,8 @@ struct canfd_frame {
 #define CAN_TP20	4 /* VAG Transport Protocol v2.0 */
 #define CAN_MCNET	5 /* Bosch MCNet */
 #define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */
-#define CAN_NPROTO	7
+#define CAN_J1939	7 /* SAE J1939 */
+#define CAN_NPROTO	8
 
 #define SOL_CAN_BASE 100
 
-- 
2.19.0
