From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: unify identifiers to ensure unique include processing
Date: Thu, 15 May 2014 20:31:56 +0200
Message-ID: <1400178716-8748-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:48226 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbaEOScG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 May 2014 14:32:06 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Armin pointed me to the fact that the identifier which is used to ensure the
unique include processing in lunux/include/uapi/linux/can.h is CAN_H.
This clashed with his own source as includes from libraries and APIs should
use an underscore '_' at the identifier start.

This patch fixes the protection identifiers in all CAN relavant includes.

Reported-by: Armin Burchardt <armin@uni-bremen.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/core.h             | 6 +++---
 include/linux/can/dev.h              | 6 +++---
 include/linux/can/led.h              | 6 +++---
 include/linux/can/platform/cc770.h   | 6 +++---
 include/linux/can/platform/mcp251x.h | 6 +++---
 include/linux/can/platform/sja1000.h | 6 +++---
 include/linux/can/platform/ti_hecc.h | 6 +++---
 include/linux/can/skb.h              | 6 +++---
 include/uapi/linux/can.h             | 6 +++---
 include/uapi/linux/can/bcm.h         | 6 +++---
 include/uapi/linux/can/error.h       | 6 +++---
 include/uapi/linux/can/gw.h          | 6 +++---
 include/uapi/linux/can/netlink.h     | 6 +++---
 include/uapi/linux/can/raw.h         | 6 +++---
 14 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 78c6c52..a087500 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -10,8 +10,8 @@
  *
  */
 
-#ifndef CAN_CORE_H
-#define CAN_CORE_H
+#ifndef _CAN_CORE_H
+#define _CAN_CORE_H
 
 #include <linux/can.h>
 #include <linux/skbuff.h>
@@ -58,4 +58,4 @@ extern void can_rx_unregister(struct net_device *dev, canid_t can_id,
 extern int can_send(struct sk_buff *skb, int loop);
 extern int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 
-#endif /* CAN_CORE_H */
+#endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 3ce5e52..6992afc 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -10,8 +10,8 @@
  *
  */
 
-#ifndef CAN_DEV_H
-#define CAN_DEV_H
+#ifndef _CAN_DEV_H
+#define _CAN_DEV_H
 
 #include <linux/can.h>
 #include <linux/can/netlink.h>
@@ -132,4 +132,4 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 
-#endif /* CAN_DEV_H */
+#endif /* !_CAN_DEV_H */
diff --git a/include/linux/can/led.h b/include/linux/can/led.h
index 9c1167ba..e0475c5 100644
--- a/include/linux/can/led.h
+++ b/include/linux/can/led.h
@@ -6,8 +6,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef CAN_LED_H
-#define CAN_LED_H
+#ifndef _CAN_LED_H
+#define _CAN_LED_H
 
 #include <linux/if.h>
 #include <linux/leds.h>
@@ -48,4 +48,4 @@ static inline void can_led_notifier_exit(void)
 
 #endif
 
-#endif
+#endif /* !_CAN_LED_H */
diff --git a/include/linux/can/platform/cc770.h b/include/linux/can/platform/cc770.h
index 7702641..78b2d44 100644
--- a/include/linux/can/platform/cc770.h
+++ b/include/linux/can/platform/cc770.h
@@ -1,5 +1,5 @@
-#ifndef _CAN_PLATFORM_CC770_H_
-#define _CAN_PLATFORM_CC770_H_
+#ifndef _CAN_PLATFORM_CC770_H
+#define _CAN_PLATFORM_CC770_H
 
 /* CPU Interface Register (0x02) */
 #define CPUIF_CEN	0x01	/* Clock Out Enable */
@@ -30,4 +30,4 @@ struct cc770_platform_data {
 	u8 bcr;		/* Bus Configuration Register */
 };
 
-#endif	/* !_CAN_PLATFORM_CC770_H_ */
+#endif	/* !_CAN_PLATFORM_CC770_H */
diff --git a/include/linux/can/platform/mcp251x.h b/include/linux/can/platform/mcp251x.h
index dc029db..d44fcae 100644
--- a/include/linux/can/platform/mcp251x.h
+++ b/include/linux/can/platform/mcp251x.h
@@ -1,5 +1,5 @@
-#ifndef __CAN_PLATFORM_MCP251X_H__
-#define __CAN_PLATFORM_MCP251X_H__
+#ifndef _CAN_PLATFORM_MCP251X_H
+#define _CAN_PLATFORM_MCP251X_H
 
 /*
  *
@@ -18,4 +18,4 @@ struct mcp251x_platform_data {
 	unsigned long oscillator_frequency;
 };
 
-#endif /* __CAN_PLATFORM_MCP251X_H__ */
+#endif /* !_CAN_PLATFORM_MCP251X_H */
diff --git a/include/linux/can/platform/sja1000.h b/include/linux/can/platform/sja1000.h
index 96f8fcc..93570b6 100644
--- a/include/linux/can/platform/sja1000.h
+++ b/include/linux/can/platform/sja1000.h
@@ -1,5 +1,5 @@
-#ifndef _CAN_PLATFORM_SJA1000_H_
-#define _CAN_PLATFORM_SJA1000_H_
+#ifndef _CAN_PLATFORM_SJA1000_H
+#define _CAN_PLATFORM_SJA1000_H
 
 /* clock divider register */
 #define CDR_CLKOUT_MASK 0x07
@@ -32,4 +32,4 @@ struct sja1000_platform_data {
 	u8 cdr;		/* clock divider register */
 };
 
-#endif	/* !_CAN_PLATFORM_SJA1000_H_ */
+#endif	/* !_CAN_PLATFORM_SJA1000_H */
diff --git a/include/linux/can/platform/ti_hecc.h b/include/linux/can/platform/ti_hecc.h
index af17cb3..a52f47c 100644
--- a/include/linux/can/platform/ti_hecc.h
+++ b/include/linux/can/platform/ti_hecc.h
@@ -1,5 +1,5 @@
-#ifndef __CAN_PLATFORM_TI_HECC_H__
-#define __CAN_PLATFORM_TI_HECC_H__
+#ifndef _CAN_PLATFORM_TI_HECC_H
+#define _CAN_PLATFORM_TI_HECC_H
 
 /*
  * TI HECC (High End CAN Controller) driver platform header
@@ -41,4 +41,4 @@ struct ti_hecc_platform_data {
 	u32 version;
 	void (*transceiver_switch) (int);
 };
-#endif
+#endif /* !_CAN_PLATFORM_TI_HECC_H */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index f9bbbb4..cc00d15 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -7,8 +7,8 @@
  *
  */
 
-#ifndef CAN_SKB_H
-#define CAN_SKB_H
+#ifndef _CAN_SKB_H
+#define _CAN_SKB_H
 
 #include <linux/types.h>
 #include <linux/skbuff.h>
@@ -80,4 +80,4 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 	return skb;
 }
 
