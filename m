Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793809071;
	b=0rbTmfle9DhvTlq7VHnFz4j0jIPn/hpaVBV9USGdCuamiZvBUIptgQ/OnC3OfADkI6kr
	 GTAKorvbBnZk6zESRfUO0gv60+SIv0I8HJ/F0iw/yHtMABcPHKd3b3pCi0tY7IOCv0SQs
	 AQKQXP87So9Zh6OXfh+nK7Cf76d/QsZcPAQk3YO+AdHjkZL+JxbJrk2b7+QWS/kYe56NW
	 Zev1bmhJQIGo48anjxVD7IppKjb9YbsDDWI1dplopXCbsGmitkrifX3vWlskQ1D+/iQuy
	 NgIo8pAatCbIWCg6afHMFFN5rHtFA3aWY4giq7Nn1b3VEfvZr004gIjlBruet9MY/ZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=MbQZmOvao/B2MoUpOEed7J/07tuqvlgPwAn+TcEnKco=;
	b=TEbOBZjj9QbjrOBz4MRo1nhkky0+B7yyREnG8fAb5oKqg32jbsiqm+Pu8Fy+t0wQCABw
	 5rw5fyCijSeHpfn8p18wHqt0YIllyy+2W9+CM9j0ouhh2fu+8NHQb+s2DsOGxZ6tkSEfm
	 Z+6XE39SXm2aTI2VDvROtKp81KvVu8RwNhlP6qNqwnj8LgH9Yf9wk7GbOdZYRRjU/RMxG
	 dkAnsYuwwrYrA7zN3sgYEAyqfKWxfzomhd4EEQEo2JHPhYGiDKbx8JnkJYgC/JYwajAXb
	 c+qocq/CDqWhgCkNHE1/DpfZbrU8YMTvXtgz+TFKeR7ATmzsgBryl8tRYllATKkDSfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="LMIS/AqZ";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE5606A32E;
	Wed,  4 Nov 2026 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5EE5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LMIS/AqZ
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 805B4202BB9;
	Wed, 04 Nov 2026 17:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbQZmOvao/B2MoUpOEed7J/07tuqvlgPwAn+TcEnKco=;
	b=LMIS/AqZDgnh22eeL7iU/JUeT+6Z+F+22ZNw20JAUY/le/H/Vuw7eD59HJ83KPPjN9FSwz
	mYeaEoP4MTKh16/lgDgh/V3Y1pntEYrDnXN4JgCnRXDSnzx+vKV8vz6DwUJZS1wDV+qwkN
	Mp5kqujL8HwZ0pmDqmpMqQ64u5ih3r2AebIz7l9BPa9/L+BimfNql+RLXN0qoJNECL41uL
	v+heA9S6xpaUxof7J3gpn/PBSIUxUjTMWqb7yOzNEIBhgUWFgDRavtdnVOOMv2fQ+qrZDx
	fuibnxnlO0Ua7V5I54IK1UYdPXL9hI2NJdwFhUW9Pkv82EAIJxC0WKJRU+YBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbQZmOvao/B2MoUpOEed7J/07tuqvlgPwAn+TcEnKco=;
	b=MQh3iPzCN1xZCJOSPJelnEn4WbxdZVi0fWB9U88AkKLmH2NtzHdVd/5tPPNYw2i74eHPfv
	85kmPhfNtAZusSx9gIk8UqkqRzd831N/lWlEsH1SPJEBYFpPfnMPEjm5IGLDLD3Yyklakp
	+4NCaNjAOY1NoCTOTs4tydDwh6yw0wr0wxAJ8rkd7CkImqo4Mv7YZ8sb/bcDXTNgwEm61B
	DPiZREl4EuIWpTbA11v1abYyiQ2USpgY1cmtnUC1N817wkSPgsbTV4RLo0jPeas6WYZ91M
	mzD+Aq9XGc6YZn4pO5i0pDmg/z++dBFvpsKGaXv9oDNYT5bcBLRNaZyKMQSHmA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809063; a=rsa-sha256;
	cv=none;
	b=JDxD58pMvpjLzOb6HzrJmoZ4o1WLsjJkckL7S63lVfpWYJRqX4eF5fjF3zSyC3hIBuFirn
	2OIWRWX7RneDl+8ixl9WiWx2eFodyGI8HoMBtKrvj1PSEHgAH0Z+/uNPhfHvw5gwcsMVAa
	sAtaW2xFQT5PHEeaAArn5XDYZoyrB0DBxbJryqN2EZRHB3O3rqHc9lI979CcwJVHsaadWI
	3xLnEr6t1slF3qHsz13iRk33n0Qq8B9fD3Ibz6Fk4Kl6f0x9HK+rBaLEZOo9q8enHYyKEj
	QL3xw+IUPkMxdfjOkvjj5DxRhJvbLiTDlZtr/3F9ajnFMSoiDc0kJ3RW63aYrg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4FA8F380A27; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:18 +0100
