Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B93D3002
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754001; cv=none; b=ZFb6mSIg1Ais3noH1q7DmwqJdwxfbbsaEBXSMcmheUGMRxHYyQVVmKM2J9aP+ZqxpfULPQ6xCHV5ZO13ZtZPtuWTrRcDIQTit1T4PztCQH35iNaLQ7jsM1+t6iYdZ/Jc4dSLday/fJjdKCTq95d1pMi3pWVS0Pm6/VMduxGRpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754001; c=relaxed/simple;
	bh=wOcBpyqYl/G37dbmWNl5L8jS/tF8aJEQF68hbvQdj5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ictFScVt+ssxkH97vCN86QI9MWgXtnDjKnkaKn4ebInxD2fDtyD7KP716pqJj8UJ7aE9a4YwY0SHGkzUtsmNY2FHmUhbCwoiahnhf+5A7/6lWIsICDsNc1kuTZC4m3fiJDhQPWDygpnsvN5agutZEmWyJpnQfIq9s4RgXjHi2bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsjP-0001j4-WA; Thu, 09 Apr 2026 18:59:52 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wAsjP-004YFK-23;
	Thu, 09 Apr 2026 18:59:51 +0200
Received: from blackshift.org (ip-185-104-138-116.ptr.icomera.net [185.104.138.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 85981518B28;
	Thu, 09 Apr 2026 16:59:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: ucan: fix devres lifetime
Date: Thu,  9 Apr 2026 18:57:07 +0200
Message-ID: <20260409165942.588421-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409165942.588421-1-mkl@pengutronix.de>
References: <20260409165942.588421-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

USB drivers bind to USB interfaces and any device managed resources
should have their lifetime tied to the interface rather than parent USB
device. This avoids issues like memory leaks when drivers are unbound
without their devices being physically disconnected (e.g. on probe
deferral or configuration changes).

Fix the control message buffer lifetime so that it is released on driver
unbind.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable@vger.kernel.org	# 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260327104520.1310158-1-johan@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0ea0ac75e42f..ee3c1abbd063 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1397,7 +1397,7 @@ static int ucan_probe(struct usb_interface *intf,
 	 */
 
 	/* Prepare Memory for control transfers */
-	ctl_msg_buffer = devm_kzalloc(&udev->dev,
+	ctl_msg_buffer = devm_kzalloc(&intf->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
 	if (!ctl_msg_buffer) {

base-commit: ebe560ea5f54134279356703e73b7f867c89db13
-- 
2.53.0

