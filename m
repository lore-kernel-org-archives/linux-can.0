Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809074;
	b=FMEnjN7ftup9UD9NJHWHvrBBFL+qgULtJPljmNSJQfMl19j0pkEBtxT2k9YFj10Ik3Rw
	 ENCcIZSLIbhtMF3gR0HMEPRPYsxblUvr5pWEbvUryyv8TYPW1RJrgnBJm3HAfqc6JYVug
	 15aAk5u31wc8pUkmCI59dzExvIHjxjRXKX11gnhWEcdaxcZeJjUFKLm/Gj+pS/LTPwC3r
	 AoGKVucCweHe+U0P8DIq+fdDZWZ2aHUZISba2imMGc0BQi5XKdNjU2ljJjUaDM4avflpj
	 ScT/Bq+OfII7zoSzz22wa3hsGOy/HPGpOBqaGeFrP/FpCfJ8q6b6RuETww/nJ4/Th3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809074;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=y+lTQyYIfVW3Ue/mz6MQSC6N/KACcxMJqlOvQ07BN8w=;
	b=CQe0xbaxARQ4XlR3palbfTTEezCeL4Sjmng2/vm52Jsk7+AzcPg3eDZh25IZkUIUil2F
	 o6t+5jTFclIdXpd8Rm5AZN0HBit21ouxNuTWdEKrIC7bLTArLwR5xeBQyK2ARGgdvQUvd
	 P66jz7P155vyl0Ogx60pQDYe/zkeEFm8nLDg4mpyaPuZa7H6SIjI13BVMLJFSVsi5pNkY
	 sWADReNs1OHnmQP45xa5aSvm8Y8hNkHaycdPZawKKN4u5jcgYeaB0RuBrVX/laUyoRJGZ
	 qcdiOO7BwMMYCllETAYDMSYuSiePe2zXzkjG15v4Oo+bxv2jEEgrdatxDQJAve9+Zng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ACZWM1hx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA1606EE9C;
	Wed,  4 Nov 2026 16:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFA1606EE9C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ACZWM1hx
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B3655202BC1;
	Wed, 04 Nov 2026 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lTQyYIfVW3Ue/mz6MQSC6N/KACcxMJqlOvQ07BN8w=;
	b=ACZWM1hxWwE09X27cHvyOV8UrmT2kOiQKNM3KAnYNVMmWQ4dcpgEsUHFXhiHrdD87zqx+Z
	8QO2/yf8od0gIXN7MqDWKUIvemzfkN3JScfjHrr9pmA8cCj5YyY2FscqVwIAey5DKqdimE
	xmc+mwUPMj0tLBMRi5IWduW9NsTv75UEs3TfAcd3ikoyRy7dysODBz9yyLPEAdlDBQzksh
	W24gmY5O2ZrAmVOs4sCzdP/0kYR9DDFBENkgqNp+OOZZNWS6lYqi3gT7YaC9tEiSUr39Uq
	YyaoS+zIaSH4xhVk5Cy1Yd8Mq6KQJAZG2uA+tPcOlkW5Z79ZpQHLpjYtuNW0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+lTQyYIfVW3Ue/mz6MQSC6N/KACcxMJqlOvQ07BN8w=;
	b=GdG+2DkLV7s0AQSaUBvFb/jLc5OdRX9VxwU+2pZwbEVS35W6jVEAXKJUiozL6pLkKJQbFI
	6IKP5ajFgvtuW6WidcRcU3WUudOtTOgArNEvko4v8q0zfv3+XQCSIGQxswPLLhGUJdi/W6
	0pjYZOnKh5zcWNlAUREnLBiA/ti5pMmXN8DpxHyJ8sw5TdR16hQEpqvCcaSCQPGjaEFOYl
	1+nl2/q4R6zhPcBoA09uXLLAEk9a5jCrRUuFWdVDTpJE16HpzcToZ5nkKPgRjjvEUAuKHN
	zHXcP5eoAFYoX3go7EJMyEQ7d+YT1y9BHch/sDXrVFsyuy0AS3FxBCMs2jBTqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809067; a=rsa-sha256;
	cv=none;
	b=ZLxkULCcOOJ9f7ahna8sTnOuj727D2N4s53rpoEUQRJWIRHZy5e1eYSa8jIJytUMk7azMf
	e5A9WEMuK2PFyXaLwn+3zyBIa6jVDi0r0zP0zxYN2JYRtdVmIRdF7Gq1+anYT9jE5vIkqE
	8DPmqAEGbmttZTkLCynThfZpQBhyJDbI7Q8rocecUBeWyB1DEAF7ShS3OsGwYHmO6NtGZh
	of2pdwP4FS9ao6CY29EBF6zYDVkfAZ3opTxmyuirKg/f2i5cBqvlxzAVHeRgTc5oeEUsom
	yNPkvz7qh/ptdosc28UMYVLuyQVup72DR5deoV6/76ieb1v4rtro0rAakEGMYA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 5ACE3381442; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:24 +0100
