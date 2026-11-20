Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167973;
	b=yObxQzC7CsSaKHuCeDa+mAyGeaMDcV6ysfjdQrTbIxd4MDGgMzxMd6TNE8sw9IV7RRlq
	 vhsd0GHzgdwyQJd+Fhx1UmPWVgMM+XGaA3pjcr9nCRWxrTo54lOEziek3tuzx0xxYWXN1
	 ODBG8AYvBAFz4xuoPkp3fwClWYr3LdYEBYBZKcaUb0uMy6gHphbNu91ir3ixsHQHxSlTb
	 vAepQ+qwggc20K35dV+A2cz3sFcpj0iDcfyziOvs7LFtPGWIKQTeV2YupXHZAqOxQUy88
	 2Jwigl/pYrVZiCpDKpGhuevmDeOYjEWAFWjK4CQhtHnqb+8o9u3PmYZmD2tvU41F5zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=oHHSoznikn/qcXytczyKzxLMNVcoFdh0Jgb4/TSbJPQ=;
	b=PR3eqmMGtajhibmiRqtXN3juyJ+Zdr5YYSKM7BAB+Zuaqp8QzfG2mpXGkVtEZXi6im3V
	 Kmm3SXBr9LuP3Wb7XvV0EDoJbeWzhEZ0wtfIKvVGAbK9YB4F0XGs2mv+ohWLwmC95JWnD
	 LmcOEK/PbaFLh8Ze+Cb5rUODJpTaREENoMRZPaEmYHkyfh5TCjadRlTMVSksNy5IrSarw
	 C30535tkjg6OmkMO3430gUmPm+uCZ5JRBW08kuFOPj9IO4iFpKR/hFcaXGDNQVvvKsYhU
	 Hy3mbfP/qEs4+H+4MDEIZ7W/9xmfMWdQ6HGJNtMrSWtYLZYbhtj0sQ2IylNjijUMr2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VjzDVXMI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4560A261E;
	Fri, 20 Nov 2026 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC4560A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VjzDVXMI
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 89FAD205B44;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHHSoznikn/qcXytczyKzxLMNVcoFdh0Jgb4/TSbJPQ=;
	b=VjzDVXMIOlY+9uy/2f3S3hRk/Y+jYSnk8wY9qoGO6EhX1xi3TH10h3qLmyxR800L/TGk0F
	Gi7YbeDgg0nfYqLdxzY2mwuLeoKl2Hxt+rLsnIjk9sXorCxZ27iMHcNisIVE7RKchNW12F
	2tqTxyHLu1rLQfrdrvEwi0O3RPxEQ86IIeWcZ1kN41VEvEB391IEMFt/BCYsmjHL8m8NCw
	kFgC2tPVFEXEGct91iFNYu3m6dhpCgk6pDq2LDjTv+2jIJrGPNkhs424gCWQvVHG8Sky4Z
	lmwhGh8vaSqIFDTdDdwYlSp7W+dANM3fRyuHMo4Hq4nxqGVJeZkT5PMdb3h2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHHSoznikn/qcXytczyKzxLMNVcoFdh0Jgb4/TSbJPQ=;
	b=aqJhEIPxnjIDMWE2Kcns2o/w2wXPaL2qmTBVJNFIOk7JmOoV2/iu55Df/qHgSSJiX6xI+5
	bb2ZHtMgq+zrorYhH1cMwJpvDOeasmdFgZyctjan3mqBs+Vrt1ys3REHKJXBJzcBINVsq5
	FaUucdfTZmWYpfLYWA0vKQHQ8GfdUI0Cm0DEj6YzAVnfmLNCesnt+QQrqnjDpe7hS0raJA
	DOgQtf+ji1ypGJ9I9UMiIfLjvELRPjR6ffabRcl/6ZPvNtKX1z9LlLjXU3d1rOYhE9XuVF
	lq5voVuR8KvSAAzwX5vxogCMzZsVMnzj6vUPEGg6j4lqboZ/d65VC4GnA0oYUg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=gM4hvGD5m78LqovW9rM+XBUIb+VNSciO7Pt9L5ieunQWnXwEB3GLMiUnB8JdCMyOhIFr1e
	pXEPulgutNZhV9n/A3MLacBiAnk3zGJDuEDfigL9D9eSM3kWKiVIMa8z6SI/KsXJx3Cwdu
	rFUT05MQ1r7IdO8OqaK3YDrQgeHi2McYD9r1LYmlWHVkDCbXXs4QzOU+byE9bCscMpnGZx
	ppS5qi27IowZV3u4oNMcIdmd95hNZSMSj9Ky1QgBie3CJ1AFjcIfFkAAxpz7epfxpbczWG
	jIAYcCw1pRaYe7LTtAad68N9JONSz02u8swKUyExcuoUGE/ihaAKut/wjn+02g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 535CD381A74; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:46:03 +0100
