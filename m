Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B968370AE5;
	Mon,  3 Aug 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752238; cv=none; b=urVzADrsGa/Z2yIH8n4kUoAqSFOSE15V88KOz3ZhmNMWiiVnGnT3bUiA0EW1C7Bc1dnf6Z9I33gwj/N6t5nbxHD2v1sXcnLTckswOuHddF0iBhqiI1B6/H0CJhcOhgQ8ruLjNm8MktM74p0okTr3rGiX/Aq2sqCX/OiPG9fEWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752238; c=relaxed/simple;
	bh=IU0Ero1Pat8ivKeKU1IZyDE/nMfbr9OHXpnKS1ysLPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYp9EhDcveYqO7wdSozqcYtJKGtk0xSzxCNmCLDWNX0yiZX+KgDqY6qnOlUMpbZFKK7L9IpG6OIzdXzVHJ8VwyM9W+PMjqaZ5sfkkAMU6qIU8QCD4Bbb36dVgcW+um/zv0rYr670La429l3EtCuJRdiwfnTbvVNfCANwTa884XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=eIrN5u3m; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="eIrN5u3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785752232; x=1786357032; i=f3lix.dev@gmx.de;
	bh=iXU7sSQmV//akItxrqGb6Zo4LBsm3gHp4fI+fOmjANk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eIrN5u3mnLGJ1K+nrU1mNHzDPuCV234L31FgDv9MTdUNTH+Vv+yD2Txp9NGqwQEq
	 vcfxbPl7aRQ1Jrh60A7/70Vntyy/sMgSO4shZA0TvpyWJzUlmj+mNTHWacE7P9I1S
	 VCgU0RFHqfamN9ubX8coRwubROmPV+ORHdZJeaPDBHiA07vyEpTIJPgMXpkAnR5XS
	 8jF9RwzF11Wa46W2sTGcVdGhmTK6P0EfokDxlQKalEdAq8U9i5AHXXQDjLJ9i8NuA
	 pgPak+2LDAqUecHhidbIEWfd1qdkr2T2OV5iQyEZQXOnX9DTXCiSkADDr1HsFm1zJ
	 fsVRaZg5VmAgB5vneA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MirjY-1xMtES15ZE-00kYcG; Mon, 03
 Aug 2026 12:17:12 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: linux-can@vger.kernel.org,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH can v2] can: j1939: avoid address-claim timer deadlock
Date: Mon,  3 Aug 2026 12:15:03 +0200
Message-ID: <20260803101503.21023-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731134255.1002902-1-f3lix.dev@gmx.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jgVMEq8WZDStrB4CvMWqNPWAfYp2UQ6DzatKUQUCwtoCz6OUM+3
 dnSIx9OeXH2dk99w2iFujgo1u/ds15JSXe58mDw1T0lsk3R7hOYcdz/brZD8ve6zOplNSMw
 7wz/JoNeBbFZLkkodmrXfTigfQA5HMd83iQqX8KdcKE20U69QlT0DGSY6rJ3XFhQGcBZW35
 oRKU9G9lfa1FVz8LpoZWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aZaGStGKBBM=;7UF4x90F0NyZgoqYgxEqiiU0ooh
 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

j1939_ac_process() holds priv->lock while synchronously canceling an
ECU's address-claim hrtimer. The timer callback takes the same lock. If th=
e
callback starts on another CPU after the receive path takes the lock, the
callback waits for priv->lock while hrtimer_cancel() waits for the callbac=
k
to finish. This deadlocks both CPUs and makes the system unresponsive.

Replace the callback's blocking lock acquisition with write_trylock(). If
the lock is busy, move the expiry forward and restart the timer. This lets
a concurrent hrtimer_cancel() observe the callback finish and remove the
requeued timer. Without a cancellation, address mapping is retried shortly=
.

The failed write trylock does not necessarily mean that the address-claim
writer owns priv->lock. Receive processing also takes its read side for
other frames, and an active reader prevents write_trylock() from
succeeding. Document both the address-claim writer and receive-path reader=
s
as possible sources of contention.

Name the 1 ms retry interval J1939_ECU_TIMER_RETRY_DELAY_MS instead of
using a literal in the callback. Track consecutive failures per ECU, reset
the counter when its timer starts, and emit a warning guarded by
net_ratelimit() on the fifth retry. Five is a pragmatic threshold for
detecting unusual delay; it is not specified by J1939.

