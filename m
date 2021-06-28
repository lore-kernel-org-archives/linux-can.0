Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB283C49361
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D8161A1D
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhF1P5o (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:57:44 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:50110 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhF1P5H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:57:07 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fufup; Mon, 28 Jun 2021 17:54:40 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:40 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 5/6] can: etas_es58x: use sizeof and sizeof_field macros instead of constant values
Date:   Tue, 29 Jun 2021 00:54:19 +0900
Message-Id: <20210628155420.1176217-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Replace two constant values by a call to sizeof{,_field} on the
relevant field to make the logic easier to understand.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es581_4.c    | 2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 1985f772fc3c..88dbfe41ba85 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -355,7 +355,7 @@ static int es581_4_tx_can_msg(struct es58x_priv *priv,
 		return -EMSGSIZE;
 
 	if (priv->tx_can_msg_cnt == 0) {
-		msg_len = 1; /* struct es581_4_bulk_tx_can_msg:num_can_msg */
+		msg_len = sizeof(es581_4_urb_cmd->bulk_tx_can_msg.num_can_msg);
 		es581_4_fill_urb_header(urb_cmd, ES581_4_CAN_COMMAND_TYPE,
 					ES581_4_CMD_ID_TX_MSG,
 					priv->channel_idx, msg_len);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index dbc4f75336a1..49a32c1e6f27 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -70,7 +70,7 @@ MODULE_DEVICE_TABLE(usb, es58x_id_table);
  * bytes (the start of frame) are skipped and the CRC calculation
  * starts on the third byte.
  */
-#define ES58X_CRC_CALC_OFFSET 2
+#define ES58X_CRC_CALC_OFFSET sizeof_field(union es58x_urb_cmd, sof)
 
 /**
  * es58x_calculate_crc() - Compute the crc16 of a given URB.
-- 
2.31.1

