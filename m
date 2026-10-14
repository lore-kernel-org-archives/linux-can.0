Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A3560ADF;
	Wed, 14 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992688; cv=pass; b=q9J2Fx1zR3Mzs27DaVG8vseMhPvGbpqurCzubXV6CkWOvquUrWWvGjaS4ltKEkXSGr4tCZ8r19Jw7GdwdtDpQJlCvYcxlb7JWM2kONQAbMGJmvrl4HvQsy31bhuB62gH7eusxF1hEYqcqfDlzif8wCHsG6sRsu5/SfPFCqKdbrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992688; c=relaxed/simple;
	bh=tKzyj9W+uPVY2IK4fUOJ0naRkm2q54GXdnrymUaXeY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vzddxbx6dshKm9B+gPU4C/WOTqnr63kSEFoFdZk8yM0Oz4JMll9/vx2fYztqaHfIB9h+HA+01vDrmLSRPjLUFg1Cew4O/DBemn1hLyT5UgBVHKsAK7BO4uzB2jDB2eOUG/8sGKKfU97LGOjMYLYMVnac+RxT6DQ0aQcMu+AqUJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Dzu8Maih; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Dzu8Maih"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 42BBD2027D2;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Kagxn8q2Nbx/IGnW/1iAYVlR6Ha3ifvH95hb9XOsM=;
	b=Dzu8MaihO8MW3oP4Rm13Dszs5e6ifAc1fbvPqlTkwdKSnEgfgIvZbsj+4QJjXBUfcS66Ys
	S2407wn7JMmr7h7SQg4Zros9V2wGaPJo9GhGzdILEjkX6lE2B0FXBXhZCxrj6yk8O8N9wC
	TpyPAl+hRmVSjWHW6DIQ4ryfog2CzfTZNERS1Xux3ZVlh8X0Q1PbH74XnWq3EXnX8P12C9
	m67sls42M7SfUVuAm5eptX9g7pv8HrCl4J9uPcs1vNhLBTg2KcCeYznkUFCl/h5WJy1Smf
	smXkG9UQsE0ImXoEe2oCqL8GyRDlDgMsllusTuXCzL6VOZWHxoKrjzhQ4jEg3g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=aAGCBwpD3EI5tb//b3Trvus7+JrycqSwigEx8OUm8jc98eL4rVI7nLbcLocYHxUU8ayhqK
	FUCFt5Nm4fqMHMQ9grBZf+XEKeoPY3zvip9Z79HUQyzxO0FXkhfASWW0VB3zjECBasTHxS
	jdPM9LmTHdI3G92FPYYRlLH1gqUPR3RJ4UPHpavWDc4/J49tdDiRoDYG/reSAnQ7vs1btM
	sMSIlCWxe7bvmKVFYcrQL15fA3pSa4mdk5HNnBnNG4IVWRPFkFkTDc6Ji57ejQMQHfLb8A
	mY9UsCRLJ2f6m1D2UtCLPuVVbILd75nB97A88mPPYGQ2BTRZOfhTsXCaQMMogw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+Kagxn8q2Nbx/IGnW/1iAYVlR6Ha3ifvH95hb9XOsM=;
	b=FBVe1S6T6JATMLhtoCKCBppzoAY4hiysN5i2UlxYfCN69bOtkW6rKb0ZrGBySCMu9YD2Hb
	DH7FXatO4Q1liy18JbdIB9iHk6lfm9x3+Dayu2uSaK5tNqVMvof05tmUM4+f+0oYDy/9oz
	9VRdesN8cc4uPYV9hi3gmRAZDd0ea5F4PFsTwn0Z0QS9xatauh1mV3Ez1a33KXrCruCIGB
	P/h0nFfaEc/P8fqwjMz1X9Mwi5GduXrVO8HZLZyF6X/arMrMuZxce2PQK79WzV68I43o77
	125Yo5nnseEHyxpdGIDoNu17MgP9o6JYEFTruA7n21aid+0SzblBQ+RkxKgvnQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 1CB8E380BA7; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 5/8] selftests: can: add J1939 wire-format tests against CAN_RAW
Date: Wed, 14 Oct 2026 17:44:31 +0200
Message-ID: <20261014154435.3577983-6-o.rempel@pengutronix.de>
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

