Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D754DAF96;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553422; cv=pass; b=naFFS4tDIFJFBLts5If/DK4295+HuttyEaRzBpeEBJ50w4oYbmi5zeP433w5IfhtIEQQpt54hzVec2qlejsDcyXUYJTjffizjsIbbeUlhsfEb/+J8aRMn/BxnJ9mhu7HSsAA8+bZ43/VVqqBRKKYisuhWU/tQhrgC36rHVRB194=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553422; c=relaxed/simple;
	bh=hDROgjyd8gXR1MfXndI8asr+7/gjZn/tP6i8YNE/J0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScpJqdPlOpx8YMWIvcJ5JYxrHX6uIne/74C9VfMmK8rLJjLcOvqJ9kNplUf3yjMV27YgLHzybnNpaU9cSwuC3RcDDMLlxvQYLFklkYc87EHEANjsYHCbdkXB2knJf70dPFMAre2DGSvX/0HIp4/uKu8V/DeOJV69KLaGtk9mcCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=K8GGl0Hx; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="K8GGl0Hx"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2123B202608;
	Fri, 09 Oct 2026 15:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rt+3lf4kLtp+XwoejmKj/N3oRWkeJkex2tbAZ9sd5Ck=;
	b=K8GGl0Hx2JQwz9qGwZ4ZSeRCHWHHrEIwPU6Rx1b2pgYSO/zgx2PFpm3Z+THH5gFN87/Try
	0RNlGLlJX2pmu5iax3bl1OlLpmF5b3hOB3RACWmidBE2ig+oWnBO0JkDu+SnStnbZhMonh
	u4jFsMMxIJIKZ7cWuOh9MyGw4JnLDHKhe74+qBw/ROYaihoeYu+9qImTUixAxqumDDKofS
	1Df+AwAPWGEboG0GiUxBp6/LHicVizChXKAvwQ6Cwez144PZYfLIpvE6TDpZpg96c476Vz
	6LLE0b79yBXVCFeQAYSyTrDIVZ6OBtkzs7anhku9IeJfFd/BPZag1wBscsSw1Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553413; a=rsa-sha256;
	cv=none;
	b=FYUSkVCWCByBV/MDIe/YA/SfOcZC2GxFr/mRUW6rZaiOc1zNKiB193x0Vs4w/gxyXzbWJZ
	A6IjpGmHOP2ePZZFI41P9B+ua6yYs2tnXsmP0mccRU9gF/r7zFYRXB33Ygq23BGWNDwocN
	p6epXFApdTXe2O6hLFk98dSaU2/OPg+JCoWcATHYA79m0VGCutbNW6MTFxM7lJ2EUU/4pU
	jTxFgBcnQsdxOlB1LPc19e42l3q3koFI4eRi3Kl+FnmXkxMLYj7LXpoPDwr4pU5azPLEUj
	OjSBIp/eOe1/rXgDbkDOzAL6ZF3dA+V2wugljDKNcCL7DC5HtkDJgC3aUIQn5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rt+3lf4kLtp+XwoejmKj/N3oRWkeJkex2tbAZ9sd5Ck=;
	b=gfaiOe4dtyqW2at9CIaDWFKibbDdWLJqSHQdzSfTKuwSJlH7mBOsnjLoB97eEO/RS76h01
	2hS4t8uj6xIlfWNzzrQM3xuF65JPdqW8+T4QvaA8AU0p5TaNBCOPoVQMAXWghZqLONxASd
	sc4Al3efQ6zoYts7WhGCDa6VXLHf0cFDSPzMbRXFSHhTupz8SvKsZxdpuiJlS0Bo/VvK0G
	vTXcHK84MEMB4CjIn2qVzlVPxl7xwrZ0bY9XO5NFeAIWIrKiMSQ0/c1zwcKGF4sP2pCVgK
	IHMwoUMJdL59YdDc/jnmdT+2fN2B6FS7YzKnFkNxw8W8l3+zzQFWxYgaxCkx7w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsn-0053Rs-07;
	Fri, 09 Oct 2026 15:43:33 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9EF0E5BD8A1;
	Fri, 09 Oct 2026 13:43:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/37] can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()
Date: Fri,  9 Oct 2026 15:27:38 +0200
Message-ID: <20261009134323.64064-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is reporting "struct j1939_ecu" refcount leak, for

  j1939_ecu_get(ecu);
  priv->ents[ecu->addr] = ecu;

in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
even after

  priv->ents[ecu->addr] = NULL;
  j1939_ecu_put(ecu);

in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
__j1939_rx_release() from j1939_netdev_stop() has completed.

  unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
       j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
       j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

  ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
       netdev_hold include/linux/netdevice.h:4525 [inline]
       j1939_priv_create net/can/j1939/main.c:140 [inline]
       j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
       j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
       __sys_bind_socket net/socket.c:1920 [inline]
       __sys_bind+0x2e3/0x410 net/socket.c:1951
       __do_sys_bind net/socket.c:1956 [inline]
       __se_sys_bind net/socket.c:1954 [inline]
       __x64_sys_bind+0x7a/0x90 net/socket.c:1954
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix this race condition by canceling address claim timers from
j1939_ecu_unmap_all().

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Assisted-by: Gemini-Pro gpt-6-astra opus-5-5
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Link: https://patch.msgid.link/9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/bus.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..0d109d1a3b4a 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -99,8 +99,38 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
+	struct j1939_ecu *ecu;
 
 	write_lock_bh(&priv->lock);
+	/* Cancel all pending address claim timers before unmapping.
+	 * This prevents an orphaned late-firing timer from re-mapping
+	 * an ECU after the spaces are cleared.
+	 */
+rescan_timers:
+	list_for_each_entry(ecu, &priv->ecus, list) {
+		int ret = hrtimer_try_to_cancel(&ecu->ac_timer);
+
+		if (ret == 0) { /* Not active or already finished. */
+			continue;
+		} else if (ret == 1) { /* Successfully canceled. */
+			/* Drop a ref from j1939_ecu_timer_start(). */
+			j1939_ecu_put(ecu);
+		} else { /* Executing on another CPU. */
+			/* Let j1939_ecu_timer_cancel() determine whether to
+			 * drop a ref from j1939_ecu_timer_start(). But guard
+			 * with a local ref in order to make sure that unlocked
+			 * j1939_ecu_put() from j1939_ecu_timer_cancel() cannot
+			 * be the final reference.
+			 */
+			j1939_ecu_get(ecu);
+			write_unlock_bh(&priv->lock);
+			j1939_ecu_timer_cancel(ecu);
+			write_lock_bh(&priv->lock);
+			j1939_ecu_put(ecu);
+		}
+		goto rescan_timers;
+	}
+	/* Unmap any remaining mapped ECUs */
 	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
 		if (priv->ents[i].ecu)
 			j1939_ecu_unmap_locked(priv->ents[i].ecu);
-- 
2.53.0

