Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410783;
	b=s2SAQNyF+axJ0NTm0NAb1Wq77ypepfyIlQiFd71j53BN011LGcWkhY8BgzDzaaGQTWEq
	 6iFHh4RRngI71qdeTb+p0ie+VCkjGm+qlQBEZhAOQpP9KW5nXUJmbmsqy83Pv0qWNtaLZ
	 tCyzhHKejXY236si64W66igXTQJPiFmolvKouC7s0AoklF7ez1u83dtWAG6T50JpzIQ1L
	 vlTBcc0TQwVtAC89N1fU6+OwFMphZexB8dHWScQIdPLqJiBM+se3wXtqMTvByR1aw2e3v
	 ru6HDYSCyVF3aLzMISHn3VT+zM50K0B39mgqd02s1aQmiAkgV+lqXDYw+Eew9GO8qDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410783;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=0iOZ0Xo1WJYBctB11LmNr03kLXScFMd7/t16aS3UGRk=;
	b=hbSfOdWIOKjb/uTWUzp+iI1kR8Zfx+eM2nb9F/6AgTXpz/mdC3SGSb+TT/zR0bdVd9tK
	 sx4Mraok8WZG92CCmsPI9bYl3LlZd/D4tI4jf3BNn2NBKR+mHrfxaLiWkl8kaz5Zychyj
	 xTaB39a/QAxYZbiWJ0+zVyt8IEg7hkjBCb2/ZGVslgwHoy7elk+LBUIQXEBVzn5J5s29L
	 Ow8Lj6lhnBtk9bvMb9UA9Szw4vQ2rF/sgy35Zrvst6HEd8W4Q/AzsSDrGxaFrWDoQK63j
	 86Tp7mP4OQAqvtW8vvAde2iShWRb3/FMERox/Xr37AjG/bWWocXSsrlfgFkrPI4htMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="Xmw/OXv2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B598606A893;
	Wed, 11 Nov 2026 15:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B598606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Xmw/OXv2
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0B783202C9A;
	Wed, 11 Nov 2026 16:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iOZ0Xo1WJYBctB11LmNr03kLXScFMd7/t16aS3UGRk=;
	b=Xmw/OXv28ZmkXHXj9t/77lEJY7bDzM9iX9NCAHJs6UYeMKjyIImpGXM9Z6QCG6Fa+xmwhh
	IkTks2ZtYiPeMZiZCfb3FcaTdzTC4Gv4U1WvIHnX8wqZBWgV8YaXGCmaffIdo5MK6lk3V5
	uv9qd2StIFzxByB8hMtXi9gZge7daygvbY7ugmYDTogAdbp7OfX4gCPqiwg1h3mO4QCdbh
	y/N0uW4Apz3prgH8yrA4krLQdwkdLB8f/2w2GnBEw2uf73b1HFqmY9KYg25jKeq0h6xTOm
	h7XhNKFTQE0m6k+HRHgNaFRQs2m3ccPTS5iqewltn1WW4c/Ev/dLGDYzzOUwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iOZ0Xo1WJYBctB11LmNr03kLXScFMd7/t16aS3UGRk=;
	b=W+NeVHfdZWAtykPo9yPihncNRUwrrCR5MuWUmzZgunbhHh6bxysfdTfSifxA45HPqhK3mb
	yWZWlubCvFRX48ZGT6U/KEG/v7o7bn6bNXKluc2kiBWHIEydivaf0s2CE0JY3BpARRb6yu
	e+BWpw67fCcWhou3WkLBGwztbBVMQYNAJCEOsUUxBwPk2gFPsMUDE6rM6wMWAgMfaBdodz
	gJXbe0iRLM56TazARFlBHSQaSXNR7v30BhUSlqTfdMpbWldBX3fAwBPuxR6V0VxNec6HBp
	ShoeGQYWHIlHtdyxWMi2u3PRTD6MX2apjhyFnG5nSrs8LbT/h/OwyXb04s50PQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410776; a=rsa-sha256;
	cv=none;
	b=J/IBWFfqdUzPRr5MK/LBZpBQ27YPShMT6A9vcAxCvVEVn7ZeKvAqiO+Gwd/D9nSuuPvdZB
	wqBKLFVKNexdBgEdmX4eYFIAvp9h4usw1EXxtziFr0gAQ/4TDGtnqORNsoQqhTRNsK6k9f
	UYz6xLUbbkFw3/VOalNhKi2Fns/0rSpETq9EN4JZiv+wQllGIMMde4ZskHapkd/iFQPywv
	A3TL3E+6nqWEJr4DAZfcQIPw3NiEbs4maVIfZbg2WcJLVuJLbDFM8Dg8kxzS2KwobjtbeQ
	/tFsbRt+up+H9Gkq/khik+4Wodx1MXE0DpEpmcCZDzUqvKk1MTRZBr3BasRW9g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id BB1193815B6; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 11 Nov 2026 16:25:57 +0100
Subject: [PATCH can-next v3 8/9] selftests: can: cover J1939 transport
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
Message-Id: <20261111-j1939-selftests-v3-8-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
In-Reply-To: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
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

Add transport edge cases to the multi-frame tests. The round-trip tests
only run transfers that succeed, and no TP transfer there is split into
CTS blocks. They leave out these cases:

- a CTS that asks for fewer packets than the message has
- the T3 timeout, when no CTS follows the RTS
- the T2 timeout, when no DT follows the CTS
- an Abort from the peer

