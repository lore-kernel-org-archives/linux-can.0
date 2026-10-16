Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F72453A29
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144662; cv=none; b=HmBCK5cVA3HT1WWP2ar/re0aHgc7T1TxNRsyBL42BHncrgQl/KlsxWFJkmw9/XOpSYGc6RBZMcd08SOX9rWb7LLf7iRedsctJPzk7bC0wzuGwW4WHCAzxg5PExhgrngepZ0rN6tcymB/u+ux4/ZwnixlmqjBagIMKkJltm+126c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144662; c=relaxed/simple;
	bh=+BflU2elRp/oOOYEKmuuC9afcLHCdlAbti/foe89B7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSzUV2nb+j+xgDIGS92re0++OZeHS/gZdB+0FsOamb8IrJzK1XIet+2kq3h4dioxc8eTc4yp/uuVP49SNIpt9OKy6KOVGHe58P2yPAGmTnYfQwEW1bj+c80oXAbw0MOQP8kg7J3tmzFdAD4ZR+AqKe5o/slw98GpsCeq8mNCyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UE4aUDQm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UE4aUDQm"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso26405965e9.1
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792144659; x=1792749459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DiJVS7Kj+4kCtaotoRvvsXd8ocn4YftmsuQb/0Cmybk=;
        b=UE4aUDQmsvk9jIXoSuIlSdMWRsCCxYfprVH6HwykuX434TusKQ7hNgBElJc8nNqk36
         xUxEH1IGglpkxYB8AXV0GG9kllnyy9XC6tURn+QgJV89FFP73Gm8dC3K+k9nL0rDkXa5
         bYmy1GWtI+8kNjRWfxMGMoHsmOjdaLTt1H1ErVlhRO/kOdALDIY4VgepDWcAwWW85MuW
         IHKON4bd2YQun5UIEKFPqHVetm0Eyox5L+fMUGwV3LRqablJ1jQ8CSOHdGwUWkssJC2v
         0mpoRocrX+7a6++2ptGWbFMR/xl5Xgc+Yz9V5nMpc3NGBMHijuDtaPTKQMUrNMPPO16h
         hfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144659; x=1792749459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiJVS7Kj+4kCtaotoRvvsXd8ocn4YftmsuQb/0Cmybk=;
        b=ipGwEbJ3YiExFwW1JaXpcwHhnmPJpKDYkK7aETsiCa63UHr1278gXc570L5/KV4IoO
         FD/mawjM7tltfwCd97iaHypAlQBF3ucDsWfjd0aIe3q8KVbksrT2ZnAQDK/zrSEnOveK
         FZIIk7gdUTjlwVZ5rGu4z4U/UgG1XvAy7ROylGiubG6YJUk8RjrZ+Lg4/NsPXHgXNbvE
         to+AzPkevCb036KRnEgEgssKqrf22hRPWxj9umsWwse+JU3/UKJopXkBvpzv35H3AaCk
         NnJQTFnpvNvHriDX8Pd+7vziUVILInECYJXCCoQavyf91PkfaHLdr62Nq7G+14IL25dF
         i3CQ==
X-Forwarded-Encrypted: i=1; AKwUvByCsVrWbNaV71hGb0+FDVbNQFl6CfK8MhyYYE5G1liWZO21qdjKIHnwJimWT63qZqHTIvsz4Xlpla4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJm/PaSy1ZMpgkq5IX9eK9ZOzCdJ4IoHABdPLVFHa13mT03Rsaw
	bz9lVhTnLgo/J0TAsG0e4rc97ipTshtdI9AW0cz7FER+DnW6UDjbQv37a2aX6/1cxyw=
X-Gm-Gg: AYBFou0/CyCqr8ZLY7J5n+VlwEruIflUAZwPEZYanoJUrKllbtRMZAVRNw2CdVOZFy4
	e4V+Sfrj6EKiClQLnqfwWWBSgB213UP0YleGdy2esKRuM2Qb+9bXWMDa8QvwxN1t5Muuq1/7D3z
	JejjbEVdBGlLcLN6wu4QWsIFdrG/qFR1pPiWQfZRd2BkUrjU89qlfYqBoV440V2fnKL7ONxyIAZ
	kM8jhTbFGCSKmpfxA6He74n9l2YmZ0qvjVss3NTstRWK9twqZz2gIlXPmOUVtdcxVuSQ608rs9k
	hhXItUGr4MNy5DsaEs4Gbtjk7eFQmuZYzpTy7es0fj6QLG2t8ohwVtwxSEAy1z5fjlR9/1D636Q
	TNs3rEso7gtBGmCI2YxRUXJoia7xyjk1mUIlVjiQSssx22oFQFMQDMmoL/3MWq9s6bLGV2st6pm
	csrlAo5vjbcfz9CqJAlh4wmEH/KncyQ0fhQnqwV6fl8s4sMruoa/Ui4ZeifLTYLU3qkIo=
X-Received: by 2002:a05:600c:a4b:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1af68d397mr229417145e9.2.1792144659190;
        Fri, 16 Oct 2026 02:57:39 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b8b5fsm149819965e9.9.2026.10.16.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:57:38 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:57:13 +0200
Subject: [PATCH v2 2/2] can: tcan4x5x: Add suspend error handling
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
In-Reply-To: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+BflU2elRp/oOOYEKmuuC9afcLHCdlAbti/foe89B7E=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLXzk4oj5s2TF7h25KyL0daVGnWhaIdJ81/vBuf6yeR
 hBLtdy5jlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZgIXyjD//x7FjHLtyxbrP9k
 t56BdJjv/fbdHXO2MC8rP2D2s0Jw1TdGhl3faw75fZYTrIpn3P6ky0y2Jz3on/vVy023RVplvv7
 4zg0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

m_can_class_suspend() may return errors. On error we should first
restore the previous state and then pass the error code on. Otherwise we
keep the device in a misconfigured state for the running state.

Fixes: b6b640c04446 ("can: tcan4x5x: support resuming from rx interrupt signal")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a5b8829aa519..b69312413d62 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -575,11 +575,20 @@ static int __maybe_unused tcan4x5x_suspend(struct device *dev)
 {
 	struct m_can_classdev *cdev = dev_get_drvdata(dev);
 	struct spi_device *spi = to_spi_device(dev);
+	int ret;
 
 	if (cdev->pm_wake_source)
 		enable_irq_wake(spi->irq);
 
-	return m_can_class_suspend(dev);
+	ret = m_can_class_suspend(dev);
+	if (ret)
+		goto err_disable_irq;
+	return 0;
+
+err_disable_irq:
+	if (cdev->pm_wake_source)
+		disable_irq_wake(spi->irq);
+	return ret;
 }
 
 static int __maybe_unused tcan4x5x_resume(struct device *dev)

-- 
2.55.0

