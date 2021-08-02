Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344A0C4338F
	for <linux-can@archiver.kernel.org>; Mon,  2 Aug 2021 04:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CA360EEA
	for <linux-can@archiver.kernel.org>; Mon,  2 Aug 2021 04:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhHBEHU (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 2 Aug 2021 00:07:20 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:56653 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBEHS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 2 Aug 2021 00:07:18 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 00:07:18 EDT
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 65B7444065D;
        Mon,  2 Aug 2021 06:59:28 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Yasushi SHOJI <yashi@spacecubics.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-can@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: fix Microchip CAN BUS Analyzer Tool entry typo
Date:   Mon,  2 Aug 2021 06:59:41 +0300
Message-Id: <cc4831cb1c8759c15fb32c21fd326e831183733d.1627876781.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes: 8a7b46fa7902 ("MAINTAINERS: add Yasushi SHOJI as reviewer for the Microchip CAN BUS Analyzer Tool driver")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9467d2839f5..25dc566a67c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11327,7 +11327,7 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-maxiradio*
 
-MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
+MCBA MICROCHIP CAN BUS ANALYZER TOOL DRIVER
 R:	Yasushi SHOJI <yashi@spacecubics.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-- 
2.30.2

