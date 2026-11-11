Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381509;
	b=zuWisoj00QvKnpZpjWH9tv5ofNHTdslGt0VkDRSTN0q8+l8h4F8sO7Vr8zTn+2x+yyn5
	 AtV+BchugPqQJJjV15uxaFOAq7INdA8KVEdNL9W9OxTWhxtAsNyN9lkAP2uLLizhXUc9Z
	 8cCbztAA6edd0kOLE44AUXskjffsxnVCZWOzea58v+D5McV/RCdRAHUn3zhufPCTixWD4
	 /pmoyE5jhq7ERdCXcAR9hWwQBBdPpbdQQg/NymGnZLRvyQtwIfUq7nf4igLm5opPjp1L6
	 5PyY2pkuK0R3w+JYWqpTpn1rV+BY3TZrRz4CuuvwHiQB4by9qJMbaYz+/LkpWGOtMcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381509;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=aTPA1WvQE/YagBl09QWbc/Y303WAsJk00AdeJ0KzqVQ=;
	b=P0NpQBpBswU1E7D0X7+MuVUqdpQMVaXdcBA2BdO8AQoi8sMJEp27jETlQCUtsIRJSYJi
	 txNDRhivo5bc2imTMNI2Rk1ZRkDfQpneoUKb8a+XR7yU4IQiGicaXkOfPOsjGQ/gfLtzU
	 kSIalOgyucKmKKyiQ9qm72jO7nA2TVkF5Iv895pjlqJdfE7mXtXtF3RNA1S2VcxmD63ul
	 WpsxvlA2Kwx9k4o2EsrS5kkd5ZkX5BN07y9UEhyza1kEt4jyvMi6i6dIoTiz3eO3KS5S0
	 9UcgfbIHuLf+8VqgEQK7Hml9VE6IBbYRRTsvcmimMjtlQCKay/ynZyZKibaimJ50Uww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bDzklcpD;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A112606A31C;
	Wed, 11 Nov 2026 07:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A112606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bDzklcpD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=aTPA1WvQE/YagBl09QWbc/Y303WAsJk00AdeJ0KzqVQ=;
	b=bDzklcpDee476Yw6RuvsS5zlRnnk2I5/J2hl9I1HT6aWzE2IJGUDGweXC81qew
	AASCh5YKfu6Zyc69NGc71X98Y64z4p6wL03HydFaENSRdXnquPXPWFrPoZtoKud/
	4+s+4JH5PMRkeSNVHsq1eWDcyOCUM09w+csJnKDBIhsCM=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v8 1/4] can: j1939: serialize cancel and rearm of the
 receive timer
Date: Wed, 11 Nov 2026 15:21:00 +0800
Message-ID: <1794300101.11111.1000001@163.com>
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
X-CM-TRANSID:_____wD3l0WuFvRqIbshHQ--.7710S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWfXrW3JFW5uryDAF1xAFb_yoWxWrWrpr
	Wagry3Gr17GF4jvr48JFyDWryFvwn3t348Xr1xJ3s2yay3Cr45tF1DG34xWa9rtrW8Z3y3
	ua4Sqwn8Gw4vg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo89NUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-w+I-Wr0Fq+fngAA3j

j1939_tp_set_rxtimeout() cancels the receive timer, takes a reference and
starts it again, but its callers do not agree on active_session_list_lock:
the receive handlers call it without the lock, while j1939_session_cancel()
is reached from the transmit timer path and used to call it with the lock
held.

That makes the sequence non-atomic.  If one caller starts the timer after
another has cancelled it and before that one starts it again, the second
hrtimer_start() reprograms an already armed timer.  hrtimer_start() does
not report that the timer was armed and does not drop the reference the
first caller took, so that reference is never released: the session, and
the netdev_hold() reference it carries, leak.

The lock cannot simply be taken around the existing helper, because
hrtimer_cancel() waits for a running callback and j1939_tp_rxtimer() takes
the same lock.  Add j1939_tp_arm_rxtimer_locked(), which uses
hrtimer_try_to_cancel() instead: it never waits, so it is safe under the
lock, and it returns 1 only when the timer was queued, which is the only
case in which the caller's reference has to be dropped.

