Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C0C4332B
	for <linux-can@archiver.kernel.org>; Tue,  9 Mar 2021 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36496509B
	for <linux-can@archiver.kernel.org>; Tue,  9 Mar 2021 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCIN6c (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 9 Mar 2021 08:58:32 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:59994 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhCIN6P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:58:15 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id eDxt240033PnFJp03DyCQx; Tue, 09 Mar 2021 14:58:14 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Mar 2021 14:58:14 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 2/2] can: bittiming: add temporary variable to increase readability
Date:   Tue,  9 Mar 2021 22:57:48 +0900
Message-Id: <20210309135748.29258-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
References: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Introduce a temporary variable sample_point_in_tq which will hold the
sample point value expressed in time quanta instead of tenth of
percent.

This change is only to increase readability.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
Hi Marc,

Please squash this patch into:
c2cd2b376005 ("can: bittiming: add calculation for CAN FD Transmitter Delay Compensation (TDC)")
---
 drivers/net/can/dev/bittiming.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 853b0ffb443c..f49170eadd54 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -191,8 +191,9 @@ void can_calc_tdco(struct net_device *dev)
 	 */
 	if (dbt->brp == 1 || dbt->brp == 2) {
 		/* Reuse "normal" sample point and convert it to time quanta */
-		tdc->tdco = min(can_bit_time(dbt) * dbt->sample_point / 1000,
-				tdc_const->tdco_max);
+		u32 sample_point_in_tq = can_bit_time(dbt) * dbt->sample_point / 1000;
+
+		tdc->tdco = min(sample_point_in_tq, tdc_const->tdco_max);
 	} else {
 		tdc->tdco = 0;
 	}
-- 
2.26.2

