Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66D3890F8;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=Ll3hv4hkCB/Pbj0hNohzq60C5+lBu6nzZb9guIxet1dLiGhelkpfjHx0m5B0AaNhp0ynBx6Wojf+nMNV4z3rIVPLk+TPkLwOntWcWxm0TcMIxhy6uiJ9PWwRaC615KKqvKXmyCf7XgTPjNI4ypL9gkjhuqB8PuAsoL8VD8lGLm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=qW8KL3iPmYGlea5Fvr4VXTyjiVX52Fmuqw1cqN4beyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSU5vmsNFSj6ShqHpL7zn6XU/TXebxr8L6L3DTYwyRfTz5jllu50gG5hm1XLcjRkB6gxBkqW3IN9ic0oMk4Z/QDf6KMoF3eQCBZpjBTAsLKSQh77I3Wxas3VLcKpQpyVFM3WsZglqMOMaRFQLV7Rq1zJD2Uxd6x06FqOZ1+7XEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=UTINhmXa; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="UTINhmXa"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7C2D92027DE;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfKTybRYJTcaZB+HtTPO3tHMeIDwhMAh4+QGFozXbxo=;
	b=UTINhmXaPWeoQzZgIl1/0cuCk2riF1+HJZnXVF7ilEH+3m/qM84aOosVSzCGZO0w00jt//
	NjhACD1ENKdexD2ldwx++bCpzHNiB2GrQ2HUm0k5dGSbn9G+7q5kHDnVRKys2vNxPQme7P
	uLXtvHRKncxUMNuUpMRp9+JsNy23weR78C5GO7FkBlrVmP969IoDcgxAx2qH15ILiqah9w
	MfJUQk2KIUZ8XEuKIl9bVUEEpez0E9+GwD6cX2dqKvfyWr8R7ygKEKJBuIBxP3bmxERHBB
	gF1AfaC8Yu9nPzEM5SE3UWGSmDEVFzJBBcoJwM810oqTjgnVb5nIKTjwRgkP5w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=dbfnB7SqVBMqW7cUUez/EioZDL/cSbicc9oRjtlqhUaGlLv6dJDqYFW2dpYUrnRwsXSTB0
	gD8YR+9UfpvrwQT6ISyP4ml+Gt5kgn+rtcIpnsFqu6e6xVO6gxDTQpfR87SwCU9PrkmY9k
	SLvUTmITapkqA9BnNnUu7/lXEp3xctgGCR82z/UKjlMKRSU0r+FVCEeuR7s7Te9dvbFcaW
	dhhENg748xO2645Clg7rOVZR3o56rfYC7mV0yFcvvfYrYVisGjh66OtySJ3bMi+vasnRX0
	pbV7rPIeHVArS+Qz9vQ1Vn41SW73/x9kQEZ4jnOXtYRHHWxnsbf2XE4pArVTFQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfKTybRYJTcaZB+HtTPO3tHMeIDwhMAh4+QGFozXbxo=;
	b=MyBsJMr8L9AHCzSZE1Hwf7OSM9jO5nh2+xx+6nOMLbMn4rwEg1Qg7NLV5oD/AUX9ihr3IR
	oLh/8dSLyf30z+L1E0FQLXRO9LQB8gsdwcTkKgubBxq2inU9WD3UjF83mVfP85PrM6mJUY
	vbzI+ezRj+6basG2GWx2HzCQDj4aVGClt18QAheHXdVu6ZkkHAa3y4doUg2SPrtsC/o14C
	boHUIrMSo4Mx/25m9ZtQbXzHReLo3YUKUwcVJUbvXb2omGkRJxeLe1U+p2iKn58bHaIONS
	Gtc/oLJPrjeFNx2+yumFWF5CJoc6c3HXLgJtVOKUWTXs/WA0O+zRPhMFfCV6pg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wra-1I;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2799D5C47B4;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
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
Date: Thu, 15 Oct 2026 03:40:29 +0200
Message-ID: <20261015015336.816543-32-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

