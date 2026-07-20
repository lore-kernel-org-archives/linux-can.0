Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15F426EB9;
	Mon, 20 Jul 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555323; cv=none; b=IBQVWAKe0FFp2hSJPnOPYkoXl2IcI9qAKGnB+U3PVLhsq0epzBxsUV/a2fZxsMR43lrhT+l/Woq2PPTmGsvp4XD+g8O6+RslegLHzqCFP6kjmF3fC3q4/O2VDMTngmi7/2xeD/Su8SdBfS1yEbryqic/623JCz482/Qzjr588wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555323; c=relaxed/simple;
	bh=+OQxfRMhE5NxxN2dF0McGZRHhVPQS9xVQyKtSl+hQ9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLXmLDbeCPCwlxtbrCrN5RqspHpgV+C2HkD38iN1iZPQv5sElca3Mq25wky4ZQJfRlT4Bh6SFTLBuNbnEHmWvyxXSg5aUcATc7U+h/56XH2riGC2lOFMYt4SD5WAUpBN1NB4yZ0tpoNNOAVN+r594A20RUWnDjiOGfmkCqJIMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8F9562028DA;
	Mon, 20 Jul 2026 15:48:27 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM7-000Pml-1a;
	Mon, 20 Jul 2026 15:48:27 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F350356E522;
	Mon, 20 Jul 2026 13:48:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:06 +0200
Subject: [PATCH can-next 05/13] can: gs_usb: gs_make_candev(): reduce scope
 of variable bt_const_extended
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-5-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=+OQxfRMhE5NxxN2dF0McGZRHhVPQS9xVQyKtSl+hQ9I=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5dmWyO9SJ4n7sBB2bMRy1RVIo9Z6zJO2j+n3fhn3
 MSn8+z/dpSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAixQ8ZGb79+nNfx3aJ4aKI
 +7PLTf1ydR+yyy/XuWq1rzHF4aW88E9GhmVnhXb/EOuz2zc5mzE+XqNn9epXLSJ6+/mbVt3WSv8
 ylRcA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve readability of the code, reduce the scope of the variable
bt_const_extended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 82be2db76fe7..d049ae20b53d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1355,7 +1355,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	struct gs_can *dev;
 	struct net_device *netdev;
 	int rc;
-	struct gs_device_bt_const_extended bt_const_extended;
 	struct gs_device_bt_const bt_const;
 	u32 feature;
 
@@ -1495,6 +1494,8 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	 */
 	if (feature & GS_CAN_FEATURE_FD &&
 	    feature & GS_CAN_FEATURE_BT_CONST_EXT) {
+		struct gs_device_bt_const_extended bt_const_extended;
+
 		rc = usb_control_msg_recv(interface_to_usbdev(intf), 0,
 					  GS_USB_BREQ_BT_CONST_EXT,
 					  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,

-- 
2.53.0

