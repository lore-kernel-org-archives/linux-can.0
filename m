Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFB4252A0;
	Mon, 20 Jul 2026 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555316; cv=none; b=BjIZxsEb3rswmUU0os6VvNy9s6/9Jlzine61+SkxzbLQou8Nsbmm2+kd2O8rP59T3a28R1mnIOri+Ae8wllyJDMqJXKVzUCvtajFKsGPDF2QJeOJdh+djke82MvJHxIHY+8nakT0z52yNDGKH54ARrDecGJZLYSdDKkSn818QQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555316; c=relaxed/simple;
	bh=dRlHuxFXBm+cO5QQ3/v5INi6PVHQolLYJrM80xvbn38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4pMnoH6yaT9ddzKdKmrOZAs/j00NP7IHemIaD8LZI2xs2Ow0LmVyYYrtYDxMhG0Gqb+SuuBgoTf8q2f9QU8EM59Ii8TTdXNMEDnRpUWnfBUps2j8xdYSp+Bd5A0NgJzPlUo1MA7NNgIAoER2zi/Ze2eZYgFyhL9E8YeqCjzlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0F8EA2028D4;
	Mon, 20 Jul 2026 15:48:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM5-000PmU-36;
	Mon, 20 Jul 2026 15:48:25 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 788AC56E51E;
	Mon, 20 Jul 2026 13:48:25 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:02 +0200
Subject: [PATCH can-next 01/13] can: gs_usb: remove unused define
 GS_CAN_MODE_NORMAL
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-1-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dRlHuxFXBm+cO5QQ3/v5INi6PVHQolLYJrM80xvbn38=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKUxdf+YuZT0X5X3X6kZmPdY8p+p+POSyt/vrPQs2Mc
 i6LNfN1O0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARlVSGvzLr3/BZnV2zZPv/
 S+Ibjj8SvdAlMstgw8/e93aimzWn+S9g+O8178RG45Yj5Y82vt3q+Mbs4tFXL5tDVzXxn8+6eOt
 YljU3AA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

The value GS_CAN_MODE_NORMAL was part of the initial commit
d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices") of
the gs_usb driver, but never used. Remove it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cbbbc69..c8bb6eeff667 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -127,7 +127,6 @@ struct gs_device_config {
 	__le32 hw_version;
 } __packed;
 
-#define GS_CAN_MODE_NORMAL 0
 #define GS_CAN_MODE_LISTEN_ONLY BIT(0)
 #define GS_CAN_MODE_LOOP_BACK BIT(1)
 #define GS_CAN_MODE_TRIPLE_SAMPLE BIT(2)

-- 
2.53.0

