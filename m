Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7FCC5519F
	for <linux-can@archiver.kernel.org>; Thu, 12 Nov 2020 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21BF22201
	for <linux-can@archiver.kernel.org>; Thu, 12 Nov 2020 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgKLSEu (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:04:50 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:35562 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKLSEu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 9D7A4FFA8F
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wDZdnIJKMd7f for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:46 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 08/16] can: ems_usb: Modified ems_usb_read_bulk_callback to handle also CPC-USB/FD
Date:   Thu, 12 Nov 2020 19:03:38 +0100
Message-Id: <20201112180346.29070-9-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The ems_usb_read_bulk_callback of the drivers present version uses a
byte in the beginning of the received bulk buffer to check how many 
messages come from the interface. This is not possible with CPC-USB/FD
and hence changed in a way to satisfy both types of interface.

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 91 +++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 0e8d1b75ef8d..41f9fb126e0a 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -456,6 +456,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 	struct ems_usb *dev = urb->context;
 	struct net_device *netdev;
 	int retval;
+	u32 length, start;
 
 	netdev = dev->netdev;
 
@@ -474,50 +475,58 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 		goto resubmit_urb;
 	}
 
-	if (urb->actual_length > CPC_HEADER_SIZE) {
+	length = urb->actual_length;
+	start = CPC_HEADER_SIZE;
+
+	while (length >= CPC_MSG_HEADER_LEN) {
 		struct ems_cpc_msg *msg;
 		u8 *ibuf = urb->transfer_buffer;
-		u8 msg_count, start;
-
-		msg_count = ibuf[0] & ~0x80;
-
-		start = CPC_HEADER_SIZE;
-
-		while (msg_count) {
-			msg = (struct ems_cpc_msg *)&ibuf[start];
-
-			switch (msg->type) {
-			case CPC_MSG_TYPE_CAN_STATE:
-				/* Process CAN state changes */
-				ems_usb_rx_err(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_CAN_FRAME:
-			case CPC_MSG_TYPE_EXT_CAN_FRAME:
-			case CPC_MSG_TYPE_RTR_FRAME:
-			case CPC_MSG_TYPE_EXT_RTR_FRAME:
-				ems_usb_rx_can_msg(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_CAN_FRAME_ERROR:
-				/* Process errorframe */
-				ems_usb_rx_err(dev, msg);
-				break;
-
-			case CPC_MSG_TYPE_OVERRUN:
-				/* Message lost while receiving */
-				ems_usb_rx_err(dev, msg);
-				break;
-			}
-
-			start += CPC_MSG_HEADER_LEN + msg->length;
-			msg_count--;
-
-			if (start > urb->transfer_buffer_length) {
-				netdev_err(netdev, "format error\n");
-				break;
-			}
+		u32 read_count;
+
+		msg = (struct ems_cpc_msg *)&ibuf[start];
+
+		/* We should leave if length is smaller than
+		 * length indicated by payload
+		 */
+		if (length < CPC_MSG_HEADER_LEN + msg->length) {
+			netdev_err(netdev, "format error\n");
+			break;
+		}
+
+		switch (msg->type) {
+		case CPC_MSG_TYPE_CAN_STATE:
+			/* Process CAN state changes */
+			ems_usb_rx_err(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_CAN_FRAME:
+		case CPC_MSG_TYPE_EXT_CAN_FRAME:
+		case CPC_MSG_TYPE_RTR_FRAME:
+		case CPC_MSG_TYPE_EXT_RTR_FRAME:
+			ems_usb_rx_can_msg(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_CAN_FRAME_ERROR:
+			/* Process errorframe */
+			ems_usb_rx_err(dev, msg);
+			break;
+
+		case CPC_MSG_TYPE_OVERRUN:
+			/* Message lost while receiving */
+			ems_usb_rx_err(dev, msg);
+			break;
 		}
+
+		read_count = CPC_MSG_HEADER_LEN + msg->length;
+		start += read_count;
+
+		if (start > urb->transfer_buffer_length) {
+			netdev_err(netdev, "format error\n");
+			break;
+		}
+
+		if (read_count <= length)
+			length -= read_count;
 	}
 
 resubmit_urb:
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
