Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE3551982;
	Wed, 14 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992688; cv=pass; b=sYZtzbJ7xFeITb233vF9/5a0mnSNUwQ7plBNRcRCaeCKD9r44QmHYrV5jTw0OTeib6wVqH2t4O8Au6nsFB3INb+Njwwq5QZkLgXjT9xm3bL1f/4q2DdcA4UsTq2qQKO974IkdH4IXGSnizFPu8oI2/mB7ljAPr6LePkW6ooCSKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992688; c=relaxed/simple;
	bh=RYczT0jpIKv4gSVjltuj56H+yF9aSE0icJvm3zDfm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkSftGP4w1nnhJ0kOrvi0VtNHEdGHooQygCIIKJ0r8lnrZc9FHidyrJR+S29RU8yiBCVV9loBswrpj/jTBIoXAKqYS4JuQPoMXDmOw+K2/4KMzHhv5wt/0/1pxaU8TLSBMQdkplFEPastwS2/IyyrAI5yq2hTj3+1f5abDplS/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Zn8a4kNQ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Zn8a4kNQ"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 410EE202657;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIYJzwLOPLap8rU/gvfWwHDxXpiVkla7ymStypmhGns=;
	b=Zn8a4kNQ3N0dojFaHeBt42Gcn/UnBSZMBAmdAwNu4v/71JuBWJ7Mm3s7g6RyOTDyFKoeiz
	aKJFa+2GppvAEczlH7bOZ5y8Ie6h8/X9ic9FOxEoQshzzk6Is5KCFchjxowcARhFlOJfUt
	1jYfiODrzUVWTqP2Iy3jBZucmnRvOtdvfMJdlsRTE2uitC0aMAf+UFJBFIeoNj2sX6i1HB
	p9M3mVxL2njxEyf22FVEBZ1H5j3s+fSbZp0xmY5PZ+0aD8StcGlRiuER2T2tpxjlPs1hEp
	DwRUWuOy9O2th8dDGL9ZYMtl8zDbV25jPAKwOEiSxoGmak8dUoqXSoIK7PeE7A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=CHgS4WMArDXVidG5lSWkefsdHcw2YP8bbs4FtlbsbKzS2xqJwxmsR3BZwj/cQ/3tDz4FfC
	RJqykDBhlC2cRqkmQ0HhEv8mw1LWJVk4wecLYeKcKJH64e+vD6tpc6AX92dFeSbiLSs8oo
	a9khk+uypkSkHtprkqhfXZydVkWZdkRHR49QhbMBOrjCMLEBKf2YmxwOJngY82Dvzz03Wl
	KZhp+m5LrKBI5bNKjZ4yiR1cjekFUq2zTPYweTZr/w4nSjPRIomho8j9Y44kW2fHw0z8/e
	Ya9uBX6UX8awwNT85ViVxw6wDrharLDhnMEGZwbVgeII63nwW+Y2JEmtlKz/ZA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIYJzwLOPLap8rU/gvfWwHDxXpiVkla7ymStypmhGns=;
	b=FUWO0bcJ3C3hTCrL2wJg2IL3flol1BPy8Yhix4SaDUXIOHivblflxx12cJsA7QpNxwY15p
	dbhjcRneEhFakm9n4JSX+pducaPwAtpSx69+nAwtKDJLhS8vfR2mBWyDowa9kfWR6PUXIy
	Tem0NNX28k5VueO3m/2AvxpYtQBgP+U0/fhH8VluEZ8J2Y5IM8o8h4Xy54d7hD2BPhR0AE
	8cPXPJWtm8OkWl2StmDVVOOzMddibBA1g5zxnwqD12BLFCv5esC19FNxLSynjxSF45RvUS
	cP4aEQOSgz+jdWBQvF8wSYCpWO2B6RQ03dPK9EXxvKeYPUng9M5Qq/19ovNtvA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 25DFF389263; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH can-next v1 7/8] selftests: can: cover J1939 transport abort and timeout paths
Date: Wed, 14 Oct 2026 17:44:33 +0200
Message-ID: <20261014154435.3577983-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154435.3577983-1-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the multi-frame tests with the transport edge cases the round-trip
tests do not reach: a per-CTS block limit smaller than the message, the
RTS/CTS and rx timeouts that must end a stalled session with a Connection
Abort, and a received Connection Abort that cancels an incoming session.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../selftests/net/can/test_j1939_multi.c      | 187 +++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
index 1f27ee58f48c..069a9c8690b5 100644
--- a/tools/testing/selftests/net/can/test_j1939_multi.c
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -5,7 +5,18 @@
  * A CAN_RAW socket plays the transport peer and drives the full handshake
  * against the kernel J1939 stack over the wire, in both directions: for TP the
  * raw side answers RTS/CTS and exchanges DT frames with EOMA; ETP does the same
