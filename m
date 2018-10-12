From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] can: ucan: fix some typos in comments
Date: Fri, 12 Oct 2018 13:00:24 +0200
Message-ID: <20181012110024.17067-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: martin.elshuber@theobroma-systems.com, jakob.unterwurzacher@theobroma-systems.com
Cc: philipp.tomsich@theobroma-systems.com, mkl@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-can.vger.kernel.org

This fixes some double-word and trivial typos in the ucan driver comments.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
hi guys,

The Seal looks very nice. Since I'm doing CAN work right now, I could totally
use one of these instead of old gear from PEAK.

I hope you're doing fine. Best regards,

                                martin


 drivers/net/can/usb/ucan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..8c680fb9fdc8 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -64,7 +64,7 @@
  *    the following way:
  *
  *	m[n].len <=> the length if message n(including the header in bytes)
- *	m[n] is is aligned to a 4 byte boundary, hence
+ *	m[n] is aligned to a 4 byte boundary, hence
  *	  offset(m[0])	 := 0;
  *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
  *
@@ -288,7 +288,7 @@ struct ucan_priv {
 	 */
 	spinlock_t echo_skb_lock;
 
-	/* usb device information information */
+	/* usb device information */
 	u8 intf_index;
 	u8 in_ep_addr;
 	u8 out_ep_addr;
@@ -1449,7 +1449,7 @@ static int ucan_probe(struct usb_interface *intf,
 
 	/* request the device information and store it in ctl_msg_buffer
 	 *
-	 * note: ucan_ctrl_command_* wrappers connot be used yet
+	 * note: ucan_ctrl_command_* wrappers cannot be used yet
 	 * because `up` is initialised in Stage 3
 	 */
 	ret = usb_control_msg(udev,
@@ -1498,7 +1498,7 @@ static int ucan_probe(struct usb_interface *intf,
 
 	up = netdev_priv(netdev);
 
-	/* initialze data */
+	/* initialize data */
 	up->udev = udev;
 	up->intf = intf;
 	up->netdev = netdev;
-- 
2.19.0
