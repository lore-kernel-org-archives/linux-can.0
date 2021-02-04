Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E04C433DB
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE9664F59
	for <linux-can@archiver.kernel.org>; Thu,  4 Feb 2021 16:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbhBDQ1M (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236785AbhBDQ1K (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 4 Feb 2021 11:27:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED21B64E4A;
        Thu,  4 Feb 2021 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612455989;
        bh=PL83UvtavwBPJYlyOtXD6stjJhbK1zHAoMjjJE2KfAE=;
        h=From:To:Cc:Subject:Date:From;
        b=fp0BwtP4I+L8etUrHcKT92Oqnxp6B25DLDnCzfuzN3MXxi+HtE1mDtiMikxBzktmN
         WUPjY8tfD0XLaKpKlJ9QiIQm8NZyRHzT5704uFmpn3bx7vnpaDmz5j/EH7wK2CRl0v
         6CohskJ8EUqYpBamGPTouHPDPBQJFx3SKY4EUy4VYkh5RaMEGtj611p4D2h/ITUhY6
         IB5j41iI5djK4isGf7zhQw1WqYVBXquGFQABj60pRpZeGd2MNQzFm1jYy7D44EoftW
         PpI2oyXOeyh9DBNwtyq56Dc8XDLG6JJvC774YKymFNuUPGm7/kM0nFj6yRiRbRYcGc
         O6e8Ql3OPff5g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] can: ucan: fix alignment constraints
Date:   Thu,  4 Feb 2021 17:26:13 +0100
Message-Id: <20210204162625.3099392-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

struct ucan_message_in contains member with 4-byte alignment
but is itself marked as unaligned, which triggers a warning:

drivers/net/can/usb/ucan.c:249:1: warning: alignment 1 of 'struct ucan_message_in' is less than 4 [-Wpacked-not-aligned]

Mark the outer structure to have the same alignment as the inner
one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index fa403c080871..536c985dad21 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -246,7 +246,7 @@ struct ucan_message_in {
 		 */
 		struct ucan_tx_complete_entry_t can_tx_complete_msg[0];
 	} __aligned(0x4) msg;
-} __packed;
+} __packed __aligned(0x4);
 
 /* Macros to calculate message lengths */
 #define UCAN_OUT_HDR_SIZE offsetof(struct ucan_message_out, msg)
-- 
2.29.2

