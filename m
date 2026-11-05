Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877547;
	b=LOVGoktu/I2qP3IettORqBhZcYkrMMh0NYhL7io7vJGAK5hQsTuM7QiTdCjo1/zihDCH
	 1qRuMVh4W3AtQf8Zs0OY88ovIXsQhv9A1PYQGzlt6gmAeQHCnz3FbuujyHM9ZhSErl8KZ
	 a8OjgANDpgcUSOUtBBRZPZtmZS9b5Lb8jC1SGaGAx+sudf4sA1xWnliCMacOKkftvAmdz
	 iSSSzEwDj13rjB1ZCPJ4L3JrZIMMguCM8EmDN0PHyeldXIpOu7ztmlqsdcs1FXfzx+R6/
	 b6cwdsW3s3AhlQNeSWPKkaHGqz3p3k2EtEUnO2wGR2dUsMUtPK96Vd9eTCFhvhZcswQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877547;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=cnph1XbXhQXt7bDvFz1EH0smDDcuk0gFAL8nj83eN3I=;
	b=VNykn42ROpiToemJQdHxaHSqY27e72hLHErSmtacm9nGrpWMv5Fiv45MFuI11/nefZAW
	 ZCKVHtJwjLl8Zy05CVUIBb9KyKYHNISbFCEL4+tLIMictfNAfzdnbrB8235B2hkgbCm7Z
	 oh+nBm0BCn1WF0PYiHDCQOReFiZwXZy4mc9i2vHfGuq2XYAG8TPA1e+GCJI8pazEvtR06
	 pNOBDVmBpOpqXjRayEceMgOtsneISMfDDK5l+0910/CjYH/lIhReByn2ogCphRBFMI4Xl
	 xheU48lJWhznd6AAPPgecQuSvVtNcanov2Kl4kR/sGfF8xSMLNwwo3DTyxTRuWMqVrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4F606A31B
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E4F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6A5BIrSA015208;
	Thu, 5 Nov 2026 20:18:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6A5BIqQU015205
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 20:18:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f12e4200-9267-424d-99f2-584774bd8eb1@I-love.SAKURA.ne.jp>
Date: Thu, 5 Nov 2026 20:18:51 +0900
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
Subject: [PATCH v7 2/2] can: j1939: fix "struct j1939_ecu" refcount leak in
 j1939_ecu_map_locked()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <00aae7aa-8351-4d69-8938-4d8e4eee78c2@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <00aae7aa-8351-4d69-8938-4d8e4eee78c2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav115.rs.sakura.ne.jp

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

Fix this problem by making j1939_ecu_get() also fail when a netdev which
is associated with j1939_priv is no longer registered (indicated by
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
 net/can/j1939/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 3422e3133800..11d08b748548 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -50,8 +50,13 @@ void j1939_ecu_put(struct j1939_ecu *ecu)
 
 static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
 {
-	/* Don't get an ECU ref if __j1939_ecu_release() was called. */
-	return kref_get_unless_zero(&ecu->kref);
+	struct j1939_priv *priv = ecu->priv;
+
+	/* Don't get an ECU ref if netdev is no longer registered or
+	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
+	 */
+	return READ_ONCE(priv->ndev->reg_state) == NETREG_REGISTERED &&
+		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);
 }
 
 static __must_check bool j1939_ecu_valid(struct j1939_ecu *ecu)
-- 
2.56.0

