Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795869657;
	b=BJyClY1Z33jLDG+X3YvGgQzzar0fLKiTwvEXn0USlEv/gFS1E2xU+YI32xQ9lCERgnBe
	 cg8HilLIYQgToMmZw6g1Uz8/up5yQh+QBhrR7FFOJqkoIWM+zObAuUQRO/c+hso0TT9IE
	 5otJCKnAOPhXRJK0SWQjx0FHCyJYhj25+2FdssmUx1FllRBOAhXYFUEz6ALwucA95tCgo
	 kEgctB4v8dn9nUebgB4Fg6VEXyzcUlO9F+UGhXmPgs70Nif2KgMGAyyW1wBztD+4jOIND
	 2QC0ZIZo7zdxgxtOlWt241Mfj6xuzRPpz9oaGL3PmRYacjiefMMlxkvZmqZ5XFmrn9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869657;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=I/uhWVjX0DNLKqwXCIrIDTah86Frhyn1hPSWea0VFSI=;
	b=4UoYa2GLCwgdoU9T3v+KYdOJwbfxjLTNFTzWjdTV7vuCF3MSeai7wG6JxDSka1ROjuvF
	 MYyojBPvnaUgyU6FxkabkbhzjvG+ZNhtjK2D2gfIOD6LXQUYXEFMt7BioXtq1PAWUjUTe
	 y/8aFXNDTLctEI+Q9/SpVjluUKSGnnIOJeCU4vHAdoAOX7mfy66MGHZSlzXEaDy2aENHi
	 ZfymsLqlurBt23ARyU56/9KfK6BxHHqeZyOGoTw/lwLdwbDVs6nOmhwtNqO1GNEATyvhg
	 PWyTqSFxiTR3EPurL4N4UnF84fA0xdsVfiaP4YzLZxxgPb2GnjV+iPYMOuweT94MpBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="P4/0Aevg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7D606A326;
	Sat, 28 Nov 2026 12:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P4/0Aevg
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BD5B4205AE5;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/uhWVjX0DNLKqwXCIrIDTah86Frhyn1hPSWea0VFSI=;
	b=P4/0AevgNWHBMUc2qSivUeb8sq+wg6xildOzXz/bVFwleONHM4ypncrRJvNbB+RFCVLtKR
	v/vs0fQcZkhNtO3yt3OvTbcpsHTAnx2z92flTX+u74QWtRz3woIK5RdBxGmd9cZFBAz0KA
	9d1mwsxKkNWrmRA3uC29XUOeB4ownVa9TbT2OzKbrOB7nP+hK+fC3WhkuIi+ZW9q3AmTWy
	1D8/rQvI6tJWRdfp6ci0ZdJAWx0Eic8VH4iL6aSIB0xuiPO/pyMBIgyluoOibxhhWJQu32
	RiEKwSWy3vKYq4js3mOQ4lkiP8RYA1Dsu397pJoagDbxkpMPgfy85eEXX5Cakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/uhWVjX0DNLKqwXCIrIDTah86Frhyn1hPSWea0VFSI=;
	b=VbejK/hYvAZmr87AUoh4u7R1eWzBzhmqUnfco11vA+DtBrpBKGOgBqUCj/x/NnGyWqmyIy
	eo+71+ZWt1OobyIk7/8HfFV7DwJVe5XvG6xY2tA0uEaopo6ThXPZBbaxgG0n6gQqXu1xwu
	xnTYBj9+j3akV05yCr6rsWB67yXdquNovb3CBkVHLRdA0cdyMCHdrF94Vig1S8RuZSk3xg
	hiAqUQR+hfTwDNywYUY+KPZw2j1MIVb07gwEWmdY8TZY/1i6w1ePWrh0fBS7dsESaOKcFO
	89hiOkRbH7zwoY0kvcNsiE5fYvg3vgnh1YtUv9h8Sa5c97P2ttEhpSxnIjNZtw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=LaJz5YyT6glCk8uvwf91D4OWw8kQLkNLfK/VfNer/OXIwQi4wBPyy+uAFnW3EMbSN0Xacm
	8HKP3XLIlUwHCJverjDo6D5yjpmqLPYiyrgIgu861Fm13t01sc1MwWHxAy9SRcYN57hSDP
	LwnFUVuCpcjr/0681D0cVNZKwVvevduJZK60WMKWLkLhsWkMinkLZiRsHXrwNqTTn15wxp
	W56e0X0hGnGmdVKXA4X+ERk4e5AS2+s+DlJACymrK+VVkdLAikKhfaL6n6fbtHWDtnDMIp
	4NinK/bkywkjgFV7I1tAUK2be05qMFDoy13eR6vd+M/aB49pLj6ZtibqwIFtUA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 98A1F381DA6; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sat, 28 Nov 2026 13:40:47 +0100
