Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA46427A10;
	Fri, 31 Jul 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505391; cv=none; b=m9wRSGjpl/Rzy6r4puGu26wut/yIBnylsQZcXJ32gQ/DNx5MqBDrTzlxoKCUTuHd+vhpfvRtAiS97umNLFbpCfIXRrSnDXqGd316QIwRBR38jeRRU/OaJjKaMJ+IdxCaKWaxlToXsYbUw0HnlHHKDYk4VQkbPLUmJyIWFlRMJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505391; c=relaxed/simple;
	bh=AEScCkDmCcgAflb4s9jaU0iJstTng+rW0KnSTfrcLVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzWDywSO5ufUmT+6ByMsRJ2hlAT5tuiwZYb4NqvT40UyKy/8Z4ExaJK02Hg8QB2E+seSHUOEeGhR7liWn0htjA5pM71+j4HJ8gE6Bpyd9zDTdRc7Dgzf7y4gPeqr1gd7kSvY8OUsaOcNc+jCKrHyErE7Zl24ug7f6tR0f28Pe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=LBaWNgDt; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="LBaWNgDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785505386; x=1786110186; i=f3lix.dev@gmx.de;
	bh=XCmjSixO+4gtIRU3U+nWyeLFjP8QTUg8B/5vfX/DgbY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LBaWNgDt6tYOOI5dd3ibYreLXfIGE1B06/xioqxqa3PYrYr5cR+9+98kUrHn4G5F
	 Gu8jJD7YiJGpHI0wZU4SrIWbicSKI59+0lfIQzJYovwDsb+D3TC/gu5pKMX2q7kUb
	 9Tc9BGsfVhEvydGvhv8u3VJtC+vgebanA/uHVsyoxymrBX3KA+anTboBdU7FkKz51
	 to71OEJ7YIn77N7V7dawND219ywdHDaQZvLhbJaVcdjKufG4ppnf5y4WTQGFTP96n
	 azXKYYCoBsVqtHJsJ72cWQhMQ24E6zjRUoO/hGWe6iSrIBz5Z2sWpeFmV7yHz/RFX
	 punamqvh60Vwy9b5yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1xLq4t1aSz-00bIRX; Fri, 31
 Jul 2026 15:43:06 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: linux-can@vger.kernel.org,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: j1939: avoid address-claim timer deadlock
Date: Fri, 31 Jul 2026 15:42:55 +0200
Message-ID: <20260731134255.1002902-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cYF27y5r7s+xYzq+Os21XoK/OZTg3VOVMblCL5lGvYWhrRo/O1u
 80QkOMP8ChQ5+tW8p9hh4+LtANNESdiINd55J4BumLqskPI7qUehN84zEH6j0X5Zx+BuCIy
 bspZk1wo/sQDP/sObPWBB5ueGc3NZgmj6yQEfNZmrpuceBVSJt1wGCPUBTqBwteUuVKqocf
 FFRk9OuKqcBlI8kEoOIiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NlfZG61cReQ=;zPMvzMKq8lOzB/3rYd71HVLKT7z
 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
 ol4

j1939_ac_process() holds priv->lock while synchronously canceling an
ECU's address-claim hrtimer. The timer callback takes the same lock. If th=
e
callback starts on another CPU after the receive path takes the lock, the
callback waits for priv->lock while hrtimer_cancel() waits for the callbac=
k
to finish. This deadlocks both CPUs and makes the system unresponsive.

Do not wait for priv->lock from the soft hrtimer callback. If
address-claim processing currently owns it, move the expiry forward by 1 m=
s
and restart the timer. This lets a concurrent hrtimer_cancel() finish and
remove the requeued timer. Without a cancellation, mapping is retried
shortly.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT5.6-Sol
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--

The deadlock was reproduced three times on a 2-vCPU kernel with KASAN
and lockdep. Cross-CPU GDB stacks showed hrtimer_cancel() and the timer
callback waiting on the same j1939_priv lock and hrtimer.

With this change, the reproducer completed 420 stress rounds, and the
patched CAN J1939 syzkaller campaign remained operational. The trigger
drops to UID and GID 65534 before opening its CAN sockets. A minimal
reproducer and the complete stack capture are available privately on
request.

 net/can/j1939/bus.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..ac654dc8872e 100644
=2D-- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -131,7 +131,17 @@ static enum hrtimer_restart j1939_ecu_timer_handler(s=
truct hrtimer *hrtimer)
 		container_of(hrtimer, struct j1939_ecu, ac_timer);
 	struct j1939_priv *priv =3D ecu->priv;
=20
-	write_lock_bh(&priv->lock);
+	/*
+	 * j1939_ac_process() cancels this timer while holding priv->lock.
+	 * Don't block here, otherwise the timer and receive paths can deadlock
+	 * waiting for each other on different CPUs. Retry shortly if address
+	 * claim processing currently owns the lock.
+	 */
+	if (!write_trylock(&priv->lock)) {
+		hrtimer_forward_now(hrtimer, ms_to_ktime(1));
+		return HRTIMER_RESTART;
+	}
+
 	/* TODO: can we test if ecu->addr is unicast before starting
 	 * the timer?
 	 */
@@ -141,7 +151,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(st=
ruct hrtimer *hrtimer)
 	 * j1939_ecu_timer_start().
 	 */
 	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
+	write_unlock(&priv->lock);
=20
 	return HRTIMER_NORESTART;
 }
=2D-=20
2.43.0
