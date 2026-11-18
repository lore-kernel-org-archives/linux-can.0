Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992725;
	b=q3LJR0Pbz9Gx/eKo7k1vF95QAU7irVUL2R9NJLb8ACEgBolipPB8/oWo0+SRPqsm1tUQ
	 +vwG9ycFiFCv7OwjZhW+5Tjbs6XnENyr6LRdShCp+bywzxINNv5V1lsMYKFKKrlDKmAVr
	 LFHyc5hypqLOO/sUPJBmqp8wNT0OKb0Cngl2dU9rvhAeNxawXUTMdG5g1A/v/lLNu8bUm
	 V5V0RLKGnZg+8YwjsLrxiI9cFB9B05KmecP3NY+Vec/16toh8A21DwPj3Ny8cZBy9qOyp
	 rdn1QNAtJpc6OB80H1MNtbLxgfSKQPWyWUhsgARvp+C73BUkE5B8qlBAq2CrDp7/zAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992725;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=KqLI2iWr3E+CbCoENrRYfXpEWSlq7m1O/v7cDwwkw5M=;
	b=CjtLPFkh72fQKJKu8LSdDtc4Lshipt+6/8QH0uduwbzfCsBCkR6VVN82nnmM9OHur4Gr
	 qohKd8SCO/5Hmhwu7JDQQjYPQlwXlmu9mDf5cjCgsBxC9HbLN72GLr3Jikv2F7tHUWLn1
	 qXNWoE9Bn1o4Z99bLJHrUOpS2Ft7dzBPU5wCz5i9MVklUXFgmUOKUI/7uaoytmycQr4lY
	 I87d229wx+2YqtL3rqj9A0HmeSpa3Fur5C6AvnhFMUce++PwS/+R5hfPTzWy08RTtAGWD
	 BT7HRQlJEdISQXzosVUkse2IjaGRK/0v2P4uklFcBZAP+6Hg2YgnwSrWrz9oI+bTRVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EkjDqgwe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6A606A331;
	Wed, 18 Nov 2026 09:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B6A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EkjDqgwe
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 59270202929;
	Wed, 18 Nov 2026 10:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794992720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqLI2iWr3E+CbCoENrRYfXpEWSlq7m1O/v7cDwwkw5M=;
	b=EkjDqgweSzFmcuk+F5mCfAVbh0AZUUxzUCWPucRpjE0N12bb51Bi8m5YS8Av64GEM8ZsTG
	39UlPLAseu41v6x3UCRe5ZxDYPp868FjL1Zlq1giV2yCM3+t6QZ42IBSA5uSgHi/Gemzew
	LQlFuc4kcUdZ5hyns1dn59VQHpgG2GXPbuLD9dq8pTy1akQcGaJt+0Oz0lp9lamLaSkttD
	WjvEroSn6Q1zqiwWkQubMPpZ6SRd1D02V3muk8HpmTJ02eMIEUaB+GQFW+mEVxeunbj/Fw
	UFqxu5duoYcTiLw7mgNgh8r8pJNgGjuEadQbJ9vuRsMuWfDJeC3cwzm1ncRHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794992720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqLI2iWr3E+CbCoENrRYfXpEWSlq7m1O/v7cDwwkw5M=;
	b=d6MCUj0IvuX5v+W1oKHJmOOfF3ZKsg6PMi+fLZkFW6xEleZPA3f8Xce1PlzKW51lUV60wi
	le01Aypb76ce6mH3pSi1GD3oX8Z7UMDPIT4gT+B6jE1CrsiyeMCSGvtgJe4AXAj0i019f7
	uFQuPSKPUlh4qVU5FiA0GYjzRs7ji1R8dCOLFLPP22goJZSPNUCnIjG7q/3BTTbcDF/hwS
	llTdNlFXRmJZmyA8Co3AtckDB+aAMADjn7d8xmQghZw9pCU4U03h6Lvf+iXFubedzlipDn
	JFiiqLja+c97FxvuLwBg8V4twZ+s0XjTyjg877il8U8eucSa9YEyES4vCjk22w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794992720; a=rsa-sha256;
	cv=none;
	b=IMlh7yk+5e9KViRilrBeYFsvbokCXDHsIz0mMVWD5PIJR0UE/LuuOp5ImgkamROlwOraYS
	+Nr1GsydlerDMgK8TKeFeiQspin8c0/+uAl4ByNcGwfkiQC2yaFZ8lZSkZXyI0Cx9vPTdb
	gAeR6crvL6zYr3K/cc7nE1HNZ40JRILAJ19WCTa0Zl7qxVWQwPyzq9GE92JiMmUL3m5TgT
	Ckoxn83YnKRKdR2aJDjOrBAdYwQZ5Yn/VS0mPh07yIaVQcoBtZfxgVjVn51MAgXdigTc6N
	7Tk21stfWMW8W0FdEbrrp+U4V6mAYAoOvJAP+Kx0BY+6RKMdPIKce7Ugmyk8Uw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTbbT-000KGc-2S;
	Wed, 18 Nov 2026 10:05:20 +0100
Received: from hardanger.blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E97355EDC78;
	Wed, 18 Nov 2026 09:05:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 18 Nov 2026 10:05:06 +0100
Subject: [PATCH can-next] can: dev: remove unused safe_candev_priv()
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-remove-safe_candev_priv-v1-1-a0083fbd5358@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCQBBFf0XmuYFWsaJfiZB19loTtMqsLoL47
 231eLj3nI0STJHoWm1kyJp0jAXcoSJ5+vgAayhM9bE+OecubHiPGZz8gE58DMjdZJq5sARpz03
 bN1TsyTDo+ivfqBw5Yp3p/l/S0r8g8zdM+/4BGWjlu4UAAAA=
X-Change-ID: 20261118-remove-safe_candev_priv-afecdc5735b3
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Magnus_Aagaard_S=C3=B8rensen?= <mas@csselectronics.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=TPL6PYgiBRhS3qVHTTMEAvCwmyh+i5BysZKLU49gYho=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6m+W2JdYide5mb/NnUc9ftGh+ezDPcG7lzxsyd61T3
 vmd63hi11HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJrD3AyPBunrHuMp0SgfJl
 SlLyjuvKtzHLyXZsaDY74Pl9m14Jyw9GhsMHN6j9/d35j2naukDRIDf74rBXTQmv1mRf0XoyU5M
 7gREA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Magnus Aagaard Sørensen <mas@csselectronics.com>

After commit 4650ff58a1b9 ("Revert "can: raw: instantly reject unsupported
CAN frames""), there are no other in-tree users of safe_candev_priv().

Remove function and prototype.

Signed-off-by: Magnus Aagaard Sørensen <mas@csselectronics.com>
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

---
base-commit: 2a324a58a084c5cfd7e5a2f55e0786bee170a4a5
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261118-remove-safe_candev_priv-afecdc5735b3

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