Subject: [PATCH can-next v2 3/9] selftests: can: add J1939 base functional
 tests
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
Message-Id: <20261104-j1939-selftests-v2-3-cf797c83317b@pengutronix.de>
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

Add a functional selftest for the SAE J1939 socket interface. It runs two
CAN_J1939 sockets (a sender and a receiver) over a vcan interface and
checks payload integrity for single frame, TP and ETP sizes, the
boundaries between them, and single-frame and BAM broadcast.

Enable CONFIG_CAN_J1939 and CONFIG_CAN_RAW in the test config. The J1939
tests skip if either is missing.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name the message sizes and add static asserts for them
- return bool from helpers named *_ok()
- sort the Makefile lists, config and .gitignore; derive TEST_GEN_FILES
  from TEST_PROGS
- add CONFIG_CAN_RAW to config here, not in the opts patch: every test
  needs it
- the wrapper no longer sets J1939_TEST_PROG
- say why a round trip failed instead of printing a stale errno
  (sashiko)
- say that size_boundaries checks only the payload, not the transport
  (sashiko)
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |  10 +-
 tools/testing/selftests/net/can/config             |   2 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 180 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   4 +
 5 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc837f7dca4f2b0c03d1dc0c1b30c57671..ac9a3abe416f924998b4b337df3ea6a3891ca3de 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+test_j1939_base
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 953f4538740984d7342f6e264ac13fadc0790ed2..9068dd77fb903b6098bc36fbc4cf8075937eb66e 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,12 +4,18 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := test_raw_filter.sh
+LOCAL_HDRS := j1939_tests.h
+
+TEST_PROGS := \
+	test_j1939_base.sh \
+	test_raw_filter.sh \
+# end of TEST_PROGS
 
 TEST_FILES := j1939_lib.sh
 
 TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
-TEST_GEN_FILES := test_raw_filter
+# each .sh in TEST_PROGS runs the binary of the same name
+TEST_GEN_FILES := $(TEST_PROGS:.sh=)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 188f7979667097071401f84cc8e81d17f838af85..c132e17011e3c5dd04310b45b665b0c2782e2c85 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,5 @@
 CONFIG_CAN=m
 CONFIG_CAN_DEV=m
+CONFIG_CAN_J1939=m
+CONFIG_CAN_RAW=m
 CONFIG_CAN_VCAN=m
diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
new file mode 100644
index 0000000000000000000000000000000000000000..d01f4c2c186cba07264a62a04ad53a0550c0ef2e
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 base functional selftests.
+ *
+ * Run two SOCK_DGRAM/CAN_J1939 sockets (a sender and a receiver) over a vcan
+ * interface and verify payload integrity across the transport-size transitions:
+ * a single frame (PDU1), Transport Protocol, Extended Transport Protocol, the
+ * exact boundaries between them, and single-frame and BAM broadcast (PDU2).
+ *
+ * Run by test_j1939_base.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* arbitrary addresses and PGNs; only the PDU class of the PGNs matters */
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define PGN_PDU1		0x0ab00	/* destination specific */
+#define PGN_PDU2		0x0feee	/* broadcast */
+_Static_assert(J1939_IS_PDU1(PGN_PDU1) && !J1939_IS_PDU1(PGN_PDU2),
+	       "PGN_PDU1 must be PDU1 and PGN_PDU2 must be PDU2");
+
+/* An arbitrary TP size inside the TP range, and one that needs ETP. */
+#define TP_SIZE			128
+#define ETP_SIZE		2000
+_Static_assert(TP_SIZE > J1939_SF_MAX_SIZE, "TP_SIZE must need TP");
+_Static_assert(TP_SIZE < J1939_TP_MAX_SIZE, "TP_SIZE must fit TP");
+_Static_assert(ETP_SIZE > J1939_TP_MAX_SIZE, "ETP_SIZE must need ETP");
+
+FIXTURE(j1939_base)
+{
+	int ifindex;
+	int tx;
+	int rx;
+};
+
+FIXTURE_SETUP(j1939_base)
+{
+	self->tx = -1;
+	self->rx = -1;
+	J1939_SETUP_IFINDEX(self);
+}
+
+FIXTURE_TEARDOWN(j1939_base)
+{
+	if (self->tx >= 0)
+		close(self->tx);
+	if (self->rx >= 0)
+		close(self->rx);
+}
+
+/*
+ * Set up a receiver bound to (rx_addr, pgn) and a sender bound to SA_TX and
+ * connected to (tx_dst, pgn). Any pair opened by a previous call is closed
+ * first. bcast opens both sockets with J1939_OPEN_BCAST, for the PDU2 and BAM
+ * tests.
+ */
+static bool pair_up_ok(FIXTURE_DATA(j1939_base) *self, uint8_t rx_addr,
+		       uint8_t tx_dst, pgn_t pgn, bool bcast)
+{
+	int flags = bcast ? J1939_OPEN_BCAST : J1939_OPEN_NONE;
+
+	if (self->tx >= 0) {
+		close(self->tx);
+		self->tx = -1;
+	}
+	if (self->rx >= 0) {
+		close(self->rx);
+		self->rx = -1;
+	}
+
+	self->rx = j1939_open_flags(self->ifindex, J1939_NO_NAME, rx_addr, pgn,
+				    flags);
+	if (self->rx < 0) {
+		fprintf(stderr, "# open rx failed: %d\n", errno);
+		return false;
+	}
+
+	self->tx = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_TX,
+				    J1939_NO_PGN, flags);
+	if (self->tx < 0) {
+		fprintf(stderr, "# open tx failed: %d\n", errno);
+		return false;
+	}
+
+	if (!j1939_connect_ok(self->tx, self->ifindex, tx_dst, pgn)) {
+		fprintf(stderr, "# connect tx failed: %d\n", errno);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Send a deterministic payload of the given size on tx and verify it is
+ * received byte for byte on rx.
+ */
+static bool roundtrip_ok(FIXTURE_DATA(j1939_base) *self, size_t size)
+{
+	uint8_t *tx_buf;
+	bool ok;
+
+	tx_buf = malloc(size);
+	if (!tx_buf) {
+		fprintf(stderr, "# alloc failed\n");
+		return false;
+	}
+	fill_pattern(tx_buf, size);
+
+	errno = 0;
+	ok = send_recv_verify_ok(self->tx, self->rx, tx_buf, size,
+				 J1939_RECV_TIMEOUT_MS);
+	if (!ok)
+		fprintf(stderr, "# round-trip failed at size %zu: %s\n", size,
+			errno ? strerror(errno) : "no or wrong data");
+
+	free(tx_buf);
+	return ok;
+}
+
+/* Largest single frame, unicast PDU1. */
+TEST_F(j1939_base, single_frame_pdu1)
+{
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, SA_RX, PGN_PDU1, false));
+	EXPECT_TRUE(roundtrip_ok(self, J1939_SF_MAX_SIZE));
+}
+
+/* Transport Protocol, unicast. */
+TEST_F(j1939_base, tp_roundtrip)
+{
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, SA_RX, PGN_PDU1, false));
+	EXPECT_TRUE(roundtrip_ok(self, TP_SIZE));
+}
+
+/* Extended Transport Protocol, unicast. */
+TEST_F(j1939_base, etp_roundtrip)
+{
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, SA_RX, PGN_PDU1, false));
+	EXPECT_TRUE(roundtrip_ok(self, ETP_SIZE));
+}
+
+/*
+ * Sizes on both sides of the single frame / TP and TP / ETP limits. Only the
+ * payload is checked here, not which transport carried it.
+ */
+TEST_F(j1939_base, size_boundaries)
+{
+	static const size_t sizes[] = {
+		J1939_SF_MAX_SIZE, J1939_SF_MAX_SIZE + 1,
+		J1939_TP_MAX_SIZE, J1939_TP_MAX_SIZE + 1,
+	};
+	size_t k;
+
+	for (k = 0; k < ARRAY_SIZE(sizes); k++) {
+		ASSERT_TRUE(pair_up_ok(self, SA_RX, SA_RX, PGN_PDU1, false));
+		EXPECT_TRUE(roundtrip_ok(self, sizes[k]))
+			TH_LOG("failed at boundary size %zu", sizes[k]);
+	}
+}
+
+/* Single-frame broadcast, PDU2. */
+TEST_F(j1939_base, single_frame_broadcast_pdu2)
+{
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, true));
+	EXPECT_TRUE(roundtrip_ok(self, J1939_SF_MAX_SIZE));
+}
+
+/* BAM (broadcast transport). */
+TEST_F(j1939_base, bam_broadcast)
+{
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, true));
+	EXPECT_TRUE(roundtrip_ok(self, TP_SIZE));
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_base.sh b/tools/testing/selftests/net/can/test_j1939_base.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

