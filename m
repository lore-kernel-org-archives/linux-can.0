Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4A4E4C40;
	Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553427; cv=pass; b=uhVxhTih5hpQBujCOTHM32lOHyzIriOIbF2TgZzIq4T1Yiw92aYrXRfl0VIkn+lj+URjORU6n5FVvnwLzTipSvYpwghxSAnGbPekbb448xBfHz/1TtC1MKBTngpd0o1WqoHDLWFYs7a5aDGTlDGgWuqjjklSyH28arVLG5aqfl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553427; c=relaxed/simple;
	bh=qW8KL3iPmYGlea5Fvr4VXTyjiVX52Fmuqw1cqN4beyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiNWHqW92ugeoynM2Fkk/SFfBVlrYagcyhkMDJO/FeRluYw0yWYWxDoLiIdfPCSUDjhQNc0GQJlvbG2ZJ7ipVFYx4jKFQHlZnVZHNBnWyTS1yd6VD+0KLDMNUftJzZF/isuvD7vsmJR20zeY8iWm5MAw/fngTrj6Cg/bfpei4is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=a2t0+n+5; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="a2t0+n+5"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A7EB5202625;
	Fri, 09 Oct 2026 15:43:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfKTybRYJTcaZB+HtTPO3tHMeIDwhMAh4+QGFozXbxo=;
	b=a2t0+n+5iWdSXfVLaW2iuo2bn2iZgzqTOWCchXCHrMfP4/gStib32hVm6h0S8WHnGTxYh4
	kNXLy119IMS27DtGnUMuzNunJyxwzs9JoDfRnXBT5A9AOSGULR1a2p5ONTGq2LPrObBTdO
	7OZ3o+FoNyahxkL3OQ/WA/6QxfqAsyMaj56L5qDb3ruJjHTUkytbDugkywyabLa1KhEUhW
	Sr8qdmyX2aS7nNb/L8H5KiGhy42FvEccSCktbYnOIEfSo6vnGCzMYfFRequHsB0DjNPx0V
	QHu/qmxsQlJXHA31kQCUlFQiXmmIVOAA+tBds37vTD3CybCv5EIgfdAd+e3wJQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553420; a=rsa-sha256;
	cv=none;
	b=RktrnZf2NSC5ps1zaPwoIszOmeEus2HnEwTZX+3uHUHaH4JlyqxTa8sFsnpYqzeHttPjYx
	5jnUB4+04hlE6/hXPVvcppZ5oAc4LXfBCLo9Fwz3VAvMLVz6tqG/fnGPY/44ovxz09XbJF
	8/K4h9O2xd2XQ9budJNuoqdIzsXp2w+ggkrD5uh+KhqDY2eJ+AqvX30CKCYVZh04EjLowo
	HGJgBkXJ9Ps+jeSgES3EUGtpSRNyBOA/Z34/C7zhTxzjqnmA048Md6AsIMS9kaINH5xsZO
	HbfPjhiqDeD9qB1J+PRuk2EW7iU9J6FmuDHxTRwqLNAoWayDIkhPOwbMPRdxwA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfKTybRYJTcaZB+HtTPO3tHMeIDwhMAh4+QGFozXbxo=;
	b=IVQvSh4zpC3D6EfS9TFWQawyj0v5LITe6o4fExA33aCud/sgs+bbmE+1o2zi5VuYh+1sAL
	LFXGcB/4SDeoenDabNElkwSkqkcScE5ajjHTPrGxFpexvTuX5eL4vAwFYzBwWpAn+W2re9
	lX4AIeHzFZ2HRMF87t7jp4Qjg2Yh0GIHywXZ3WVDpv+8y6DeLFsMY5NG/XBEyQ/SaZlZHH
	BlPV3r4cnRGkdjWB/AFwJMpLYEDI3U+SpeBgVYgbQHyt9dNxhdrR+l/DP1pEJpyArrj6Ry
	lqUBR3fVMZexEnQgmzZv8zKv7UYNCf0f678IsR+Wa/JZem8Ig0YeNL0yjbdxMA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsu-0053TV-1u;
	Fri, 09 Oct 2026 15:43:40 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C50185BD8E4;
	Fri, 09 Oct 2026 13:43:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Anton Olsson <anol@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 31/37] can: kvaser_usb: refactor endpoint lookup
Date: Fri,  9 Oct 2026 15:28:03 +0200
Message-ID: <20261009134323.64064-32-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Olsson <anol@kvaser.com>

The check for endpoint addresses in mhydra is redundant as the correct in
and out endpoints will always be first.

Move kvaser_usb_leaf_setup_endpoints() to kvaser_usb_core() and use with
both mhydra and leaf. Remove dev_setup_endpoint() from struct
kvaser_usb_dev_ops.

