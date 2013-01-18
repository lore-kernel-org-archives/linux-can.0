From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 1/3] can: c_can: fix invalid error codes
Date: Fri, 18 Jan 2013 09:32:39 +0100
Message-ID: <1358497961-9080-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:43515 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3ARIeh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jan 2013 03:34:37 -0500
Received: by mail-ea0-f178.google.com with SMTP id a14so1398169eaa.9
        for <linux-can@vger.kernel.org>; Fri, 18 Jan 2013 00:34:36 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>, Bhupesh Sharma <bhupesh.sharma@st.com>

Errors in CAN protocol (location) are reported in data[3] of the can
frame instead of data[2].

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: Bhupesh Sharma <bhupesh.sharma@st.com>
---
 drivers/net/can/c_can/c_can.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5233b8f..58607f1 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -960,7 +960,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[2] |= (CAN_ERR_PROT_LOC_ACK |
+		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
 				CAN_ERR_PROT_LOC_ACK_DEL);
 		break;
 	case LEC_BIT1_ERROR:
@@ -973,7 +973,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[2] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
+		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
 				CAN_ERR_PROT_LOC_CRC_DEL);
 		break;
 	default:
-- 
1.7.9.5

