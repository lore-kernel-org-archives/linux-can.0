Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167973;
	b=l9ar2kN+rqDceOtERu2iCxJxKhawvsnMGQGSMUbV1aU5A5XBupcvPT40/Tk8CLRorY6l
	 4fWDHijfG3L4q1X9Tsgy+PJXeeY8gyjazM8TMd0FT4/OO410faRwx8bbPS2V5vOiiWSRU
	 0IfN23WBW711/QAf8T+8CTllpsdRX6uq2e9fFEfpWiryYaSFuZvOOrGEWEyZjE1GrKOxf
	 glCjvDFydmgEXb/Zb2OvU5hXxGIMBAHui5m5/ToUtMuRLXUcpCLvNQivcdzTFwcUHt2r1
	 vd6C3h9w46CUe1oCYlXvjSTZhIi2SIITqo5UX5mAUYkdWesJmEOPqhshgsJoab5/iQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wwRIpEgk/sJ10mDKVcoIKdZ0zyU165aLMA+Bt2QWW58=;
	b=WY2sTMCJQLfRdLdVWq5240Sc/FUad3gde8jZqm9saKFMGyA02Ng6jNTVgWy3YcEvo8Qm
	 pXaUQ7wfFZ9HN/0vOGOCEi7iO36n6SratQSuOgxATqy1l1BNTf8k3qQFNLMJCyp24R3VP
	 55/s6QgjDu0iNPSLfobjx5cIROFJbeHrTfZpyTTnPFSaD/Pl29a6/bxZ95GEWVhDtGexc
	 PBxGDN7ldj5PLKOherHKkm9ORZ7r5A0QG7PnHuQS5Q+j0dLOAN26mBKytAqUdbXn7UApL
	 NMaDFvK+9wdtItzfSYkuTk8uo2oLGogW4Cj+QT2swgwC1XQFjlEc4x0iX99NuQJgnoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dO0hHPWZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895D606A325;
	Fri, 20 Nov 2026 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A895D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dO0hHPWZ
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 855E3205B41;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwRIpEgk/sJ10mDKVcoIKdZ0zyU165aLMA+Bt2QWW58=;
	b=dO0hHPWZNZdyj09taLJDqqkeksCmGwaQxdgflvQcafEx89e2lcvSEXbZeZZWJthUSRHZbX
	BxnBAmfginbL24r/Bo5p1aa4LdqhEENVqkhf/en5gNKxzfeCdFkgKqEXGJVMIYubj73juX
	2iDdxSUzrXxjmhNWqWF9wImBVi/av9phnpzv47phfA48hLblxZyQ+Y0uwMu3N/Qc8gV5nu
	ItlL2E4shj8Tv9EJFd878J2xtfBngrj3rP4xNXDX2SR4mfRE/Sux4w9cEYBFpBhzVmfDIv
	e04ceL0ef7/C8c3UgBJkwB8z+mDGULzvQQVJ/fcRSwzIveWPh3SsqxzCIFrziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwRIpEgk/sJ10mDKVcoIKdZ0zyU165aLMA+Bt2QWW58=;
	b=XGIgN+gWRhVjvoZ247vZswr7MWFPUyekJDImBpxCDif28bpdzFyiayiEDc96yahWEZyq4r
	+k0p4Rx92S2c/8GzG89YvbDEtqRQ2TA2QGX6Piud+tTnaVHMfcAJRx3qHv/DLNyhFVqmpj
	WuswFTbDtZyNqSeZbJyCB3XftVPMK3pbuhN0A5AarC37Hgsq5RsW3hEj4nNPmHie4oUnO9
	+P8o4sTY6OEyywlPx9neAmNBUbA0HSqQS0pyPTnTt6A9Bce/PbbEAsUZHi6a9RlhXnn3g1
	h1cY4xFYBa/ppcZ1CnRC39L+CfT4yyHDwKthc1IgU674LB+weBH6BtPnVMKpVQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=XfHAQFLIHU9ZnZP98mSe2FRxsUck4tcZHrVHEhbiQCAs27YC4ER16YP3/TZIOcwcQ54Z0u
	WEtg0Qfc4TB5AFOAJYc6PuHlCFnqpBZ0dITfI3g0cMWiKkeqrf2yJqrqMFIzQY5VTTNNbk
	fcxJ1Kax9f50rWWRm2oZCFicKR/xyv5TjFABJIjyl+OeDHnaH/adUjnKkk9NjsEgcQFSEp
	MG5OuW33jDIJxeYb04naNMyHMFnSlcnyUNszxQcMzw46pvWb17kFsA3ENtW52OJhbbJBAc
	Z8zv+NNellk+6asl4tcVRJvzTxSCy/Nv8lz308DAis2MlQD/VCMbgyWQv/WQNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4FD6C3811C9; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:46:01 +0100
