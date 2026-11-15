Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742568;
	b=rJUoQClUSCXqtOXc1v2M230oSkZgNe5hK25nAHA4PJ47tz3Yo2fAh+5IdG/RDV0dg/mS
	 E8A+qr198Mn7Ouu6C+nOgwvPuq9s31891yz5RcXIcRbRCuyCEyB7sIX2wRl93yEjEzUmu
	 NtmHX3bsAhVLhJZgogqVx+zwfkkPNZENj1CfXfO8kYBRiiVW9BGScA/LfZ41Q+YUXWQe+
	 9WEnIwbsMd6zvXhOqj9WbXJhAuybqH71F5NV0mIC9ofFzjujJb7EG07Vfb2M9yB5+wRCj
	 CaYnMclcUhS3K8bMS+LV62cIYJuvzPkGG65Agta9UBVxMp8Mdpt3kOA9CbuGwOkMz3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742568;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=sILmx0Y/HceayuvS+uwKcOJliSM4uzlVLZx02stxI94=;
	b=2kc5Vh1kQyj+lhTT6nMmK03iA6LLfnwNj54WfUzPy8/7w8D01luKh8E7tU+3Qw+Q1Qie
	 ZnDn35tfzjUfOUOolGoDBINUnalS6FYLepqWmpVnMk9486N8oPST2PK8GpaPiF7Czq+ci
	 7tcJkVwOFgCnHFwpPGKn+pZxCMUdc2SoXGoti9S+70yMZVIsjnumE5hXsSY69DdxYVcxE
	 r293I1a4GM57k+gQUf7mj0HbYM06VHTnrZxFmMmfyYEzsEceI0zxzreO7fV0+HwTQpFYj
	 FHhscgelWfD+Bz4T1p850/MQN30oJdUB4X4HuB+ciWKFbcO3xvRoO67NhmiAqAU/F7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F880606A323
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F880606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBZtA2026778;
	Sun, 15 Nov 2026 20:35:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBZsc3026774
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:35:55 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fc9af395-3578-494b-bc6d-b8481845e435@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:35:55 +0900
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
Subject: [PATCH v14 2/6] can: j1939: add a safeguard to
 __j1939_priv_release_work()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <1d96e742-0479-4c36-ad0a-a0aaeda0a4fc@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <1d96e742-0479-4c36-ad0a-a0aaeda0a4fc@I-love.SAKURA.ne.jp>
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
index e1602b9a0c86..e5b8f486a1e9 100644
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

