From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: peak_usb: mark expected switch fall-throughs
Date: Thu, 28 Jun 2018 12:41:42 -0500
Message-ID: <20180628174142.GA17081@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index f530a80..13238a7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -423,6 +423,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			new_state = CAN_STATE_ERROR_WARNING;
 			break;
 		}
+		/* else: fall through */
 
 	case CAN_STATE_ERROR_WARNING:
 		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 50e9114..611f9d3 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -353,6 +353,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 		default:
 			netdev_warn(netdev, "tx urb submitting failed err=%d\n",
 				    err);
+			/* fall through */
 		case -ENOENT:
 			/* cable unplugged */
 			stats->tx_dropped++;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 0105fbf..d516def 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -141,8 +141,10 @@ static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
 	switch (id) {
 	case PCAN_USBPRO_TXMSG8:
 		i += 4;
+		/* fall through */
 	case PCAN_USBPRO_TXMSG4:
 		i += 4;
+		/* fall through */
 	case PCAN_USBPRO_TXMSG0:
 		*pc++ = va_arg(ap, int);
 		*pc++ = va_arg(ap, int);
-- 
2.7.4
