Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809075;
	b=I4yTom9MYgLSpN2G7Cmr3OYhS6WenPzZrzHGsYC0FMoZPTgToJx8ua0UatE2fEZOxXF3
	 uAbVWLG2QfyVe0ESaK1h2a0Ert+tKDCA31feLOAwcBfn3QUu9t0WzoIpdSo7/L/CStEfi
	 ceqamk/2LXFYTIyHC+mr3L3J9mzZalhtF2TBScplP5hgEnkqcKaP9s3mHW0Eri0StswLG
	 UNvtm/AOmdLoeEeaQ0Df7789EwDXqRiT2z0Jb3N9281kIabItNUwOp/fymtOlcLhh/r9f
	 oMii363NZWY/j0pd8uLTiOOzcN2i/rb+D5A1+xqOVACupgR8A2NbJABFxfsBh8KfVOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=L/HuuIs6dgnHN7S+g9uR/oguZ8OUqRlifKl4HU+44z4=;
	b=mQ1QIwP+Z9UogeCMRh8YYoW91P5FI8PiRukwnND8z2ucH+d0YlJUCAoRDh4BtszvfXwV
	 N8FhNz/j2Lu9APbFOpUs1UwJXhO2c0AdJ5dXrIOEyfCJ7nH+p8/26ENfrzLzxIOJhmmII
	 PCkJXHI0Z9DUj4vQu5gfy8C188eaw6c1pjCAOOHkeN498GCnaxTJyROBmQgxweleb6XA9
	 1t23BeAzEBEiWQDTarSd0HZEA69rIJttegrvdb8NieufAqs3okMwiB3feJgNh+rSxbzQB
	 wwwHAa6rIs6csHiiRanFVsDId6T3k1FtM9/Xql0bGMKDYFEq5owhC2nBobGv9FmmWKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJBcmMf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653CD6082BC3;
	Wed,  4 Nov 2026 16:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 653CD6082BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJBcmMf1
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AD346202BC0;
	Wed, 04 Nov 2026 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/HuuIs6dgnHN7S+g9uR/oguZ8OUqRlifKl4HU+44z4=;
	b=LJBcmMf1j/qz2HpPbgSzB3F0P5qgDal1di1BcA59nrmrbx7gJJHYLEBth675XN2PPC3zq9
	N2RCy5dTbks6ziYolpQxMYTULW1SBi9N2eyr9ZYlxd/6V4q17YR1kItAusgAVuN2aasQST
	GScJ67NVq+W9cW57snqCtSauD4dWFDeQOxWmCEYlQNM2jkNc27ujBAo3qFj4i0yQ/iqPWQ
	PVUXbzxeCiuBTTCJaJMCME0mEncRviZxuwgCC3zmOeMGGYXi2OI8uCQkN5mGWTOEfw5GjM
	GYdYIxFkQssxgX+fopI13OVe5XAtVFh3LFW6NuwOh8V/hV/8QnDZMkrYLHE+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/HuuIs6dgnHN7S+g9uR/oguZ8OUqRlifKl4HU+44z4=;
	b=Q0WbpEsqk19y/cLF5uSUeojwO9rLkYQ/27KPsArP5qSv5sAaoC4vY/1jt1GQ2GAheemo+U
	52fDlKKzO+XM4YLWWR20sZgDhTa2cRTC89lr17uwXntWTvd2MBjnvp8M05fPnUVI0KHAMs
	FZf9VCPzBrLCNTV/gvsOYCdCYyYYTIwl792ucE8V6N2v1MeNrxfmNqtzXMDYLE6G9SNr6P
	Vsj27dBNuTbtWaFV40jtCyrfBAfD3SRpYmxhQaF8FQxQ2lvzxm6d/U+Qj5/asyJAwZ4Fpx
	xEMp7FfkoYOpow5wadLaa8O2M8wocOxNbrl1PYySh6lCquBD99ZgxKNUwddhBA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809067; a=rsa-sha256;
	cv=none;
	b=Lvo+wtDO9dn5igfYNyeztdtrkE3Cmo7Vai3cArZzb2OrVTgJ+12ce/xOPxKfl1NJN9GDFV
	WgSic0WEBj6a0+p1OY6/CfBEEKX1bwxSyoQqm0/a3domwdWMvOtkc0Wcde6aTWRB0Im1li
	Wbw6Cn9ZWIPWcCnAKWyW6i1fSDvIl5BUc5XnWCg1y91rpvwRWm/hh/aY9ZpTEgUz0UGvbZ
	NcvKqj/15m6wu3BSxeKVH9W8wknBl1upc5FOUVIigiklsFTKj0pKZPMiFNhpNpgcUkGhxp
	CqPq90yfqMa/ZTpRopq6GbECZuTaD5Uw7P0vM3vuBmq6hThknn0vp1Vafu8IxA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 59140380F65; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:23 +0100