-#endif /* CAN_SKB_H */
+#endif /* !_CAN_SKB_H */
diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 5d9d1d1..41892f7 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -42,8 +42,8 @@
  * DAMAGE.
  */
 
-#ifndef CAN_H
-#define CAN_H
+#ifndef _UAPI_CAN_H
+#define _UAPI_CAN_H
 
 #include <linux/types.h>
 #include <linux/socket.h>
@@ -191,4 +191,4 @@ struct can_filter {
 
 #define CAN_INV_FILTER 0x20000000U /* to be set in can_filter.can_id */
 
-#endif /* CAN_H */
+#endif /* !_UAPI_CAN_H */
diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index 382251a..89ddb9d 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -41,8 +41,8 @@
  * DAMAGE.
  */
 
-#ifndef CAN_BCM_H
-#define CAN_BCM_H
+#ifndef _UAPI_CAN_BCM_H
+#define _UAPI_CAN_BCM_H
 
 #include <linux/types.h>
 #include <linux/can.h>
@@ -95,4 +95,4 @@ enum {
 #define TX_RESET_MULTI_IDX  0x0200
 #define RX_RTR_FRAME        0x0400
 
-#endif /* CAN_BCM_H */
+#endif /* !_UAPI_CAN_BCM_H */
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/error.h
index b632045..c247446 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -41,8 +41,8 @@
  * DAMAGE.
  */
 
-#ifndef CAN_ERROR_H
-#define CAN_ERROR_H
+#ifndef _UAPI_CAN_ERROR_H
+#define _UAPI_CAN_ERROR_H
 
 #define CAN_ERR_DLC 8 /* dlc for error message frames */
 
@@ -120,4 +120,4 @@
 
 /* controller specific additional information / data[5..7] */
 
-#endif /* CAN_ERROR_H */
+#endif /* _UAPI_CAN_ERROR_H */
diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 844c896..3e6184c 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -41,8 +41,8 @@
  * DAMAGE.
  */
 
-#ifndef CAN_GW_H
-#define CAN_GW_H
+#ifndef _UAPI_CAN_GW_H
+#define _UAPI_CAN_GW_H
 
 #include <linux/types.h>
 #include <linux/can.h>
@@ -200,4 +200,4 @@ enum {
  *         Beware of sending unpacked or aligned structs!
  */
 
-#endif
+#endif /* !_UAPI_CAN_GW_H */
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 7e2e186..813d11f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -15,8 +15,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef CAN_NETLINK_H
-#define CAN_NETLINK_H
+#ifndef _UAPI_CAN_NETLINK_H
+#define _UAPI_CAN_NETLINK_H
 
 #include <linux/types.h>
 
@@ -130,4 +130,4 @@ enum {
 
 #define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
 
-#endif /* CAN_NETLINK_H */
+#endif /* !_UAPI_CAN_NETLINK_H */
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
index c7d8c33..78ec76f 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -42,8 +42,8 @@
  * DAMAGE.
  */
 
-#ifndef CAN_RAW_H
-#define CAN_RAW_H
+#ifndef _UAPI_CAN_RAW_H
+#define _UAPI_CAN_RAW_H
 
 #include <linux/can.h>
 
@@ -59,4 +59,4 @@ enum {
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
 };
 
-#endif
+#endif /* !_UAPI_CAN_RAW_H */
-- 
2.0.0.rc2

