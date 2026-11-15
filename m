Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794720900;
	b=ql49Ms+i+/p5FJMBp7DXkFraomfxJdbKlVxogSDATMGUVgONoCpS/qUD6tYsR00EmKVL
	 7oOwkwBqqdfk01tc/vhLbjWUhDzi4If6PVOprHSeajTDVFBn44yM9A4LcN2gVD3V6dETx
	 H850E7UuNZpHnD0iNjUuvH/9zPAbg3Ch0zNRnX2UbESRVJ5yadB3KATJUh3TElZvkBKt6
	 YIbqdcrZOTpNz/OiDm3H4exAbPJPeKPsk04R8uLDjHcb2xSDsyiKgw3mgsFwdXNCX71QI
	 TpIxwfeX7rup5mUWf6LCCi5lt92+4hIpIkc7WqMtDotgumeg1OYfBEtxdUlNNbpYntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794720900;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=yxKvi7rkCNKHtxy3y8Vnu7pGobvduh0NIgfp4tDXi14=;
	b=DeeuYy5yz5pKalL+jE6LcE/3sllxkqjTwrTwMnpdI3Ltqof2ikxcCsFPGHJutfomzaJm
	 v2D+EDBRhQM3vRFruGLr7OeqLiCsodgTHdakYfhjOUDFWzktHXvrYOzpDv5MDAQuoQnuj
	 2K2J6zpdOt9qMfZLfd0Oek/jYbv9WsQNXa4U0q6aCjd2oyrqTE2nVcbhVOzWqlcLDVbz3
	 wd7I8Y9AT60dqOaypGMBsaRzVq9lXqLjepBWYOIM5+otvHmVW9JWQdGeDszh+jpcCO0oF
	 J7aXuCXtBA9vnAZY3WbMKJhVMbyLig4V4svJP2KcXI9D7W7U7M3Z/xJaVyMgTswhTsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9E606A323
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 05:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A9E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AF5YleU072070;
	Sun, 15 Nov 2026 14:34:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AF5YlO8072066
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 14:34:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3e4669b1-fbc8-4e69-8e73-6ee35cbd13e4@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 14:34:48 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v13 2/6] can: j1939: add a safeguard to
 __j1939_priv_release_work()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav413.rs.sakura.ne.jp

If a user calls j1939_ecu_put(ecu) with priv->lock held but without knowing
that this "struct j1939_ecu" is the last user of a "struct j1939_priv",
__j1939_priv_release_work() via __j1939_priv_release() from
j1939_priv_put() from __j1939_ecu_release() might call kfree(priv)
before priv->lock is released (i.e. causing UAF).

Add a safeguard that delays kfree() in __j1939_priv_release_work() until
there is no priv->lock holder.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index bfe3e6ada0a0..a28216021020 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -164,6 +164,29 @@ static void __j1939_priv_release_work(struct work_struct *work)
 	struct j1939_priv *priv = container_of(work, struct j1939_priv, release_work);
 	struct net_device *ndev = priv->ndev;
 
+	/* Wait for priv->lock owner to release the lock.
+	 * This is a protection for
+	 *
+	 *   (1) Read priv from e.g. ecu->priv.
+	 *
+	 *   (2) Take priv->lock.
+	 *
+	 *   (3) A user who unexpectedly became the last user of "struct j1939_priv"
+	 *       indirectly calls j1939_priv_put() via e.g. j1939_ecu_put(ecu).
+	 *
+	 *   (4) j1939_priv_put() calls __j1939_priv_release() because it was the last
+	 *       user.
+	 *
+	 *   (5) __j1939_priv_release_work() which was scheduled via
+	 *       __j1939_priv_release() starts and calls kfree(priv).
+	 *
+	 *   (6) Releases priv->lock, but this is UAF if (5) already called kfree().
+	 *
+	 * pattern.
+	 */
+	write_lock_bh(&priv->lock);
+	write_unlock_bh(&priv->lock);
+
 	netdev_dbg(priv->ndev, "%s: 0x%p\n", __func__, priv);
 
 	WARN_ON_ONCE(!list_empty(&priv->active_session_list));
-- 
2.56.0