Subject: [PATCH can-next v2 8/9] selftests: can: cover J1939 transport
 abort and timeout paths
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
Message-Id: <20261104-j1939-selftests-v2-8-cf797c83317b@pengutronix.de>
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

Add transport edge cases to the multi-frame tests: a per-CTS packet limit
below the message's packet count, the T3 timeout (no CTS after RTS) and
the T2 timeout (no DT after CTS), which must end with a Connection Abort,
and a received Abort that cancels an incoming session.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, add static asserts, avoid casts and return bool
  from helpers named *_ok()
- time T2 and T3 against the bounds of the timing mode; strict mode
  catches a doubled timer, and the header no longer claims that the
  default mode does (sashiko)
- tp_tx_rts_cts_timeout: check that the sender sees EHOSTUNREACH
- tp_rx_cts_block_limit: check the exact packet count in each CTS, not
  only an upper bound
- time T2 and T3 from before the test opens its socket, so a delay in
  the test cannot make an abort look early (sashiko)
---
 tools/testing/selftests/net/can/test_j1939_multi.c | 253 ++++++++++++++++++++-
 1 file changed, 252 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
index 88a283a3394e026f69d17cd36222c0812d9b38a1..0af15e9ea9550346f943d0c1aa87628877588e61 100644
--- a/tools/testing/selftests/net/can/test_j1939_multi.c
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -5,7 +5,8 @@
  * A CAN_RAW socket plays the transport peer and drives the handshake against
  * the kernel J1939 stack, in both directions: for TP the raw side answers
  * RTS/CTS and exchanges DT frames with EOMA; ETP does the same
- * with a payload spanning several CTS blocks (DPO windows).
+ * with a payload spanning several CTS blocks (DPO windows). The tests also
+ * cover the TP CTS block limit and the TP abort and timeout paths.
  *
  * Run by test_j1939_multi.sh, see j1939_tests.h.
  */
@@ -43,6 +44,7 @@ _Static_assert(PGN_DATA & J1939_PGN_DP, "PGN_DATA must have the DP bit set");
 #define TP_CMD_RTS		0x10
 #define TP_CMD_CTS		0x11
 #define TP_CMD_EOMA		0x13
+#define TP_CMD_ABORT		0xff
 
 #define ETP_CMD_RTS		0x14
 #define ETP_CMD_CTS		0x15
@@ -57,6 +59,7 @@ _Static_assert(PGN_DATA & J1939_PGN_DP, "PGN_DATA must have the DP bit set");
 #define TP_CTS_NEXT_OFF		2
 #define TP_EOMA_SIZE_OFF	1	/* le16 */
 #define TP_EOMA_PKTS_OFF	3
+#define TP_ABORT_REASON_OFF	1
 
 #define ETP_RTS_SIZE_OFF	1	/* le32 */
 #define ETP_CTS_PKTS_OFF	1
