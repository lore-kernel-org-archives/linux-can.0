Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD71C2B9F4
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6B761A0F
	for <linux-can@archiver.kernel.org>; Mon, 28 Jun 2021 15:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhF1P5q (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:57:46 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:37836 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhF1P5M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:57:12 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfu82501E0zjR6y03fujvM; Mon, 28 Jun 2021 17:54:45 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:54:45 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 6/6] can: etas_es58x: rewrite the message cast in es58{1,_fd}_tx_can_msg to increase readability
Date:   Tue, 29 Jun 2021 00:54:20 +0900
Message-Id: <20210628155420.1176217-7-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The es581_tx_can_msg() does below cast:
|	tx_can_msg = (struct es581_4_tx_can_msg *)
|	    &es581_4_urb_cmd->bulk_tx_can_msg.tx_can_msg_buf[msg_len - 1];

The -1 offset is to skip the first member of struct
es581_4_tx_can_msg. However, es581_4_urb_cmd already has a raw_msg
field which can be used instead without the use of an offset
calculation.

The function es58x_fd_tx_can_msg() is also modified to mirror
es581_tx_can_msg().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es581_4.c  | 3 +--
 drivers/net/can/usb/etas_es58x/es58x_fd.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 88dbfe41ba85..14e360c9f2c9 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -371,8 +371,7 @@ static int es581_4_tx_can_msg(struct es58x_priv *priv,
 		return ret;
 
 	/* Fill message contents. */
-	tx_can_msg = (struct es581_4_tx_can_msg *)
-	    &es581_4_urb_cmd->bulk_tx_can_msg.tx_can_msg_buf[msg_len - 1];
+	tx_can_msg = (typeof(tx_can_msg))&es581_4_urb_cmd->raw_msg[msg_len];
 	put_unaligned_le32(es58x_get_raw_can_id(cf), &tx_can_msg->can_id);
 	put_unaligned_le32(priv->tx_head, &tx_can_msg->packet_idx);
 	put_unaligned_le16((u16)es58x_get_flags(skb), &tx_can_msg->flags);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index f19022ca8f25..4f0cae29f4d8 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -357,8 +357,7 @@ static int es58x_fd_tx_can_msg(struct es58x_priv *priv,
 		return ret;
 
 	/* Fill message contents. */
-	tx_can_msg = (struct es58x_fd_tx_can_msg *)
-	    &es58x_fd_urb_cmd->tx_can_msg_buf[msg_len];
+	tx_can_msg = (typeof(tx_can_msg))&es58x_fd_urb_cmd->raw_msg[msg_len];
 	tx_can_msg->packet_idx = (u8)priv->tx_head;
 	put_unaligned_le32(es58x_get_raw_can_id(cf), &tx_can_msg->can_id);
 	tx_can_msg->flags = (u8)es58x_get_flags(skb);
-- 
2.31.1

