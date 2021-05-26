Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D074C47089
	for <linux-can@archiver.kernel.org>; Wed, 26 May 2021 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E609D6113D
	for <linux-can@archiver.kernel.org>; Wed, 26 May 2021 12:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhEZMxQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 26 May 2021 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhEZMv1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 08:51:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD67FC061350
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so436953wmg.3
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QSIsP6w+qEHOE1YU732ng4YXzraRvh2ol8TZbSmZYkM=;
        b=k8oHGHHIjnktUuQtCkmRbAV9uWGk0kUkpwDqLRwjuS8eHwsCeP7eVOZfDzQHNjKJWc
         5pyEfTaNsfHiVps2qrpYk6cz4rvj6ZsDX03yT/pZs2IzTXX2eGFd3mSCqyUe2UYfXAyp
         Cmo++McXAHbGZFKax1SzLkdtSgnohm8exRLPWjOF013SR3sHbT4+PUFLiypRA6gYUb8H
         GigRx04IpQkf9SsK9QSOk3+d85W4wpbmLk3D6z62iTlW6646qfqclxWGekJGYUKx8ft5
         NfoRTpp2Po5UhlL9qoXvN0Tw4KQJ8Y7R+5mbYoi5a1LyMPEnyLFSdkKqq12eDtCmd874
         wPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QSIsP6w+qEHOE1YU732ng4YXzraRvh2ol8TZbSmZYkM=;
        b=LEXPBZbNlo6llndx9yY9lhBJcoVQIUcUvAcu5PUg37s6o/ssbzK16So8kOyAhUcioE
         zImLMDutdWtIqMjSIryBKNfK2hIufAT00XdA/9JaIxmm7E7tj8+F/puLSPRGSAPM2fC4
         5ar5re2kDNT3pYe26UwuGgHlW/CARD8m6J8kKwYnw4wSGe+h0+J5wsJYxv4zDbfXOLZQ
         H3SzInMbtXNJR9oDkuHPouiBRcn+hNkUtTvzMPsZWpf8hjh4bits+Mnfe5WjnMeTCoNQ
         Hln4G+ste1Iim61SYcfNFjOU5d7iCkza8KknznYJLWiJC0/TMlocPM/syrXyDh8p5eLT
         J3rw==
X-Gm-Message-State: AOAM530JEM60lJ8yEzkry7GuPSswGPOtTZzwvTDMv/8iIFy6GNCqMnzk
        wKgVPvezzqRI9BBNtPVvLZTuGgp6w7c40w==
X-Google-Smtp-Source: ABdhPJxyp8tn5gPdBdlEuLv5P4tWZjvz77PDoY/MRJvD4nAvuw/o0BVsVI5KMV4CTt+aH3oTep+lKg==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr3253327wmk.97.1622033318791;
        Wed, 26 May 2021 05:48:38 -0700 (PDT)
Received: from localhost.localdomain (92.41.10.155.threembb.co.uk. [92.41.10.155])
        by smtp.gmail.com with ESMTPSA id a4sm1864100wme.45.2021.05.26.05.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:48:38 -0700 (PDT)
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Subject: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle device-specific interrupts
Date:   Wed, 26 May 2021 13:47:44 +0100
Message-Id: <20210526124747.674055-3-torin@maxiluxsystems.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Device-specific interrupts are handled, if no M_CAN core interrupts were
handled in the ISR call.

The patch also improves the flow at the start of m_can_isr(), removing a
conditional which always evaluates to true, and improves comments.

Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
---
 drivers/net/can/m_can/m_can.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fa853201d2c4..3bc957da06f7 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1033,17 +1033,24 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
+	irqreturn_t irq_ret = IRQ_NONE;
 
 	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
+
 	ir = m_can_read(cdev, M_CAN_IR);
-	if (!ir)
-		return IRQ_NONE;
 
-	/* ACK all irqs */
-	if (ir & IR_ALL_INT)
-		m_can_write(cdev, M_CAN_IR, ir);
+	if (!ir) {
+		/* Handle device-specific interrupts */
+		if (cdev->ops->handle_dev_interrupts)
+			irq_ret = cdev->ops->handle_dev_interrupts(cdev, false);
+		return irq_ret;
+	}
+
+	/* ACK M_CAN interrupts */
+	m_can_write(cdev, M_CAN_IR, ir);
 
+	/* ACK device-specific interrupts */
 	if (cdev->ops->handle_dev_interrupts)
 		cdev->ops->handle_dev_interrupts(cdev, true);
 
-- 
2.30.2