- * with a payload spanning several CTS blocks (DPO windows).
+ * with a payload spanning several CTS blocks (DPO windows). The tests also
+ * cover the CTS block limit and the abort and timeout paths. Those edge cases
+ * are TP only; ETP has no equivalents here yet.
+ *
+ * Timing limitation: the abort/timeout tests wait with wide receive windows
+ * rather than tight bounds, because timing over vcan under QEMU is not tightly
+ * bounded. They catch a gross timer regression (e.g. a doubled timeout) but not
+ * a subtle shift; see the per-test comments.
+ *
+ * Coverage limitation: a received Connection Abort is exercised RX-side only;
+ * there is no kernel-as-transmitter received-abort test, matching the known
+ * net-next limitation that a TX session ignores an incoming Connection Abort.
  *
  * The vcan interface is set up by the caller (see test_j1939_multi.sh); its name
  * is passed via the CANIF environment variable.
@@ -39,6 +50,14 @@
 #define ETP_CMD_DPO		0x16
 #define ETP_CMD_EOMA		0x17
 
+/* TP.Abort reason codes (not durations), from the kernel's enum j1939_xtp_abort */
+#define ABORT_REASON_TIMEOUT	3	/* J1939_XTP_ABORT_TIMEOUT */
+#define ABORT_REASON_BUSY	1	/* J1939_XTP_ABORT_BUSY */
+
+/* TP responder T2: wait for the next DT after CTS (ISO 11783-3:1998 §3.10.2.4). */
+#define TP_T2_MS		1250
+#define TP_RX_ABORT_WAIT_MS	(TP_T2_MS * 2)	/* generous; floor check is the real test */
+
 #define TP_SIZE			200
 #define ETP_SIZE		6000		/* > TP max 1785 (255*7); several blocks */
 
@@ -313,6 +332,69 @@ TEST_F(j1939_multi, tp_tx_to_raw)
 	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
 }
 