Subject: [PATCH can-next v5 6/9] selftests: can: add J1939 wire-format
 tests against CAN_RAW
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
Message-Id: <20261120-j1939-selftests-v5-6-fdf4c242a37e@pengutronix.de>
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

Check J1939 single frames against a CAN_RAW socket in both directions,
for PDU1 and PDU2, both with the DP bit set: the CAN id and payload of a
J1939 send, and the payload, source address and PGN that the J1939
socket gets for an injected frame.

The base test sends between two J1939 sockets, so a CAN id encoding bug
and a matching decoding bug in the kernel cancel out there. CAN_RAW does
not use the J1939 code, so it checks each direction on its own.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): does the test check the priority of a received frame, or
the SCM_J1939_PRIO cmsg?
A: Neither. It checks the priority of sent frames only; the cmsg
metadata of received messages is not tested.

Q (sashiko): can the TX tests see a frame from another node?
A: No. j1939_lib.sh runs them only on vcan interfaces it creates, so
the only frames there are the test's own. Without J1939_SHARED_IF=1 it
creates two and links them with CAN gateway rules that do not change
frames.

Changes in v5:
- No changes.

Changes in v4:
- pass J1939_NEEDS_RAW to j1939_test_main()
- pass J1939_OPEN_* flags to the helpers instead of a bool
- zero the source address that the RX check reads

Changes in v3:
- the @bcast comments say that @bcast opens the socket with SO_BROADCAST
  (sashiko)
- assert that the addresses are two different unicast ones and that the
  PGNs are valid, with the DP bit set and PS 0 for PDU1
- set the DP bit in the PDU2 PGN too
- clarify the @pgn comment and the RX mismatch log

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, avoid casts, return bool from helpers named
  *_ok() and fill test payloads with fill_pattern()
- check that a sent frame is an extended data frame (sashiko, Marc)
- check the full PGN of a sent frame (sashiko); use a PDU1 PGN with DP
  set
- check the source address and PGN of a received frame (sashiko)
- say in the commit message what CAN_RAW checks that the base test
  cannot (sashiko)
- keep the Makefile and .gitignore lists sorted; the wrapper no longer
  sets J1939_TEST_PROG
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   1 +
 tools/testing/selftests/net/can/test_j1939_wire.c  | 190 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 4 files changed, 196 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 1a6e89cdceb4a337648ca1062a6095c0168b76d4..6c6b18a9deda7f4a7c2b4ef9fbbc980a5b36811b 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -3,4 +3,5 @@ j1939_gw
 test_j1939_addr
 test_j1939_base
 test_j1939_opts
+test_j1939_wire
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 51ce18682f3044e932e9d8854872ec563b129040..e97e10e92e417bc70049e533ca7490c66c971897 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	test_j1939_addr.sh \
 	test_j1939_base.sh \
 	test_j1939_opts.sh \
+	test_j1939_wire.sh \
 	test_raw_filter.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/testing/selftests/net/can/test_j1939_wire.c
