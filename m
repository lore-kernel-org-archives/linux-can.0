Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD119C4361B
	for <linux-can@archiver.kernel.org>; Thu, 10 Dec 2020 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4C423D9D
	for <linux-can@archiver.kernel.org>; Thu, 10 Dec 2020 09:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgLJJVP (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Dec 2020 04:21:15 -0500
Received: from s2.neomailbox.net ([5.148.176.60]:28530 "EHLO s2.neomailbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbgLJJU4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 10 Dec 2020 04:20:56 -0500
X-Greylist: delayed 1522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 04:20:51 EST
From:   Antonio Quartulli <a@unstable.cc>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antonio Quartulli <a@unstable.cc>
Subject: [PATCH] can: avoid double unlikely() notation when using IS_ERR()
Date:   Thu, 10 Dec 2020 09:53:21 +0100
Message-Id: <20201210085321.18693-1-a@unstable.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The definition of IS_ERR() already applies the unlikely() notation
when checking the error status of the passed pointer. For this
reason there is no need to have the same notation outside of
IS_ERR() itself.

Clean up code by removing redundant notation.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 drivers/net/can/rx-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 450c5cfcb3fc..3c1912c0430b 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -157,7 +157,7 @@ can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 	/* There was a problem reading the mailbox, propagate
 	 * error value.
 	 */
-	if (unlikely(IS_ERR(skb))) {
+	if (IS_ERR(skb)) {
 		offload->dev->stats.rx_dropped++;
 		offload->dev->stats.rx_fifo_errors++;
 
-- 
2.29.2

