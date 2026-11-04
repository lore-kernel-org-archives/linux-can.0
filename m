Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809075;
	b=krW6GhiVtUwWbifREYI6J3IxocB4FILJa8hfPdTkO8OdI12qrKDQQYXbaGHLmym9uKlx
	 ADvkdcEIL/NFYdOxJOnptJ0iZRBS7PyN3W4J8QkZVSA4XDlfzpxCmD0VHODMSiTi67nOt
	 W0OFDSitwdt6UGXXLdEWnmeIk0tx5u33P2lhwAi7QjYO8wp3lcalDgOcFH6k+5LqJDteh
	 IaFPsR6a304V8pSxeeU+v+e9oPO/JJ0IpYwnag+uiBGQlkgLnTRDJug3AEjWw53d0mq5Z
	 kBzYiUToBLBJT13yVJFGF1DQO676cZ5WIAbQ+g3ti+coKiIGHzO8gy/M6blS32Z/2jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=MvI0Lx6fgE4q900gNWp80qFr2w8VWPFjdRdBExRimwg=;
	b=QfRo8t3qo6KuOkgkP+LT+4/nmfq/2/zq7zZ55RLlKqT5QAnqexrPIIK5wWMc4dOYkGC+
	 K9cCpgLbHEJbIllubqlTiY3L+McbbEVrBOQpy/Zj7Ort/eqEXL6u85ydpVc46A5JzQTSH
	 zdU1jU/cVU/Aun9r+FhZ1kQp+p9stIdKEMzr1wxEK6fwoBPjBIEGbdLQM1I4SZ5Syjswp
	 yXAXFKqTU6WDilevNrFeItdWijpgmvXdH8QeLWUmQpEqKAJon/dBQjOFqX4ap+9gDl+K0
	 Rrj4vBsLsm1fHgZCVqVFRcNhgm8lYfCHy/T/4kPwDvOIzFSWQN0NC1VY91+sS76NW/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Do9Ux5SX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469A6082BC2;
	Wed,  4 Nov 2026 16:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6469A6082BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Do9Ux5SX
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A5F18202BBC;
	Wed, 04 Nov 2026 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvI0Lx6fgE4q900gNWp80qFr2w8VWPFjdRdBExRimwg=;
	b=Do9Ux5SXgLdC/9Bs5k3ZH1KX2Roxq6lnBY0d5M3JAOtGuqxi/Khk5sicdcBuHI1oLKPlYf
	McQN8kwZVu+c54fjN/D68DsqQsPcLrP51OH0zfJvWXs8OA9jedoyvAzM/lL2eVC4KPgxmL
	UUa4ouXqHVrUK2f8HYRxdJnxyQsDxKzB3yykS/h8N7WXvTOoLN9n7RzK2xSsffXu19duFS
	aYrqngVJ+lp7xqMQe7astdrX5vnQdvolCyPEivTvh+9M6YSQsBfTt39qf6LyDQhIFSKGKg
	2ihNQy0xqdjNStHKmm23Y4EjQiGQWMv6MQYNOz6hla8ZJ/XY/I5+dk/W4L2Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvI0Lx6fgE4q900gNWp80qFr2w8VWPFjdRdBExRimwg=;
	b=CuGRuffFznzSMgLxpSnE9HHogMMdoR1/TqEHlWNUb2uK44WvBWK8Klb7F1quPrWyQ27SN0
	SgZVCULNO2kfEwoosWN3xsYDDcWzChSILpCR8MsjZ43OX7WI90LqmyYixpZdAWkj87UX4H
	NcX2QoCUi8B1q/7gkHN0lgNws7fmsWhEkpLJnsBV9GCqQxN/yMJxdYd/aps+veMswiFn2C
	Lf7SSDJz55+wWCmdeo4X3MgLxhZOePDB0ohk9ZDQ2Gy1+dMDkqjbB7YL3GLeW8ba9X7ug8
	cY965RDWRd19PehYb0b/IwlTD0WYUe9vfR4y27KfAPAtrwJxwukrdy0rGngs0g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809067; a=rsa-sha256;
	cv=none;
	b=aB8zsjUpArqWYnn2kfF41hynlQYp54yd2NXr49vVqnL+4S3gBnH97TUCCB4uNbDivej384
	y6CVlzWgqrEf/u8f+67Lx49DIlz1god768L3EihKWsSmXEB5CKGr0YoGUCLJT17WiPnw1/
	y48h6PuQmr8txu+5TF2XoME59FWkMNNzpuoL07dHfcorNN8BSf3eeQLb6U3yh+MulYYc8n
	972/HT9Cie84ym5ou4aC9lp5ljrVVH1pgLx0C4Poj1TtmCAuCu573NwmI09/+ozZPQZtxu
	EnkeLJeAUsPqm2lQmnRQFUvchbO8LilPyl+QuQBAgk9EzqjnM2wX/Axvfyvufw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 55571380C49; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:21 +0100
Subject: [PATCH can-next v2 6/9] selftests: can: add J1939 wire-format
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
Message-Id: <20261104-j1939-selftests-v2-6-cf797c83317b@pengutronix.de>
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

Check J1939 single frames against a CAN_RAW socket in both directions,
for PDU1 (with the DP bit set) and PDU2: the CAN id and payload of a
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
 tools/testing/selftests/net/can/test_j1939_wire.c  | 186 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_wire.sh |   4 +
 4 files changed, 192 insertions(+)

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
index d72095ad7d849d8a35c20e9c5bdaa81bc194bc64..5262f0b8f73f80f524c32665c1fc08a7a0ec7e78 100644
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
index 0000000000000000000000000000000000000000..ad542ed241c0b0e59c40cc49bccc418031273002
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.c
@@ -0,0 +1,186 @@
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
+/* arbitrary addresses and PGNs; only PDU class and DP bit matter */
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW peer */
+/* a destination-specific PGN with DP set, and a broadcast PGN */
+#define PGN_PDU1		(J1939_PGN_DP | 0x0ab00)
+#define PGN_PDU2		0x0feee
+_Static_assert(J1939_IS_PDU1(PGN_PDU1) && !J1939_IS_PDU1(PGN_PDU2),
+	       "PGN_PDU1 must be PDU1 and PGN_PDU2 must be PDU2");
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
+ * @bcast selects a broadcast (PDU2) socket and frame; @pgn and @da address the
+ * injected frame.
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
+			"# from SA 0x%02x PGN 0x%05x, want 0x%02x 0x%05x\n",
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
+ * opens a broadcast (PDU2) socket.
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