Add a test that pairs a J1939 socket with a CAN_RAW socket so the actual
CAN frames on the wire are checked in both directions: a J1939 send
produces the expected CAN id (priority, PGN, source and destination) and
payload, and an injected CAN frame is parsed and delivered to the J1939
socket. The base test only exercises J1939-socket-to-J1939-socket
transfers, which stay on the local delivery path inside one netdevice, so
the on-wire format is otherwise unchecked. Both PDU1 (destination
specific) and PDU2 (broadcast) single frames are covered.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   2 +
 .../selftests/net/can/test_j1939_wire.c       | 170 ++++++++++++++++++
 .../selftests/net/can/test_j1939_wire.sh      |   5 +
 4 files changed, 178 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/test_j1939_wire.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_wire.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 7ca63a19472c..3f31fa5b7438 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -3,3 +3,4 @@ test_raw_filter
 test_j1939_base
 test_j1939_opts
 test_j1939_addr
+test_j1939_wire
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 6e4176a1b985..d80fa114a0cd 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS := \
 	test_j1939_base.sh \
 	test_j1939_opts.sh \
 	test_j1939_addr.sh \
+	test_j1939_wire.sh \
 
 TEST_FILES := j1939_lib.sh
 
@@ -19,5 +20,6 @@ TEST_GEN_FILES := \
 	test_j1939_base \
 	test_j1939_opts \
 	test_j1939_addr \
