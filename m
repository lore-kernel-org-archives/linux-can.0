Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC9E330B0B
	for <linux-can@vger.kernel.org>; Mon, 17 Aug 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966262; cv=none; b=uhxiX5qM8cnxIGzwl3Jp8cm8yuWSp6x7ntM5cm39NphNvLkHb+gR3S4MIjrXwuqW1madODzBzCk/LIv53IwqlZk4qrL8vHD84KNHYMn6rGsF26VzCATxxGgBlBAXPfOeRc8augq6wGMcIesnZJNWzwn1g1ICqLFIaAnTzaq/cAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966262; c=relaxed/simple;
	bh=UiH/N/r4NQN35823Rjw9P3wnGwD8DehAQ5PBx6erTzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzK5lTuNkjefOs3y/VGz7QK6PD+N6Sqsh4XT/GcZh8+ptShZuvNP9eNm6SiugNGJVG5wvYG8FCwA9mX7wsq1bFYYgjq3OLFZrSxpLYD7SFXxjta0wdhloSvQ6yEbdcw33oA0h08/uWH0MHFFnnB7qhkUcKoYA/OOK+uxzai4FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=UBQMoD1/; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="UBQMoD1/"
Received: from ATHENA.kvaser.se (ATHENA.kvaser.se [10.0.3.118])
	by qmail.kvaser.se (Postfix) with ESMTP id 1F758E3014;
	Mon, 17 Aug 2026 13:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1786965672; bh=UiH/N/r4NQN35823Rjw9P3wnGwD8DehAQ5PBx6erTzc=;
	h=From:To:Cc:Subject:Date:From;
	b=UBQMoD1/QEJwOUZlVLDRWUwsf+5WIlaEOf2BOz5oZzVa+Vl+UuCt99xxGz5qYw5jr
	 L1MAiHp0gvnUCBnZfE4745pE/SgjgtX/6k1/QucCMb21rbWiLwgpjIQiV/Ah+4n4aE
	 CBx08EFRUAjwlGVPLw9yakTCGkZ+KvpW/K+1lrsf/Nrp5xiv8dvzZLnxgTAMO+suQV
	 bJVvxZp7hYz2nkY4CcjSmqBIUWwcFkxOj8udlMRGUfn/Rhy9Mvayx6lv55foUOX5g/
	 7YsOTcDx8ojBvI52oYKf7/vc0KtYE70HZRatRcGoQiB64JDy6lCDcRiqvzsKpHWmYF
	 eiOk5RREUu09w==
From: Anton Olsson <anol@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Anton Olsson <anol@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_usb: refactor endpoint lookup
Date: Mon, 17 Aug 2026 13:20:52 +0200
Message-ID: <20260817112052.1477126-1-anol@kvaser.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for endpoint addresses in mhydra is redundant as the correct in
and out endpoints will always be first.

Move kvaser_usb_leaf_setup_endpoints to kvaser_usb_core and use with both
mhydra and leaf.
Remove dev_setup_endpoint from kvaser_usb_dev_ops.

Signed-off-by: Anton Olsson <anol@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
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
index e09d663e362f..a1890157d734 100644
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
 
@@ -1732,32 +1729,6 @@ static int kvaser_usb_hydra_get_berr_counter(const struct net_device *netdev,
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
@@ -2202,7 +2173,6 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_set_data_bittiming = kvaser_usb_hydra_set_data_bittiming,
 	.dev_get_data_busparams = kvaser_usb_hydra_get_data_busparams,
 	.dev_get_berr_counter = kvaser_usb_hydra_get_berr_counter,
-	.dev_setup_endpoints = kvaser_usb_hydra_setup_endpoints,
 	.dev_init_card = kvaser_usb_hydra_init_card,
 	.dev_init_channel = kvaser_usb_hydra_init_channel,
 	.dev_get_software_info = kvaser_usb_hydra_get_software_info,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index df737cfc5ea0..38b64bc10a03 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -1955,22 +1955,6 @@ static int kvaser_usb_leaf_get_berr_counter(const struct net_device *netdev,
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
@@ -1978,7 +1962,6 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_set_data_bittiming = NULL,
 	.dev_get_data_busparams = NULL,
 	.dev_get_berr_counter = kvaser_usb_leaf_get_berr_counter,
-	.dev_setup_endpoints = kvaser_usb_leaf_setup_endpoints,
 	.dev_init_card = kvaser_usb_leaf_init_card,
 	.dev_init_channel = kvaser_usb_leaf_init_channel,
 	.dev_remove_channel = kvaser_usb_leaf_remove_channel,
-- 
2.43.0

