Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931057;
	b=GM/9OvJVA8WkLgQlm70Yh0g4LowEv/CVEhqZtDBS2oxGL2jOD32HPhuon9cGVOo3LlYL
	 mfZVr9sMTetYzxQMvgdJzs6tL4wCyVufFeormQ83J0I88LXLCKw1bJNQLIXr9vBHwaZgB
	 37MhT7I/LpT5XwbNyoYGa7GFafWsgap4/iEScEMPc925fsO8WwzqDo4dDLYcWVaCdKk2L
	 akeZePUChLN7DrMd1mwgZ1ejTcHhzSp1fVdxz3DZPEGN7Tf61UNGEPV6FAY9k50QGrEx3
	 MI9O9GlM8E1K5X+wi4pbMBQCtQfd6iSaDDUB4jerc8fFdWh5IU+R3lX4JLFIeefUQhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931057;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Anti-Virus-Server:
	 X-Virus-Status;
	bh=G4cooeaqTljR4GUGnsKhH/Bmmnsu/adBJ2ojrRQjUbU=;
	b=OthnAvQlTJLF79GA/TU+s0PDPj06OnvNGFhKoWuQxnyMSRLhSWdO6N5ZAafUVWjAxNGB
	 rWr4BbBT57u5v8GZY6oed+wl4/i72gDoeLfLKiFj3ikJG3578zEjZyYEwoPvBpXEziI0R
	 8cEKrmL5t4DAi78izaC2oldzavaB8DNPiAFeBH4KdrxB+sroVHuZ1AA1+WtpKQYvD9q0M
	 hkWH6pQ5LTmHibaH50FTgdonfY8UZPwJQjTWsB5GsWTV/p0wKvrqeSN9JoyNDTkHeD+t9
	 CIxfUbZbv6oelv2SA8TtP936tK4t/r1YlCNHrRDCIpgYPR8WYfJy6szbQX1i4NFP6Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551A606A334
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 15:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3551A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6AHFvKA8029926;
	Wed, 18 Nov 2026 00:57:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6AHFvKY2029923
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 00:57:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f778db47-a217-448e-9dbd-f1860afab00b@I-love.SAKURA.ne.jp>
Date: Wed, 18 Nov 2026 00:57:19 +0900
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
Subject: [PATCH v15 2/3] can: j1939: fix "struct j1939_ecu" refcount leak
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98c16a74-5ea7-476e-ab36-c98fb77b6be4@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav111.rs.sakura.ne.jp
X-Virus-Status: clean

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
 net/can/j1939/bus.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

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
-- 
2.56.1

