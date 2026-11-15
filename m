Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742611;
	b=40Kdj5wNewW1+gtHFLmhGCNHaNgPIyA417cM060bI7s2GCwvEJI/Yj8oVZibF4EeHhE3
	 2h1WKiLFwjp/S1tTjPxDc9wORtzjcbJpZBo+SmtYFhw6SyeEmZsRBsG/3oKor7EhsA+Lo
	 j7Z8on7yCAVIYgRzWUZTsYHQ62vVJ8yb38Ebmu8G/D4rGavsDD4IPWcvYrb64rOk059ys
	 tMkvXu9Knz+dcp3hRSsQXVTzptH+JDpOr+DjxS8isx4dIpOC0HheBa5FHTwZs3T8SOAuQ
	 +Z7vhGKq3e0bYy5aZ7lvhYGIfKs9dsaUzkxfFrbHzE92uk3gzjxfr0eMtz1TkeA8wPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742611;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=Z24vigVADf2ThVVp657k3PG5JYdZaLUmwyhVpeN48w8=;
	b=mgTklF6UOWUfHu024whcw7Fp21NFn9oz7svQdq7kpdh1kEOWcHIJNigw3okNFTsaEaWm
	 oBeuqIX46i/p7WTH1Y/WIu2fmtRa8rbaa6t2FQV9JHWLIbe/vbaEYhaeg7Me7FGALYkG9
	 r06JEQUxVMWTzCsKQsoJUt9+fqvieV6Zpi18DOb1iyocDYPZCIUcc/LE2wfGHYHah2lBC
	 Bw3LYr7boRVbcapBupFlaRWiUME1ZYPR/EApgDuT3I82V2A9vcFfQKUhi/QNiD3Y5EAYA
	 2ZUjCphOiNILvLpVhjW38f5x3bv7j17YAiGdI/wQlzGHbW/NGXk9rYiWJNNjd/MaDZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913ED606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913ED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBac7s026989;
	Sun, 15 Nov 2026 20:36:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBacZ2026982
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:36:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3c3b25f8-93db-4f98-ba96-8250eb49b79f@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:36:39 +0900
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
Subject: [PATCH v14 4/6] can: j1939: add a safeguard to
 __j1939_ecu_release_work()
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
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

Since pending ecu->ac_timer is not canceled during j1939_ecu_unmap_all()
or __j1939_rx_release(), ecu->ac_timer can call j1939_ecu_timer_handler()
after __j1939_ecu_release() or j1939_module_exit() (i.e. causing UAF).

Add a safeguard that explicitly cancels ecu->ac_timer before kfree().

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 0aeeee1491e4..3924404152a2 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -22,6 +22,11 @@ static void __j1939_ecu_release_work(struct work_struct *work)
 	write_lock_bh(&priv->lock);
 	list_del(&ecu->list);
 	write_unlock_bh(&priv->lock);
+	/* There can't be any ref on this ECU because __j1939_ecu_release()
+	 * was already called. But we need to make sure that
+	 * j1939_ecu_timer_handler() is no longer running before kfree().
+	 */
+	WARN_ON(hrtimer_cancel(&ecu->ac_timer));
 	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
 	kfree(ecu);
 	j1939_priv_put(priv);
-- 
2.56.0