The timer uses HRTIMER_MODE_REL_SOFT, so its callback runs from
HRTIMER_SOFTIRQ with bottom halves already disabled. write_trylock() does
not change bottom-half state and must therefore pair with write_unlock() o=
n
success. The write_lock_bh()/write_unlock_bh() pair is unnecessary in this
context.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT5.6-Sol
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--
Thanks to Oleksij Rempel for the review.

Changes in v2:
- use the CAN-specific patch prefix and omit the netdev list;
- clarify that both an address-claim writer and receive-path readers can
  make write_trylock() fail;
- replace the literal 1 ms retry delay with a named constant;
- add a network-rate-limited warning on the fifth consecutive retry and
  document that the threshold is pragmatic rather than protocol-defined;
- explain why write_trylock()/write_unlock() is safe in the soft hrtimer
  callback without the _bh() variants.

The revised patch passed strict style checks, and the affected J1939 code
built successfully with additional compiler warnings enabled.

 net/can/j1939/bus.c        | 34 ++++++++++++++++++++++++++++++++--
 net/can/j1939/j1939-priv.h |  1 +
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..eb9a3fd847f4 100644
=2D-- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -10,10 +10,19 @@
  * Since rtnetlink, no real bus is used.
  */
=20
+#include <linux/net.h>
+
 #include <net/sock.h>
=20
 #include "j1939-priv.h"
=20
+#define J1939_ECU_TIMER_RETRY_DELAY_MS 1
+/*
+ * J1939 does not specify a lock-contention retry count. Five retries are=
 a
+ * pragmatic threshold for warning about an unusual address-claim delay.
+ */
+#define J1939_ECU_TIMER_RETRY_WARN 5
+
 static void __j1939_ecu_release(struct kref *kref)
 {
 	struct j1939_ecu *ecu =3D container_of(kref, struct j1939_ecu, kref);
@@ -109,6 +118,8 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
=20
 void j1939_ecu_timer_start(struct j1939_ecu *ecu)
 {
+	ecu->ac_timer_retries =3D 0;
+
 	/* The ECU is held here and released in the
 	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
 	 */
@@ -131,7 +142,26 @@ static enum hrtimer_restart j1939_ecu_timer_handler(s=
truct hrtimer *hrtimer)
 		container_of(hrtimer, struct j1939_ecu, ac_timer);
 	struct j1939_priv *priv =3D ecu->priv;
=20
-	write_lock_bh(&priv->lock);
+	/*
+	 * j1939_ac_process() cancels this timer while holding priv->lock.
+	 * Don't block here, otherwise the timer and receive paths can
+	 * deadlock waiting for each other on different CPUs. Retry shortly
+	 * if the lock is held by the address claim writer or by a reader on
+	 * the receive path.
+	 */
+	if (!write_trylock(&priv->lock)) {
+		ecu->ac_timer_retries++;
+		if (ecu->ac_timer_retries =3D=3D J1939_ECU_TIMER_RETRY_WARN &&
+		    net_ratelimit())
+			netdev_warn(priv->ndev,
+				    "address claim timer retried %u times due to lock contention, nam=
e: 0x%016llx\n",
+				    ecu->ac_timer_retries, ecu->name);
+
+		hrtimer_forward_now(hrtimer,
+				    ms_to_ktime(J1939_ECU_TIMER_RETRY_DELAY_MS));
+		return HRTIMER_RESTART;
+	}
+
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
@@ -141,7 +171,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(st=
ruct hrtimer *hrtimer)
 	 * j1939_ecu_timer_start().
 	 */
 	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
+	write_unlock(&priv->lock);
=20
 	return HRTIMER_NORESTART;
 }
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..5ed4f4b592e3 100644
=2D-- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -36,6 +36,7 @@ struct j1939_ecu {
=20
 	/* indicates that this ecu successfully claimed @sa as its address */
 	struct hrtimer ac_timer;
+	unsigned int ac_timer_retries;
 	struct kref kref;
 	struct j1939_priv *priv;
 	netdevice_tracker priv_dev_tracker;
=2D-=20
2.43.0
