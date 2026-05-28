Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66D3B1EC6
	for <linux-can@vger.kernel.org>; Thu, 28 May 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961551; cv=none; b=RiRPvpR4doH02rGxfBJZTLNKrdWBODMruRCvQqJ4pbZNLSUJg2UdQz11nF2KRS83TfQyff9W+oYzS+yb5ZiYyPzmlDUAJGfQNOLfqtmGIfmrle92D3/OsRb6vn1TFgVK4iIZ1Wn9JddNgOxjFd4kF307iR/kfEtQ4dn2j0MbmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961551; c=relaxed/simple;
	bh=V13AfRKBoFfWymKdCDI1z5Br/O/2J+tw3n3387QbOCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXAVft/1CB+4ejusTudg+1/pRjbxCwl/c8He+WMipWZ2mEqh8fW1L1zOGgfXd4Arp1H7JJCZ6+HMnwJXaXjn1zxlrmxj6eSOHvB4OaWSfe/WPGJzTrjXSGZsUU6X+g2bQE7bfcd0rjFpph7052srw876TbH5sn0HjBc5CyCPir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WMsureQg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WMsureQg"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45e7c636e74so6687601f8f.0
        for <linux-can@vger.kernel.org>; Thu, 28 May 2026 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779961547; x=1780566347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh6aSIZiiIgo8ohcnAvcWtYuptVBBfGbUMRArMN4MVY=;
        b=WMsureQgqgI+T8zlRE9t+pkPs0nVOkRpK25oKTPf+S4vkuvNnaJ7dLlZmtQS2N67Qt
         0iCWsK0zr5aMRO4Rp2Zc66oLcZOPx57P22MZpPeS/c7pyOnDpDCRtqRS6XGgf2v+ImUY
         gpdrz5eNTh57p97PsOohdcvye5CI85hShleNOBat6pvQGrqYKSYhXloRT/7TuAOkR8LK
         Nk2CSLexvuQuM/Cx37LZdOiXmRxHVS/HIGwVB/2twaqwB3+6Xqax9ZiPF906Ri3/fomW
         rmj29Bs2jtdb0+ccBxfw3nHHFQrXIAgpPuYfymOTV+OZzlfibAfFXlduUkmeiFhp+R9u
         cOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779961547; x=1780566347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh6aSIZiiIgo8ohcnAvcWtYuptVBBfGbUMRArMN4MVY=;
        b=VE9qqIIUAP8KRcinxXrB3rKEiaSfa5l6hC39stdJpu4w9NwAF2nOTSkRoLr8ViaKz9
         Us/kt0sHGRne1SmbC3DiQL0NPEkP5lS5CE0PAM4foxaE8DVpfF4G1Eyqu3xrJvtl2e1t
         OaTpbVgNhys1bpLQ7htiVtcEjBSG3BumhMqzJYxwSLpiHkwt7f9KuCLJhAbHHhxjFrSn
         yuFp2ocmOVGvDOk+mY3N/PWNODfpFT7/u+yPbLPtACXyzlgXqzCRHhulJ46ndUqoqKd4
         iEOca9fRTjIdu9lHAmpx540fpxHrJGcoLdCMsMKscGpO8ztBiPg7hTmQwlHkVnmXSY96
         bPGA==
X-Gm-Message-State: AOJu0YxYwhNIVu+mAoZ5kHCIxWm5pQwzM+V3sqochOulZZdy5obLbvxu
	e1LWX0EqnscTlB99gGjP9DySQgHZMJhFn638ZYjuizOdpULkLsFsiK26UI4OCzPJqsY=
X-Gm-Gg: Acq92OFrAU3BYMGBbNrR4AM5DODzzXyn4tYII0d7rfNKuo4sjqZMAAom8249Ec3jh9C
	+RSMwNg/MboK1L03TEXKTB4ODwnz3CknI7VUb66CCmz1EeB1SbM8ZpBIwfc5+lV9LUJy9e0fsCk
	5PhQnwJMfHolh87SolKDsYwjsP/UYQVKhgzy2QnnrHx6eh9ELbFTGrRDkr+boWc3UEitBQL3M5H
	Bq/0ZQCClM+4T6TKwFbIB5bNxcpcSJvbdMVNsEaCpq4PFY/Dg2fSHsJBghatSaTJ20PmBV/HMIv
	eowOtQ+KuqXIgVUL4mPmnEDx5g9tzSksZpOiuH+LHcZxtQxBFlzCLCOucJyCaMzBbqGyMClR9S8
	8HkGwEVC3Uw/4w/eWvc9yzv0nuH43E8XSFeT90HJsMgk7wfnqR6nKz2RB6mnpGeUF3o+r+veFf9
	EP4uqzLZQvQQkLK/KJTjyEQ6HTQiKSvAtCgLQ5uOjlXtmYj/kqd+oQBZBQ/FKzymsxrkz346C31
	H0xQG0S+2YiI2q3AfK+iUV5HA==
X-Received: by 2002:a05:6000:4b05:b0:452:c9f:4b91 with SMTP id ffacd0b85a97d-45eb367f6e7mr41451950f8f.4.1779961547141;
        Thu, 28 May 2026 02:45:47 -0700 (PDT)
Received: from localhost (p200300f65f47db04e95e43453a0d1648.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e95e:4345:3a0d:1648])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb5b314dsm11510561f8f.30.2026.05.28.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:45:46 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] can: flexcan: Drop unused platform driver data
Date: Thu, 28 May 2026 11:45:39 +0200
Message-ID: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=V13AfRKBoFfWymKdCDI1z5Br/O/2J+tw3n3387QbOCA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGA7EkaqACZXilClx9eWgJ28cjRa813TGq79hT QDff5lCWp+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahgOxAAKCRCPgPtYfRL+ Tm0WB/4s96D1moX08qH819PyesNSQ/XkDxeJhj4TuMiXRl2AeSdT6aoBHmyqGuB/6w0pv+OwDj+ NYCyJgcke3j45TyozVXc7nblD/XzU3IEmXovXaP1MR2t5egfFSyDUl1LegeqH6gi9vTYHP+b/ZF joVtmPN8fGETe5+08hRQIEqzVO8nqPHdgutQbL31eOQfC/wpxyssZAqeUrbmIKYygsHsfa4DHCk N9ljpcu2MDAf/kSw6Ixq4UOMr36fCOzT4X3H7md/wYTgbTVNj0ZIiT2NVCZt3dQvbni9iL/YDyb 9cVyShyUxJcCU4wEBKv/6z0ixE2dmU9YEdUVxfmcSK3xjRKH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

No function in the flexcan driver ever accesses the .driver_data member
of its .id_table array as device_get_match_data() returns NULL for
non-of platform devices. So drop that unused assignment.

While touching that array, drop the trailing comma after the terminator
entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I found this patch opportunity while working on a cleanup quest that has
unifying platform_device_id arrays as first step.

Best regards
Uwe
 drivers/net/can/flexcan/flexcan-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..1871def90fe3 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
 static const struct platform_device_id flexcan_id_table[] = {
 	{
 		.name = "flexcan-mcf5441x",
-		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,
 	}, {
 		/* sentinel */
-	},
+	}
 };
 MODULE_DEVICE_TABLE(platform, flexcan_id_table);
 

base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
-- 
2.47.3