The timeouts must end in a Connection Abort. The Abort from the peer must
cancel an incoming session.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): does tp_rx_cts_block_limit run into the echo race of
patch 7?
A: Yes, and more often: it waits for more CTS frames. The answer in
patch 7 applies.

Q: why is there no test for a Connection Abort received on a kernel TX
session?
A: The stack ignores it today and ends the session only on the T3
timeout, so such a test would fail. This series changes no kernel code.

Changes in v3:
- say in the body which cases the round-trip tests leave out
- assert that the last TP CTS window is partial
- check that the first CTS of the abort and T2 tests asks for all packets,
  and check the EOMA of tp_rx_cts_block_limit
- reword the TP_CTS_LIMIT and T2 comments

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
 tools/testing/selftests/net/can/test_j1939_multi.c | 270 ++++++++++++++++++++-
 1 file changed, 269 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
index aec96e83305cf2d9129aed3ccdf4035437337ba7..b35c5477afddf25ae650d2c9bfd32d4375b52809 100644
--- a/tools/testing/selftests/net/can/test_j1939_multi.c
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -5,7 +5,8 @@
  * A CAN_RAW socket plays the transport peer against the kernel J1939 stack,
  * in both directions. It takes the other side of the RTS/CTS/DT/EOMA
  * exchange, for TP with a short message and for ETP with a payload that
- * spans several CTS blocks (DPO windows).
+ * spans several CTS blocks (DPO windows). The tests also cover the TP CTS
+ * block limit and the TP abort and timeout paths.
  *
  * Known stack race: the stack updates a session from the loopback echo of
  * its own CTS, RTS and DT frames, and the CAN_RAW peer can read that echo
@@ -59,6 +60,7 @@ _Static_assert(!J1939_IS_PDU1(PGN_DATA) && PGN_DATA <= J1939_PGN_MAX,
 #define TP_CMD_RTS		0x10
 #define TP_CMD_CTS		0x11
 #define TP_CMD_EOMA		0x13
+#define TP_CMD_ABORT		0xff
 
 #define ETP_CMD_RTS		0x14
 #define ETP_CMD_CTS		0x15
@@ -75,6 +77,7 @@ _Static_assert(!J1939_IS_PDU1(PGN_DATA) && PGN_DATA <= J1939_PGN_MAX,
 #define TP_CTS_NEXT_OFF		2
 #define TP_EOMA_SIZE_OFF	1	/* le16 */
 #define TP_EOMA_PKTS_OFF	3
+#define TP_ABORT_REASON_OFF	1
 
 #define ETP_RTS_SIZE_OFF	1	/* le32 */
 #define ETP_CTS_PKTS_OFF	1
@@ -118,6 +121,67 @@ _Static_assert(J1939_NUM_PKTS(ETP_SIZE) % ETP_CTS_MAX_PKTS != 0,
 #define TP_CTS_ALL		J1939_NUM_PKTS(TP_SIZE)
 _Static_assert(TP_CTS_ALL <= UINT8_MAX, "the TP.CM packet counts are one byte");
 
+/*
+ * arbitrary limit on packets per CTS, sent in the RTS, below the packet
+ * count of TP_SIZE
+ */
+#define TP_CTS_LIMIT		3U
+_Static_assert(J1939_NUM_PKTS(TP_SIZE) > TP_CTS_LIMIT,
+	       "TP_SIZE must need more packets than TP_CTS_LIMIT");
+_Static_assert(J1939_NUM_PKTS(TP_SIZE) % TP_CTS_LIMIT != 0,
+	       "the last TP CTS window must be partial");
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
@@ -558,6 +622,116 @@ TEST_F(j1939_multi, tp_tx_to_raw)
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
+
+	/* frame is the kernel's EOMA */
+	EXPECT_EQ(get_le16(&frame.data[TP_EOMA_SIZE_OFF]), TP_SIZE);
+	EXPECT_EQ(frame.data[TP_EOMA_PKTS_OFF], J1939_NUM_PKTS(TP_SIZE));
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
@@ -676,6 +850,100 @@ TEST_F(j1939_multi, etp_tx_to_raw)
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
+/*
+ * Open a TP RX j1939 socket, send an RTS that allows all packets in one CTS
+ * and check that the first CTS asks for all of them.
+ */
+static bool tp_rx_start_session_ok(int *j1939, int raw, int ifindex,
+				   struct can_frame *cts)
+{
+	if (!tp_rx_open_and_send_rts_ok(j1939, raw, ifindex, TP_CTS_ALL))
+		return false;
+
+	return recv_kernel_cm_ok(raw, TP_CM, TP_CMD_CTS, cts,
+				 J1939_RECV_TIMEOUT_MS) &&
+	       cts_accept_ok(cts->data[TP_CTS_PKTS_OFF],
+			     cts->data[TP_CTS_NEXT_OFF], 0,
+			     J1939_NUM_PKTS(TP_SIZE), TP_CTS_ALL);
+}
+
+/*
+ * TP RX timeout: the CAN_RAW peer opens a session with RTS but never sends the
+ * data; the kernel's T2 timer must abort the session and emit a TP.CM_Abort.
+ * The kernel starts its receive timer when it gets the RTS
+ * (j1939_xtp_rx_rts()). It starts it again as T2 when it sends the CTS
+ * (j1939_session_tx_cts()) and on the CAN echo of that CTS
+ * (j1939_xtp_rx_cts_one()). The wait is timed from before the socket is
+ * opened.
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