new file mode 100644
index 0000000000000000000000000000000000000000..79d72f00af6727b554251d3cefc5be12b2f5ec25
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 wire-format selftests: a J1939 socket against CAN_RAW.
+ *
+ * Run by test_j1939_wire.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* arbitrary addresses and PGNs, within the asserts below */
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW peer */
+/* a destination-specific and a broadcast PGN, both with DP set */
+#define PGN_PDU1		(J1939_PGN_DP | 0x0ab00)
+#define PGN_PDU2		(J1939_PGN_DP | 0x0feee)
+_Static_assert(J1939_IS_PDU1(PGN_PDU1) && !J1939_IS_PDU1(PGN_PDU2),
+	       "PGN_PDU1 must be PDU1 and PGN_PDU2 must be PDU2");
+_Static_assert((PGN_PDU1 & J1939_PGN_DP) && (PGN_PDU2 & J1939_PGN_DP),
+	       "both PGNs must have the DP bit set");
+_Static_assert((PGN_PDU1 & UINT8_MAX) == 0,
+	       "the kernel rejects a PDU1 PGN whose PS byte is not 0");
+_Static_assert(PGN_PDU1 <= J1939_PGN_MAX && PGN_PDU2 <= J1939_PGN_MAX,
+	       "PGN_PDU1 and PGN_PDU2 must be valid PGNs");
+_Static_assert((SA_LOCAL != SA_PEER) &&
+	       (SA_LOCAL <= J1939_MAX_UNICAST_ADDR) &&
+	       (SA_PEER <= J1939_MAX_UNICAST_ADDR),
+	       "SA_LOCAL and SA_PEER must be two different unicast addresses");
+
+#define PRIO			J1939_PRIO_DEFAULT
+
+FIXTURE(j1939_wire)
+{
+	int ifindex;
+	int j1939;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_wire)
+{
+	self->j1939 = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+
+	J1939_SETUP_RAW(self, J1939_RAW_RCVBUF_DEFAULT);
+}
+
+FIXTURE_TEARDOWN(j1939_wire)
+{
+	if (self->j1939 >= 0)
+		close(self->j1939);
+	if (self->raw >= 0)
+		close(self->raw);
+}
+
+/*
+ * Inject one CAN frame from the raw peer and check that the J1939 socket
+ * receives the same CAN_MAX_DLEN-byte payload, from SA_PEER and with PGN @pgn.
+ * Opens the J1939 RX socket into self->j1939 (the fixture teardown closes it).
+ * @open_flags are the J1939_OPEN_* flags of the socket. @pgn is the PGN of the
+ * injected frame and the one the socket binds to; @da is the frame's
+ * destination.
+ */
+static bool rx_single_frame_ok(FIXTURE_DATA(j1939_wire) *self,
+			       int open_flags, pgn_t pgn, uint8_t da,
+			       const uint8_t payload[CAN_MAX_DLEN])
+{
+	struct sockaddr_can src = {};
+
+	self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_LOCAL,
+				       pgn, open_flags);
+	if (self->j1939 < 0)
+		return false;
+
+	if (!send_raw8_ok(self->raw, PRIO, pgn, da, SA_PEER, payload))
+		return false;
+
+	if (!recvfrom_verify_ok(self->j1939, payload, CAN_MAX_DLEN,
+				J1939_RECV_TIMEOUT_MS, &src)) {
+		fprintf(stderr, "# payload missing or not the one sent\n");
+		return false;
+	}
+
+	if (src.can_addr.j1939.addr != SA_PEER ||
+	    src.can_addr.j1939.pgn != pgn) {
+		fprintf(stderr,
+			"# got SA 0x%02x PGN 0x%05x, want SA 0x%02x PGN 0x%05x\n",
+			src.can_addr.j1939.addr, src.can_addr.j1939.pgn,
+			SA_PEER, pgn);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Send one CAN_MAX_DLEN-byte payload from the J1939 socket to the raw peer and
+ * return the CAN frame seen on the wire via *frame, so each caller can assert
+ * the id fields it cares about. Opens the J1939 TX socket into self->j1939
+ * (the fixture teardown closes it) and connects it to (@da, @pgn);
+ * @open_flags are its J1939_OPEN_* flags.
+ */
+static bool tx_to_raw_send_recv_ok(FIXTURE_DATA(j1939_wire) *self,
+				   int open_flags, pgn_t pgn, uint8_t da,
+				   const uint8_t payload[CAN_MAX_DLEN],
+				   struct can_frame *frame)
+{
+	self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_LOCAL,
+				       J1939_NO_PGN, open_flags);
+	if (self->j1939 < 0)
+		return false;
+
+	if (!j1939_connect_ok(self->j1939, self->ifindex, da, pgn))
+		return false;
+
+	if (!send_all_ok(self->j1939, payload, CAN_MAX_DLEN))
+		return false;
+
+	return recv_frame_ok(self->raw, frame, J1939_RECV_TIMEOUT_MS);
+}
+
+/* J1939 TX -> CAN_RAW: destination-specific (PDU1) single frame. */
+TEST_F(j1939_wire, tx_pdu1_to_raw)
+{
+	uint8_t payload[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	fill_pattern(payload, sizeof(payload));
+	ASSERT_TRUE(tx_to_raw_send_recv_ok(self, J1939_OPEN_NONE, PGN_PDU1,
+					   SA_PEER, payload, &frame));
+	ASSERT_TRUE(j1939_is_data_frame(frame.can_id))
+		TH_LOG("CAN id 0x%08x is not a 29-bit data frame",
+		       frame.can_id);
+
+	EXPECT_EQ(j1939_id_prio(frame.can_id), PRIO);
+	EXPECT_EQ(j1939_id_sa(frame.can_id), SA_LOCAL);
+	EXPECT_EQ(j1939_id_ps(frame.can_id), SA_PEER);
+	/* PGN, with the PS (the destination) masked off */
+	EXPECT_EQ(j1939_id_pgn(frame.can_id) & J1939_PGN_PDU1_MAX, PGN_PDU1);
+
+	ASSERT_EQ(frame.can_dlc, sizeof(payload));
+	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
+}
+
+/* CAN_RAW -> J1939 RX: destination-specific (PDU1) single frame. */
+TEST_F(j1939_wire, rx_pdu1_from_raw)
+{
+	uint8_t payload[CAN_MAX_DLEN];
+
+	fill_pattern(payload, sizeof(payload));
+	ASSERT_TRUE(rx_single_frame_ok(self, J1939_OPEN_NONE, PGN_PDU1,
+				       SA_LOCAL, payload));
+}
+
+/* J1939 TX -> CAN_RAW: broadcast (PDU2) single frame. */
+TEST_F(j1939_wire, tx_pdu2_to_raw)
+{
+	uint8_t payload[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	fill_pattern(payload, sizeof(payload));
+	ASSERT_TRUE(tx_to_raw_send_recv_ok(self, J1939_OPEN_BCAST, PGN_PDU2,
+					   J1939_NO_ADDR, payload, &frame));
+	ASSERT_TRUE(j1939_is_data_frame(frame.can_id))
+		TH_LOG("CAN id 0x%08x is not a 29-bit data frame",
+		       frame.can_id);
+
+	EXPECT_EQ(j1939_id_prio(frame.can_id), PRIO);
+	EXPECT_EQ(j1939_id_sa(frame.can_id), SA_LOCAL);
+	EXPECT_EQ(j1939_id_pgn(frame.can_id), PGN_PDU2);
+
+	ASSERT_EQ(frame.can_dlc, sizeof(payload));
+	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
+}
+
+/* CAN_RAW -> J1939 RX: broadcast (PDU2) single frame. */
+TEST_F(j1939_wire, rx_pdu2_from_raw)
+{
+	uint8_t payload[CAN_MAX_DLEN];
+
+	fill_pattern(payload, sizeof(payload));
+	ASSERT_TRUE(rx_single_frame_ok(self, J1939_OPEN_BCAST, PGN_PDU2,
+				       J1939_NO_ADDR, payload));
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv, J1939_NEEDS_RAW);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_wire.sh b/tools/testing/selftests/net/can/test_j1939_wire.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