+/*
+ * TP RX, per-CTS block limit: the RTS advertises a "max packets per CTS"
+ * (RTS data byte 4, 0-based; the spec's byte 5) smaller than the total packet
+ * count. The kernel must never request more than that many packets in a
+ * single CTS.
+ */
+TEST_F(j1939_multi, tp_rx_cts_block_limit)
+{
+	const unsigned int limit = 3;
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+	int max_want;
+
+	ASSERT_GT(num_pkts, limit)
+		TH_LOG("test needs more packets than the CTS limit");
+
+	/* advertise a max packets/CTS (limit) smaller than the total */
+	ASSERT_EQ(tp_rx_roundtrip(self, limit, &max_want, &frame), 0)
+		TH_LOG("TP RX round-trip against the raw peer failed");
+
+	EXPECT_LE(max_want, (int)limit)
+		TH_LOG("kernel CTS requested %d packets, sender limit was %u",
+		       max_want, limit);
+}
+
+/*
+ * TP TX, RTS->CTS timeout: the J1939 socket starts a TP transmit; the raw peer
+ * receives the RTS but never answers with a CTS. The kernel must give up (spec
+ * T3 = 1250 ms, SAE J1939-21:2001 §5.12.3) and send a Connection Abort.
+ *
+ * The abort must arrive within 2000 ms (a doubled T3 would miss this window) but
+ * no sooner than 800 ms, safely below the 1250 ms timer, so an instant-fire
+ * regression (an abort emitted immediately on a zeroed timer) is caught too. The
+ * bounds are wide, not tight, to stay reliable over vcan, so a subtle shift
+ * (e.g. 1250->1800 ms) still escapes.
+ */
+TEST_F(j1939_multi, tp_tx_rts_cts_timeout)
+{
+	uint8_t payload[TP_SIZE];
+	struct timespec t0, t1;
+	struct can_frame frame;
+	long elapsed_ms;
+
+	fill_pattern(payload, sizeof(payload));
+
+	ASSERT_EQ(tx_start_session(&self->j1939, self->ifindex, payload,
+				   sizeof(payload), self->raw, J1939_PF(TP_CTL),
+				   TP_CMD_RTS, &frame), 0);
+
+	/* Deliberately send no CTS; expect the kernel to abort within 2000 ms. */
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(TP_CTL), SA_PEER, &frame,
+			       2000, TP_CMD_ABORT), 0)
+		TH_LOG("kernel did not send a Connection Abort within 2000 ms");
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	elapsed_ms = timespec_diff_ms(&t0, &t1);
+	/* must not fire instantly: the T3 timer has to run before the abort */
+	ASSERT_GE(elapsed_ms, 800)
+		TH_LOG("abort fired after only %ld ms, timer did not run", elapsed_ms);
+	/* the T3 expiry must be reported as a timeout abort */
+	EXPECT_EQ(frame.data[1], ABORT_REASON_TIMEOUT);
+}
+
 /*
  * ETP RX: the CAN_RAW peer transmits an ETP message to the J1939 socket.
  * The kernel requests blocks with ETP.CTS; raw answers each with a DPO and
@@ -450,4 +532,107 @@ TEST_F(j1939_multi, etp_tx_to_raw)
 	free(rx_buf);
 }
 
+/* Send a TP.CM_Abort control frame. */
+static int send_abort(int raw, uint8_t da, uint8_t sa, uint8_t reason)
+{
+	uint8_t dat[8];
+
+	ctl_dat_init(dat, TP_CMD_ABORT);
+	dat[1] = reason;
+	return send_ctl_frame(raw, PRIO, TP_CTL, da, sa, dat, PGN_DATA);
+}
+
+/* Open a TP RX j1939 socket, send a full RTS, consume the first CTS. */
+static int tp_rx_start_session(int *j1939, int raw, int ifindex,
+			       unsigned int num_pkts, struct can_frame *cts)
+{
+	if (tp_rx_open_and_send_rts(j1939, raw, ifindex, num_pkts,
+				   num_pkts /* no per-CTS cap */))
+		return -1;
+	return recv_ctl_cmd(raw, J1939_PF(TP_CTL), SA_PEER, cts,
+			    J1939_RECV_TIMEOUT_MS, TP_CMD_CTS);
+}
+
+/*
+ * TP RX timeout: the CAN_RAW peer opens a session with RTS but never sends the
+ * data; the kernel's rx timer must abort the session and emit a TP.CM_Abort.
+ * The wait uses wide bounds (not a tight window) to stay reliable over vcan: the
+ * lower bound catches an instant-fire regression; the upper bound is a generous
+ * T2 multiple, so timer shifts within it escape.
+ */
+TEST_F(j1939_multi, tp_rx_timeout)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct timespec t0, t1;
+	struct can_frame frame;
+	long elapsed_ms;
+
+	ASSERT_EQ(tp_rx_start_session(&self->j1939, self->raw, self->ifindex,
+				      num_pkts, &frame), 0)
+		TH_LOG("failed to open and start the TP rx session");
+
+	/*
+	 * No data follows the CTS; the kernel's rx timer (T2, see TP_T2_MS) must
+	 * fire and abort; the wait is a generous TP_T2_MS * 2, the floor below is
+	 * the real check.
+	 */
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(TP_CTL), SA_PEER, &frame,
+			       TP_RX_ABORT_WAIT_MS, TP_CMD_ABORT), 0)
+		TH_LOG("kernel did not abort the stalled rx session");
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	elapsed_ms = timespec_diff_ms(&t0, &t1);
+	/*
+	 * Must not fire instantly: the T2 timer (1250 ms) has to run before the
+	 * abort, so 800 ms is a floor safely below it.
+	 */
+	ASSERT_GE(elapsed_ms, 800)
+		TH_LOG("abort fired after only %ld ms, timer did not run", elapsed_ms);
+	EXPECT_EQ(frame.data[1], ABORT_REASON_TIMEOUT);
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
+	unsigned int i;
+
+	fill_pattern(payload, sizeof(payload));
+
+	ASSERT_EQ(tp_rx_start_session(&self->j1939, self->raw, self->ifindex,
+				      num_pkts, &frame), 0)
+		TH_LOG("failed to open and start the TP rx session");
+
+	ASSERT_EQ(send_abort(self->raw, SA_LOCAL, SA_PEER, ABORT_REASON_BUSY), 0);
+	/* let the kernel process the abort first; 100 ms is a generous
+	 * empirical margin, not a spec value.
+	 */
+	usleep(100000);
+
+	/*
+	 * Send the full DT burst anyway. A kernel that honoured the abort has
+	 * torn the session down and drops these; one that ignored it would
+	 * reassemble them and deliver, so POLLIN below means the abort was not
+	 * honoured.
+	 */
+	for (i = 1; i <= num_pkts; i++)
+		ASSERT_EQ(send_dt(self->raw, PRIO, TP_DAT, SA_LOCAL, SA_PEER,
+				  i, payload, (i - 1) * 7, TP_SIZE), 0);
+
+	pfd.fd = self->j1939;
+	pfd.events = POLLIN;
+	/*
+	 * Short negative-check window: nothing should arrive after the abort,
+	 * so this is deliberately shorter than J1939_RECV_TIMEOUT_MS.
+	 */
+	EXPECT_EQ(poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS), 0)
+		TH_LOG("socket delivered data despite the abort");
+}
+
 J1939_TEST_MAIN();
-- 
2.47.3

