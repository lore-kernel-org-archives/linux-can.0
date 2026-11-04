Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809074;
	b=nZYDiw0VUhapGEJUpXmSuaTWYTlI3NArqy/61y04HhhWKz64dYEJXNkrDt47YrOcd0K+
	 KEx4Kd0BKw3p6Yfu/bsmihjH7weY3iNgw1mAUXlbfEtuOPHNwH9qREYF3tjsI3N8zn/zx
	 lbSADHWQGytRHR/tPfisd4bYahk2EWitvO3ibwR8n6l9X5jx5kkmPVZYLoIV7pa22xWof
	 Ba/xl2MfF1++sR19eXwZWaywtySodcY3oj77m2qxggTEKCHLUOkVgj3lFQNM9YBNApzOC
	 8bpe8bSGKpjbCG81t52sEXeAB/3QcS+oWBcgreHpFQULHsxdKlNZtMvAQ183pUzG71A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809074;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ONgZHop3ZtEL8lLnEmhmPsTjsGZYDlMw6lncU/1U9to=;
	b=d1yErnLwvz+DA8Z12yO63fJNF/en7bSOnrILfjjbKFhzjXkp4f/pKq/fxNkyxqTbwuaU
	 uHeI/l7Qmb91GxeAAcse9cBNu6FZ17iAEcVhZOCg0K7BVrIV8i/bGvM5TpgBAcQpvrj0n
	 qjqGnJJoR0BeWt2UiRj/vQn9svwwoQr4p4qEcj8YccJ5oY+Jm1D2tRbkJbOVa3oPQqTAM
	 6H63tyhBhd//Dtaso+iILcaprru498J2v/j0Pxxf8ro374tIMli26yX6miVdKVgBy3jqH
	 dSQtCe/dCsNZTHnIzLtUniWoK/cbxFa+XUXVjSLNtakAVprryPMo4nCLXTiYXxhQL7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=N2k34kSv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638376082BC1;
	Wed,  4 Nov 2026 16:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 638376082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=N2k34kSv
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AA406202BBD;
	Wed, 04 Nov 2026 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONgZHop3ZtEL8lLnEmhmPsTjsGZYDlMw6lncU/1U9to=;
	b=N2k34kSvhd/lnZP/i7FaI0frhqa8rIWMKbVBeqc+woEBtfTJo4gUIi5yPH0PqMNMB9VMdu
	VoAgFDUjKzDMoVKPOS8arXi7wIcnpnGNfSRaZA3TvYANKEaIo+lAckeiZiKp8fTGAeR+Zb
	HBkBE1x1HRsaEw6H0YQTneMa+Df9aAOrP9dqblfqiaWJiCKgtybEUrzFFRd3O59un3nSRv
	ctRpS8bdmrE4YS9bnVt+eKgoQe6nadGt3vSnDwZxR6qigw45mK0fo7zVrs66n9EnlL9M7G
	jsuOs0FA88WsWjorJt+2zSgkonoHTMvJpLez2U109Ousnc+UBfzT7eE7wS0l5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONgZHop3ZtEL8lLnEmhmPsTjsGZYDlMw6lncU/1U9to=;
	b=TAc5Aj9Ij9jxvzvtjajAw08gQw0y4Sry2WAjCPrhxDmmLWJckHLz4PLtLO5HkpVGhSY2dy
	mdYa2DSnvORqHMvZpOAXW4d12VGQCDxpSExnQDiFpglJpFkB1mixSlzNdkgeyddY3rL3y5
	+A6ehpjooWWXFzU38z99tU9oY+avfTJtcCvDY5vUoMtphnbgmCW5pc/Ju7wgd0SPIVEfWJ
	4QiFJjpXXAXx6PklmVSFv/IHAw/3JC5Z61PZC4mrHooTneiAUIFNrblsr9nzTvinVU+Zhz
	EsHaCKZ3R3ceCOpOUFIvXcqQbkNNyuIkyETiWhvGPsG/fgRczT18nIiVx99YrQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809067; a=rsa-sha256;
	cv=none;
	b=PjdSSl1rU9xcwyr01hx8+aBsBW42t9nxjmaW9ncG5XDUwMqwD8dvQW3XHd6pPa69KxfFxy
	5I1aVvDI/ZIOe1G9x3pr4xVPIeCB4zFd2c6dBHGMftK6KE3QIPftdw47OJdRaujdZjnVKK
	JZo+LQoBBRjKsGLBVQBkQD9jeG2LwM2q021I99Jz6EjR+BK2B95Hn0G6i/su64H5i8wg2l
	sQsVn8FlKoCbYJJJq2Yf0DaF3q3ewjSnRCAM/f/tzsmMQGMgn3/5aDGYOyA2IwsTlmLMHe
	DjHNNPcqYkhnScR7LviuPbT578QyEOZ412mY4j6R9ShbuWFGqcSNvmoorenalg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 57359380E8D; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:22 +0100
