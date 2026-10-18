Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746913E7BB2;
	Sun, 18 Oct 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341868; cv=pass; b=WRWD01ppeQAT9fcrxTn5xpBGXw+AGgZIHI1Ye2VfkuMqXZ+Q0DkWsuGImqdXpWlGhUS8W3ik0lqCX+gADUCWf8N2MOtwMeo4V9qiGP3qrhYCrikLgLmtBdJU4/TJVRFBpSMlpcy6qGm34BwZnLm6aQ9XR6cXJNYAfsWrAlcxT+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341868; c=relaxed/simple;
	bh=GpwLxlR+stR1Rg8gaukBUWthMh3zZEVhHmxNYmSU9I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmWHeXmEMx9nU/uh4eL6pIX4zbFJcrg5/18ESl/TVP+KVPr5RyZjgF5uAWbo2fcN6DimuD9Yws6Sjvp2JYHNwyWwc9Et6cYYuzZmvLloRTS/blUEVHckm9u+77io//h+pfndqNEDfDYpM/neTDPv1+iHWPYQJ6z/NhiMtEXlyY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DnszBOI+; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DnszBOI+"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4BE1E20283B;
	Sun, 18 Oct 2026 18:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZVDy+lqgjH+/oz52DDKW89DZkuncBqspjxQsK1q7hg=;
	b=DnszBOI+b+khVa6jDty9XCR1kR4RpxdWVTue3I1R7Nbwu1Jb6rlB4QT/E0C0It4Z5cHao0
	cg6Ka9F/YHEXUfo0oAgKhohyxMRK03HDp6NVpHDPznB0egd38JWRYRCX0p8L804D4gQG6p
	Awenh8kh6cuDeaPWTsE93etqCKavRgFwx1k1X9PbvD+c/EJBJIGL4EZpxjNHElofvJbv7u
	6XVqNTUcMpoTHGjgsU3rLyd7gUDin7TVMNCLj4fLelHNHUUJ+ek9TTjVC0/HH04O10sLcb
	PXZiIYDmYjwAmhpz7WC3qxNmLlMExjkK4CLLsmh5RN/jM4Vf/V/i85lwzgVvGQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792341860; a=rsa-sha256;
	cv=none;
	b=Lpp3boBYaxsets8FvLpEcvMH3G7zkQlAWqrV2GBiBD+dDoJo+3rrxybIb51ES/h79Htpvt
	akOCWWo/k2JJTzaz3sgrWzSZYoYIfmchw/FoqaJhbaccCBsfpNJl9vR/kf9iRW1yE6u7vN
	ahRfXh3OQBhRddfJpvj/Mn7V8sMPPDfjhDEFNl3pZw8FKf3YiuvSCM8ZW+J1gbQ8JPKzlZ
	IzQE5bjARqy5sFNLtjA7V88y0yROF+IlgZP5LjhVkg45sPiTw/yEHlNE9CEroTG9CtY3kM
	Fc2KqyPTNPhDNmtK2EGjfRfBAT3jDS5U91KMXgei1bS1aotNH5hxFR4ZyExpYw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792341860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZVDy+lqgjH+/oz52DDKW89DZkuncBqspjxQsK1q7hg=;
	b=J9ofz5y2yFvMd40G2od1C05THAx2qgcQg7mkW+ljVvB/sVSMvQ74LRS29i0MigrEyPZ20L
	AkEqsY7mCqaA8IFt6ah8MnMu6IFGLnrrsDVtV8XJ0j/U7Ko3NUpkJ4qPv9kQEaUGD9FhzN
	DFr5T4cRmaMtVCj4QwHnSdlqSxtNBES+9GWna6/A6JSJCsk6HEFDGVHnl9l/4B+v/+tBs0
	ZABS9leSXA7PnO/ahaW6VYzB3ntbBxeCtuPGQBKD4+Zb6hAo/qpNWOo/52izGLzK3A3L3p
	weMs8L5N0C8vFl3zJd8inFavszwK1W6vQgblUnjiaNXoD7VJyKVE2AllFweBWw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xITzg-0006Sa-0e;
	Sun, 18 Oct 2026 18:44:20 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DE2A45C7D98;
	Sun, 18 Oct 2026 16:44:19 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/12] can: raw: take rtnl_lock() before leaving the notifier list
Date: Sun, 18 Oct 2026 18:41:44 +0200
Message-ID: <20261018164417.1540449-9-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

raw_release() removes the socket from raw_notifier_list before it takes
rtnl_lock(). As the netdev notifier chain runs under RTNL, a socket that
leaves the list in this window is skipped by raw_notify() and has to
remove its CAN filters itself.

For raw this is not harmful: raw_release() removes the filters with
dev_net(ro->dev) under RTNL, so they are found even when the bound
device has been moved to another network namespace in this window. The
receivers only remain on the moved device until raw_release() gets
RTNL.

Take rtnl_lock() before removing the socket from the notifier list, so
that raw, isotp and bcm use the same locking scheme in their release
functions. As the notifier chain is always invoked under RTNL,
raw_busy_notifier can not point to the released socket anymore. Replace
the now dead busy-wait loop with a WARN_ON_ONCE().

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261016091128.325332-4-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index dfea48768b23..d95ce54a4c45 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -422,16 +422,17 @@ static int raw_release(struct socket *sock)
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so raw_notifier() can't
+	 * be walking raw_notifier_list and point to this socket. The spinlock
+	 * is still needed as raw_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&raw_notifier_lock);
-	while (raw_busy_notifier == ro) {
-		spin_unlock(&raw_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&raw_notifier_lock);
-	}
+	WARN_ON_ONCE(raw_busy_notifier == ro);
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
-- 
2.53.0

