Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126295;
	b=ubyzjxgngoc2sKLNVypIctOLZHWsEt+XU4YKJlrrdVwN9/Pd4/5WykGUUZNwIVy1OJIU
	 4s2J6/oUgbYTB7JoEjWeOLO/hFuGHh/zolgYagycyvCBgEy50ScQFqmqzMjBUpxOmsKHb
	 nGFkwPa+RhcZTPLsmXKL9ISS2oeB5d6x/7E50M2XsbOhNUhpidhSKE8xpeWexNZz4/s8u
	 SnLxQCXCtlkXtQX6rCZk3s360Q9unjnPFQ3ivolG6ofePumD5oIy48Tnld6np8yLXQ/JG
	 euTaicc59uSeYJki36dREfkrMH8yqIl+WgOdxWF90YBYUQyzLyLJdY7LM52r4AkROCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=Az5/079Fp+Tude3KDYIR+E50TzMQ6mhGbp0BKANr+1hynvMhJ0WtZ6rKlKmlGd5LR7zl
	 T6oadoQ/W6ehAPlrdZwDjqPZgv32wV74owVHGChdXW/q5LfEauvxM8PCLytAjW5QeWeA2
	 nm+u34dJhz4iN9Fi553gyJCqiiyUfob2fSYRrXq/3lT/9kEYWd3TMyflS5/sy/EWXYF4V
	 9FPgg0vY4GD5582o6Q9FTKmsQ3AyBTSkrY0DSAKID8Lm/NkSeaIVWOwTfToMzk0nDtiBg
	 FEAoV5AE/bcviQgY6nY0p2gima+jkftTOUoHqpoFcvMdC3G2lJ3XUia20RiVSChkUsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=R3Y83Ec1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E74606A32A;
	Thu, 19 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E74606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=R3Y83Ec1
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 324A8205B34;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=R3Y83Ec1Zg26qke+aKV+EGardKac3zGml4x/3G9d+28NfGY4rlWEMalx0k6bIA3kVtmSZk
	SP5VMQ3j0iLc9uGbSraZHiQ2qlj5DHXJ6VNGPr2f4GklsUPmPDc2m3Y6Njx3mGIoR6Zonq
	KGKpWb25vLL+tUkOovTOX1MMRNGoLf6+xHfbWZ6V9zuVYzoCuIAZB+UReiLCe9PEFIt2Z5
	h5MD2w0O69YeWNfJ03LZgJFKTJrrLJ7HcV3bBFnVlU7Wulb8w11SkfbeQhZDrCu2l7vcdb
	GKRxny1jXEDjJvTsFBN+U0+8ISvhkDk26oFUQnUIurAbLG3PJsQm7bCirS4VHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=PCh8vnI4vjXl6mwSrYa412NbsYzEHBp/nyH5/+1kO1u5vP4g1OFCwY4t4Pp9Rxk5ui8pmI
	Yi6KsSzaHs+LWXxSU1PNFzDhLzuHUiJ+JN662DcvJPTTEykbzos5N0KJpgf/5ELASL3LbD
	3oxvjoDHI+hqmS8P0KT0vMI+/3bMyneERyqRzR5qr66FmybDxzljnXplGh9LzBbzPhJxEZ
	5awiFuwZnVuLXHPdHtP5deShAEjzp/VX+iOwlj2L+Adq0IFoKZZTiw2nLdoJLNMzFezmPH
	0SbhkdkPU1LgjF75IZyhLC+6LjUKfqB+ue9I0oXbq8OzSLwRB/nJDdqiMGAt6A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=OxpKlDD3WnyikXULfyS/tWdBKCO/6PoTskPUUFUG2o9QXfQH43jP288phHW3L/AmAiGIre
	tvPDeedVi6kVB6Um2/rtQdZ8Z1N1xav9fi0cd+VBrD5J0z0N4oI8k2dscBRMRQg27uAy/Q
	GrnNRfiPG0E9NsLVShrCCOdyXpYd1PK22rh6/4BtnW8LLcaApCPqKVRN5y1BxZxNTwoHxZ
	lgKjRehJ5HeJvu0Yu7Oy5onmB0HrtRdZTvla5+ek1rmVzvyoRy/iXsVXyAewitbVlD5RW4
	7xbbB9lLhTicWBFKcPM5O35LhfBnDtPpGd/S9Xa9NkU048bT6DVNTUii3tcvqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z66-1g;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C0E5F5F0996;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= <mas@csselectronics.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/13] can: dev: remove unused safe_candev_priv()
Date: Thu, 19 Nov 2026 22:58:39 +0100
Message-ID: <20261119220936.155728-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Magnus Aagaard Sørensen <mas@csselectronics.com>

After commit 4650ff58a1b9 ("Revert "can: raw: instantly reject unsupported
CAN frames""), there are no other in-tree users of safe_candev_priv().

Remove function and prototype.

Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
Link: https://patch.msgid.link/20261118-remove-safe_candev_priv-v1-1-a0083fbd5358@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 12 ------------
 include/linux/can/dev.h   |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c..3207c0e08712 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -656,18 +656,6 @@ void unregister_candev(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_candev);
 
-/* Test if a network device is a candev based device
- * and return the can_priv* if so.
- */
-struct can_priv *safe_candev_priv(struct net_device *dev)
-{
-	if (dev->type != ARPHRD_CAN || dev->rtnl_link_ops != &can_link_ops)
-		return NULL;
-
-	return netdev_priv(dev);
-}
-EXPORT_SYMBOL_GPL(safe_candev_priv);
-
 static __init int can_dev_init(void)
 {
 	int err;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 346faddee02e..648abf2be478 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -110,9 +110,6 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
-/* a candev safe wrapper around netdev_priv */
-struct can_priv *safe_candev_priv(struct net_device *dev);
-
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
-- 
2.53.0

