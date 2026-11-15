Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794742630;
	b=aV3sRmS501+S3vVZqO5r4YGh5K+MZ5TqNbiuZaMIndvpvFj9R04e6MMRYltq2pVJuIJ9
	 Y1/J7EUGHzdF//kOdcL0BS/S52hjkCsZjMJigdMenqXP1yEJb45wUQJH3Pj36w3Bbazt5
	 kwazV5xYO/bFW0uOtL8uFd8IAFI/LxQCtKV2qcwgxWGTpAG2cvvuAzJfeLpQ0dhpARa4l
	 COqtfqOF0ydO04APnRdDeQYUS7gYVRWZGG1AfQrFb3MsvxZidlFcVPqrGlf1C/ve5lt87
	 1FJBxU4NIyqKpR8FyaoxyDN2/w3AY61l4S9mZUayvcLaEK83ogxxT0Y4wRTaNuLhEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794742630;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=UFKy8MqLEatABI8fXsga4GKi1tAdrZXKlNEt7p+5XMc=;
	b=4vRkHMxBC1OJEFb5BHIk4Z3dYymtI+6cj6wH4OvcmOIuL1YxUkci3urFQBIuC2mlLIOi
	 s/wbax4xdRBgVf2UWpg6KiYzrjbI0yHxunDDU1X0hgFa6ESu5dKe1GQge949zTM3wv2V/
	 0nxbU5CDJESwDPlcvm0rXQYnLdtr/KNk7v/Qg9biksG+BubssqE4nyOUGQMUbXc6PL2hG
	 KHMqdfCLyBbkPpNOPydNyhaKlFvT7u8oFK1rgfhhSo1uphU41/ar6PGYQHu5N8Muku0dq
	 QgI2OIB7ZlDugdtk38fxjNxCnMock9KvQqnfdXW76xThPl+KAfjZiD7aB5ktLi0d+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD5606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3CD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AFBaw6O027092;
	Sun, 15 Nov 2026 20:36:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AFBavX2027087
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Nov 2026 20:36:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6a627b63-8d8d-4bc9-8533-3f3d8f4a8cc4@I-love.SAKURA.ne.jp>
Date: Sun, 15 Nov 2026 20:36:59 +0900
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
Subject: [PATCH v14 5/6] can: j1939: fix "struct j1939_ecu" refcount leak
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
X-Anti-Virus-Server: fsav311.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by

  (1) preventing ecu->ac_timer from re-arming in j1939_ecu_timer_start()
  (2) making j1939_ecu_map_locked() no-op

when a netdev which is associated with j1939_priv is no longer registered
(indicated by ecu->priv->ndev->reg_state != NETREG_REGISTERED) or
__j1939_rx_release() was called (indicated by ecu->priv->rx_kref == 0).

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c    | 15 +++++++++++++--
 net/can/j1939/socket.c | 10 +++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 3924404152a2..9b40f3754623 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -56,6 +56,17 @@ static bool __must_check j1939_ecu_get(struct j1939_ecu *ecu)
 	return kref_get_unless_zero(&ecu->kref);
 }
 
+static bool __must_check j1939_ecu_verify_get(struct j1939_ecu *ecu)
+{
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && j1939_ecu_get(ecu);
+}
+
 static bool __must_check j1939_ecu_valid(struct j1939_ecu *ecu)
 {
 	/* Treat an ECU as invalid if __j1939_ecu_release() was called. */
@@ -83,7 +94,7 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_address_is_unicast(ecu->addr))
 		return;
 
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	ent = &priv->ents[ecu->addr];
@@ -141,7 +152,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 	/* The corresponding j1939_ecu_put() is in
 	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
 	 */
-	if (!j1939_ecu_get(ecu))
+	if (!j1939_ecu_verify_get(ecu))
 		return;
 
 	/* Schedule timer in 250 msec to commit address change. */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4..6e22ec5e88f5 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			goto out_release_sock;
 		}
 
-		if (ndev->reg_state != NETREG_REGISTERED) {
+		/* Do nothing and fail early if netdev is no longer registered.
+		 * This check is racy but we don't need to recheck after j1939_jsk_add()
+		 * is called, for either j1939_sk_netdev_event_unregister() from
+		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
+		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
+		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
+		 * from being called) or j1939_sk_release() will take care of this race.
+		 */
+		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {
 			dev_put(ndev);
 			ret = -ENODEV;
 			goto out_release_sock;
-- 
2.56.0

