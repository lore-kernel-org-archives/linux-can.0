Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378614;
	b=N2k89kyy4NE0RxHuszmkw4sTtfJAWO/+0Ewk2bI+7uOSl1EZRmRi0m9PL+z9wGQeD0j0
	 JZprfHAMKEhSuiaUOP4IqLnsFY+owqla/i9hVreYrEUUlPmUzAFusrPHh8RYtoj0vdEy0
	 z5j4rfncnQyoIk/nGLyrrIOyPCX4ji0Ul6QpzZZG8LkCpwKXsRBraOjehLK87eBzUhaPs
	 KtR2zP1i9pFHUxlsSzTjoQv54RoVvlMPJxaroMLU9ddl7tQ7G6ZvD1QZgu1oz9hxeJwPj
	 WVmCUKDuyokwvysZ8wPFifVAhp2b+pNwmauoV4qdfrVP6zgxXOauYWvKahLf9mosNRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378614;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OkP72PiE2ON2H9VZh3M0HnWeTkIa/MFwv0dP7X1pRv8=;
	b=SJ5mqzn+q5MhOL1G49Na+k3AvlKZVuCNbMOJTfXNYc2uxN09EDcQs8ZNNMPgsqLOHlO/
	 6iY/N0QV6lsWSjaxcUNE1UJLuWNC2Tv0r9+lc2wwT80l3isCmKeHYSkX57wyTn6PNxP26
	 vptAji8gBeZzWtvf9lrPOYd4XxJ5C3o8MNL6l2P4UHns8qv7yaFTllOxvMLUc54y80Zlg
	 7eBhkklzmm2XlZgQJc9ZNiuLpd+6fdRnEI4Q2GcZEPhMJr/wOX6A++Vf/4o9Bevd3iltB
	 vmSi+UzZhlJRUlQZ67aW9HEhNaGnL3/7jH+BjJZdXUEAunGs9NgiKlRkK5Ttge1eeow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F7wfYg17;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F3606A321;
	Wed, 11 Nov 2026 06:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A41F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F7wfYg17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=OkP72PiE2ON2H9VZh3M0HnWeTkIa/MFwv0dP7X1pRv8=;
	b=F7wfYg17IGNRwcVZzac9OMBgJgrkx9RprsM+NqGDFeTHIfBSmJsnp295tzEmnB
	ygrPTFTko6F8oNzIfNmEM2HNAmMjyN1iXOQDyut6Ud2avCLhyimtQrXSu2ecIzlZ
	Mpmyfohcc9eVICL3byoVwN7TdSEKUHjvld9IhHC/QCxIc=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v7 1/4] can: j1939: arm the abort timer under the session list lock
Date: Sun, 08 Nov 2026 09:34:23 +0800
Message-ID: <179410166345.60581.16722127854597502548@163.com>
In-Reply-To: <179410166344.60581.3898011861151549156@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n7ReC_RqVbDqGQ--.1148S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kKF48Kr4kWr18Kw15urg_yoWrJryrpr
	W5Kry3Gr1DWr4xZrs7JayDWFyFvwn3Xr48XF1xJ3sayayakF45tF4DG34Igayqyw4kA39x
	u3WSqw1DGw4kW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo89NUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4x+xJ2r0C1+XzAAA37

From 672c37cb66569c9103f28405d455c8777c81c9e0 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <quchaosheng000406@163.com>
Date: Sun, 8 Nov 2026 09:22:28 +0800
Subject: [PATCH net v7 1/4] can: j1939: arm the abort timer under the session
 list lock

j1939_session_cancel() cancels the receive timer while holding
active_session_list_lock.  hrtimer_cancel() waits for a callback that is
already running, and j1939_tp_rxtimer() takes the same lock, so a softirq
callback waiting for the lock deadlocks against the CPU that holds it.
Cancel the timer before taking the lock instead.

Cancelling outside the lock opens a second window: the cancel/get/start
sequence is no longer atomic against j1939_tp_set_rxtimeout(), which rearms
the same timer from the receive path without holding the lock.  A
concurrent
arm in that window queues a timer whose reference is never dropped, and the
session then never reaches j1939_session_destroy(), keeping both its netdev
and its j1939_priv reference alive.  Take the lock for the rearms so both
armers are serialized; hrtimer_start() does not wait for a callback, so it
is safe to call while holding it.

A session that is already in J1939_SESSION_WAITING_ABORT also gets its
timer
back.  A second unparsable frame re-enters j1939_session_cancel() after
j1939_session_timers_cancel() has killed the timer, and without a rearmed
timer nothing ever moves that session out of WAITING_ABORT, so
unregistering
the device hangs in unregister_netdevice().

The reference accounting stays balanced: one j1939_session_get() per
hrtimer_start(), dropped by j1939_session_put() in j1939_tp_rxtimer() when
the timer fires.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..590a04c453b5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1161,12 +1161,38 @@ static void __j1939_session_cancel(struct j1939_session *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool abort_sent = false;
+
+	/* Cancel the abort timer before taking the list lock.
+	 *
+	 * hrtimer_cancel() waits for a callback that is already running, and
+	 * j1939_tp_rxtimer() takes the same lock, so cancelling the timer while
+	 * holding active_session_list_lock can deadlock: the lock holder waits
+	 * for the callback, the callback waits for the lock.
+	 */
+	j1939_session_rxtimer_cancel(session);
+
 	j1939_session_list_lock(session->priv);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
+		abort_sent = true;
+	}
+
+	/* Re-arm under the lock, whether the abort frame just went out or the
+	 * session is already in WAITING_ABORT and only needs its timer back.
+	 *
+	 * hrtimer_start() does not wait for a running callback, so arming here
+	 * cannot deadlock, and taking the lock closes the window against
+	 * j1939_tp_set_rxtimeout(), which rearms the same timer from the
+	 * receive path without holding it.
+	 */
+	if (abort_sent || session->state == J1939_SESSION_WAITING_ABORT) {
+		j1939_session_get(session);
+		hrtimer_start(&session->rxtimer,
+			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
+			      HRTIMER_MODE_REL_SOFT);
 	}
 
 	j1939_session_list_unlock(session->priv);
-- 
2.43.0


