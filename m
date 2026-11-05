Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880439;
	b=nfPlD80E/2Jip+IeEsb0ccpw+ga9SKkgqBt/wui29byMjpReOwDzHm9PfdLXAKzNWgZM
	 hlUBm5RLW8EIGgSYKbay/6ty+XkabuJygRvnvDg/wO4NrmOYwRPhpibwXqqEPDTCfcHOk
	 wUdgToN36yey4OCPm2oOD+AL528UKL3ztT5V4oY32opFw7gP55alvR4PBbT6DuFfx5+Dp
	 0Rl8w4YtA3EZBqkkPwljnA4eUmVzjxw7Tlbf1dP9wDm0wKRBSDoCByDnAUxO5t2kq83P8
	 HokM8jS9SP21w+kohb3cIqoPx0rbilWMz13WpsIrPDJY9Dgq6ifdu9wH8MTE1+tp5ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880439;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=Uyhbz4DgRRKvDkevznvN2WtRPTCOATJhniaOCD2aQHg=;
	b=gM6t+H0EqMYUIOZHdZEWnTqVkJc1ayU3blFZgGS9RYPmMgvicMSIa27xNN/iK94hAZcd
	 0IthJ9gFtHLY202l79JlKYhQDbiHilB2f3koCmIK8Z2LTE9IXAfoVvvN439VcoqCvrDgJ
	 2VwpB4oA/bCMJpw43b80dnqVMEuSc6hNabuVozsjT5s7UTFYSDIaAFFPAeOjZZwkHy/bZ
	 PT5Ek3yV6iD2ScM1d/icAvY6llVPu6g95ojKEhNe/1ZyKTL0KTkTJU0gVdqBKQLILB0vZ
	 /R0KNIOLBXegxfxKK0oVxjEd716nZ5zl+vyzabJWGLbeFTkUCb1YjW/oZmg50S5EHbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA107606A31B
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 12:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA107606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A5C717x061030;
	Thu, 5 Nov 2026 21:07:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A5C71Aq061026
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 21:07:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cc9950f0-a9e8-4639-b2b3-28d64f8a906b@I-love.SAKURA.ne.jp>
Date: Thu, 5 Nov 2026 21:07:00 +0900
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
Subject: [PATCH v8 2/2] can: j1939: fix "struct j1939_ecu" refcount leak in
 j1939_ecu_map_locked()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by undoing j1939_ecu_get() in j1939_ecu_map_locked()
and failing j1939_ecu_create_locked() when a netdev which is associated
with j1939_priv is no longer registered (indicated by
ecu->priv->ndev->reg_state != NETREG_REGISTERED) or __j1939_rx_release()
was called (indicated by ecu->priv->rx_kref == 0).

For now we don't cancel ecu->ac_timer from j1939_ecu_unmap_all(), for
we can't safely call hrtimer_cancel() with priv->lock held. However,
since ecu->ac_timer expires in 250ms, for now let's tolerate delaying
completion of NETDEV_UNREGISTER event for less than one second.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 3422e3133800..77b678806057 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -84,6 +84,15 @@ static void j1939_ecu_map_locked(struct j1939_ecu *ecu)
 	if (!j1939_ecu_get(ecu))
 		return;
 
+	/* Drop the ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called.
+	 */
+	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
+	    !kref_read(&priv->rx_kref)) {
+		j1939_ecu_put(ecu);
+		return;
+	}
+
 	ent = &priv->ents[ecu->addr];
 
 	if (ent->ecu) {
@@ -179,6 +188,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
 
 	lockdep_assert_held(&priv->lock);
 
+	/* Don't create a new ECU if netdev is no longer registered or
+	 * __j1939_rx_release() was called.
+	 */
+	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
+	    !kref_read(&priv->rx_kref))
+		return ERR_PTR(-ENODEV);
+
 	ecu = kzalloc_obj(*ecu, gfp_any());
 	if (!ecu)
 		return ERR_PTR(-ENOMEM);
-- 
2.56.0