Subject: [PATCH can-next v2 9/9] selftests: can: check SO_J1939_PROMISC
 receive effect
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-j1939-selftests-v2-9-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
In-Reply-To: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 Quchaosheng <quchaosheng000406@163.com>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

Add a test that SO_J1939_PROMISC changes what the RX path delivers. The
existing coverage only round-trips the flag through set/getsockopt, so a
kernel that stores the flag but never acts on it still passes.

It sends two frames, once before and once after enabling the flag. Each
misses one of the socket's filters, the bound address or the bound PGN.
Only the frames sent after enabling the flag must arrive.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants and avoid casts
- check the address and the PGN filter each on its own
---
 tools/testing/selftests/net/can/test_j1939_opts.c | 64 ++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
index 10d0e379840277cddbe9d1f5090f900ce7dd65dc..bbf2698de7d9491fca4881ade4c63284926ef9eb 100644
--- a/tools/testing/selftests/net/can/test_j1939_opts.c
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -6,8 +6,9 @@
  * and addressing: the SO_J1939_FILTER PGN whitelist, the SO_J1939_SEND_PRIO
  * send priority seen in the CAN id (via a CAN_RAW peer, including the kernel's
  * default), unconnected sendto(2), a wrong-family bind rejection,
- * SO_J1939_ERRQUEUE TX-completion notifications, and set/getsockopt
- * round-trips of SO_J1939_SEND_PRIO, SO_J1939_PROMISC and SO_J1939_ERRQUEUE.
+ * SO_J1939_ERRQUEUE TX-completion notifications, the SO_J1939_PROMISC receive
+ * effect, and set/getsockopt round-trips of SO_J1939_SEND_PRIO,
+ * SO_J1939_PROMISC and SO_J1939_ERRQUEUE.
  *
  * Run by test_j1939_opts.sh, see j1939_tests.h.
  */
@@ -20,6 +21,9 @@
 /* arbitrary addresses */
 #define SA_TX			0x80
 #define SA_RX			0x90
+#define SA_OTHER		0x50	/* neither SA_TX nor SA_RX */
+_Static_assert(SA_OTHER != SA_TX && SA_OTHER != SA_RX && SA_TX != SA_RX,
+	       "test addresses overlap");
 
 /* two different destination-specific PGNs, otherwise arbitrary */
 #define PGN_A			0x0ab00
@@ -130,6 +134,62 @@ TEST_F(j1939_opts, filter_pgn)
 		TH_LOG("PGN_B was received but should have been filtered out");
 }
 
+/*
+ * Frames that a socket bound to (SA_RX, PGN_A) must not get without
+ * SO_J1939_PROMISC: each misses one of the two, so each filter is tested on
+ * its own.
+ */
+static const struct {
+	uint8_t da;
+	pgn_t pgn;
+} promisc_probes[] = {
+	{ SA_RX, PGN_B },	/* the bound address, another PGN */
+	{ SA_OTHER, PGN_A },	/* another address, the bound PGN */
+};
+
+/* SO_J1939_PROMISC delivers frames that do not match the bound (addr, pgn). */
+TEST_F(j1939_opts, promisc_receive)
+{
+	uint8_t tx_buf[CAN_MAX_DLEN];
+	uint8_t rx_buf[CAN_MAX_DLEN];
+	int enable = 1;
+	size_t i;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
+		ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+					    self->ifindex, J1939_NO_NAME,
+					    promisc_probes[i].da,
+					    promisc_probes[i].pgn))
+			TH_LOG("sendto probe %zu failed: %d", i, errno);
+		EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+				       J1939_NEG_RECV_TIMEOUT_MS), -1)
+			TH_LOG("probe %zu was received without promisc", i);
+	}
+
+	/* SO_J1939_PROMISC returns the flag value (1), not 0, on success. */
+	ASSERT_GE(setsockopt(self->rx, SOL_CAN_J1939, SO_J1939_PROMISC,
+			     &enable, sizeof(enable)), 0)
+		TH_LOG("SO_J1939_PROMISC failed: %d", errno);
+
+	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
+		ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+					    self->ifindex, J1939_NO_NAME,
+					    promisc_probes[i].da,
+					    promisc_probes[i].pgn))
+			TH_LOG("sendto probe %zu failed: %d", i, errno);
+		EXPECT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+					   J1939_RECV_TIMEOUT_MS))
+			TH_LOG("probe %zu not received despite promisc", i);
+	}
+}
+
 /* Without SO_J1939_SEND_PRIO the kernel's default priority is used. */
 TEST_F(j1939_opts, send_prio_default)
 {

-- 
2.47.3

