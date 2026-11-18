Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=irtRkN2ixAE/jRPFNU0TPuYCwj4rBeTSgTivle+6WV030LgRe92SgNAaYJ6GVlIcJeCz
	 3xbnXEcRTXmL2206bcVgYV4Ck2qR3xpAIMt4pb0h6EQIQgxrPjJnKH2UuGXAdSoJVQQdX
	 ZlTlwQGjWj1s3TE1J41UNCLBDOYSOWCqdhyvM0wxthe1Xb/C9fxjdlXR3+XE8EwnEXxuJ
	 uNEJUDRuF2OM0prHvrTZ3+0NZZdVR6xX4KZOG08oyeHVQGdMcS1hbKA+g680XYa8eLOlg
	 z66XCHPiFWZ1HBUtoR5WrvOFreIHSgbS704RFCbApiIxNHHDIFz22hZXQ92m1Ef2XEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=laS9Jb0x7fKHsI4/1p8AWqDnLgPRL0P3+124nuj6KnuR3oOWLEvccyP5jcFFUbzpKHSE
	 Lo17ATo1iJ/gxQpcnSdDPyFQNKcE8fX7JAKhrPeRZq9q9S2XxcGxK7wxOp8ug9WnD1np0
	 ihyCYq2wELLq7Ab/mnSFLVvao4KHD+Ee3M0JlH2mAzWLGu1HOCxAaShdKqSHzhhZiGLiV
	 EkN5SGV/gSDQGdgvQaB773kdJGxRHIv5bb9BvQruRtfeUGvSqp3ANvgu0jB0ehmeUzo7J
	 iS0fOV8hQFsUjLyvFkcbxbBrd30IBLuNV7f/IhyVFo0jTChbY8YrWORQjca6OqQruhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NOKo4NC8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936B606A89A;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C936B606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NOKo4NC8
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 60D31205AB6;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=NOKo4NC8OQaD0af+zeoc6U1pl2oUrFfvRY6piIONH0tXjHpvwz7FubVfknPxVlw3br/Nd+
	OzA+DozlZ/mc7MeW61E7R5cAaMCK5n7+4BzG6nFNhTMPlJ8J35Cms38q6+y5clxNnMxPbJ
	+SYCEG7ZUlA0e8hz4YRh1mUV4qS+ZKipIBi/g78eE+PPJ6nYW1IZe8xJzo+dfcgLhUVFN9
	8MDTNGsvAcRGrNU1FLRD5en9JarrBhviFzCgmvkZqoX6rrCcArOS2p5XhcXhm9As7BV7H6
	sqsAJKGceoTbKt5zrtrPXanQSYK+UASRB8n17DGdei95UsEeipgBZPbXkSQ+9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNq27cXcKEfdgYBBCEEM3zpAtrVhV45KuzwJebs7rvw=;
	b=H+lcj9rn/PC2bLfO8zTY0Js1TY4suY73SmWrsQ563YxWUvVh9pSltWYdKuc8MUoxQyEgvV
	PDox0byWenAb4WnUwDfNgBDjZj/UgqbNHZFZBNWfyji2nOcgQtQB7VBBau3Tl2iEzYAjzZ
	bN190VZCgTu10rq5fFMm4oQHXXksNhtblsaClicNTtHKVFhTflH2uMnZBebjYQAzPfR/Rw
	gLuMo6aEDJWWEC9yt3pWqUGHRoA0MNe9uo+iB9zsvOatv42U1uGJGAsFZhaVKsn42SoZkf
	cBd73HbgVE4v7q2hiXuELQ0X8cgVY/oV2z+1V42hVTJXNcKvNsqzUULE8v34hg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=PzJLx7q9e2NMPRPnkOInpChmVF17odb3LRT3om84OtY3FtNATKGxIHCfOfE3dPVIAJH7rN
	Sz2SPxl2WsF9A4BcjX9Id0mqR8gMC3Uiwxus/pgvAHreyoG6y/H0wQIC3D0sp+arWUc2Q3
	MvGcIFV46uaxYQJ+Qcb25T5UKU+rWjKem6QfcPvdnguMbz1QbcVa98HsQi9xt2Jd0PTbf5
	FBCtpeSyQKUhQcxYcBmdXxUSKhavKgbAflQuLF8kXJ3w8z44X+RxGAgGrMMvy6CU88phUy
	hx48AFyPJaYidj1Xxc5OG79uK+Lqx5bPidIAY5obOWresz+apOqy1SxAlI+nsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KI9-2O;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A93415EDC8A;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= <mas@csselectronics.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/12] can: dev: remove unused safe_candev_priv()
Date: Wed, 18 Nov 2026 10:11:36 +0100
Message-ID: <20261118092955.1283165-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
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

