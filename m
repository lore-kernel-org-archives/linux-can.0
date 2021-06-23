Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E808EC48BC2
	for <linux-can@archiver.kernel.org>; Wed, 23 Jun 2021 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99C96112D
	for <linux-can@archiver.kernel.org>; Wed, 23 Jun 2021 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWOaV (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 23 Jun 2021 10:30:21 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60026 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWOaV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 23 Jun 2021 10:30:21 -0400
Received: from Focal.peak-system.com (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 536E05FFA8;
        Wed, 23 Jun 2021 16:27:29 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_pciefd: fix a potential issue of sending frames
Date:   Wed, 23 Jun 2021 16:26:00 +0200
Message-Id: <20210623142600.149904-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rather than just indicating that transmission can start, this patch
requires the explicit flushing of the network Tx queue when the driver is
informed by the device that it can transmit, next to its configuration.
In this way, if frames have already been written by the application, they
will actually be transmitted.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 00847cbaf7b6..d08718e98e11 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -351,8 +351,8 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 				return err;
 		}
 
-		/* start network queue (echo_skb array is empty) */
-		netif_start_queue(ndev);
+		/* wake network queue up (echo_skb array is empty) */
+		netif_wake_queue(ndev);
 
 		return 0;
 	}
-- 
2.25.1

