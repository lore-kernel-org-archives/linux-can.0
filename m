Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549C3D0C09
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827488; cv=none; b=dNDA1C32lbQZEbIHVvuMn4qS9fjmKmtALM8dy+rNHcQFTM/nzMdZ+pDb3XASiXxAJQNJPBmbARUyzOkLw6jtEnQaAEzOCm+6Bp9LR2Ul1JmwWRMVbXOQ5dgT1skKzR5sAN/ylvctwmNg3qb1smTjS36rw2pZnOuHHvKoi2/1J0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827488; c=relaxed/simple;
	bh=l0XTIMkKqN1zTE6zpDaySzAYwNEEjSWW841rF1IHlzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaVy35BGKnAi47oA1erJfmJmOmkcYgNrwgWhc1lG6UtakxKydgyo8030GxdGrCZANqyrceKvA9pwPUvDYLW0CvfSyfa1knLagdnrgBC2mbNfvKyeEN/XRj0SK0D/XC1EuxAnnkz7pl5ZUImk5vALvdw3YMk1czZPhxlRx5DsWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHp358nL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHp358nL"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso576333f8f.0
        for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827485; x=1783432285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmtMFmdutnbR/Vf/MchNEdAZUmVTy7ZFFM6Crcn12+g=;
        b=nHp358nLX8xU9/n2gs/I9pZR0TS8AVR1Vlo2+bUmmgMjHCLe5G3Scr8nR+lDIf3K8H
         xMebfEiSJF727vSrUSlBEwNEBiAUvBn3m/zoJGeHlmx/bRObiwZf5G+gGuhSSOyw1mNr
         UTFgypV3diKgFSvwmMQvk26Td3iSdQ8crTQwJF2CCWL/KusQpgJEUPDtTlKC+zsEIMll
         rmd9WfYpzpFC7UQQ6iM8m24Jr2ndSmgUeEVlXLTYmvlvQf4RXetEPrKyLzQ6ZnmkyWn+
         4sHrD1b6UnyTVM3FZ6AO+51Xay/lW74cg7Hswf52X2Gbh0Yz9KZuBEEJ4MvWcDUtuOGo
         herw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827485; x=1783432285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmtMFmdutnbR/Vf/MchNEdAZUmVTy7ZFFM6Crcn12+g=;
        b=UNIZK76j/2hPv1vU8FIYY/rBNY6Pi8Tkh+2Q0keSItGRXFZBrTGVnnPFGjiW29FJtF
         ZZfOFqJ6QcGf1thKKjk2Qo0RvMoF4d8BORRBI817NUezU9fCj6NihARtka7ez9xF4ggk
         eCc8ZZzCFKDjFowBG54vt3/Rja6iCgK0n/sMXOVfe4/wjRdKULB7qCAV1b2cAa99pEHX
         BiqUEjdSO8pqNJUD1NmcD6EarYB8yz0s+L0GvOfu/+AWMEN/AbjXJYRRUgFhsOSEqXLc
         IChPmu7kiGl+mIS7vjkblfku7sd76ubTqGilnISYsp5N7XXebX/494xFjb4Xh7qeeUGF
         9whg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm3LeXTH6lX4gkaO5RFjJ+nEoygS0WeBLiIcEUh3DHBj/a+NlmV9PdcWNw+4N+6Gm7GfIMx/PQZAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBobuK8gQ54F375sdVMptPRo0VaHQN4ldxT/TxOthSpBW7kx13
	dMHDDtQznkj/y3nV4dvtxmmag6xZTHaMww5ndv9/fP4Jn3io72MoqAdI
X-Gm-Gg: AfdE7clYp6PyOJJqpw6RYE0Rn3F6wumBBAgNhw1mSeDFHYfHYsNQT95yZfUUsyHu41n
	AkVk08gSMPzU/4FQBFXmt2SL8JXAvgSHhDOQqfr1zHx1h0ysTfQcNOXQmBjH/os1LkqYvEvCZRG
	yAV7BIxgwcaWV7VVurOuUtgNYUbP1P/1G2NwnaXwQyrXdoLQNWkN6h+j8hVzTt8UG7ZVcqBNfIM
	5pDZ7jXfx0BTnsKSyYWbIspg5L94YnEXXY1BCPFjKyUnx3y2xpwbGOI003h+NXYcZKjU9xKMFmO
	WX1HXrzXtniE9McKAkjNP39egqM4Q71oe6soJ5UvAxAbuACf1/DE6cWR0hxcFLPOgRz/vme65Ek
	A2I0R1Nyn16gG9XQhP6KWtCND6Ili2rtSoR6zpfCnqBpumDP8GRkubDVEDdB+y3QSP1rs+FIGO3
	x7qWpmX372HFItc2Cghq3k+4RdJ9T2ad8GudZ07g==
X-Received: by 2002:a05:6000:e4f:b0:475:69ce:ac4a with SMTP id ffacd0b85a97d-47659ee671amr755903f8f.33.1782827485050;
        Tue, 30 Jun 2026 06:51:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm7216964f8f.19.2026.06.30.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:51:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/3] can: rcar_canfd: Fix double-cleanup and unclocked register access on init failure
Date: Tue, 30 Jun 2026 14:51:15 +0100
Message-ID: <20260630135119.104774-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
References: <20260630135119.104774-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

In rcar_canfd_probe(), if rcar_canfd_global_init() encounters an
error, it disables the clocks and asserts the resets before
returning. However, the probe function then jumps to the fail_mode
label and unconditionally calls rcar_canfd_global_deinit().

The deinit function calls rcar_canfd_disable_global_interrupts(),
which writes to the hardware registers. Since the peripheral clock
has already been disabled by the failed init, this leads to a
synchronous external abort.

Make the rcar_canfd_global_init() failure path jump directly to
fail_dev, skipping the redundant global_deinit() call, since
global_init() has already unwound its own clock/reset state on
error.

Fixes: fa5f4ec8fff8 ("can: rcar_canfd: Extract rcar_canfd_global_{,de}init()")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 57f1710caa89..e88554388553 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2257,7 +2257,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	err = rcar_canfd_global_init(gpriv);
 	if (err)
-		goto fail_mode;
+		goto fail_dev;
 
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
@@ -2275,7 +2275,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_channel:
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
-fail_mode:
+
 	rcar_canfd_global_deinit(gpriv, false);
 fail_dev:
 	return err;
-- 
2.43.0

