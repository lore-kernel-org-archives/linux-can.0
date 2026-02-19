Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFD828DC4
	for <linux-can@vger.kernel.org>; Thu, 19 Feb 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505881; cv=none; b=JIS1ig8OgYMSCA+qfrM1rlRIuk9DsOsS+v5WyTBtzSgVus3gJ6Kg2MgxpX5f+ktvhjPYQCEF89FGxzNdqbqfJPVacO8qqi9APXgviKiU3vYIhuzBzidu2QiXCQ7uUzO0YCjuUaikKAHr7tOBRoR/rAZ8HpZwZLhxFduXKI9iEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505881; c=relaxed/simple;
	bh=Dq8pvqqmEimoX943UcACVbReQewJFyMF/LOlzykaJQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FIsFfHODdIeto9nxRoCMvgecFMAwYVj1ikcQfsfYTmE54GUqJEf12qs9hW2LfItS4BtEJT0LsGrCIrFrwwirZviD9le9T3UrXh3Zpv70G37mK8jqYPJsMG025945QL5lKPSnsfHwOR0LMVtzM4go4UxN7JPDct6beoZm9aUu/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3bP-00082m-3g; Thu, 19 Feb 2026 13:57:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vt3bN-001a1u-11;
	Thu, 19 Feb 2026 13:57:54 +0100
Received: from hardanger.blackshift.org (ip-185-104-138-130.ptr.icomera.net [185.104.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B577C4EC31B;
	Thu, 19 Feb 2026 12:57:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Feb 2026 13:57:34 +0100
Subject: [PATCH v2] can: gs_usb: gs_can_open(): always configure bitrates
 before starting device
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-gs_usb-always-configure-bitrates-v2-1-671f8ba5b0a5@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAL0Il2kC/5WOQQ6CMBBFr2K6tqatBsGV9zDEtGUoY0xLOi1CC
 HcX8AQuX/Ly358ZQUQgdjvMLMKAhMGvoI4HZjvtHXBsVmZKqEIoWXJHz0yG6/dHT8Rt8C26HIE
 bTFEnIG6s0q05C1WZgq0zfYQWxz3xqH9M2bzApm13MzqkFOK0fxjk5v2RGySXvDAXENVVGFnqe
 w/e5RSDx/HUAKuXZfkC1hF5eucAAAA=
X-Change-ID: 20260218-gs_usb-always-configure-bitrates-bc2afb3029b6
To: Vincent Mailhol <mailhol@kernel.org>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Dq8pvqqmEimoX943UcACVbReQewJFyMF/LOlzykaJQo=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsicznHG+qhe8e51Nw0k/e93Pn1ysLDIt8tIzLjc/WCfp
 3Tt117mjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEykXJfhr8SbZ/+Z7jaej93y
 /OHx3BnpUsYd+acuck5IMdnz9P6CjccZ/gd03P5xo0Xys7b0cr+o+63XNjL9/nT8aOarN1MPSDO
 u2MQLAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

So far the driver populated the struct can_priv::do_set_bittiming() and
struct can_priv::fd::do_set_data_bittiming() callbacks.

Before bringing up the interface, user space has to configure the bitrates.
With these callbacks the configuration is directly forwarded into the CAN
hardware. Then the interface can be brought up.

An ifdown-ifup cycle (without changing the bit rates) doesn't re-configure
the bitrates in the CAN hardware. This leads to a problem with the
CANable-2.5 [1] firmware, which resets the configured bit rates during
ifdown.

To fix the problem remove both bit timing callbacks and always configure
the bitrates in the struct net_device_ops::ndo_open() callback.

[1] https://github.com/Elmue/CANable-2.5-firmware-Slcan-and-Candlelight

Cc: stable@vger.kernel.org
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- fix format string
- Link to v1: https://patch.msgid.link/20260218-gs_usb-always-configure-bitrates-v1-1-6b4e0970b18a@pengutronix.de
---
 drivers/net/can/usb/gs_usb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d8b2dd74b3a1..6faa877d33ae 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -772,9 +772,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 }
 
-static int gs_usb_set_bittiming(struct net_device *netdev)
+static int gs_usb_set_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -791,9 +790,8 @@ static int gs_usb_set_bittiming(struct net_device *netdev)
 				    GFP_KERNEL);
 }
 
-static int gs_usb_set_data_bittiming(struct net_device *netdev)
+static int gs_usb_set_data_bittiming(struct gs_can *dev)
 {
-	struct gs_can *dev = netdev_priv(netdev);
 	struct can_bittiming *bt = &dev->can.fd.data_bittiming;
 	struct gs_device_bittiming dbt = {
 		.prop_seg = cpu_to_le32(bt->prop_seg),
@@ -1057,6 +1055,20 @@ static int gs_can_open(struct net_device *netdev)
 	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
+	rc = gs_usb_set_bittiming(dev);
+	if (rc) {
+		netdev_err(netdev, "failed to set bittiming: %pe\n", ERR_PTR(rc));
+		goto out_usb_kill_anchored_urbs;
+	}
+
+	if (ctrlmode & CAN_CTRLMODE_FD) {
+		rc = gs_usb_set_data_bittiming(dev);
+		if (rc) {
+			netdev_err(netdev, "failed to set data bittiming: %pe\n", ERR_PTR(rc));
+			goto out_usb_kill_anchored_urbs;
+		}
+	}
+
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -1370,7 +1382,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev->can.state = CAN_STATE_STOPPED;
 	dev->can.clock.freq = le32_to_cpu(bt_const.fclk_can);
 	dev->can.bittiming_const = &dev->bt_const;
-	dev->can.do_set_bittiming = gs_usb_set_bittiming;
 
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_CC_LEN8_DLC;
 
@@ -1394,7 +1405,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		 * GS_CAN_FEATURE_BT_CONST_EXT is set.
 		 */
 		dev->can.fd.data_bittiming_const = &dev->bt_const;
-		dev->can.fd.do_set_data_bittiming = gs_usb_set_data_bittiming;
 	}
 
 	if (feature & GS_CAN_FEATURE_TERMINATION) {

---
base-commit: 77c5e3fdd2793f478e6fdae55c9ea85b21d06f8f
change-id: 20260218-gs_usb-always-configure-bitrates-bc2afb3029b6

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