+	test_j1939_wire \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/test_j1939_wire.c b/tools/testing/selftests/net/can/test_j1939_wire.c
new file mode 100644
index 000000000000..8f5113394f99
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 wire-format selftests: a J1939 socket against CAN_RAW.
+ *
+ * Where test_j1939_base keeps transfers on the local path between two J1939
+ * sockets, these pair a J1939 socket with a CAN_RAW socket and check the actual
+ * CAN frames on the wire both ways: a J1939 send produces the expected CAN id
+ * (priority, PGN, source and destination) and payload, and an injected CAN frame
+ * is parsed and delivered to the J1939 socket. Both destination-specific (PDU1)
+ * and broadcast (PDU2) single frames are covered.
+ *
+ * The vcan interface is set up by the caller (see test_j1939_wire.sh); its name
+ * is passed via the CANIF environment variable.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW peer */
+#define PGN_PDU1		0x0ab00	/* PF 0xab (< 240): destination specific */
+#define PGN_PDU2		0x0feee	/* PF 0xfe (>= 240): broadcast */
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
+	J1939_SETUP_RAW(self, 0);
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
+ * Inject one CAN frame from the raw peer and confirm the J1939 socket receives
+ * the identical 8-byte payload. Opens the J1939 RX socket into self->j1939 (the
+ * fixture teardown closes it). @bcast selects a broadcast (PDU2) socket and
+ * frame; @pgn and @da address the injected frame. Returns 0 on success, -1
+ * otherwise; the caller ASSERTs the result.
+ */
+static int rx_single_frame_check(FIXTURE_DATA(j1939_wire) *self, bool bcast,
+				 pgn_t pgn, uint8_t da, const uint8_t payload[8])
+{
+	uint8_t rx_buf[8];
+
+	if (bcast)
+		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
+					       SA_LOCAL, pgn, J1939_OPEN_BCAST);
+	else
+		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, pgn);
+	if (self->j1939 < 0)
+		return -1;
+
+	if (send_raw8(self->raw, PRIO, pgn, da, SA_PEER, payload))
+		return -1;
+
+	if (recv_timeout(self->j1939, rx_buf, sizeof(rx_buf),
+			 J1939_RECV_TIMEOUT_MS) != (int)sizeof(rx_buf))
+		return -1;
+
+	return memcmp(rx_buf, payload, sizeof(rx_buf)) == 0 ? 0 : -1;
+}
+
+/*
+ * Send one 8-byte payload from the J1939 socket to the raw peer and return the
+ * CAN frame seen on the wire via *frame, so each caller can assert the id fields
+ * it cares about. Opens the J1939 TX socket into self->j1939 (the fixture
+ * teardown closes it) and connects it to (@da, @pgn); @bcast opens a broadcast
+ * (PDU2) socket. Returns 0 on success, -1 otherwise; the caller ASSERTs the
+ * result.
+ */
+static int tx_to_raw_send_recv(FIXTURE_DATA(j1939_wire) *self, bool bcast,
+			       pgn_t pgn, uint8_t da, const uint8_t payload[8],
+			       struct can_frame *frame)
+{
+	if (bcast)
+		self->j1939 = j1939_open_flags(self->ifindex, J1939_NO_NAME,
+					       SA_LOCAL, J1939_NO_PGN,
+					       J1939_OPEN_BCAST);
+	else
+		self->j1939 = j1939_open(self->ifindex, SA_LOCAL, J1939_NO_PGN);
+	if (self->j1939 < 0)
+		return -1;
+
+	if (j1939_connect(self->j1939, self->ifindex, da, pgn))
+		return -1;
+
+	if (send(self->j1939, payload, 8, 0) != 8)
+		return -1;
+
+	if (recv_timeout(self->raw, frame, sizeof(*frame),
+			 J1939_RECV_TIMEOUT_MS) <= 0)
+		return -1;
+
+	return 0;
+}
+
+/* J1939 TX -> CAN_RAW: destination-specific (PDU1) single frame. */
+TEST_F(j1939_wire, tx_pdu1_to_raw)
+{
+	uint8_t payload[8] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88 };
+	struct can_frame frame;
+	canid_t id;
+
+	ASSERT_EQ(tx_to_raw_send_recv(self, false, PGN_PDU1, SA_PEER, payload,
+				      &frame), 0);
+	id = frame.can_id & CAN_EFF_MASK;
+
+	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
+	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
+	EXPECT_EQ(J1939_ID_PS(id), SA_PEER);		/* destination (PS) */
+	EXPECT_EQ(J1939_ID_PF(id), J1939_PF(PGN_PDU1));
+	ASSERT_EQ(frame.can_dlc, sizeof(payload));
+	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
+}
+
+/* CAN_RAW -> J1939 RX: destination-specific (PDU1) single frame. */
+TEST_F(j1939_wire, rx_pdu1_from_raw)
+{
+	uint8_t payload[8] = { 0xde, 0xad, 0xbe, 0xef, 0x01, 0x02, 0x03, 0x04 };
+
+	ASSERT_EQ(rx_single_frame_check(self, false, PGN_PDU1, SA_LOCAL,
+					payload), 0);
+}
+
+/* J1939 TX -> CAN_RAW: broadcast (PDU2) single frame. */
+TEST_F(j1939_wire, tx_pdu2_to_raw)
+{
+	uint8_t payload[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+	struct can_frame frame;
+	canid_t id;
+
+	ASSERT_EQ(tx_to_raw_send_recv(self, true, PGN_PDU2, J1939_NO_ADDR,
+				      payload, &frame), 0);
+	id = frame.can_id & CAN_EFF_MASK;
+
+	EXPECT_EQ(J1939_ID_PRIO(id), PRIO);
+	EXPECT_EQ(J1939_ID_SA(id), SA_LOCAL);			/* source address */
+	EXPECT_EQ((id >> 8) & J1939_PGN_MAX, PGN_PDU2);	/* full broadcast PGN */
+	ASSERT_EQ(frame.can_dlc, sizeof(payload));
+	EXPECT_EQ(memcmp(frame.data, payload, sizeof(payload)), 0);
+}
+
+/* CAN_RAW -> J1939 RX: broadcast (PDU2) single frame. */
+TEST_F(j1939_wire, rx_pdu2_from_raw)
+{
+	uint8_t payload[8] = { 0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7 };
+
+	ASSERT_EQ(rx_single_frame_check(self, true, PGN_PDU2, J1939_NO_ADDR,
+					payload), 0);
+}
+
+J1939_TEST_MAIN();
diff --git a/tools/testing/selftests/net/can/test_j1939_wire.sh b/tools/testing/selftests/net/can/test_j1939_wire.sh
new file mode 100755
index 000000000000..77a1bddb5854
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_wire.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+J1939_TEST_PROG=test_j1939_wire
+source "$(dirname "$0")/j1939_lib.sh"
-- 
2.47.3

