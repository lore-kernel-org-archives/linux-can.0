From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 4/5] can: extend sockaddr_can to include j1939 members
Date: Mon,  8 Oct 2018 11:48:35 +0200
Message-ID: <20181008094836.14080-5-o.rempel@pengutronix.de>
References: <20181008094836.14080-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181008094836.14080-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This patch prepares struct sockaddr_can for SAE J1939.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/can.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 06d92d6be6e6..1e988fdeba34 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -175,6 +175,23 @@ struct sockaddr_can {
 		/* transport protocol class address information (e.g. ISOTP) */
 		struct { canid_t rx_id, tx_id; } tp;
 
+		/* J1939 address information */
+		struct {
+			/* 8 byte name when using dynamic addressing */
+			__u64 name;
+
+			/* pgn:
+			 * 8 bit: PS in PDU2 case, else 0
+			 * 8 bit: PF
+			 * 1 bit: DP
+			 * 1 bit: reserved
+			 */
+			__u32 pgn;
+
+			/* 1 byte address */
+			__u8 addr;
+		} j1939;
+
 		/* reserved for future CAN protocols address information */
 	} can_addr;
 };
-- 
2.19.0
