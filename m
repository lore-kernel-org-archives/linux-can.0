Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F196547063;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029223; cv=pass; b=o1VkCSfWPYB3MNjorsxMj0fNlfUenS3PqfdDxi82JFUftG/V8a8qEYfPj+vPWvBabKJCHlOM+iqGTJ8wQ+ukI5upwvYS2KIjmHC0bKXdsqiLp9QJnnHjwzFwNnIA3MmpWNlO8lnHiMpLxW5phiocosMkyUMUuwxXonODaPD1lfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029223; c=relaxed/simple;
	bh=icwttVp/gpJ9Ow/0dJ5cGcW3oVQP3H8pD+33rsf3U90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N47zNfyN+vYyqTICbvI6M/cmysR/X+n7lZvyTG6U4KUxBhz/TYdbY/iPzGl3Wy1fjdhvrEhqh5VIUJaTmmOmOmnmecpqWmwurqMH6YJpziK/cXag7QjISqP9Z02sPo8NkLtm+wwufpgQtKxbu60F6+KxvBd1+e92I8x7meyaHt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=awIbH+1v; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="awIbH+1v"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B9DB1201E7D;
	Thu, 15 Oct 2026 03:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=awIbH+1viQ29r2rs2wRhZHkHX6YVkdtMHZ7eBG31lxbW0p6vCEKGCz/9OeIEeBgknWHnPu
	XMqEnBxh/sS4ttuMloNUZeSx25It4Jehoh+q7/Q6MJz/5EC53yLz2FjiDYP4zibIyTbMCz
	LUhyezobGAEb58ZOeIi8Gx1+a+ou+Wc5EBOWChNlKZkeCuP1BBxL48ra/uQyEDVhmkbgHR
	uLqHr+HEiUtU/eT0EqSbfKErpc8AuLMQx0TVf+P0cd0cXh4T68F777dF5FRbO+jPR/70dR
	+MHgF5/ynQEgzCDi9ZTmLKq2y8dPMSxUEl5bPiP9d7FWfhF0qXnZyFgq668uog==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029219; a=rsa-sha256;
	cv=none;
	b=EbHAf2RiS5aRK4ZXff1R3V2MOBv4msPA9pe7iVI/AbwhQwPcEO/P7+awBNnoGkN79IaBki
	oCOrigNOaN0pw6BcFV7BKttQch4rBS/JYvtenVUmHggsD37E1a1XZhWYmPoBuBwnAxk36z
	XpIauVFye3tKPxJ07kcttbGGw4CfUoRWazw6NvjtUsYH1ldI+QYUSCX1dQDWxzIImxZoKM
	dWkJ4Akv0XbjcDQByy0/8oOfQYPsuflEvfdyfGCvc8wJbe2Ebvb3mQT4XrdtnuaPlb4Lxw
	XJXwnMceVYQ+jOQ7pgB5bZA6OYOBDspL+0PsJHGUB9DRlPsuWtsKe4JS9P8XsQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=HeIRcctTs60Lh3hZlYuiZ4NFqwnkYN2gjC6zRfkY6ufhgnHUgRVby8mlEtcNAPDt17M10n
	esGCqsRizbHaFTMjqKlqCUCXuoXFMyTrS24tPMmbpBGBbGkTGxEQaxhIU5kH861Zr3Gd35
	+SI0WeyLePPP60xmPxZCzl6vAfFIwevdW36Deo98BdslyG74/mGyi38JsoGO/YEhVdZQJY
	WocXHI6mi5r1mDR5HSNNWQaP1uwY9tmIxIPIsWyGjO9g1eipg/DT4Wj9A8E0Sfr5g5xFfy
	TMP4d8t6StbqvGi0Nsn5Xpcqaz3B4yEsQqCOGsPQhM/ywQG/MuTqWvwvx2v41A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wpj-24;
	Thu, 15 Oct 2026 03:53:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5F2A05C4775;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/37] can: raw: remove redundant NULL check before netdev_hold()
Date: Thu, 15 Oct 2026 03:40:00 +0200
Message-ID: <20261015015336.816543-3-mkl@pengutronix.de>
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

From: Sang-Heon Jeon <ekffu200098@gmail.com>

netdev_hold() does nothing if dev is NULL, so the check before the call
is redundant.

So remove it. No functional change.

This is the result of running the Coccinelle script from
scripts/coccinelle/free/ifnulldev_put.cocci after commit f83b8a58695c
("coccinelle: ifnulldev_put: update outdated helper names").

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260831052031.902699-1-ekffu200098@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 0acd4f6c6dd6..6944ebab3feb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -529,8 +529,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
-		if (ro->dev)
-			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
 out_put_dev:
-- 
2.53.0

