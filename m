Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4A5013D4;
	Mon, 28 Sep 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624009; cv=pass; b=ptmqFOtJIKcp//ZT/d5HRiZlkDfdsXmgm4L/PJ9Ap61FPxdto3XfvLStOEnQQADMHqzvGMINASO3wZmknRZsR8iSlvCQiJ7uw083A0zooQx5e6wNvP1ZVBNqMuk8Ei3Ced2TQGIlIDWVq3zycajktMjMCNs0u+v4jwTWbcbnq5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624009; c=relaxed/simple;
	bh=+AolzH1JD2w0X/ly3wFQj1mLu/tePV3k9Ndl+Ti51pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwxzcbJUpCL2mkW230YOtpY6/Uk1xQbZ0JoqR7QyTgABoKyXRMpbdjPK8mMd54KC7XzERIpNxiAZpNDLsxGraR9kk2DLR+OEyooE67Ri+o3m6hQ4pG7idI8dmLPVQRilqjbomq7PsZqCg76EJoScwdHbXBqKHH25NvhBf4AZcRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=K4WXTIwF; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="K4WXTIwF"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 577A3201F08;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjUx+ZyqERdBVFs8yyr47WM5m3EjvIL9s/gkuaKj6bo=;
	b=K4WXTIwF1JbZR/aW/CnyvRXyGQbMUV7tqOThINBdKXMgcV6I6fKcHeAqgemPC8oCm/tmsW
	MSMwlhQkTSFr5JMWsJNpBbPv1iDarIr4pja25xqFZZC+LwMBycD4XN96OrrpslRG50ERHg
	EEA2YdUH4dgG1jodR46Y095UG1zKBINyKryTTMjXCqi0xTeepOIUS0ZibQwYwEYMsUnmsw
	TnDUKAUwFEzRjEunYynhVitA8JDrl5TD3xnpSJscgz+dt8xy0tDNgw6FWcOM5jCsSvizE1
	Nnx420ZZx5GYXZjxfHp1rC6mWjwHoOJWUMHPkiK5U6/F811bR9jgAXJTuykmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjUx+ZyqERdBVFs8yyr47WM5m3EjvIL9s/gkuaKj6bo=;
	b=CYd/Wo6Y+nuPZknQ2Tky73keaqZZAeoi6GC5bT5LSDD/CEx43OZAhaMRqCJ4eBFe00vzTh
	A5Ao+0Gl5R+8NP7EAHU8lyooOu+H+Nr7CTyC968Grfyvs4VzZfqeUvw20Rut8EaKUO90uh
	pP8zRqPzLTtdUE32j0a+WZ8vVb57glU1V0rcVs/jBY4yU5yzzmIQcWOAQGtY7wD5RDBcVD
	PCXp96XYeIyo+9HPhJkhTDE7LrUpUPQO1J0QrBtjsctWrc/lARAPmxBWPnImvUfpkPjl7v
	x8DVxFT9W044iL2gLpruWvKcoH19z0YlQnlcb2E/VIic9gMnSouB7Y/GfhfL+w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=L7RA3LV6t/tLMC+fGU6GrvyCkxPxDQhIqRuSp5bCnFv31dMYiW1LYGITY5I/u1ebuJKxYf
	dtvs7haOnfPnpqiKvbXnfrJ60hY7tJn/LMBh/hlcuxWuv+iHnVJOsR/eJ8zVbx0adpMY0w
	Tu59PmC4d03of4Gx2OvmG3l8A/vbshcbGbUliGgk1dnCUqJD1aAmdI4dFfGAA1c8BW0azQ
	jzvWlEclM1UPESNYFyZ9viAGQVvWb/ZgjzumcKbEVF7c6o0LneWZwDwBr1dJf+Tbv/BCHw
	M/THDixOX7VLe/BbfoQ0FAWNQSR4d2vjNBVpey0r2amAgo9HybAATNx9Ffkagw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6J-0W;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CFD615B1553;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
	Kendall Willis <k-willis@ti.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix suspend deinit() error path
Date: Mon, 28 Sep 2026 20:45:19 +0200
Message-ID: <20260928193312.553632-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

When suspending mcan, deinit is called and its return value is returned,
but nothing is restored. Returning an error in the suspend function will
stop suspending and resume the system immediately. So on error the device
should be restored to its previous state.

Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init callback when going into suspend/resume")
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Link: https://patch.msgid.link/20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16f80607e150..91a0c5eca260 100644
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
+					goto err_restore_interface;
+				}
+			}
 		} else {
 			m_can_stop(ndev);
 		}
@@ -2625,6 +2631,21 @@ int m_can_class_suspend(struct device *dev)
 	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
 		pinctrl_pm_select_sleep_state(dev);
 
+	return 0;
+
+err_restore_interface:
+	if (netif_running(ndev)) {
+		if (cdev->pm_wake_source) {
+			/* Enable interrupts that trigger immediately if
+			 * something is there and keep the hrtimer off
+			 */
+			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
+			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
+		}
+		netif_device_attach(ndev);
+		netif_start_queue(ndev);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
-- 
2.53.0