Signed-off-by: Anton Olsson <anol@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20260817112052.1477126-1-anol@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  2 --
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 19 +++++++++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 30 -------------------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 17 -----------
 4 files changed, 18 insertions(+), 50 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 46a1b6907a50..2e862120ec3f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -161,7 +161,6 @@ struct kvaser_usb_net_priv {
  * @dev_get_data_busparams:	readback data busparams
  * @dev_get_berr_counter:	used for can.do_get_berr_counter
  *
- * @dev_setup_endpoints:	setup USB in and out endpoints
  * @dev_init_card:		initialize card
  * @dev_init_channel:		initialize channel
  * @dev_remove_channel:		uninitialize channel
@@ -189,7 +188,6 @@ struct kvaser_usb_dev_ops {
 	int (*dev_get_data_busparams)(struct kvaser_usb_net_priv *priv);
 	int (*dev_get_berr_counter)(const struct net_device *netdev,
 				    struct can_berr_counter *bec);
-	int (*dev_setup_endpoints)(struct kvaser_usb *dev);
 	int (*dev_init_card)(struct kvaser_usb *dev);
 	int (*dev_init_channel)(struct kvaser_usb_net_priv *priv);
 	void (*dev_remove_channel)(struct kvaser_usb_net_priv *priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d0a2a2a33c1c..9687dfb89b4c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -926,6 +926,23 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	return err;
 }
 
+static int kvaser_usb_setup_endpoints(struct kvaser_usb *dev)
+{
+	struct usb_host_interface *iface_desc;
+	int ret;
+
+	iface_desc = dev->intf->cur_altsetting;
+
+	/* use first bulk endpoint for in and out */
+	ret = usb_find_common_endpoints(iface_desc, &dev->bulk_in,
+					&dev->bulk_out, NULL, NULL);
+
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int kvaser_usb_probe(struct usb_interface *intf,
 			    const struct usb_device_id *id)
 {
@@ -949,7 +966,7 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	dev->driver_info = driver_info;
 	ops = driver_info->ops;
 
-	err = ops->dev_setup_endpoints(dev);
+	err = kvaser_usb_setup_endpoints(dev);
 	if (err) {
 		dev_err_probe(&intf->dev, err, "Cannot get usb endpoint(s)");
 		goto free_devlink;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..ad168cad1d78 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -37,9 +37,6 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan;
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_flexc;
 static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 
-#define KVASER_USB_HYDRA_BULK_EP_IN_ADDR	0x82
-#define KVASER_USB_HYDRA_BULK_EP_OUT_ADDR	0x02
-
 #define KVASER_USB_HYDRA_MAX_TRANSID		0xff
 #define KVASER_USB_HYDRA_MIN_TRANSID		0x01
 
@@ -1733,32 +1730,6 @@ static int kvaser_usb_hydra_get_berr_counter(const struct net_device *netdev,
 	return 0;
 }
 
-static int kvaser_usb_hydra_setup_endpoints(struct kvaser_usb *dev)
-{
-	const struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *ep;
-	int i;
-
-	iface_desc = dev->intf->cur_altsetting;
-
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
-		ep = &iface_desc->endpoint[i].desc;
-
-		if (!dev->bulk_in && usb_endpoint_is_bulk_in(ep) &&
-		    ep->bEndpointAddress == KVASER_USB_HYDRA_BULK_EP_IN_ADDR)
-			dev->bulk_in = ep;
-
-		if (!dev->bulk_out && usb_endpoint_is_bulk_out(ep) &&
-		    ep->bEndpointAddress == KVASER_USB_HYDRA_BULK_EP_OUT_ADDR)
-			dev->bulk_out = ep;
-
-		if (dev->bulk_in && dev->bulk_out)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
 static int kvaser_usb_hydra_init_card(struct kvaser_usb *dev)
 {
 	int err;
@@ -2203,7 +2174,6 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_set_data_bittiming = kvaser_usb_hydra_set_data_bittiming,
 	.dev_get_data_busparams = kvaser_usb_hydra_get_data_busparams,
 	.dev_get_berr_counter = kvaser_usb_hydra_get_berr_counter,
-	.dev_setup_endpoints = kvaser_usb_hydra_setup_endpoints,
 	.dev_init_card = kvaser_usb_hydra_init_card,
 	.dev_init_channel = kvaser_usb_hydra_init_channel,
 	.dev_get_software_info = kvaser_usb_hydra_get_software_info,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a876c7819b81..00302b5c6223 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1964,22 +1964,6 @@ static int kvaser_usb_leaf_get_berr_counter(const struct net_device *netdev,
 	return 0;
 }
 
-static int kvaser_usb_leaf_setup_endpoints(struct kvaser_usb *dev)
-{
-	struct usb_host_interface *iface_desc;
-	int ret;
-
-	iface_desc = dev->intf->cur_altsetting;
-
-	/* use first bulk endpoint for in and out */
-	ret = usb_find_common_endpoints(iface_desc, &dev->bulk_in, &dev->bulk_out,
-					NULL, NULL);
-	if (ret)
-		return -ENODEV;
-
-	return 0;
-}
-
 const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_set_mode = kvaser_usb_leaf_set_mode,
 	.dev_set_bittiming = kvaser_usb_leaf_set_bittiming,
@@ -1987,7 +1971,6 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_set_data_bittiming = NULL,
 	.dev_get_data_busparams = NULL,
 	.dev_get_berr_counter = kvaser_usb_leaf_get_berr_counter,
-	.dev_setup_endpoints = kvaser_usb_leaf_setup_endpoints,
 	.dev_init_card = kvaser_usb_leaf_init_card,
 	.dev_init_channel = kvaser_usb_leaf_init_channel,
 	.dev_remove_channel = kvaser_usb_leaf_remove_channel,
-- 
2.53.0