@@ -89,6 +92,62 @@ _Static_assert(J1939_NUM_PKTS(ETP_SIZE) > ETP_CTS_MAX_PKTS,
 #define TP_CTS_ALL		J1939_NUM_PKTS(TP_SIZE)
 _Static_assert(TP_CTS_ALL <= UINT8_MAX, "the TP.CM packet counts are one byte");
 
+/* an RTS per-CTS limit below the packets of TP_SIZE, arbitrary */
+#define TP_CTS_LIMIT		3U
+_Static_assert(J1939_NUM_PKTS(TP_SIZE) > TP_CTS_LIMIT,
+	       "TP_SIZE must need more packets than TP_CTS_LIMIT");
+
+/*
+ * Connection Abort reasons (SAE J1939-21:2001 Table 6); the kernel names them
+ * J1939_XTP_ABORT_*.
+ */
+#define ABORT_REASON_BUSY	1
+#define ABORT_REASON_TIMEOUT	3
+
+/*
+ * TP responder T2: wait for the next DT after CTS (SAE J1939-21:2001
+ * section 5.10.2.4 and Figure C1).
+ */
+#define TP_T2_MS		1250
+/*
+ * TP originator T3: wait for a CTS after RTS (SAE J1939-21:2001 section
+ * 5.10.2.4 and Figure C1).
+ */
+#define TP_T3_MS		1250
+
+/*
+ * Bounds for the time from before the test opens its socket to the kernel's
+ * abort.
+ * The values below are guesses, not spec values.
+ */
+
+/* relaxed (default, for slow VMs): catches a timer that fires early or never */
+#define TP_RELAXED_EARLY_MS	450
+#define TP_RELAXED_LATE_MS	1250
+#define TP_RELAXED_MIN_MS(t)	((t) - TP_RELAXED_EARLY_MS)
+#define TP_RELAXED_MAX_MS(t)	((t) + TP_RELAXED_LATE_MS)
+
+/* strict: also catches a doubled timer */
+#define TP_STRICT_EARLY_MS	100
+#define TP_STRICT_LATE_MS	200
+#define TP_STRICT_MIN_MS(t)	((t) - TP_STRICT_EARLY_MS)
+#define TP_STRICT_MAX_MS(t)	((t) + TP_STRICT_LATE_MS)
+
+/* for any timer: the relaxed bounds must contain the strict bounds */
+_Static_assert(TP_RELAXED_EARLY_MS >= TP_STRICT_EARLY_MS,
+	       "the relaxed minimum must not be above the strict one");
+_Static_assert(TP_RELAXED_LATE_MS >= TP_STRICT_LATE_MS,
+	       "the relaxed maximum must not be below the strict one");
+_Static_assert(TP_T2_MS > TP_RELAXED_EARLY_MS,
+	       "TP_T2_MS must exceed TP_RELAXED_EARLY_MS");
+_Static_assert(TP_T3_MS > TP_RELAXED_EARLY_MS,
+	       "TP_T3_MS must exceed TP_RELAXED_EARLY_MS");
+/* so that strict mode catches a doubled T2 or T3 */
+_Static_assert(TP_STRICT_LATE_MS < TP_T2_MS,
+	       "TP_STRICT_LATE_MS must stay below TP_T2_MS");
+_Static_assert(TP_STRICT_LATE_MS < TP_T3_MS,
+	       "TP_STRICT_LATE_MS must stay below TP_T3_MS");
+
 FIXTURE(j1939_multi)
 {
 	int ifindex;
@@ -497,6 +556,112 @@ TEST_F(j1939_multi, tp_tx_to_raw)
 		TH_LOG("no TX-completion ACK after the EOMA");
 }
 
+/*
+ * TP RX, per-CTS block limit: the RTS asks for at most TP_CTS_LIMIT packets
+ * per CTS, fewer than the message has. Each CTS from the kernel must ask
+ * for TP_CTS_LIMIT packets, or for the rest.
+ */
+TEST_F(j1939_multi, tp_rx_cts_block_limit)
+{
+	struct can_frame frame;
+
+	ASSERT_TRUE(tp_rx_roundtrip_ok(self, TP_CTS_LIMIT, &frame))
+		TH_LOG("TP RX round-trip against the raw peer failed");
+}
+
+/* Set *min_ms and *max_ms to the abort bounds of a TP timer of timer_ms. */
+static void tp_abort_window(int timer_ms, int *min_ms, int *max_ms)
+{
+	*min_ms = j1939_timing_ms(TP_RELAXED_MIN_MS(timer_ms),
+				  TP_STRICT_MIN_MS(timer_ms));
+	*max_ms = j1939_timing_ms(TP_RELAXED_MAX_MS(timer_ms),
+				  TP_STRICT_MAX_MS(timer_ms));
+}
+
+/*
+ * Wait until max_ms after t0 for the kernel's Connection Abort to the peer
+ * and store it in *frame; *elapsed_ms gets the time from t0 to its arrival.
+ */
+static bool recv_abort_timed_ok(int raw, const struct timespec *t0,
+				int max_ms, struct can_frame *frame,
+				long *elapsed_ms)
+{
+	struct timespec now;
+	bool ok;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	*elapsed_ms = timespec_diff_ms(t0, &now);
+	if (*elapsed_ms > max_ms)
+		return false;
+
+	ok = recv_kernel_cm_ok(raw, TP_CM, TP_CMD_ABORT, frame,
+			       max_ms - *elapsed_ms);
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	*elapsed_ms = timespec_diff_ms(t0, &now);
+	return ok;
+}
+
+/*
+ * Wait for an error on s and return it (SO_ERROR), or 0 if none came within
+ * J1939_RECV_TIMEOUT_MS.
+ */
+static int sock_wait_error(int s)
+{
+	struct pollfd pfd = { .fd = s };
+	socklen_t len;
+	int err = 0;
+
+	if (poll(&pfd, 1, J1939_RECV_TIMEOUT_MS) <= 0 ||
+	    !(pfd.revents & POLLERR))
+		return 0;
+
+	len = sizeof(err);
+	if (getsockopt(s, SOL_SOCKET, SO_ERROR, &err, &len))
+		return 0;
+	return err;
+}
+
+/*
+ * TP TX, RTS->CTS timeout: the J1939 socket starts a TP transmit; the raw peer
+ * receives the RTS but never answers with a CTS. The kernel must give up after
+ * T3 (TP_T3_MS), send a Connection Abort and report the error to the sender.
+ *
+ * The kernel starts T3 when it sends the RTS, and starts it again when it
+ * receives its own RTS back from the CAN echo (j1939_xtp_rx_rts() in
+ * net/can/j1939/transport.c). The wait is timed from before the socket is
+ * opened, so a delay in this test cannot make the abort look early.
+ */
+TEST_F(j1939_multi, tp_tx_rts_cts_timeout)
+{
+	uint8_t payload[TP_SIZE];
+	struct can_frame frame;
+	struct timespec t0;
+	int min_ms, max_ms;
+	long elapsed_ms;
+
+	fill_pattern(payload, sizeof(payload));
+	tp_abort_window(TP_T3_MS, &min_ms, &max_ms);
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	ASSERT_TRUE(tp_tx_start_session_ok(self, payload, sizeof(payload),
+					   &frame));
+
+	ASSERT_TRUE(recv_abort_timed_ok(self->raw, &t0, max_ms, &frame,
+					&elapsed_ms))
+		TH_LOG("kernel did not send a Connection Abort within %d ms",
+		       max_ms);
+
+	/* the T3 timer has to run before the abort */
+	ASSERT_GE(elapsed_ms, min_ms)
+		TH_LOG("abort after only %ld ms, expected at least %d ms",
+		       elapsed_ms, min_ms);
+	EXPECT_EQ(frame.data[TP_ABORT_REASON_OFF], ABORT_REASON_TIMEOUT);
+
+	/* j1939_xtp_abort_to_errno() reports a timeout as EHOSTUNREACH */
+	EXPECT_EQ(sock_wait_error(self->j1939), EHOSTUNREACH)
+		TH_LOG("the sender did not see the aborted session");
+}
+
 /*
  * ETP RX: the CAN_RAW peer transmits an ETP message to the J1939 socket.
  * The kernel requests blocks with ETP.CTS; raw answers each with a DPO and
@@ -612,6 +777,92 @@ TEST_F(j1939_multi, etp_tx_to_raw)
 		TH_LOG("no TX-completion ACK after the EOMA");
 }
 
+/* Send a TP.CM_Abort control frame from the peer to the kernel. */
+static bool send_abort_ok(int raw, uint8_t reason)
+{
+	uint8_t dat[CAN_MAX_DLEN];
+
+	cm_dat_init(dat, TP_CMD_ABORT);
+	dat[TP_ABORT_REASON_OFF] = reason;
+	return peer_send_cm_ok(raw, TP_CM, dat);
+}
+
+/* Open a TP RX j1939 socket, send a full RTS, consume the first CTS. */
+static bool tp_rx_start_session_ok(int *j1939, int raw, int ifindex,
+				   struct can_frame *cts)
+{
+	if (!tp_rx_open_and_send_rts_ok(j1939, raw, ifindex, TP_CTS_ALL))
+		return false;
+
+	return recv_kernel_cm_ok(raw, TP_CM, TP_CMD_CTS, cts,
+				 J1939_RECV_TIMEOUT_MS);
+}
+
+/*
+ * TP RX timeout: the CAN_RAW peer opens a session with RTS but never sends the
+ * data; the kernel's T2 timer must abort the session and emit a TP.CM_Abort.
+ * The kernel starts T2 when it gets the RTS, and again when it sends the CTS
+ * and on the CAN echo of that CTS; the wait is timed from before the socket
+ * is opened.
+ */
+TEST_F(j1939_multi, tp_rx_timeout)
+{
+	struct can_frame frame;
+	struct timespec t0;
+	int min_ms, max_ms;
+	long elapsed_ms;
+
+	tp_abort_window(TP_T2_MS, &min_ms, &max_ms);
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	ASSERT_TRUE(tp_rx_start_session_ok(&self->j1939, self->raw,
+					   self->ifindex, &frame))
+		TH_LOG("failed to open and start the TP rx session");
+
+	ASSERT_TRUE(recv_abort_timed_ok(self->raw, &t0, max_ms, &frame,
+					&elapsed_ms))
+		TH_LOG("kernel did not abort the stalled rx session");
+
+	/* the T2 timer has to run before the abort */
+	ASSERT_GE(elapsed_ms, min_ms)
+		TH_LOG("abort after only %ld ms, expected at least %d ms",
+		       elapsed_ms, min_ms);
+	EXPECT_EQ(frame.data[TP_ABORT_REASON_OFF], ABORT_REASON_TIMEOUT);
+}
+
+/*
+ * TP RX abort: the CAN_RAW peer aborts an open session; the kernel must cancel
+ * it and deliver nothing to the J1939 socket.
+ */
+TEST_F(j1939_multi, tp_rx_abort_from_raw)
+{
+	uint8_t payload[TP_SIZE];
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+	struct pollfd pfd;
+
+	fill_pattern(payload, sizeof(payload));
+
+	ASSERT_TRUE(tp_rx_start_session_ok(&self->j1939, self->raw,
+					   self->ifindex, &frame))
+		TH_LOG("failed to open and start the TP rx session");
+
+	ASSERT_TRUE(send_abort_ok(self->raw, ABORT_REASON_BUSY));
+
+	/*
+	 * Send all DT frames anyway. A kernel that ignored the abort would
+	 * deliver the message.
+	 */
+	ASSERT_TRUE(send_tp_dt_burst_ok(self->raw, SA_LOCAL, SA_PEER,
+					TP_FIRST_PKT, num_pkts, payload,
+					TP_SIZE));
+
+	pfd.fd = self->j1939;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS), 0)
+		TH_LOG("socket delivered data despite the abort");
+}
+
 int main(int argc, char **argv)
 {
 	return j1939_test_main(argc, argv);

-- 
2.47.3

