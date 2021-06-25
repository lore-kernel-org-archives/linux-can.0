Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD94C2B9F4
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D373F6142C
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 09:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFYJrR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJrQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 05:47:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982FC061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:44:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bb20so5145455pjb.3
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCjHgfRpBr5GpP6XzIF6y5OhARZdM5AIUwApYAhTTMw=;
        b=fLysygqSiqQ7iA7/9umwn7sqN9BFZoXhlyteSlil42Uwi6lVhkh9hT4qnNiwdrRBRj
         We1kLy+GCRrRNz0wMod0unpPNzBTZ3YFILaQ4b7D6ZSYzE8RWYyk7zZwP5s7bFvn01yA
         acNR+eSKJTTsihUslDxYtq+uOErmAKpbp12qcAgCmfG8Yy91Z5ITpPmJmjXZlfaRLnJF
         4N7ugillbGJoSjmC8n6k2vRBpnaM411RetkXLopFUk+ltXhUmttns7Z+9c6CdagOy5B7
         ay5GQbZg3xUTY0VfMOTRYoVLGMvlskQ7RKz+C+lEB9RGrurCthaXXtmk81W3JZYnb2PT
         tWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCjHgfRpBr5GpP6XzIF6y5OhARZdM5AIUwApYAhTTMw=;
        b=jYvauALfO5Fp7GisW1zu9Kp0OREX1O9pJ9U++9iHHd6qGICVdPHzK5/LJcixaLAgZe
         9NVwDcZcaaeJBpN+drHQe9Lxv82PP5crH6TUvz59e2ux0FIl/RbigOGAAi6g/WejFr/6
         yKWjtGy5Iudgw3pmkBkzKY5kl5E3xBOyQbmaYUlzMCernWdfhTuG79TRMxflqsx4wXbn
         QdAFDnLRJF6Qs6CV83YWo2rjfMMS25Hi4k2lt7CfXu501jUheq3zzM9f2Oi1dvoLW9d4
         JuORfMzdBD+3xdggLMsxDj+f+KgO9jy1Gok0Ye2rINSuN7oWs/n6GmSoWpoz/ipGWIfC
         qoyw==
X-Gm-Message-State: AOAM531mN9C0U/rN5jZGtv7p3ToSZgmTdEi7N4oDYgvxAZQekcFCgV/l
        CyGa4DcffkoOEwZSJPOq6Qc=
X-Google-Smtp-Source: ABdhPJyGpP/ecsueKHG1Rj0J5NBFEgAZcWyY5SSLXMG+tWKU2P4sZAzMMEhvINkB4VepgiN6WLu4Zw==
X-Received: by 2002:a17:902:7046:b029:119:fc9:e42b with SMTP id h6-20020a1709027046b02901190fc9e42bmr8383173plt.78.1624614295601;
        Fri, 25 Jun 2021 02:44:55 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id r4sm5162456pja.41.2021.06.25.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:44:54 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     wg@grandegger.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC CAN controller driver
Date:   Fri, 25 Jun 2021 17:44:36 +0800
Message-Id: <20210625094436.13184-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC CAN controller

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a2b4463..e96f914 100644
--- a/Makefile
+++ b/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
 obj-$(CONFIG_CAN_XILINXCAN)	+= xilinx_can.o
 obj-$(CONFIG_PCH_CAN)		+= pch_can.o
+obj-$(CONFIG_CAN_SX2010)	+= sx2010_can.o
 
 subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) += -DDEBUG
-- 
2.20.1

