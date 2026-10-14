Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A855C314;
	Wed, 14 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992688; cv=pass; b=kPyXa5xVsFR3FQXQaUiW2vh415PJWNHwbzJcoTFVaLUal64EXgF3LuFikXMGy7Exbs0Tmrk1rTjI8LeC4t/RNEQpOaGsMoTHqqlbBbnLLkRiF4XIqvkoIYNqD00sbJBXwb1p1r3PjrFQkbt6mJceJIcBP00DI7w8YGwfNDYrGPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992688; c=relaxed/simple;
	bh=waHwM96mq5sCn+gi+sCE/41KY5T1kztHYAG3OST75H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWSh1IWmSulFJ7qVXklwAKhzRO+lg4xPDQMhHWBqoiSztR/DuBbp94zKzedJ044yvx5PmQ6lQKwUXhKu33N+CC5EWMlSYVDIl8Gs5jsCotrZR4TAhE05TlJ67kIWOs4xo0ospQrgHHPegvhNJCgc0tHwf6Vd5u2riUMQCH/KQPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=HKPXYXVc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="HKPXYXVc"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3C57B202342;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRmPDnhHFa8lI44IyLRucBBaF4qSYEKhBLI39YR4Its=;
	b=HKPXYXVc2W3YByoBFyEGaK9XwJgkkj1XktnIZS3no2l6BW8AMs+XG1Y+18NhYPJDgAqm3r
	Omk/lK6NGWXQD92Dg8xm6CcRQbRT6zVQun1IfE6WkdJSASxC1jtcc5HEQePdHo6RDezNG0
	UUfdp5c5ekHnU2ITNpjdsayXKmfmVnAFThBVPfIAMkT5Okg6gDXpZs1F+f9zC9xwUDpYMR
	p3duaBjcidZ1R4Lu48S5U/yIbSkM/O2xfJZ1wQwjIEDvcO52OSWhgb/Lp0peQ0R2ig6Vu5
	6KAqBOABlAT4V65IGC4+21nILIonwNg0oPt3GluYxjoLghHBT+fLJTJG4vVFQQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=VtoXHEUXZgWnryuGGszivryaxqGZ/LI2Q+mOsjlXvQ5Q2WxYZXmWR+B4UGtAUVQQkRjPTG
	ObkjiNSbC1gbhujCKjisnRMk+TY6nr0PYxtTSWc0GWU5+rsbWh6PyrYH1INlwwgdqq1VoR
	E0WdSrbiS0G7HJCu6l8PWW+gcTY7ZFnSpb/KsJc9lRnr0QE7jj3grylWDMzJ93zydMmKpH
	iz1wDcYVYl4EYgaQ9Jp5onMwn7dmSOlKGxd3ZcnMcl8La46q8XShE/s8rpDiybmIM2Ay32
	i+0jHkLQidvldygu0rcMdUW4Elfq8lUDaUi2DO4ewg8aQvqC51TKFoEFc9FsdQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRmPDnhHFa8lI44IyLRucBBaF4qSYEKhBLI39YR4Its=;
	b=PKhLVGJaAysGG5uSl3NxZ9JbOwUyhSV0XvtriboSjSsWEfDC/rG1m3aklnweReU97svHzx
	rxkYWETM18zUtFeRqxV79Hkdr+0BmhlitEgb5CTFB0+1s4B9QnMUd2RTAaICSu6jg03lub
	u+jpzuwufcDWC9NIARvdwDwAIi4SaPVcWpD9stAkrf6CGYu99lFROD839pBC9a0dvdfzpz
	Y1RS4wIGZzCICu3fu++cWzn2dEzaCgGC9kUWqjYS/O9WTfQwb4IteImInpjW3x+32Iu757
	GhCmG5lTTNbLpeJq3GtUti85MrZOrHz1HOITwEl4cIA+jBVgn9WWKYEOi84rbg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 2179938925F; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 6/8] selftests: can: add J1939 TP/ETP multi-frame tests against CAN_RAW
