Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF904423E9E
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144661; cv=none; b=r3WN4HwMCwx1d8kcZupEp5VTdWQmjv12gk2cGmsIIeVOTwAbijWPbizPMq/yUm2PLzHjBIxfXK9+PSEbgUe9jAlrhJNWcvhXTxUQAhL1n8cIT64yC64ChIEf9ZjnkapI4JgnfW92ki23SaG6MEocs5E9/xZY7hhdlLvBRFts2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144661; c=relaxed/simple;
	bh=UoTM8ItbqEeaBM/lQeEOpEFLul1eJGMCR3RCy34RXQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqzVZ6VXzoRFgk2vztRPIKIB+KRPT2+u+6Plf3R1RbrCaDMdA2fagP+lMdANAeWgudyPdS2La/Z65us8Us05FsJrR41Pcj+lW0fNpkcEzV7vHK3xBPZM4c1/jEtw+pmqgzVtfdo8NNYJaEyBHxQ5unTfNn9Xuybyz+fgCn2P72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hJx8nc1e; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hJx8nc1e"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0584ad71so3719453f8f.0
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792144658; x=1792749458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lS7au6nzsuO2aRNvLqMF0r9p85w4fxyfzI4JwkyMGs=;
        b=hJx8nc1e+erCz8rSQJup1CamQwiqXkj2CRC8qcWRaNKxq5N1aU1ogIUVpqKthB9jv6
         54YK1hrXivK3fDmUSlH0IL+D4ZFdd+rsneBQhm+VFcp6rP/yIUQQ9O2MO5HP30l7lA7d
         krKaZUe8Og6yqkhDpubMwAAU4Ca3NLvYPYVr5JwCpoi66fReE7af4qd6IWtlGRouv0PU
         h0umP9dyZ/WnA1aP3oRquagemH4Si6tRu/WpclJa0dTAKZPDXtlA+tgV9skhYwCkq7LV
         /6umOdCAjBl4/JTOHHdbTjAKlDxELy84w5wldWmb738M46/I10IzOxtDIk+fPGIruQiX
         C5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144658; x=1792749458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lS7au6nzsuO2aRNvLqMF0r9p85w4fxyfzI4JwkyMGs=;
        b=NidQIF9km4l45qN39cd8nn/1DPtt11U5HsFyqtUUOk5z7TxSK/X+NPNrqSfOlApfwu
         1U8mkVVEoERPTBp4tA56KVZffWOPONNQrW3h6qoaXJ7w12VIYSYr5VKLyK60nXJtKUBp
         50gBSBg9Hw6m1UOmZkZoX128ANOmstWviGidkiU/kbmwJPWCZZG/3C5ADRatCGYbRcLb
         fpmvsjw/quCz7GUBtoyYnFHm70IzJIAHLWG+sLsaaXcKZ9cB2bCRaU5fdk+MZi2wnaCX
         bdFhv5l6LTR5MM0ZBtyYW56Caiajl6s616vg/xj3nSNIle8gw+xHzcK3yf4kC2HpIDYg
         GEYg==
X-Forwarded-Encrypted: i=1; AKwUvBwzvmO9dfqDgjYuIHNZkYG1AaS551pN3vbSxAl7oCn/6iZailOZqYoi4wi2BKRfzHwJabl2C0hyB1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdw53UCLBNSkWAI8jYMb8/t9k7hibLkTq0D5nP070WAR7x6KNd
	t2EdmyfLRa98zKUldmNRrlAild0QY9wxZb3gz7oiK6YY8WnWAvpWZWUNAweZhMVIo74=
X-Gm-Gg: AYBFou3Sy5pIYzNc5+WoBFJqW+7CM0vvd2jINCqVBTkun00Sda7Z14jG81v/4peE/rV
	gg+DdMJgTKDbm0V4xIKx/Qcqsju9uUvtzkcZ87W1ndxY0HytAItVE7k/+MYx6DP4tbHAB3S0mIk
	ryhqWnfLgUn0UNbjbV0zFg0wUhFSaXJNEq5rpoVj3A8TtTz3ap9QpQxS/UYwjWDx5JRDqyjvemF
	OIj6OMdLnZiglmUG23H4jj9jS4U6g2t9dcyZkdAJ8LWip9bNgL2t/KrNU+TZ2rBlSsKVguZQGJa
	BfzOSNeaFCHZ2fyNCV7r4EbVj35OlojJ8KKZani19kBLeyh4ELzQnLt7DpM+A43gi9CiQrIm7LY
	Sbg+N1dvs8VTX+aRZC/lqmFJlIf37lCMTg/e1tS28bblhw3S8n70/7Cgt+eBOgAdpUw1wGpUgXO
	XOERK04hFdr5D3MTtTpNVZcdyP0QuSX29jlG9yKepqXsQF9kuLqSC9CZgDL8SxogHpvvU=
X-Received: by 2002:a05:6000:2012:b0:48d:ffe7:e883 with SMTP id ffacd0b85a97d-48dffe7f678mr2448773f8f.46.1792144657874;
        Fri, 16 Oct 2026 02:57:37 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm4232702f8f.34.2026.10.16.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:57:37 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 16 Oct 2026 11:57:12 +0200
Subject: [PATCH v2 1/2] can: m_can: Fix suspend deinit() error path
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-1-7efa2b172cce@baylibre.com>
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
In-Reply-To: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=msp@baylibre.com;
 h=from:subject:message-id; bh=UoTM8ItbqEeaBM/lQeEOpEFLul1eJGMCR3RCy34RXQM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLX/4bXF/CVHWC97a26KyFs5xmO00o03x64mBx4sXbx
 hO4V7+Y1VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQAT+a3FyHB/3zwHq7n7+zb0
 T1rz+4eSnevpL4pcrK1Wnts+SPl7lDoyMtzlUv+nYsLwa+upsr/Xe4omlwrqfivRXm5St5DxYy3
 TJ24A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

When suspending mcan, deinit is called and its return value is returned,
but nothing is restored. Returning an error in the suspend function will
stop suspending and resume the system immediately. So on error the
device should be restored to its previous state. If coalescing is
active, the hrtimer is restarted.

Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init callback when going into suspend/resume")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150..02a95a769a78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2612,8 +2612,14 @@ int m_can_class_suspend(struct device *dev)
 			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
 
-			if (cdev->ops->deinit)
+			if (cdev->ops->deinit) {
 				ret = cdev->ops->deinit(cdev);
+				if (ret) {
+					netdev_err(cdev->net, "failed to deinit device while suspending %pe\n",
+						   ERR_PTR(ret));
+					goto err_pm_wake_source;
+				}
+			}
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2625,6 +2631,23 @@ int m_can_class_suspend(struct device *dev)
 	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
 		pinctrl_pm_select_sleep_state(dev);
 
+	return 0;
+
+err_pm_wake_source:
+	if (netif_running(ndev)) {
+		if (cdev->pm_wake_source) {
+			bool coalescing_active = (cdev->active_interrupts & (IR_RF0N | IR_TEFN))
+						 != (IR_RF0N | IR_TEFN);
+			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
+			if (coalescing_active)
+				hrtimer_start(&cdev->hrtimer,
+					      cdev->irq_timer_wait,
+					      HRTIMER_MODE_REL);
+		}
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);

-- 
2.55.0

