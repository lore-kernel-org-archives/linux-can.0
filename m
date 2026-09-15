Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E553BA25E
	for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491820; cv=none; b=Em2TJ/dP+ICD7ZWeVi2TtHSAjbypgubPg0nRrFZAohWcpDlb2VccLiMA9wN5brr4bgnYy/ZPY+OSw4sp1qe8uysO6IGMw26K+SUpthrRBwy+HQzk6TjwoVMnL256i8wrbxguT+TVdiDanhWMFEWiOctXsdRVBIzDZZLs2Ivf0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491820; c=relaxed/simple;
	bh=hTEjC3+A998jnjtbDDPcjkqe+ykFkqEqEeoFsWgMQCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQDKfab2WNIYnyOXp3CWyuaOc/GB6YJzpgAIvXTCm7g84RbDemrHVzaNqXdwDPI/cu0BVWUtmqVQJItHc0E5+Tzo7b09sP9LEMz7owP/98N3O3rmd4wcj5AmGtOPxZwFhzceYDIICBosHfBsXG33ZXnVgSqFFZXViB6lJireK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Vi6A4F; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Vi6A4F"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8674704dab1so614411b3a.2
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789491819; x=1790096619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1+3zNA91lWe4ktM0AiO1FGkZy/aJNB7SvOgCysQ3Uo=;
        b=b6Vi6A4FRRGfF0p2PDmJyHNU1Nf6oRYW2V22+AhtOutzDMiTEVSdPpDznhx1QLHY6o
         YXx0GH34mloEG0Eg5hmYpJwbLOMCmVYhGF06kXplkGSbspkyqt6dErk+X7tOn/9OaIBA
         0vCLEIiybxse8lhh05bUqfpeqeoSMaeXk2kSOhzkXYkhuq8OHaMda+TxYRJhpUIJTYkG
         bxVzwrWudUNs0MxB4T4vFPLsot8Uw8Z2Ap2kZdTnLmjBjcbf9lpuHd+0ub++35N9pQmL
         5rJiL9fCNpc4lD16gmdxSg12fliWG3lVgchbqVsOxVQXHBpIZcesQZz1InMRDc/QY2l9
         6X+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789491819; x=1790096619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1+3zNA91lWe4ktM0AiO1FGkZy/aJNB7SvOgCysQ3Uo=;
        b=f0n6MxJGwLjtdvSEtFIsHeQuPAePHUeRgYH0/L3+hxwFjpxnvLNEVYxHT6bk2I7Lct
         TCZrSJ4d25j3E47CTz4VTjikZlaJ8cvbDRrQyLLCaOO8B6GXFlr+jsxTvcszu8LF/686
         5uavqCLi+kk1bdsCAOaVBHRiTeDxCidwGp0da/8Us+fep3bD6PwsrzL9I8rSzQNwGWpz
         C8hA7DeLrgobLsRsKg/8yCfDxUpLoWIzV5DaoywfZUiVUpzCJ5CgPW+Gi+5vYuE/wLr7
         lkFHl4jiI3iT1DwoB7O7U8hrf3jzrHiD+03lRIyeUnlTGkK9FwdszhdPl+FXkvFIbG03
         H8nA==
X-Forwarded-Encrypted: i=1; AKwUvBzYr1ApOLIKNEDZCtSLCbYv2+2EJZL/gFWbrDjpT5qZfFLrH04IbIO7EGMHNL5xSs++KWvVddUJxlo=@vger.kernel.org
X-Gm-Message-State: AFuF++m/eU8gt1+gFCr/r7oQ9aHyguhqwl6alF77HZH3UEW+MXJJ3IQC
	iYrUV8G5UQo9wv4S7ZxNFCMxtvu1YlQiE1AMBYqMP0/f/RzpKVubYptG
X-Gm-Gg: AYBFou0vouG2s2itmbWUY9XCB+85N+ATMlEts5j0hijJoLmCK/1ClRnfbo2Ermd4qP3
	M8i2+cSbKG/+1fcN0khevThw8+xinQfmIM8V03ol+fIvF3xqQREOJ1lr3/DGRntdRUYE5P24j7N
	Q6vLVKYQlOom8l7OiBcRYH9l6UzjW2h/oUyxLr9N7zPfDLSYmvPNoe+J5mJa7e6QqWrJhkiUUgv
	pFhnD/5NiU4tTtO9TcOXQlzC7QFAdXNdR4kxtXb7xWlvaW5c+QkcJ4ipcn6AdDRbpMAcvdtzkbU
	UxmEsa76I7ZOBLGoolhbsIfKku00xpym01VoaPPh1d8mdTF/iwYfBm0KmouGN72jFtxsjBz5jOD
	b4J9cmSSfoz+cP7Cd7zSbpQGS4Ue4WfE6qmWNesJQP/cn+fCv8ENyqw+84QiviZra6ex5iJG9R/
	q5Cvo5gNJPH2HtocV7MEQYoMCBOiJNijRPVbUCgRRAvLVLQDiZXN6Pew==
X-Received: by 2002:a05:6a20:431b:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3dd5285049amr3756830637.12.1789491818809;
        Tue, 15 Sep 2026 10:03:38 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm246392a12.32.2026.09.15.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:03:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] can: flexcan: fix runtime PM reference imbalance on probe failure
Date: Wed, 16 Sep 2026 01:03:27 +0800
Message-ID: <20260915170327.2503156-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

flexcan_probe() increments the runtime PM usage counter with
pm_runtime_get_noresume() before registering the CAN device.

On successful registration, register_flexcandev() drops this reference
with pm_runtime_put(). However, if flexcan_setup_stop_mode() subsequently
fails, the error path unregisters the CAN device and falls through to
failed_register, where pm_runtime_put_noidle() drops the same reference
again.

This results in an unbalanced runtime PM usage counter on the stop mode
setup failure path.

Skip pm_runtime_put_noidle() after a successful register_flexcandev()
and only disable runtime PM before freeing the CAN device.

This issue was found by manual code inspection.

Fixes: 812f0116c66a ("can: flexcan: add CAN wakeup function for i.MX8QM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/can/flexcan/flexcan-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..7d675696797f 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2266,8 +2266,10 @@ static int flexcan_probe(struct platform_device *pdev)
 
  failed_setup_stop_mode:
 	unregister_flexcandev(dev);
+	goto failed_pm_runtime_disable;
  failed_register:
 	pm_runtime_put_noidle(&pdev->dev);
+failed_pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
  failed_platform_get_irq:
 	free_candev(dev);
-- 
2.43.0