Subject: [PATCH can-next v6 6/9] selftests: can: add J1939 wire-format
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
Message-Id: <20261128-j1939-selftests-v6-6-a9dc9140dee6@pengutronix.de>
References: <20261128-j1939-selftests-v6-0-a9dc9140dee6@pengutronix.de>
In-Reply-To: <20261128-j1939-selftests-v6-0-a9dc9140dee6@pengutronix.de>
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

Changes in v6:
- print why a helper failed, as test_j1939_base does
- shorten the SA/PGN mismatch message, so it fits on its print line

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
 tools/testing/selftests/net/can/test_j1939_wire.c  | 202 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 4 files changed, 208 insertions(+)

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
index 1d036194738842062fa25fb5ade95100f07d0167..61bb4d60577d563b88117ac7a53bb3e0ae498fb6 100644
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
index 0000000000000000000000000000000000000000..3c13ca68fc97450b07b6994e3fa95bc574eb1793
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 wire-format selftests: a J1939 socket against CAN_RAW.
+ *
+ * Run by test_j1939_wire.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
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
+ * receives the same CAN_MAX_DLEN-byte payload, from SA_PEER and with PGN pgn.
+ * Opens the J1939 RX socket into self->j1939 (the fixture teardown closes it).
+ * open_flags are the J1939_OPEN_* flags of the socket. pgn is the PGN of the
+ * injected frame and the one the socket binds to; da is the frame's
+ * destination.
+ */
+static bool rx_single_frame_ok(FIXTURE_DATA(j1939_wire) *self, int open_flags,
+			       pgn_t pgn, uint8_t da,
+			       const uint8_t payload[CAN_MAX_DLEN])
+{
+	struct sockaddr_can src = {};
+
+	self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_LOCAL,
+				       pgn, open_flags);
+	if (self->j1939 < 0) {
+		fprintf(stderr, "# open failed: %d\n", errno);
+		return false;
+	}
+
+	if (!send_raw8_ok(self->raw, PRIO, pgn, da, SA_PEER, payload)) {
+		fprintf(stderr, "# raw send failed: %d\n", errno);
+		return false;
+	}
+
+	if (!recvfrom_verify_ok(self->j1939, payload, CAN_MAX_DLEN,
+				J1939_RECV_TIMEOUT_MS, &src)) {
+		fprintf(stderr, "# payload missing or not the one sent\n");
+		return false;
+	}
+
+	if (src.can_addr.j1939.addr != SA_PEER ||
+	    src.can_addr.j1939.pgn != pgn) {
+		fprintf(stderr, "# SA/PGN 0x%02x/0x%05x, want 0x%02x/0x%05x\n",
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
+ * (the fixture teardown closes it) and connects it to (da, pgn);
+ * open_flags are its J1939_OPEN_* flags.
+ */
+static bool tx_to_raw_send_recv_ok(FIXTURE_DATA(j1939_wire) *self,
+				   int open_flags, pgn_t pgn, uint8_t da,
+				   const uint8_t payload[CAN_MAX_DLEN],
+				   struct can_frame *frame)
+{
+	self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_LOCAL,
+				       J1939_NO_PGN, open_flags);
+	if (self->j1939 < 0) {
+		fprintf(stderr, "# open failed: %d\n", errno);
+		return false;
+	}
+
+	if (!j1939_connect_ok(self->j1939, self->ifindex, da, pgn)) {
+		fprintf(stderr, "# connect failed: %d\n", errno);
+		return false;
+	}
+
+	if (!send_all_ok(self->j1939, payload, CAN_MAX_DLEN)) {
+		fprintf(stderr, "# send failed: %d\n", errno);
+		return false;
+	}
+
+	if (!recv_frame_ok(self->raw, frame, J1939_RECV_TIMEOUT_MS)) {
+		fprintf(stderr, "# no frame on the raw socket\n");
+		return false;
+	}
+	return true;
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