Subject: [PATCH can-next v5 8/9] selftests: can: cover J1939 transport
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
Message-Id: <20261120-j1939-selftests-v5-8-fdf4c242a37e@pengutronix.de>
References: <20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de>
In-Reply-To: <20261120-j1939-selftests-v5-0-fdf4c242a37e@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Felix Maurer <fmaurer@redhat.com>, Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 Chaosheng Qu <quchaosheng000406@163.com>, 
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
A: Only when the peer shares the vcan, or when RPS is on for the peer's
vcan and cannot be turned off. The test warns in the first case, and
j1939_lib.sh in the second. See the echo-race Q&A in patch 7. By
default the CAN_RAW peer is on its own vcan, linked by a CAN gateway,
and RPS is off on that vcan (patch 2).

Q: why is there no test for a Connection Abort received on a kernel TX
session?
A: The stack ignores a Connection Abort received on a TX session today,
so such a test would fail. This series changes no kernel code.

Changes in v5:
- Q&A: RPS is now off on the peer's vcan, or j1939_lib.sh warns (sashiko)
- add the J1939_STRICT_TIMING example to j1939_helpers.h, moved from
  patch 5; this patch adds the first timer check

Changes in v4:
- use recv_none_ok() for the negative receive check

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
 tools/testing/selftests/net/can/j1939_helpers.h    |   7 +-
 tools/testing/selftests/net/can/test_j1939_multi.c | 267 ++++++++++++++++++++-
 2 files changed, 272 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
index ac9f2cd43b4983a68ffaf0c5d3512bf839292031..1e2d6b1da1e0ac591e6aaacbdeb42191c913b680 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.h
+++ b/tools/testing/selftests/net/can/j1939_helpers.h
@@ -12,7 +12,12 @@
  *
  * Timing modes: timer checks use relaxed bounds by default, so that slow
  * machines such as QEMU in CI pass. Set J1939_STRICT_TIMING in the
- * environment (any value) for tight bounds on a real machine.
+ * environment (any value) for tight bounds on a real machine:
+ *
+ *	J1939_STRICT_TIMING=1 ./test_j1939_multi.sh
+ *
+ * Where a bound differs between the modes, the check picks it with
+ * j1939_timing_ms().
  */
 #ifndef __SELFTESTS_NET_CAN_J1939_HELPERS_H__
 #define __SELFTESTS_NET_CAN_J1939_HELPERS_H__
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
index 6edce7493892b0eaaa0e3249dd921b08fa67df5e..8fdf44e75b58b22f2288d0bc68fb0cf8d0a6bc3e 100644
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
  * its own TP and ETP frames. A CAN_RAW peer on the same vcan can read
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
@@ -676,6 +850,97 @@ TEST_F(j1939_multi, etp_tx_to_raw)
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
+	EXPECT_TRUE(recv_none_ok(self->j1939))
+		TH_LOG("socket delivered data despite the abort");
+}
+
 int main(int argc, char **argv)
 {
 	return j1939_test_main(argc, argv, J1939_NEEDS_RAW);

-- 
2.47.3

