Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C35C696
	for <linux-can@vger.kernel.org>; Mon, 31 Aug 2026 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788153639; cv=none; b=lvifoQGztBOuA9j9TEUeQT3xJDdX3lrYOjyVf6IDXMGnXgYW+oIJ0lHXNRo1kNNTwjZNQAi0yDIsPjkdAW9HeOZviTv8e4eWwSP87JEeb1m+gupbf7R3Ox5h37kPoNW1sqzMGdYSEfcHo4IjKEliorUTmmFJQvaDQJil7eGJNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788153639; c=relaxed/simple;
	bh=6bjycwJwoHTgtM+LiOnjD0YbOiOU3t4LuNN3XpnRkUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE9lwTLywvlwmMtbqURxiVsr2qm6cv9AI99wSJrt2bZz81ukRTfJmJ1DG5V0x3kUqtR3xROJGH0I4FO7hE0ZfSfY50adyE0hsH+FqGnLPDKYchnVZvLJ862nYupvnBebbSOsa4M3pP9I8hMwnoRInlHxgqabWbzyd6pOZ1h3Tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bERpR3M9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bERpR3M9"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so2787399a12.3
        for <linux-can@vger.kernel.org>; Sun, 30 Aug 2026 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788153637; x=1788758437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=svT7/2yLoNCYGafpDjiaochGPtkcrMvh5TQU74Jif5M=;
        b=bERpR3M9jwni6LHuaDbrEgZhK1hwSjufhYlhQB1hrd68YYf9aJKVfkIVRXpRRQ0uI7
         ZgPJcZkh0FHxrgsGdY1QjHrZRzhhQhLt6M8Eg4CONWZ8a6JonHhT+EQ2kuAey43ydgO7
         Ao47jHg1trqjsoW086MFgGAMAiLtip+BVG1noqnyyxSwq/Td0tjLS/ODBhC4e0cFKWCD
         ZFZuUvaEfDNDtjjLG6XJ4q2nuiuY/Rk6Q4fTwjNd9wKc7sEB8LLiGnDZAZpRb91wa6Kg
         vGUBF+07yrJgNQjI/f/bU/ioGNuyub3BdHgHJ7j5AX4VNfaB5ckY/NRRO6TVDxvBM7Y9
         NCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788153637; x=1788758437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svT7/2yLoNCYGafpDjiaochGPtkcrMvh5TQU74Jif5M=;
        b=DvRNtidibUwI9nmjlV3wnoBMCnWmQiIIV9ilgM1c9K3jmHQZon4fe2Xxn5SBRlOZvZ
         fIdolsKTuo325FY3fcSo8lmaJpKUJwpyLyul94htbxjkcde9lr5fnmWU72u2vnOU0IqV
         Qn60TsQxHNwD+t/BsXJILXjbBD6XBm7vQETID5CGzhdEntYHWSPNsR+4Mp6t6m+eJafI
         MjYHjE9CSSGZOaI0+axs0SdmA2Akph5Yg13Eo7unKqc6B5wz2UYgLmwMd6r08ejvaGWg
         v9hkWAcSnV2trL3rNgFXeaX/XXjBLCUhArgHc/5b3CA0sNNBuBlloT08L6ZXLkf/zVPF
         B9Og==
X-Gm-Message-State: AFuF++m8sCoSBELtWwNuadXyG9yQ3aziD6RXYFYDMbhzesEXKPTlgBAH
	EIoZra6twxiyATNG9XNwYxsgdPS76Hfif/PTAJkZdHtyV00xOIBSiyuH9cvd2Q==
X-Gm-Gg: AR+sD10IXIpkTXGspfkKjae68Ph8k9S0oDS6vHrlhuXDqFM5rihdaL68Zx7w4lXCrcv
	eU2kui6oKE1dAaMgOYNn+ycTUNAvZypUefm6zW8NXIl2CGPacH7AeFPkwHwzM3maM/I+fgXo1iY
	JLXocztje7DFjupPHkxUyh1VdxA/1WUBqQW11r/APSbz284NTtWcOpSADN/RjeeoUPgWM1TTXV6
	TvZZN+6ym9RnO1ttWTtWCOu+wg4M7yR7ncPl07Gf/nT2AY+KcnrXe7hPXlb/yh6FgR+T4xHLKaA
	AZuEbUvnHVK+7Llduj7GgJxvtD4dNqzpXf9lPgkm9XnZYH/MbeCOJsdRqdiouisr1wVgt+6mFMN
	gxIT3D6AdXlzU0J5mqDyuGGZ2uFjLR7kapEPApXC+/yJKoTO5v+iOKv1hMWLtRUseWnD9txmQlZ
	FYI6sG6KZuPKTIpEteyekCIfZLuU+rjnCVS2rcG2Mx7NdEWa4zhAXNhg==
X-Received: by 2002:a05:6a21:a346:b0:3cf:ec52:ce5b with SMTP id adf61e73a8af0-3d26819b3ccmr42325703637.13.1788153637148;
        Sun, 30 Aug 2026 22:20:37 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f66e9sm3418147a12.4.2026.08.30.22.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:20:36 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH can-next] can: raw: remove redundant NULL check before netdev_hold()
Date: Mon, 31 Aug 2026 14:20:28 +0900
Message-ID: <20260831052031.902699-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_hold() does nothing if dev is NULL, so the check before the call
is redundant.

So remove it. No functional change.

This is the result of running the Coccinelle script from
scripts/coccinelle/free/ifnulldev_put.cocci after commit f83b8a58695c
("coccinelle: ifnulldev_put: update outdated helper names").

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 net/can/raw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 82d9c0499c95..e1d05a0341eb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -525,8 +525,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
-		if (ro->dev)
-			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
 out_put_dev:
-- 
2.43.0