Subject: [PATCH can-next v2 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
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
Message-Id: <20261104-j1939-selftests-v2-7-cf797c83317b@pengutronix.de>
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

Add Transport Protocol (TP) and Extended Transport Protocol (ETP)
round-trip tests in both directions, with a CAN_RAW socket as the
transport peer. The raw peer sees the frames as they are on the wire, so
a framing bug in the kernel cannot cancel out against its own decoder.

The tests check the PGN in each control frame the kernel sends, with a
PGN that has the DP bit set. In the TX tests, the peer's EOMA must end
the session with a TX-completion ACK on the socket's error queue, and no
ACK may come before the EOMA.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q: can a multi test fail against a correct kernel?
A: Yes, through one known race in the stack: it updates a session from
the loopback echo of its own CTS, RTS and DT frames, and a CAN_RAW peer
can see that echo before the stack does. A peer frame that follows
quickly can then cancel the session and fail a multi test. The fix
belongs in the stack, not in these tests.

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, add static asserts, avoid casts and return bool
  from helpers named *_ok()
- fail at once on a CTS for 0 packets, a CTS that does not ask for the
  next packet, or a DPO that does not match the CTS
- check the source address of the kernel's TP/ETP frames
- check the packet count in each CTS: all packets left, capped by the
  RTS limit for TP and by a full block for ETP
- check the PGN in each control frame the kernel sends, with a PGN that
  has the DP bit set
- check that the peer's EOMA ends a TP or ETP TX session with a
  TX-completion ACK, and that no ACK comes before it (sashiko)
- a reassembled message longer than the one sent now fails (sashiko)
- check the sequence number and the length of each DT frame the kernel
  sends (sashiko)
- keep the Makefile and .gitignore lists sorted; the wrapper no longer
  sets J1939_TEST_PROG
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   1 +
 tools/testing/selftests/net/can/j1939_tests.h      |   8 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 618 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 5 files changed, 632 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index d83fd28a50766c25069c60d10deb76e5722bba5b..9042b532e0e19e5e9f4e0ecae3f28d73b7089405 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_j1939_addr
 test_j1939_base
+test_j1939_multi
 test_j1939_opts
 test_j1939_wire
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 5262f0b8f73f80f524c32665c1fc08a7a0ec7e78..0b9fb4227f07b35a0fbd8a33534754a36b00b73c 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -9,6 +9,7 @@ LOCAL_HDRS := j1939_tests.h
 TEST_PROGS := \
 	test_j1939_addr.sh \
 	test_j1939_base.sh \
+	test_j1939_multi.sh \
 	test_j1939_opts.sh \
 	test_j1939_wire.sh \
 	test_raw_filter.sh \
diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
index bb22faa323e3d7de87a0a9a447216caaeb6b4b52..8c3ac4b4538a3948aaa9d843237ef846a49b6c70 100644
--- a/tools/testing/selftests/net/can/j1939_tests.h
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -743,6 +743,14 @@ static inline bool errqueue_read_ack_ok(int s)
 	return msg_has_tstamp_ack(&msg);
 }
 