Date: Wed, 14 Oct 2026 17:44:32 +0200
Message-ID: <20261014154435.3577983-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154435.3577983-1-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-frame transport tests that pair a J1939 socket with a CAN_RAW
peer. They drive the Transport Protocol (TP) and Extended Transport
Protocol (ETP) round-trips in both directions. The raw peer answers the
kernel's RTS/CTS/DPO sequencing, and the reassembled payload is checked
byte for byte.

The ETP payload spans several 255-packet blocks. In the receive
direction, the test checks the kernel-emitted EOMA on the wire (command
and size, plus the packet count for TP). In the transmit direction the
kernel sends the RTS, so the test also checks its ETP RTS message-size
field.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   2 +
 .../selftests/net/can/test_j1939_multi.c      | 453 ++++++++++++++++++
 .../selftests/net/can/test_j1939_multi.sh     |   5 +
 4 files changed, 461 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/test_j1939_multi.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_multi.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 3f31fa5b7438..b6bf4c613ba3 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -4,3 +4,4 @@ test_j1939_base
 test_j1939_opts
 test_j1939_addr
 test_j1939_wire
+test_j1939_multi
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index d80fa114a0cd..559cca255875 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS := \
 	test_j1939_opts.sh \
 	test_j1939_addr.sh \
 	test_j1939_wire.sh \
+	test_j1939_multi.sh \
 
 TEST_FILES := j1939_lib.sh
 
@@ -21,5 +22,6 @@ TEST_GEN_FILES := \
 	test_j1939_opts \
 	test_j1939_addr \
 	test_j1939_wire \
