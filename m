Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108048;
	b=ZQYBUvzBznCgH9QHmO+geEqcvcPLXoa2PusLfssUWGAPi5aQI/wnT49Vst+y6MsuuweL
	 dk1xpl46y63ZBUPuo9XA1yeVp1X8u9VyDInIzxFi4+ygPgNxkOvSHfb6sF3b5kYdwpbIZ
	 nLeFNIp/4qUjhVFn8KyRweNxqxze9rZpj9mEa5m72P4vpD/H681AGwYBeUCFYp4kyNdVE
	 ZM5ZSJOK+rb0Ny/l0kVOKofrvm5pKL9I5ecVOdHgkBD+4i4vWdFNHHze47wha1vqGFt3G
	 gkGMX7gvDDxAwYoIGJjTTbwhqE6euE8ThbwskTa68YaQ52i3wB1wyVcBnpsMQ8DQviQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=CPSkT3mQY7L20a8r35/Y3UAKl++Ut888ubg0F2YWBeY=;
	b=QycLfPvLAfsPANQYKacvwhtuhdQoGv1K+c9JUBRr3f7J+7Jh/mcDe43q2NeTFg/v+fMo
	 N+Ohqstp69CGVpmY+srQKVMQbLgEXgi8wiPXYazG/i6QmbyhW0u7vz4irSy6y4p3iy5u6
	 98Q09eE0hHqjn3g7eTk0U0Y1ZIzkrlsUu8v5NXfAq2+3hoWW2gdBE+F413QEfP6SMLvq/
	 sANZ3+MujfU0mR6EGmY4cLcNsWCabYkdwSM21dmtypbQ1lc/DpQpsByDumS1ai6wSFtPI
	 Lfi69Eo0exG5QI8xKMclffMZTf5h3d8ur5dNVQdVu595E6CUOw6cTQL4rFSNQ/sPQjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oQJ2zRf7;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54376606A33A
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 17:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54376606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oQJ2zRf7
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so3660401eec.1
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795108047; x=1795712847; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CPSkT3mQY7L20a8r35/Y3UAKl++Ut888ubg0F2YWBeY=;
        b=oQJ2zRf7WaeJXxKVx8+Ci1prOzbFnjiyzDxmPKQ6slH141x143RIZISqaQOa4oT3rP
         Yab/eNteyL55flOnj5vp8iAIEx9d/Kh4cX9ML/WMhElGYEYm90MmEs2+4hLN3av06Oz8
         SM1Yp955IKP70oO5LEeLMyZZeI7dDmyeLaoZ7El3x4c9jQru3NMg8NCO5WpBgY/QQSlG
         +f6tPV0uW2jqEdv/B+IIOINbv929d4BttYh4k47BH3cn12pj7n2aP2rg6lU8hxmKoSuL
         04sdSFG8yV+RbNrJlyMieONaW3K6N7eFer5g9XVGIZsNIwtIqgMoIg/MlpKsOrXj5tg5
         JHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108047; x=1795712847;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPSkT3mQY7L20a8r35/Y3UAKl++Ut888ubg0F2YWBeY=;
        b=hfKFtUoALMQLE3SHHLqw2v+OTrm8TWns5KNShJO7vxiVfALlWIdjD2Kk75692m/3To
         Fgs5s+6sFobF5yEJkL5tYACcnjWGUPhB3hLKGJXR6zgr2Fpiq3rSlC7pIfCvKG125TYP
         3DSkuafGLmZlDOLHL2XB2pOuQ6QPbnAVOWqpWXhkXcMMtunr9m0e4VB0FaDbcE/8P5WB
         iavan6s3DuLMERbTTwPr66/HgfN9uHyFpya4jaWQQ49KE/o2JcDSNyurVUNIzl825zvg
         GkkypSJKmx5p1zSbsZOWLUSLMB5hvKErJRiEbvgE1a697nw+Oi2Iso7BEcxXgh9oKWw5
         kaqQ==
X-Gm-Message-State: APuU4Z89s+jyNSiPciMHVDlH+NIQWMFrUkmx3Zs7hgYvRP1Y9ZLG+tkx
	REjB4316MwqjO6dqw1GmMjT/uHG3cCQ22SB/gLgRb1eYoZvAD+zn4N4S3fC0aSBesc2ER0JM3hg
	6IKR6IwCApA==
X-Received: from dybmd48.prod.google.com ([2002:a05:7301:1830:b0:376:93cf:d6ce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3f16:b0:375:dc5b:4400
 with SMTP id 5a478bee46e88-3856c5b52eemr19829eec.1.1795108047106; Thu, 19 Nov
 2026 09:07:27 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:22 -0800
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170722.1524088-1-irogers@google.com>
Subject: [PATCH] can: softing: lock card->fw.lock unconditionally in softing_card_shutdown()
From: Ian Rogers <irogers@google.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

softing_card_shutdown() calls mutex_lock_interruptible(&card->fw.lock)
with an empty if-body ('{ /* return -ERESTARTSYS */; }'). Because
softing_pdev_remove() invokes softing_card_shutdown() before
unregistering netdevs or removing sysfs attributes, a pending signal
while card->fw.lock is contended causes mutex_lock_interruptible() to
return -EINTR without acquiring the lock. Execution then proceeds unlocked
through IRQ and DPRAM teardown and calls mutex_unlock(&card->fw.lock) on a
mutex not owned by the current task.

Use mutex_lock(&card->fw.lock) in softing_card_shutdown().

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wextra-semi-stmt enabled; fix and changelog drafted with an AI coding
assistant. Build-tested under LLVM=1 W=1 (-Werror) and -Wextra-semi-stmt;
not tested on Softing CAN hardware.

Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Fixes: 47fa0336c1b7 ("can: softing: softing_card_shutdown(): add  braces around empty body in an 'if' statement")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/net/can/softing/softing_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 519ab3097f86..d3dfad4f5321 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -448,9 +448,7 @@ static void softing_card_shutdown(struct softing *card)
 {
 	int fw_up = 0;
 
-	if (mutex_lock_interruptible(&card->fw.lock)) {
-		/* return -ERESTARTSYS */;
-	}
+	mutex_lock(&card->fw.lock);
 	fw_up = card->fw.up;
 	card->fw.up = 0;
 
-- 
2.56.1.708.g77570a6a1d-goog