+/* Is the error queue of s still empty after J1939_NEG_RECV_TIMEOUT_MS? */
+static inline bool errqueue_empty_ok(int s)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLERR };
+
+	return poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS) == 0;
+}
+
 /* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
 #define J1939_PATTERN_SEED	0x3c
 
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
new file mode 100644
index 0000000000000000000000000000000000000000..88a283a3394e026f69d17cd36222c0812d9b38a1
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 multi-frame wire selftests: TP and ETP against CAN_RAW.
+ *
+ * A CAN_RAW socket plays the transport peer and drives the handshake against
+ * the kernel J1939 stack, in both directions: for TP the raw side answers
+ * RTS/CTS and exchanges DT frames with EOMA; ETP does the same
+ * with a payload spanning several CTS blocks (DPO windows).
+ *
+ * Run by test_j1939_multi.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* arbitrary addresses */
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW transport peer */
+/* transported message PGN, with the DP bit set so a PGN cut to 16 bits shows */
+#define PGN_DATA		(J1939_PGN_DP | 0x0feef)
+_Static_assert(PGN_DATA & J1939_PGN_DP, "PGN_DATA must have the DP bit set");
+
+/*
+ * Priority for the TP and ETP frames this test injects as the CAN_RAW
+ * peer. SAE J1939-21:2001 lists 7 as the TP.CM/TP.DT default and
+ * ISO 11783-6:2004 Annex K gives 6 for ETP; the stack checks neither.
+ */
+#define PRIO			7
+
+/*
+ * PGNs, control bytes and field byte offsets (_OFF) of TP (SAE J1939-21:2001
+ * sections 5.10.3 and 5.10.4) and ETP (ISO 11783-6:2004 K.2.2.1 and K.2.3).
+ */
+
+/* PGNs */
+#define TP_CM			0x0ec00
+#define TP_DT			0x0eb00
+#define ETP_CM			0x0c800
+#define ETP_DT			0x0c700
+
+/* control bytes */
+#define TP_CMD_RTS		0x10
+#define TP_CMD_CTS		0x11
+#define TP_CMD_EOMA		0x13
+
+#define ETP_CMD_RTS		0x14
+#define ETP_CMD_CTS		0x15
+#define ETP_CMD_DPO		0x16
+#define ETP_CMD_EOMA		0x17
+
+/* field offsets */
+#define TP_RTS_SIZE_OFF		1	/* le16 */
+#define TP_RTS_PKTS_OFF		3
+#define TP_RTS_MAX_PKTS_OFF	4
+#define TP_CTS_PKTS_OFF		1
+#define TP_CTS_NEXT_OFF		2
+#define TP_EOMA_SIZE_OFF	1	/* le16 */
+#define TP_EOMA_PKTS_OFF	3
+
+#define ETP_RTS_SIZE_OFF	1	/* le32 */
+#define ETP_CTS_PKTS_OFF	1
+#define ETP_CTS_NEXT_OFF	2	/* le24 */
+#define ETP_DPO_PKTS_OFF	1
+#define ETP_DPO_BASE_OFF	2	/* le24, packets before this block */
+#define ETP_EOMA_SIZE_OFF	1	/* le32 */
+
+/*
+ * largest ETP.CTS packet count: the field is one byte. It is also the
+ * kernel's ETP block (pkt.block, applied in j1939_session_tx_cts()).
+ */
+#define ETP_CTS_MAX_PKTS	UINT8_MAX
+/* TP and ETP packet numbers start at 1 */
+#define TP_FIRST_PKT		1
+/* TP counts DT sequence numbers from the start of the message */
+#define TP_BASE_PKT		0
+
+/* message sizes: TP of several packets, ETP of several ETP.CTS blocks */
+#define TP_SIZE			200
+_Static_assert(TP_SIZE > J1939_SF_MAX_SIZE, "TP_SIZE must need TP");
+_Static_assert(TP_SIZE <= J1939_TP_MAX_SIZE, "TP_SIZE must fit TP");
+
+#define ETP_SIZE		6000U
+_Static_assert(ETP_SIZE > J1939_TP_MAX_SIZE, "ETP_SIZE must need ETP");
+_Static_assert(J1939_NUM_PKTS(ETP_SIZE) > ETP_CTS_MAX_PKTS,
+	       "ETP_SIZE must span several ETP.CTS blocks");
+
+/* an RTS per-CTS limit as large as the message: all packets in one CTS */
+#define TP_CTS_ALL		J1939_NUM_PKTS(TP_SIZE)
+_Static_assert(TP_CTS_ALL <= UINT8_MAX, "the TP.CM packet counts are one byte");
+
+FIXTURE(j1939_multi)
+{
+	int ifindex;
+	int j1939;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_multi)
+{
+	self->j1939 = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+
+	J1939_SETUP_RAW(self, J1939_RAW_BIG_RCVBUF);
+}
+
+FIXTURE_TEARDOWN(j1939_multi)
+{
+	if (self->j1939 >= 0)
+		close(self->j1939);
+	if (self->raw >= 0)
+		close(self->raw);
+}
+
+/*
+ * Finish a TP/ETP control frame by embedding its data PGN and sending it on the
+ * control PGN. dat must already hold the command and its command-specific
+ * bytes.
+ */
+static bool send_cm_frame_ok(int raw, uint8_t prio, pgn_t cm_pgn, uint8_t da,
+			     uint8_t sa, uint8_t *dat, pgn_t data_pgn)
+{
+	put_pgn(dat, data_pgn);
+	return send_raw8_ok(raw, prio, cm_pgn, da, sa, dat);
+}
+
+/* send_cm_frame_ok() from the peer to the kernel, for PGN_DATA. */
+static bool peer_send_cm_ok(int raw, pgn_t cm_pgn, uint8_t *dat)
+{
+	return send_cm_frame_ok(raw, PRIO, cm_pgn, SA_LOCAL, SA_PEER, dat,
+				PGN_DATA);
+}
+
+/*
+ * Receive the next control frame on cm_pgn from the kernel to the peer and
+ * check that it has the control byte cmd and carries PGN_DATA.
+ */
+static bool recv_kernel_cm_ok(int raw, pgn_t cm_pgn, uint8_t cmd,
+			      struct can_frame *frame, int timeout_ms)
+{
+	if (!recv_cm_cmd_ok(raw, J1939_PF(cm_pgn), SA_PEER, SA_LOCAL, frame,
+			    timeout_ms, cmd))
+		return false;
+
+	return get_le24(&frame->data[J1939_CM_PGN_OFF]) == PGN_DATA;
+}
+
+/*
+ * Build and send a TP.CM_RTS: message size, total packets and max packets/CTS.
+ */
+static bool send_tp_rts_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da,
+			   uint8_t sa, uint16_t size, uint8_t total_pkts,
+			   uint8_t max_cts_pkts)
+{
+	uint8_t dat[CAN_MAX_DLEN];
+
+	cm_dat_init(dat, TP_CMD_RTS);
+	put_le16(&dat[TP_RTS_SIZE_OFF], size);
+	dat[TP_RTS_PKTS_OFF] = total_pkts;
+	dat[TP_RTS_MAX_PKTS_OFF] = max_cts_pkts;
+	return send_cm_frame_ok(raw, prio, TP_CM, da, sa, dat, pgn);
+}
+
+/*
+ * Send a burst of @count DT frames for the block starting at the 1-based packet
+ * @next, each carrying up to J1939_DT_DATA_LEN payload bytes from the matching
+ * absolute offset. The first frame has sequence number @first_seq: TP numbers
+ * packets across the whole message (@next), ETP starts again at TP_FIRST_PKT
+ * in each DPO block.
+ */
+static bool send_dt_burst_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da,
+			     uint8_t sa, unsigned int next, unsigned int count,
+			     const uint8_t *payload, size_t size,
+			     unsigned int first_seq)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		size_t abs_pkt = (next - 1) + i;
+		uint8_t seq = first_seq + i;
+
+		if (!send_dt_ok(raw, prio, dt_pgn, da, sa, seq, payload,
+				abs_pkt * J1939_DT_DATA_LEN, size))
+			return false;
+	}
+	return true;
+}
+
+/* send_dt_burst_ok() for TP, which numbers packets across the message */
+static bool send_tp_dt_burst_ok(int raw, uint8_t da, uint8_t sa,
+				unsigned int next, unsigned int count,
+				const uint8_t *payload, size_t size)
+{
+	return send_dt_burst_ok(raw, PRIO, TP_DT, da, sa, next, count, payload,
+				size, next);
+}
+
+/*
+ * Check a CTS or ETP.CTS from the kernel for cts_pkts packets from the 1-based
+ * packet next. After sent of num_pkts packets, the kernel must ask for packet
+ * sent + 1 and for min(cts_limit, num_pkts - sent) packets, see
+ * j1939_session_tx_cts(). No frame is lost here, so no resend is expected
+ * (SAE J1939-21:2001 section 5.10.3.2 allows one for TP).
+ */
+static bool cts_accept_ok(unsigned int cts_pkts, unsigned int next,
+			  unsigned int sent, unsigned int num_pkts,
+			  unsigned int cts_limit)
+{
+	unsigned int want = num_pkts - sent;
+
+	if (want > cts_limit)
+		want = cts_limit;
+	if (cts_pkts == want && next == sent + 1)
+		return true;
+
+	fprintf(stderr, "# CTS for %u packets from %u, want %u from %u\n",
+		cts_pkts, next, want, sent + 1);
+	return false;
+}
+
+/*
+ * Answer each CTS from the kernel with a DT burst from the peer, until
+ * num_pkts are delivered. Each CTS must ask for cts_limit packets, or for the
+ * rest, see cts_accept_ok().
+ */
+static bool tp_serve_cts_ok(int raw, const uint8_t *payload, size_t size,
+			    unsigned int num_pkts, unsigned int cts_limit)
+{
+	unsigned int sent = 0;
+	struct can_frame frame;
+
+	while (sent < num_pkts) {
+		unsigned int cts_pkts, next;
+
+		if (!recv_kernel_cm_ok(raw, TP_CM, TP_CMD_CTS, &frame,
+				       J1939_RECV_TIMEOUT_MS))
+			return false;
+
+		cts_pkts = frame.data[TP_CTS_PKTS_OFF];
+		next = frame.data[TP_CTS_NEXT_OFF];	/* 1-based */
+		if (!cts_accept_ok(cts_pkts, next, sent, num_pkts, cts_limit))
+			return false;
+
+		if (!send_tp_dt_burst_ok(raw, SA_LOCAL, SA_PEER, next, cts_pkts,
+					 payload, size))
+			return false;
+
+		sent += cts_pkts;
+	}
+	return true;
+}
+
+/*
+ * Answer each ETP.CTS from the kernel with a DPO and the block's DT frames,
+ * until the ETP_SIZE bytes of payload are delivered. Each ETP.CTS must ask
+ * for a full block of ETP_CTS_MAX_PKTS packets, or for the rest.
+ */
+static bool etp_rx_serve_cts_ok(int raw, const uint8_t *payload)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(ETP_SIZE), sent = 0;
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	while (sent < num_pkts) {
+		unsigned int cts_pkts, next;
+
+		if (!recv_kernel_cm_ok(raw, ETP_CM, ETP_CMD_CTS, &frame,
+				       J1939_RECV_TIMEOUT_MS)) {
+			fprintf(stderr, "# no ETP CTS after %u/%u packets\n",
+				sent, num_pkts);
+			return false;
+		}
+
+		cts_pkts = frame.data[ETP_CTS_PKTS_OFF];
+		next = get_le24(&frame.data[ETP_CTS_NEXT_OFF]);	/* 1-based */
+		if (!cts_accept_ok(cts_pkts, next, sent, num_pkts,
+				   ETP_CTS_MAX_PKTS))
+			return false;
+
+		cm_dat_init(dat, ETP_CMD_DPO);
+		dat[ETP_DPO_PKTS_OFF] = cts_pkts;
+		put_le24(&dat[ETP_DPO_BASE_OFF], next - 1);
+		if (!peer_send_cm_ok(raw, ETP_CM, dat))
+			return false;
+
+		if (!send_dt_burst_ok(raw, PRIO, ETP_DT, SA_LOCAL, SA_PEER,
+				      next, cts_pkts, payload, ETP_SIZE,
+				      TP_FIRST_PKT))
+			return false;
+
+		sent += cts_pkts;
+	}
+	return true;
+}
+
+/*
+ * Scatter a received DT frame's payload into buf, a message of size bytes,
+ * at the offset implied by its sequence number. base_pkt is the 0-based
+ * absolute packet the 1-based seq is relative to (TP_BASE_PKT for TP, the DPO
+ * offset for ETP).
+ */
+static void unpack_dt_into(uint8_t *buf, size_t size, unsigned int base_pkt,
+			   const struct can_frame *frame)
+{
+	size_t abs_pkt = base_pkt + (frame->data[J1939_DT_SEQ_OFF] - 1);
+	size_t off = abs_pkt * J1939_DT_DATA_LEN;
+
+	/* drop a frame with a bad sequence number instead of overrunning buf */
+	if (off >= size)
+		return;
+
+	memcpy(buf + off, &frame->data[J1939_DT_DATA_OFF],
+	       j1939_dt_chunk_len(size, off));
+}
+
+/*
+ * Receive count DT frames on dt_pgn from the kernel and scatter them into
+ * buf, a message of size bytes; base_pkt as for unpack_dt_into(). Each frame
+ * must have CAN_MAX_DLEN bytes (the kernel pads the last one, see
+ * j1939_tp_tx_dat()) and the sequence number TP_FIRST_PKT + i, as in one ETP
+ * block or a TP CTS window from the first packet.
+ */
+static bool recv_dt_block_ok(int raw, pgn_t dt_pgn, uint8_t *buf, size_t size,
+			     unsigned int base_pkt, unsigned int count)
+{
+	struct can_frame frame;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (!recv_for_peer_ok(raw, J1939_PF(dt_pgn), SA_PEER, SA_LOCAL,
+				      &frame, J1939_RECV_TIMEOUT_MS)) {
+			fprintf(stderr, "# missing DT %u of %u\n",
+				i + TP_FIRST_PKT, count);
+			return false;
+		}
+		if (frame.len != CAN_MAX_DLEN ||
+		    frame.data[J1939_DT_SEQ_OFF] != TP_FIRST_PKT + i) {
+			fprintf(stderr, "# DT %u of %u: len %u, seq %u\n",
+				i + TP_FIRST_PKT, count, frame.len,
+				frame.data[J1939_DT_SEQ_OFF]);
+			return false;
+		}
+		unpack_dt_into(buf, size, base_pkt, &frame);
+	}
+	return true;
+}
+
+/*
+ * Open a TP RX j1939 socket and send the RTS for a TP_SIZE message that
+ * starts a receive session.
+ */
+static bool tp_rx_open_and_send_rts_ok(int *j1939, int raw, int ifindex,
+				       uint8_t cts_limit)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, PGN_DATA);
+	if (*j1939 < 0)
+		return false;
+
+	return send_tp_rts_ok(raw, PRIO, PGN_DATA, SA_LOCAL, SA_PEER, TP_SIZE,
+			      J1939_NUM_PKTS(TP_SIZE), cts_limit);
+}
+
+/*
+ * TP-RX round-trip: open the j1939 socket, drive a full TP receive from the
+ * raw peer advertising cts_limit packets per CTS, and verify the reassembled
+ * payload against the sent pattern. Each CTS must ask for cts_limit packets,
+ * or for the rest, see cts_accept_ok(). The kernel's EOMA frame is returned
+ * via *eoma_out.
+ */
+static bool tp_rx_roundtrip_ok(FIXTURE_DATA(j1939_multi) *self,
+			       uint8_t cts_limit,
+			       struct can_frame *eoma_out)
+{
+	uint8_t payload[TP_SIZE];
+
+	fill_pattern(payload, sizeof(payload));
+
+	if (!tp_rx_open_and_send_rts_ok(&self->j1939, self->raw, self->ifindex,
+					cts_limit))
+		return false;
+
+	if (!tp_serve_cts_ok(self->raw, payload, TP_SIZE,
+			     J1939_NUM_PKTS(TP_SIZE), cts_limit))
+		return false;
+
+	if (!recv_kernel_cm_ok(self->raw, TP_CM, TP_CMD_EOMA, eoma_out,
+			       J1939_RECV_TIMEOUT_MS))
+		return false;
+
+	return recv_verify_ok(self->j1939, payload, sizeof(payload),
+			      J1939_RECV_TIMEOUT_MS);
+}
+
+/*
+ * TP RX: the CAN_RAW peer transmits a TP message to the J1939 socket.
+ * raw sends RTS, then answers each CTS from the kernel with DT frames.
+ */
+TEST_F(j1939_multi, tp_rx_from_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+
+	/* the RTS allows all packets in one CTS */
+	ASSERT_TRUE(tp_rx_roundtrip_ok(self, TP_CTS_ALL, &frame))
+		TH_LOG("TP RX round-trip against the raw peer failed");
+
+	/* frame is the kernel's EOMA */
+	EXPECT_EQ(get_le16(&frame.data[TP_EOMA_SIZE_OFF]), TP_SIZE);
+	EXPECT_EQ(frame.data[TP_EOMA_PKTS_OFF], num_pkts);
+}
+
+/*
+ * Start a TP/ETP transmit session from the J1939 socket: open a socket bound
+ * to SA_LOCAL with no PGN, connect to the peer, send the size bytes of
+ * payload and collect the kernel's RTS from the raw peer (cm_pgn/rts_cmd
+ * select TP or ETP). *j1939 holds the fd before connect() or send() can
+ * fail, so the fixture teardown closes it.
+ */
+static bool tx_start_session_ok(int *j1939, int raw, int ifindex,
+				const void *payload, size_t size,
+				pgn_t cm_pgn, uint8_t rts_cmd,
+				struct can_frame *rts)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, J1939_NO_PGN);
+	if (*j1939 < 0)
+		return false;
+
+	if (!j1939_connect_ok(*j1939, ifindex, SA_PEER, PGN_DATA))
+		return false;
+
+	if (!send_all_ok(*j1939, payload, size))
+		return false;
+
+	return recv_kernel_cm_ok(raw, cm_pgn, rts_cmd, rts,
+				 J1939_RECV_TIMEOUT_MS);
+}
+
+static bool tp_tx_start_session_ok(FIXTURE_DATA(j1939_multi) *self,
+				   const void *payload, size_t size,
+				   struct can_frame *rts)
+{
+	return tx_start_session_ok(&self->j1939, self->raw, self->ifindex,
+				   payload, size, TP_CM, TP_CMD_RTS, rts);
+}
+
+static bool etp_tx_start_session_ok(FIXTURE_DATA(j1939_multi) *self,
+				    const void *payload, size_t size,
+				    struct can_frame *rts)
+{
+	return tx_start_session_ok(&self->j1939, self->raw, self->ifindex,
+				   payload, size, ETP_CM, ETP_CMD_RTS, rts);
+}
+
+/*
+ * TP TX: the J1939 socket transmits a TP message to the CAN_RAW peer.
+ * raw answers the kernel's RTS with a CTS, collects the DT frames and
+ * acknowledges with EOMA, which completes the session: the socket gets the
+ * TX-completion ACK.
+ */
+TEST_F(j1939_multi, tp_tx_to_raw)
+{
+	uint8_t payload[TP_SIZE], rx_buf[TP_SIZE];
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+	uint8_t dat[CAN_MAX_DLEN];
+
+	fill_pattern(payload, sizeof(payload));
+	memset(rx_buf, 0, sizeof(rx_buf));
+
+	ASSERT_TRUE(tp_tx_start_session_ok(self, payload, sizeof(payload),
+					   &frame));
+	ASSERT_TRUE(errqueue_enable_ack_ok(self->j1939));
+
+	EXPECT_EQ(get_le16(&frame.data[TP_RTS_SIZE_OFF]), TP_SIZE);
+	EXPECT_EQ(frame.data[TP_RTS_PKTS_OFF], num_pkts);
+
+	/* request all packets in one CTS, starting at the first */
+	cm_dat_init(dat, TP_CMD_CTS);
+	dat[TP_CTS_PKTS_OFF] = num_pkts;
+	dat[TP_CTS_NEXT_OFF] = TP_FIRST_PKT;
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, TP_CM, dat));
+
+	ASSERT_TRUE(recv_dt_block_ok(self->raw, TP_DT, rx_buf, TP_SIZE,
+				     TP_BASE_PKT, num_pkts));
+	EXPECT_TRUE(errqueue_empty_ok(self->j1939))
+		TH_LOG("TX-completion ACK before the EOMA");
+
+	cm_dat_init(dat, TP_CMD_EOMA);
+	put_le16(&dat[TP_EOMA_SIZE_OFF], TP_SIZE);
+	dat[TP_EOMA_PKTS_OFF] = num_pkts;
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, TP_CM, dat));
+
+	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
+	EXPECT_TRUE(errqueue_read_ack_ok(self->j1939))
+		TH_LOG("no TX-completion ACK after the EOMA");
+}
+
+/*
+ * ETP RX: the CAN_RAW peer transmits an ETP message to the J1939 socket.
+ * The kernel requests blocks with ETP.CTS; raw answers each with a DPO and
+ * the block's DT frames. The payload spans several ETP.CTS blocks.
+ */
+TEST_F(j1939_multi, etp_rx_from_raw)
+{
+	static uint8_t payload[ETP_SIZE];
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	fill_pattern(payload, ETP_SIZE);
+
+	self->j1939 = j1939_open(self->ifindex, SA_LOCAL, PGN_DATA);
+	ASSERT_GE(self->j1939, 0);
+
+	cm_dat_init(dat, ETP_CMD_RTS);
+	put_le32(&dat[ETP_RTS_SIZE_OFF], ETP_SIZE);
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, ETP_CM, dat));
+
+	ASSERT_TRUE(etp_rx_serve_cts_ok(self->raw, payload));
+
+	ASSERT_TRUE(recv_kernel_cm_ok(self->raw, ETP_CM, ETP_CMD_EOMA, &frame,
+				      J1939_RECV_TIMEOUT_MS))
+		TH_LOG("no well-formed ETP EOMA from kernel after last DT");
+	EXPECT_EQ(get_le32(&frame.data[ETP_EOMA_SIZE_OFF]), ETP_SIZE);
+
+	EXPECT_TRUE(recv_verify_ok(self->j1939, payload, ETP_SIZE,
+				   J1939_RECV_TIMEOUT_MS))
+		TH_LOG("J1939 socket did not get the exact ETP message");
+}
+
+/*
+ * Ask the kernel for the ETP block of cts_pkts packets after the first got
+ * packets, check its DPO and receive the block into rx_buf.
+ */
+static bool etp_tx_serve_block_ok(FIXTURE_DATA(j1939_multi) *self,
+				  uint8_t *rx_buf, unsigned int got,
+				  unsigned int cts_pkts)
+{
+	unsigned int next = got + 1;		/* 1-based */
+	unsigned int dpo_num, dpo_base_pkt;
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	cm_dat_init(dat, ETP_CMD_CTS);
+	dat[ETP_CTS_PKTS_OFF] = cts_pkts;
+	put_le24(&dat[ETP_CTS_NEXT_OFF], next);
+	if (!peer_send_cm_ok(self->raw, ETP_CM, dat))
+		return false;
+
+	if (!recv_kernel_cm_ok(self->raw, ETP_CM, ETP_CMD_DPO, &frame,
+			       J1939_RECV_TIMEOUT_MS)) {
+		fprintf(stderr, "# no DPO after %u packets\n", got);
+		return false;
+	}
+
+	dpo_num = frame.data[ETP_DPO_PKTS_OFF];
+	dpo_base_pkt = get_le24(&frame.data[ETP_DPO_BASE_OFF]);
+	if (dpo_num != cts_pkts || dpo_base_pkt != got) {
+		fprintf(stderr,
+			"# DPO for %u packets after %u, want %u after %u\n",
+			dpo_num, dpo_base_pkt, cts_pkts, got);
+		return false;
+	}
+
+	return recv_dt_block_ok(self->raw, ETP_DT, rx_buf, ETP_SIZE,
+				dpo_base_pkt, dpo_num);
+}
+
+/*
+ * ETP TX: the J1939 socket transmits an ETP message to the CAN_RAW peer.
+ * raw requests the data in blocks of ETP_CTS_MAX_PKTS packets (ETP.CTS); for
+ * each block the kernel sends a DPO followed by the DT frames, acknowledged by
+ * EOMA, which completes the session: the socket gets the TX-completion ACK.
+ */
+TEST_F(j1939_multi, etp_tx_to_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(ETP_SIZE);
+	static uint8_t payload[ETP_SIZE], rx_buf[ETP_SIZE];
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+	unsigned int got = 0;
+
+	fill_pattern(payload, ETP_SIZE);
+	memset(rx_buf, 0, sizeof(rx_buf));
+
+	ASSERT_TRUE(etp_tx_start_session_ok(self, payload, ETP_SIZE, &frame));
+	ASSERT_TRUE(errqueue_enable_ack_ok(self->j1939));
+
+	EXPECT_EQ(get_le32(&frame.data[ETP_RTS_SIZE_OFF]), ETP_SIZE);
+
+	while (got < num_pkts) {
+		unsigned int cts_pkts = num_pkts - got;
+
+		if (cts_pkts > ETP_CTS_MAX_PKTS)
+			cts_pkts = ETP_CTS_MAX_PKTS;
+
+		ASSERT_TRUE(etp_tx_serve_block_ok(self, rx_buf, got, cts_pkts))
+			TH_LOG("ETP block after %u/%u packets failed", got,
+			       num_pkts);
+		got += cts_pkts;
+	}
+	EXPECT_TRUE(errqueue_empty_ok(self->j1939))
+		TH_LOG("TX-completion ACK before the EOMA");
+
+	cm_dat_init(dat, ETP_CMD_EOMA);
+	put_le32(&dat[ETP_EOMA_SIZE_OFF], ETP_SIZE);
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, ETP_CM, dat));
+
+	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
+	EXPECT_TRUE(errqueue_read_ack_ok(self->j1939))
+		TH_LOG("no TX-completion ACK after the EOMA");
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.sh b/tools/testing/selftests/net/can/test_j1939_multi.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