+	test_j1939_multi \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
new file mode 100644
index 000000000000..1f27ee58f48c
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 multi-frame wire selftests: TP and ETP against CAN_RAW.
+ *
+ * A CAN_RAW socket plays the transport peer and drives the full handshake
+ * against the kernel J1939 stack over the wire, in both directions: for TP the
+ * raw side answers RTS/CTS and exchanges DT frames with EOMA; ETP does the same
+ * with a payload spanning several CTS blocks (DPO windows).
+ *
+ * The vcan interface is set up by the caller (see test_j1939_multi.sh); its name
+ * is passed via the CANIF environment variable.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW transport peer */
+#define PGN_DATA		0x0feef	/* transported message PGN */
+/*
+ * Priority for frames this test injects as the CAN_RAW peer; the stack
+ * does not check it. SAE J1939-21:2001 lists 7 as the TP.CM/TP.DT
+ * default; the kernel defaults its own J1939 TX to 6 (J1939_PRIO_DEFAULT).
+ */
+#define PRIO			7
+
+#define TP_CTL			0x0ec00
+#define TP_DAT			0x0eb00
+#define ETP_CTL			0x0c800
+#define ETP_DAT			0x0c700
+
+#define TP_CMD_RTS		0x10
+#define TP_CMD_CTS		0x11
+#define TP_CMD_EOMA		0x13
+#define TP_CMD_ABORT		0xff
+#define ETP_CMD_RTS		0x14
+#define ETP_CMD_CTS		0x15
+#define ETP_CMD_DPO		0x16
+#define ETP_CMD_EOMA		0x17
+
+#define TP_SIZE			200
+#define ETP_SIZE		6000		/* > TP max 1785 (255*7); several blocks */
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
+ * control PGN. dat must already hold the command and its command-specific bytes.
+ */
+static int send_ctl_frame(int raw, uint8_t prio, pgn_t ctl_pgn, uint8_t da,
+			  uint8_t sa, uint8_t *dat, pgn_t data_pgn)
+{
+	put_pgn(dat, data_pgn);
+	return send_raw8(raw, prio, ctl_pgn, da, sa, dat);
+}
+
+/* Build and send a TP.CM_RTS: message size, total packets and max packets/CTS. */
+static int send_tp_rts(int raw, uint8_t prio, pgn_t pgn, uint8_t da, uint8_t sa,
+		       uint16_t size, uint8_t total_pkts, uint8_t max_cts_pkts)
+{
+	uint8_t dat[8];
+
+	ctl_dat_init(dat, TP_CMD_RTS);
+	put_le16(&dat[1], size);
+	dat[3] = total_pkts;
+	dat[4] = max_cts_pkts;
+	return send_ctl_frame(raw, prio, TP_CTL, da, sa, dat, pgn);
+}
+
+/*
+ * Send a burst of @count DT frames for the block starting at the 1-based packet
+ * @next, each carrying 7 payload bytes from the matching absolute offset. The DT
+ * sequence byte differs by protocol: TP numbers packets absolutely across the
+ * whole message, ETP numbers them 1-based within each DPO block (@seq_relative
+ * selects the latter). Returns 0 on success, -1 on error.
+ */
+static int send_dt_burst(int raw, uint8_t prio, pgn_t dat_pgn, uint8_t da,
+			 uint8_t sa, unsigned int next, unsigned int count,
+			 const uint8_t *payload, size_t size, bool seq_relative)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		unsigned int abs_pkt = (next - 1) + i;
+		uint8_t seq = seq_relative ? (i + 1) : (abs_pkt + 1);
+
+		if (send_dt(raw, prio, dat_pgn, da, sa, seq, payload,
+			    (size_t)abs_pkt * 7, size))
+			return -1;
+	}
+	return 0;
+}
+
+/*
+ * Answer each kernel CTS with its DT burst until num_pkts are delivered.
+ * Returns the largest CTS packet count the kernel requested, or -1 on error.
+ */
+static int tp_serve_cts(int raw, uint8_t prio, uint8_t da, uint8_t sa,
+			const uint8_t *payload, size_t size, unsigned int num_pkts)
+{
+	unsigned int sent = 0, max_want = 0;
+	struct can_frame frame;
+
+	while (sent < num_pkts) {
+		unsigned int want, next;
+
+		if (recv_ctl_cmd(raw, J1939_PF(TP_CTL), sa, &frame,
+				 J1939_RECV_TIMEOUT_MS, TP_CMD_CTS))
+			return -1;
+		want = frame.data[1];
+		next = frame.data[2];		/* 1-based packet number */
+		if (want > max_want)
+			max_want = want;
+		if (send_dt_burst(raw, prio, TP_DAT, da, sa, next, want,
+				  payload, size, false))
+			return -1;
+		sent = next - 1 + want;
+	}
+	return (int)max_want;
+}
+
+/*
+ * Scatter a received DT frame's payload into buf at the offset implied by its
+ * sequence number. base_pkt is the 0-based absolute packet the 1-based seq is
+ * relative to (0 for TP, the DPO offset for ETP).
+ */
+static void unpack_dt_into(uint8_t *buf, size_t total, unsigned int base_pkt,
+			   const struct can_frame *frame)
+{
+	unsigned int abs_pkt = base_pkt + (frame->data[0] - 1);
+	size_t off = (size_t)abs_pkt * 7;
+	size_t n;
+
+	/*
+	 * A bogus sequence number (e.g. data[0] == 0 wrapping abs_pkt) can put
+	 * off past the buffer; total - off would then underflow size_t into a
+	 * huge length. Drop such frames instead of overrunning buf.
+	 */
+	if (off >= total)
+		return;
+	n = total - off;
+	if (n > 7)
+		n = 7;
+	memcpy(buf + off, &frame->data[1], n);
+}
+
+/* Open a TP RX j1939 socket and send the RTS that starts a receive session. */
+static int tp_rx_open_and_send_rts(int *j1939, int raw, int ifindex,
+				   unsigned int num_pkts,
+				   unsigned int max_cts_pkts)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, PGN_DATA);
+	if (*j1939 < 0)
+		return -1;
+	return send_tp_rts(raw, PRIO, PGN_DATA, SA_LOCAL, SA_PEER, TP_SIZE,
+			   num_pkts, max_cts_pkts);
+}
+
+/*
+ * Shared TP-RX round-trip: open the j1939 socket, drive a full TP receive from
+ * the raw peer advertising max_cts_pkts per CTS, and verify the reassembled
+ * payload against the sent pattern. The kernel's largest single-CTS packet
+ * request is returned via *max_want_out and its EOMA frame via *eoma_out, so
+ * each caller can assert the specific property it cares about. ASSERT_* cannot
+ * be used here (the harness jump target lives in the TEST body), so failures
+ * are reported through the return value. Returns 0 on success, -1 otherwise.
+ */
+static int tp_rx_roundtrip(FIXTURE_DATA(j1939_multi) *self,
+			   unsigned int max_cts_pkts, int *max_want_out,
+			   struct can_frame *eoma_out)
+{
+	uint8_t payload[TP_SIZE], rx_buf[TP_SIZE];
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	int max_want;
+
+	fill_pattern(payload, sizeof(payload));
+
+	if (tp_rx_open_and_send_rts(&self->j1939, self->raw, self->ifindex,
+				    num_pkts, max_cts_pkts))
+		return -1;
+
+	max_want = tp_serve_cts(self->raw, PRIO, SA_LOCAL, SA_PEER,
+				payload, TP_SIZE, num_pkts);
+	if (max_want < 0)
+		return -1;
+	*max_want_out = max_want;
+
+	if (recv_ctl_cmd(self->raw, J1939_PF(TP_CTL), SA_PEER, eoma_out,
+			 J1939_RECV_TIMEOUT_MS, TP_CMD_EOMA))
+		return -1;
+
+	if (recv_timeout(self->j1939, rx_buf, sizeof(rx_buf),
+			 J1939_RECV_TIMEOUT_MS) != (int)sizeof(rx_buf))
+		return -1;
+	if (memcmp(payload, rx_buf, sizeof(payload)) != 0)
+		return -1;
+
+	return 0;
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
+	int max_want;
+
+	ASSERT_EQ(tp_rx_roundtrip(self, num_pkts, &max_want, &frame), 0)
+		TH_LOG("TP RX round-trip against the raw peer failed");
+
+	/*
+	 * The kernel (TP receiver) must acknowledge with a well-formed EOMA on
+	 * the wire: command, the 16-bit message size and the total packet count.
+	 */
+	EXPECT_EQ(get_le16(&frame.data[1]), TP_SIZE);
+	EXPECT_EQ(frame.data[3], num_pkts);
+}
+
+/*
+ * Start a TP/ETP transmit session from the J1939 socket: open an unbound
+ * socket, connect to the peer, send the payload and collect the kernel's RTS
+ * from the raw peer (ctl_pf/rts_cmd select TP or ETP). *j1939 is set even on
+ * open failure so the fixture teardown can close it. Returns 0 on success, -1
+ * otherwise; the caller ASSERTs the result.
+ */
+static int tx_start_session(int *j1939, int ifindex, const void *payload,
+			    size_t len, int raw, uint8_t ctl_pf,
+			    uint8_t rts_cmd, struct can_frame *rts)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, J1939_NO_PGN);
+	if (*j1939 < 0)
+		return -1;
+	if (j1939_connect(*j1939, ifindex, SA_PEER, PGN_DATA))
+		return -1;
+	if (send(*j1939, payload, len, 0) != (ssize_t)len)
+		return -1;
+	return recv_ctl_cmd(raw, ctl_pf, SA_PEER, rts,
+			    J1939_RECV_TIMEOUT_MS, rts_cmd);
+}
+
+/*
+ * TP TX: the J1939 socket transmits a TP message to the CAN_RAW peer.
+ * raw answers the kernel's RTS with a CTS, collects the DT frames and
+ * acknowledges with EOMA.
+ */
+TEST_F(j1939_multi, tp_tx_to_raw)
+{
+	uint8_t payload[TP_SIZE], rx_buf[TP_SIZE];
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+	uint8_t dat[8];
+	unsigned int got = 0;
+
+	fill_pattern(payload, sizeof(payload));
+	memset(rx_buf, 0, sizeof(rx_buf));
+
+	ASSERT_EQ(tx_start_session(&self->j1939, self->ifindex, payload,
+				   sizeof(payload), self->raw, J1939_PF(TP_CTL),
+				   TP_CMD_RTS, &frame), 0);
+	/* The kernel's TP RTS must carry the message size and packet count. */
+	EXPECT_EQ(get_le16(&frame.data[1]), TP_SIZE);
+	EXPECT_EQ(frame.data[3], num_pkts);
+
+	/* request all packets in one CTS */
+	ctl_dat_init(dat, TP_CMD_CTS);
+	dat[1] = num_pkts;
+	dat[2] = 1;
+	ASSERT_EQ(send_ctl_frame(self->raw, PRIO, TP_CTL, SA_LOCAL, SA_PEER,
+				 dat, PGN_DATA), 0);
+
+	while (got < num_pkts) {
+		ASSERT_EQ(recv_for_peer(self->raw, J1939_PF(TP_DAT), SA_PEER, &frame,
+					J1939_RECV_TIMEOUT_MS), 0)
+			TH_LOG("missing DT after %u/%u packets", got, num_pkts);
+		unpack_dt_into(rx_buf, TP_SIZE, 0, &frame);
+		got++;
+	}
+
+	/* acknowledge with EOMA */
+	ctl_dat_init(dat, TP_CMD_EOMA);
+	put_le16(&dat[1], TP_SIZE);
+	dat[3] = num_pkts;
+	ASSERT_EQ(send_ctl_frame(self->raw, PRIO, TP_CTL, SA_LOCAL, SA_PEER,
+				 dat, PGN_DATA), 0);
+
+	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
+}
+
+/*
+ * ETP RX: the CAN_RAW peer transmits an ETP message to the J1939 socket.
+ * The kernel requests blocks with ETP.CTS; raw answers each with a DPO and
+ * the block's DT frames. The payload spans several 255-packet blocks.
+ */
+TEST_F(j1939_multi, etp_rx_from_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(ETP_SIZE);
+	uint8_t *payload, *rx_buf;
+	struct can_frame frame;
+	unsigned int sent = 0;
+	uint8_t dat[8];
+
+	payload = malloc(ETP_SIZE);
+	rx_buf = malloc(ETP_SIZE);
+	ASSERT_NE(payload, NULL);
+	ASSERT_NE(rx_buf, NULL);
+	fill_pattern(payload, ETP_SIZE);
+
+	self->j1939 = j1939_open(self->ifindex, SA_LOCAL, PGN_DATA);
+	ASSERT_GE(self->j1939, 0);
+
+	ctl_dat_init(dat, ETP_CMD_RTS);
+	put_le32(&dat[1], ETP_SIZE);
+	ASSERT_EQ(send_ctl_frame(self->raw, PRIO, ETP_CTL, SA_LOCAL, SA_PEER,
+				 dat, PGN_DATA), 0);
+
+	while (sent < num_pkts) {
+		unsigned int num, next;
+
+		ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(ETP_CTL), SA_PEER,
+				       &frame, J1939_RECV_TIMEOUT_MS,
+				       ETP_CMD_CTS), 0)
+			TH_LOG("no ETP CTS after %u/%u packets", sent,
+			       num_pkts);
+		num = frame.data[1];
+		next = get_le24(&frame.data[2]);	/* 1-based */
+
+		ctl_dat_init(dat, ETP_CMD_DPO);
+		dat[1] = num;
+		put_le24(&dat[2], next - 1);
+		ASSERT_EQ(send_ctl_frame(self->raw, PRIO, ETP_CTL, SA_LOCAL,
+					 SA_PEER, dat, PGN_DATA), 0);
+
+		/* ETP numbers DT packets 1-based within each DPO block */
+		ASSERT_EQ(send_dt_burst(self->raw, PRIO, ETP_DAT, SA_LOCAL,
+					SA_PEER, next, num, payload, ETP_SIZE,
+					true), 0);
+		sent = (next - 1) + num;
+	}
+
+	/*
+	 * The kernel (ETP receiver) must acknowledge with a well-formed ETP EOMA
+	 * carrying the 32-bit total message size in bytes 1..4.
+	 */
+	ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(ETP_CTL), SA_PEER, &frame,
+			       J1939_RECV_TIMEOUT_MS, ETP_CMD_EOMA), 0)
+		TH_LOG("no well-formed ETP EOMA from kernel after last DT");
+	EXPECT_EQ(get_le32(&frame.data[1]), (uint32_t)ETP_SIZE);
+
+	ASSERT_EQ(recv_timeout(self->j1939, rx_buf, ETP_SIZE,
+			       J1939_RECV_TIMEOUT_MS), (int)ETP_SIZE);
+	EXPECT_EQ(memcmp(payload, rx_buf, ETP_SIZE), 0);
+
+	free(payload);
+	free(rx_buf);
+}
+
+/*
+ * ETP TX: the J1939 socket transmits an ETP message to the CAN_RAW peer.
+ * raw requests the data in 255-packet blocks (ETP.CTS); for each block the
+ * kernel sends a DPO followed by the DT frames, acknowledged by EOMA.
+ */
+TEST_F(j1939_multi, etp_tx_to_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(ETP_SIZE);
+	const unsigned int block = 255;
+	uint8_t *payload, *rx_buf;
+	struct can_frame frame;
+	unsigned int got = 0;
+	uint8_t dat[8];
+
+	payload = malloc(ETP_SIZE);
+	rx_buf = malloc(ETP_SIZE);
+	ASSERT_NE(payload, NULL);
+	ASSERT_NE(rx_buf, NULL);
+	fill_pattern(payload, ETP_SIZE);
+	memset(rx_buf, 0, ETP_SIZE);
+
+	ASSERT_EQ(tx_start_session(&self->j1939, self->ifindex, payload,
+				   ETP_SIZE, self->raw, J1939_PF(ETP_CTL),
+				   ETP_CMD_RTS, &frame), 0);
+	/* The kernel's ETP RTS must carry the correct 32-bit message size. */
+	EXPECT_EQ(get_le32(&frame.data[1]), (uint32_t)ETP_SIZE);
+
+	while (got < num_pkts) {
+		unsigned int req = num_pkts - got;
+		unsigned int next = got + 1;		/* 1-based */
+		unsigned int i, dpo_num, dpo_off;
+
+		if (req > block)
+			req = block;
+
+		ctl_dat_init(dat, ETP_CMD_CTS);
+		dat[1] = req;
+		put_le24(&dat[2], next);
+		ASSERT_EQ(send_ctl_frame(self->raw, PRIO, ETP_CTL, SA_LOCAL,
+					 SA_PEER, dat, PGN_DATA), 0);
+
+		ASSERT_EQ(recv_ctl_cmd(self->raw, J1939_PF(ETP_CTL), SA_PEER,
+				       &frame, J1939_RECV_TIMEOUT_MS,
+				       ETP_CMD_DPO), 0)
+			TH_LOG("no DPO after %u/%u packets", got, num_pkts);
+		dpo_num = frame.data[1];
+		dpo_off = get_le24(&frame.data[2]);
+
+		for (i = 0; i < dpo_num; i++) {
+			ASSERT_EQ(recv_for_peer(self->raw, J1939_PF(ETP_DAT),
+						SA_PEER, &frame,
+						J1939_RECV_TIMEOUT_MS), 0)
+				TH_LOG("missing ETP DT %u in block", i);
+			unpack_dt_into(rx_buf, ETP_SIZE, dpo_off, &frame);
+		}
+		got += dpo_num;
+	}
+
+	ctl_dat_init(dat, ETP_CMD_EOMA);
+	put_le32(&dat[1], ETP_SIZE);
+	ASSERT_EQ(send_ctl_frame(self->raw, PRIO, ETP_CTL, SA_LOCAL, SA_PEER,
+				 dat, PGN_DATA), 0);
+
+	EXPECT_EQ(memcmp(payload, rx_buf, ETP_SIZE), 0);
+
+	free(payload);
+	free(rx_buf);
+}
+
+J1939_TEST_MAIN();
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.sh b/tools/testing/selftests/net/can/test_j1939_multi.sh
new file mode 100755
index 000000000000..53f473588154
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+J1939_TEST_PROG=test_j1939_multi
+source "$(dirname "$0")/j1939_lib.sh"
-- 
2.47.3

