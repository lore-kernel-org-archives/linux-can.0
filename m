Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1D3DEAC6;
	Sun, 18 Oct 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342224; cv=pass; b=aA/Et2gEPKiPyOjtyKG1iy6bhaA7O+gzlYzAdg6Wp3VsJ2TlEgPbDOAjA4JdYZQolqSkKNzO+lv8xgiLwk62X+hWGNB33h+tjoH0ENQ2G7tjhk9c4wnZsEajrAFLPhh0flSHl1tEsqLOWk6CIqvXoLHRIS02NWAMWdkLiP0n7us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342224; c=relaxed/simple;
	bh=icwttVp/gpJ9Ow/0dJ5cGcW3oVQP3H8pD+33rsf3U90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmeZuAMO2YAEDAiOJA7dzNyDqJ4ppbsjJOAoYnFHtXk5M6SkeyGsZpzYtpf0s1XnqEgTZ9dPQnWStfOaqI1o286yD1apBkVHKfsyfPC6KnTIrDRiZ6kBQ2yICx2LWPdYVM+xUSTS4ItVxi8cu+CtGqrKFs7jG+9QjqUv0bHKFqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Es8cpYvP; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Es8cpYvP"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C6544202809;
	Sun, 18 Oct 2026 18:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=Es8cpYvPv9bd18RgAldhwxepEnI0IDBc+nSaBetdA9PK47A8Gmbg83/3u49CpK+ayYimlM
	HxKEi5WALbx9uCb5v515VLnj10ctvyVr0bQ9ZJCGB0VK3ZkNgBvSaTmLxlmO25J6YDkkh0
	CasuHPSF2tsHbI84zFJcmfpphjDL9LSxDYh+oVvdTJsVz4P7HCBSdxJeZlE5xs5IjsQEmA
	C+JWki9Knvl0gmFoSiaYBM7ySeCf8H4jr6eo8nRjaj8zBnEOKwATljrXUB0OfGWXidWSX0
	Rl0CK2PeGz3ORTADJ7Vb/kf4M9AzohpdRQa7iZWj2zArRX07pAm4r4aurvp0sg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341859; a=rsa-sha256;
	cv=none;
	b=EArmSK0nOzkaHwhS6j2k5MhuhW9Cq48tI5/NwZpLZ17RqGNRbr7AgEXw2/DC2KirDyVRLh
	YzpFKsJ6CuLic8I6ni0WJGw95OJFeWZXDo0VXgW+CnQW8GNdmv9nIvrRSeyQV6E13mi9Ub
	XOdJIpqGkj93/fe7wfI5c6jlstBtc6CpBZqHJl5JURcFFqdXJ/wCNrUhmigSxik65KjwCT
	vQbq8VMgFtIl135OvUd6ova9BK++QHK9rTaYGZ9HfUOWWoSxWkv/aKsG/h9KDOo5s7Rj6x
	Z2wc3vUwGn5HskLUHS1USmTPZilfvvJT2OcDykC1bZj2IxqRr7ICIcPqxHs/Ag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=PYsiy9y28VzveLtQKV7eU+QEuNFUIbeGyGNz7Whjk1wPQKlnC2sfnD0sT5gmBFuQ1AY93+
	WE/P4AHkZQX8nRQDuOsA4Kfzr8lZsPJSGCtWVAOv7PXb/7jPV1XDAJBbvezkyI9wiYyWAZ
	Kv/jEjwkBBJApvR9RNkoskvKiG2W5srSamnZVLv8YSKOjDibpAbzqJa+G4Ymrb7sGw72NG
	klIHhBRj9z2QnIqe6dk+jnZ4wsfcnFIgkO733akw0mjXokQbhxxWgGsNq7FeUquI0RbCjc
	5Hn0bGjoDpS8N9Rm2U3rz+7IPH/j3QP21O+mgxrYDJMRyLQjbsUGp9Ml45sVGg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzf-0006SE-2A;
	Sun, 18 Oct 2026 18:44:19 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6507C5C7D92;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/12] can: raw: remove redundant NULL check before netdev_hold()
Date: Sun, 18 Oct 2026 18:41:38 +0200
Message-ID: <20261018164417.1540449-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018164417.1540449-1-mkl@pengutronix.de>
References: <20261018164417.1540449-1-mkl@pengutronix.de>
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

