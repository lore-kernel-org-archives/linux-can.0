Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB244C433E6
	for <linux-can@archiver.kernel.org>; Wed, 20 Jan 2021 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBAB23381
	for <linux-can@archiver.kernel.org>; Wed, 20 Jan 2021 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbhATOij (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:38:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390380AbhATOiY (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 20 Jan 2021 09:38:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xgX7YPXzNS9rb1w3IpK/3aOUFtKLDljIQ672WlmTLU=;
        b=BJ89Vl2NW1T1s6jYod39xoXuxBMUgMGzQdBM1TzoYHskV3GBxiOQ22UKFOloaxnJjwG8L5
        UxkHzeAsiTDDmAPp9b+JtqSWRE98Eq02J5OWvzorK8iP1oSZq4r0OWfOgv/ULqbvmuuG0R
        gxSp/JbohbIGLlUCV7+Vr/HcImgak48=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADC81ACAC;
        Wed, 20 Jan 2021 14:37:37 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     ltp@lists.linux.it
Cc:     linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: [PATCH v3 1/7] API: Add FILE_SCANF to new lib
Date:   Wed, 20 Jan 2021 14:37:17 +0000
Message-Id: <20210120143723.26483-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210120143723.26483-1-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_safe_file_ops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 894c16123..ea8f89263 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -7,6 +7,9 @@
 
 #include "safe_file_ops_fn.h"
 
+#define FILE_SCANF(path, fmt, ...) \
+	file_scanf(__FILE__, __LINE__, (path), (fmt), ## __VA_ARGS__)
+
 #define SAFE_FILE_SCANF(path, fmt, ...) \
 	safe_file_scanf(__FILE__, __LINE__, NULL, \
 	                (path), (fmt), ## __VA_ARGS__)
-- 
2.30.0

