Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410782;
	b=AHBBMJFMiT5tFGcc+52/oBaE+GKPE71R2rKh6N5YrMGRWv+zqxDwTgr2EsVSQdu/DM6H
	 SVTramSvgyRwYeNGCFavUcuMKWidcDYpY/oiVv+siViNurHr1oTA43IK3n44JXv9i5EY3
	 tI3+LOAGJLib4N33sQ+2Jo/DxXex5SCFSTCR7P57OS/qBnm8ZCH2hdo02Zl5SdYM95lpn
	 ZG9rdh87PyrWYds2hs5xes4IsUtYTevNSoQc94zpfNzr4LQj6STIzMn2YSXF03FrDNS2l
	 f+FhP79dGlyQGMSDUnplyUrKZh+BFe53wJmMN26ooGXV1tibDBEPKkcJsQrn0+FUwCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410782;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=eQ1j1eThapuQalsmRdpRFTrV7mtVEanNcwdPUTL6v9E=;
	b=r2C8t3dtWAAG4Zcku4IBYWHm1wQTyPMcnnYhDQ96l2jc8c4zRwvdU0sbHCXpi2YGiCKF
	 BJ3RRaITsNReewIgn9qokhoUIoDuTvkPQb6pW+FsGGYn4upFt2vocQAkJEniCz7hFMvdr
	 QIJqsVh9SqtNnKYvzOKjiHTjQgixOF8pSb2cwmUbN6UtTens58bIx6Ul1FtQ5Ho2BTjoI
	 uskzcf+KAlV367eGj2PzdcE5UYMsNwsDk71hqWtp3cFyMkRzjkhlOdZkaBYYROnKrVZAd
	 EPLnNMslxiA2f3KGLTJiSL5J1LqfOQh6XnsI0NI0Z4MFMz7tz0vLp8UIxHzq20gMerA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GS5uzw3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D83606A33B;
	Wed, 11 Nov 2026 15:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0D83606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GS5uzw3W
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 09235202C98;
	Wed, 11 Nov 2026 16:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ1j1eThapuQalsmRdpRFTrV7mtVEanNcwdPUTL6v9E=;
	b=GS5uzw3WLHQC9atQ7HHK1adHE+E2zA7+ma2SNXrrsiHTjRjNZq1yuDsbdSL9VPusbabkdF
	DTa/vbDnyunDIw67ka/uLuA5EjUs0NTsKp0yC1KgL+xoo0UFg102roHi98bXj0pKkLLzEh
	pZ+AXj5hAQzyU9NVXlGlKRDC3/CiboI+AHj547TqQTs39QC+arbARtQ8LzdaXprKunOltk
	1E8HifiwwU+9ZJxgnyAjxUXWbIxkfASehSYzjq5jvDpXBpWa/pFmS1VGgS0uPNa+gTfb/H
	JjS7rHcRQ8m7801ZZTmK65jkCzZvEcmnwmhxyE1BpU8csPUL7Q2k4YlEfwI1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ1j1eThapuQalsmRdpRFTrV7mtVEanNcwdPUTL6v9E=;
	b=VIYABlUPID41SOJQLhBATVZWyrkPadbjIUpdSKaOZ+yy1/K8/74/ZoQbjsEZ03HpCYw4DG
	zWoLE0ooX+GopeVzqO3jAnGDkGjHyM5K0J8rRQDe7jzsztEpdH5Y86mZaMTpUVX2rnd/lv
	gF+wQrfVoe9x2gEysHDXOyUXdOVVrtDrw03YxKRq7Mi/WCKZRhxLhYazLqV/1LGLBNU+Bt
	ZeMhh0TBmiQ8Ql1LyQHbuRgOyo471EvHcTrE0SeK5oeySmcEfvD35s0nHHm7tG7N9lANQu
	G/Z6ua47ZvUTJ4sPGgxRp9kolv9sG8jtMAG9IQCjL9718hFG8eeLO61n0CHqFg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410776; a=rsa-sha256;
	cv=none;
	b=OjWhpR4kyvJ+8hVawBcIVkP8cXwU/lbenQk5M5pN0JaN4DaZNBuC7Hno6NQfIFaZyGuA74
	m8WX2w+bKXL0O80Ci24rk4LQf8mJOX3YkFSN5ZUVqRnl0Fvk57+XH08Tj9nCtphgTzzYRI
	0ldeMMXysZzTlWYdQewjxZ2EPfpJ8VPu0AS9bVf/mv1mm2D+AR2UJzxZxh8kSxuyyT36cE
	g6tBhDLJ/3skefR626HgXUWhgM7W2qFAqzraFWvV2nj2ZNgqubSo4Vqh8wly/AiYNu8GMd
	9t28jHTB+cCMtEq5JTAUoueedK3a0DAcbApFkbXQspy0y3kw89DDTAh4vybE/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B71ED38128C; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 11 Nov 2026 16:25:55 +0100
