Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FE4C48BDF
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 08:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2FC61260
	for <linux-can@archiver.kernel.org>; Fri, 18 Jun 2021 08:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhFRI4R (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:56:17 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:31979 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhFRI4O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 04:56:14 -0400
Received: from localhost.localdomain ([114.149.34.46])
        by mwinf5d28 with ME
        id JYtR2500E0zjR6y03Yu2f0; Fri, 18 Jun 2021 10:54:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 18 Jun 2021 10:54:04 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 3/4] iplink_can: print brp and dbrp bittiming variables
Date:   Fri, 18 Jun 2021 17:53:21 +0900
Message-Id: <20210618085322.147462-4-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210618085322.147462-1-mailhol.vincent@wanadoo.fr>
References: <20210618085322.147462-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Report the value of the bit-rate prescaler (brp) for both the nominal
and the data bittiming.

Currently, only the constant brp values (brp_{min,max,inc}) are being
reported. Also, brp is the only member of struct can_bittiming not
being reported.

Although brp is not used as an input for bittiming calculation, it
makes sense to output it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 ip/iplink_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index ec4e122f..311c097d 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -348,6 +348,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "phase_seg2", "phase-seg2 %u ",
 			   bt->phase_seg2);
 		print_uint(PRINT_ANY, "sjw", " sjw %u", bt->sjw);
+		print_uint(PRINT_ANY, "brp", " brp %u", bt->brp);
 		close_json_object();
 	}
 
@@ -423,6 +424,7 @@ static void can_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_uint(PRINT_ANY, "phase_seg2", " dphase-seg2 %u",
 			   dbt->phase_seg2);
 		print_uint(PRINT_ANY, "sjw", " dsjw %u", dbt->sjw);
+		print_uint(PRINT_ANY, "brp", " dbrp %u", dbt->brp);
 		close_json_object();
 	}
 
-- 
2.31.1