j1939_tp_set_rxtimeout() now holds the lock around the helper,
j1939_session_cancel() calls the helper instead of hand-rolling
get + hrtimer_start(), and the rx timeout branch of j1939_tp_rxtimer()
does the same, removing a second copy of that sequence.

Every existing caller of j1939_tp_set_rxtimeout() is outside the lock, so
the added acquisition does not recurse.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 66 ++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..fa23260e1833 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -721,15 +721,42 @@ void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
 		      HRTIMER_MODE_REL_SOFT);
 }
 
-static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
-					  int msec)
+/*
+ * Rearm the receive timer as one step under active_session_list_lock.
+ *
+ * j1939_tp_set_rxtimeout() is called from receive handlers that do not hold
+ * the session list lock, while j1939_session_cancel() is called from the
+ * transmit timer path.  If the cancel and the rearm are not serialized, a
+ * concurrent caller can start the timer after this one cancelled it and
+ * before this one starts it again: hrtimer_start() on an already armed timer
+ * reprograms it without dropping the reference taken by that caller, and the
+ * session leaks together with its netdev reference.
+ *
+ * hrtimer_try_to_cancel() does not wait for a running callback, so it can be
+ * called with the lock held even though j1939_tp_rxtimer() takes the same
+ * lock; a callback that is already running drops its own reference.  For the
+ * same reason the return value is only 1 when the timer was queued: when this
+ * runs from j1939_tp_rxtimer() itself, the timer is no longer queued and 0 is
+ * the expected result.
+ */
+static void j1939_tp_arm_rxtimer_locked(struct j1939_session *session, int msec)
 {
-	j1939_session_rxtimer_cancel(session);
+	if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+		j1939_session_put(session);
+
 	j1939_session_get(session);
 	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
 		      HRTIMER_MODE_REL_SOFT);
 }
 
+static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
+					  int msec)
+{
+	j1939_session_list_lock(session->priv);
+	j1939_tp_arm_rxtimer_locked(session, msec);
+	j1939_session_list_unlock(session->priv);
+}
+
 static int j1939_session_tx_rts(struct j1939_session *session)
 {
 	u8 dat[8];
@@ -1161,18 +1188,29 @@ static void __j1939_session_cancel(struct j1939_session *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool waiting;
+
 	j1939_session_list_lock(session->priv);
 
+	waiting = session->state == J1939_SESSION_WAITING_ABORT;
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
+		j1939_tp_arm_rxtimer_locked(session, J1939_XTP_ABORT_TIMEOUT_MS);
 	}
 
 	j1939_session_list_unlock(session->priv);
 
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+
+	/* The abort already went out on an earlier call, so this one armed no
+	 * timer.  Several callers cancel the timers before calling here, which
+	 * would otherwise leave the session on the list with nothing to finish
+	 * it off, so deactivate it now.
+	 */
+	if (waiting)
+		j1939_session_deactivate_activate_next(session);
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1279,10 +1317,8 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		    session->state < J1939_SESSION_ACTIVE_MAX) {
 			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
 				     __func__, session);
-			j1939_session_get(session);
-			hrtimer_start(&session->rxtimer,
-				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
-				      HRTIMER_MODE_REL_SOFT);
+			j1939_tp_arm_rxtimer_locked(session,
+						    J1939_XTP_ABORT_TIMEOUT_MS);
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
 		}
 		j1939_session_list_unlock(session->priv);
@@ -1729,16 +1765,10 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-		if (session->transmission) {
-			j1939_session_deactivate_activate_next(session);
-		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
-			/* Force deactivation for the receiver.
-			 * If we rely on the timer starting in j1939_session_cancel,
-			 * a second RTS call here will cancel that timer and fail
-			 * to restart it because the state is already WAITING_ABORT.
-			 */
-			j1939_session_deactivate_activate_next(session);
-		}
+		/* Both roles: the peer is restarting the transfer, so free the
+		 * slot now rather than wait out the abort timeout.
+		 */
+		j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}
-- 
2.43.0