Subject: [PATCH can-next v3 6/9] selftests: can: add J1939 wire-format
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
Message-Id: <20261111-j1939-selftests-v3-6-5a80277ab363@pengutronix.de>
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
metadata of received messages is not tested yet.

Q (sashiko): can the TX tests see a frame from another node?
A: No. They still read the first frame, but j1939_lib.sh runs them
only on a vcan it creates, where no other node sends.

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
 tools/testing/selftests/net/can/test_j1939_wire.c  | 196 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 4 files changed, 202 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index c9b50d4865c4a1f7523b96516669d7fc6e0d151c..d83fd28a50766c25069c60d10deb76e5722bba5b 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -2,4 +2,5 @@
 test_j1939_addr
 test_j1939_base
 test_j1939_opts
+test_j1939_wire
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 857ff49298290aa7322a5f1b02ecc4566442cbbb..21898e645ced72f1fb450c920e85fb7e0151e2ad 100644
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
index 0000000000000000000000000000000000000000..b476ac0fbcfb8595d6ac4d6167ce178c603b091f
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.c
@@ -0,0 +1,196 @@
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
+ * @bcast opens the socket with SO_BROADCAST. @pgn is the PGN of the injected
+ * frame and the one the socket binds to; @da is the frame's destination.
+ */
+static bool rx_single_frame_ok(FIXTURE_DATA(j1939_wire) *self, bool bcast,
+			       pgn_t pgn, uint8_t da,
+			       const uint8_t payload[CAN_MAX_DLEN])
+{
+	struct sockaddr_can src;
+
+	if (bcast)
+		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
+					       SA_LOCAL, pgn, J1939_OPEN_BCAST);
+	else
+		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, pgn);
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
+ * (the fixture teardown closes it) and connects it to (@da, @pgn); @bcast
+ * opens it with SO_BROADCAST.
+ */
+static bool tx_to_raw_send_recv_ok(FIXTURE_DATA(j1939_wire) *self, bool bcast,
+				   pgn_t pgn, uint8_t da,
+				   const uint8_t payload[CAN_MAX_DLEN],
+				   struct can_frame *frame)
+{
+	if (bcast)
+		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
+					       SA_LOCAL, J1939_NO_PGN,
+					       J1939_OPEN_BCAST);
+	else
+		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, J1939_NO_PGN);
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
+	ASSERT_TRUE(tx_to_raw_send_recv_ok(self, false, PGN_PDU1, SA_PEER,
+					   payload, &frame));
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
+	ASSERT_TRUE(rx_single_frame_ok(self, false, PGN_PDU1, SA_LOCAL,
+				       payload));
+}
+
+/* J1939 TX -> CAN_RAW: broadcast (PDU2) single frame. */
+TEST_F(j1939_wire, tx_pdu2_to_raw)
+{
+	uint8_t payload[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	fill_pattern(payload, sizeof(payload));
+	ASSERT_TRUE(tx_to_raw_send_recv_ok(self, true, PGN_PDU2, J1939_NO_ADDR,
+					   payload, &frame));
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
+	ASSERT_TRUE(rx_single_frame_ok(self, true, PGN_PDU2, J1939_NO_ADDR,
+				       payload));
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv);
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

