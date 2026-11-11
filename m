Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410779;
	b=z1sP0F3t9sc2D9nbLFnTmvjPaMVos3AafJdEbX5CMagEk9rHqNIlNehzwmw8Fg8SxKfI
	 SZv0RkkqqvLiK+XjQvzN8/jMV3v8LDSjDwPBHBrK7gWEimW+u0Y7YZ/zeLV8Z697iCuzo
	 hmvgyVsvGRCC7ZLzlfMv6yC33h8NoKswIdEcPqst9QfkYyeiJHkJzri/VI94jBQIYQD7O
	 g88IsHc2K9MtgxfhlB+Uc6zAPPxd3jX2x1n5AAlwojZZnyUsDJnRSNcOsX1KZUJoMrwIM
	 +dGEV+cgfkTg7Br3E8ZWShIiSSeIvlLFA4MQp11ROFZpMjbiyvnsA0p/GFUkRvxSFZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=9NTLsOL/6eh0iUOAbXJ8erY+OswRsGGMqdRm9o03L2U=;
	b=lb77cp9oB09ernOfBrxmo/semWwsBgbxlV+eqgJpi15PnTVKva27ktGn3n//UnZ6Tr3s
	 0kT9XOTnv2jHju/ysYM2kWopF6AIrIpuiQxO0c41YhIYv4ya6a7Kgq3JOxQMOulBrQYZf
	 uFLTo+C0tqkLxK+n7ClCGp29JDn0NWNtG1DEaNeAO6Z7y9EA3zi9cC0tpcA2yEb5n8um6
	 mFTnSGeCjNtIuYhsD860M7iz1Bxj4mCVihEu0wu6Tdz0bXjjg9cmgS8as4FfoJOV/la7+
	 vh2rj5gyrhZvSmD+OQQQ6v8QvDW6tVfft4Sz+nV3Xp6evjcjrOdeHdWpVz9ZQ9/+5yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KUzZpThZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE7606A32E;
	Wed, 11 Nov 2026 15:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05AE7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=KUzZpThZ
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D408B200F26;
	Wed, 11 Nov 2026 16:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NTLsOL/6eh0iUOAbXJ8erY+OswRsGGMqdRm9o03L2U=;
	b=KUzZpThZP0l5PBDvrQAx/e3ldRFanLW0wkfwhTyF5VTHBGGrvv9v9shvAJdSpOqL8g0u/E
	ff0S28cxKi88zxIBVu/nWmSqy+ISQBw4P1vzL5Ri4Co/u8zLkEUfaZZMkA0owDMQi2mk76
	mQL8T5I5d+LVTyH3tlMsVS8n8vWjeIAh8oLmqT8lg3rXUoqTmo/WK4AjWPExd96Y1kA1F7
	5L4QBC3TD3RDSw1opy6SABBD4gh3xQjY0mRo6g98XWB2u5z8IdREBQSjWcghuxCDkJ8DLs
	9thvTaZPfJfkWXPwbOy0Bk4s0pMU5xbdhyCgXHGafQbyFLEUGvyD4grKoBIw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NTLsOL/6eh0iUOAbXJ8erY+OswRsGGMqdRm9o03L2U=;
	b=bT1eBQxMtryjG86XSi401kreKEwhtTBj5g1k1Jo0Z02Y6Bj68i2hEDU1sA8VeFPloR2DKN
	6qiO0DPEcVyNwZm1XYyVUCnhcUIgkgBj2nG1JB5pDjyxtaGhHjZviYqaWbcqafRQ4j8h/a
	RLId0vJDIn+mg1z84NTM71Dh9vNTZqParruYqJ5mx3Td1uEbT+kf/YbBkL1cQ4MrnrKBJ2
	6M4z/zkXaNvXp4M2kBC79T9KqyejC52eAj+tJm7o7IlPGVz5HpWt8rHAdyEZWGm1fdOnrb
	bknmEGgFaejf86PSjZD96ysdqrOd3yNwI3dF2rrIuCQDgKsE9VuCwAfHiBOEcA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410771; a=rsa-sha256;
	cv=none;
	b=UI8gD0JI1vt+C2jPSy7OjMsvTKuDvbSxpjumSGf3ucKCyme6rcolmMog7TjrnEeKcXYjEs
	as86smKXTalRS+/s96ZsoxI6N5FimqA88ApJ3Yn8zcUR8HUOOosHaC25D9LVGTPHSfO1V2
	4LHFILjC3gNe3MYMDuWdpy5KWRHyR9ykdjwiyys6bgUS0jc8v05NnZaSCoeaKNNsV4Ljqy
	CZo7IFkFxqHcxAVDa5QSvKAftE0IcyotnMWuTi1spVwV5zbJSCnlgxY+AUdwx9Wc1FrnVt
	sXDdIx7j6klQm4NFfq2vqsbyuhse0jk4sbMdnjvFjm6MCr1bayqEvkMqen7y+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B0F44380EB3; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 11 Nov 2026 16:25:52 +0100
Subject: [PATCH can-next v3 3/9] selftests: can: add J1939 base functional
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
Message-Id: <20261111-j1939-selftests-v3-3-5a80277ab363@pengutronix.de>
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

Add a functional selftest for the SAE J1939 socket interface. It sends
between CAN_J1939 sockets over a vcan interface and checks payload
integrity for single frame, TP and ETP sizes, the boundaries between
them, and single-frame and BAM broadcast. A single-frame broadcast
reaches a receiver only with SO_BROADCAST.

Enable CONFIG_CAN_J1939 and CONFIG_CAN_RAW in the test config. The J1939
tests skip if either is missing.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v3:
- use the 200 ms maximum packet gap of the spec, per packet, in the
  receive timeout of a BAM message (sashiko)
- add a test that a single-frame broadcast reaches a receiver only
  with SO_BROADCAST
- assert that PGN_PDU1 has PS 0, that both PGNs are valid, and that
  SA_TX and SA_RX are two different unicast addresses
- rebuild the tests when clock-helpers.h changes
- link j1939_helpers.c into the J1939 test binaries

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
 tools/testing/selftests/net/can/Makefile           |  13 +-
 tools/testing/selftests/net/can/config             |   2 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 236 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   4 +
 5 files changed, 254 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc837f7dca4f2b0c03d1dc0c1b30c57671..ac9a3abe416f924998b4b337df3ea6a3891ca3de 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+test_j1939_base
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 953f4538740984d7342f6e264ac13fadc0790ed2..64a436a59aa69a381cb98bb6a9b15a3feeac9eff 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,12 +4,21 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := test_raw_filter.sh
+LOCAL_HDRS := j1939_helpers.h j1939_tests.h ../../clock-helpers.h
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
+
+# the J1939 tests link the shared helper code
+$(filter $(OUTPUT)/test_j1939_%,$(TEST_GEN_FILES)): j1939_helpers.c
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
index 0000000000000000000000000000000000000000..7bf492c767bf618af0be5ac89db7d7507c92e15c
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 base functional selftests.
+ *
+ * Send between SOCK_DGRAM/CAN_J1939 sockets over a vcan interface and verify
+ * payload integrity across the transport-size transitions:
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
+/* arbitrary addresses and PGNs, within the asserts below */
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define PGN_PDU1		0x0ab00	/* destination specific */
+#define PGN_PDU2		0x0feee	/* broadcast */
+_Static_assert(J1939_IS_PDU1(PGN_PDU1) && !J1939_IS_PDU1(PGN_PDU2),
+	       "PGN_PDU1 must be PDU1 and PGN_PDU2 must be PDU2");
+_Static_assert((PGN_PDU1 & UINT8_MAX) == 0,
+	       "the kernel rejects a PDU1 PGN whose PS byte is not 0");
+_Static_assert(PGN_PDU1 <= J1939_PGN_MAX && PGN_PDU2 <= J1939_PGN_MAX,
+	       "PGN_PDU1 and PGN_PDU2 must be valid PGNs");
+_Static_assert(SA_TX != SA_RX && SA_TX <= J1939_MAX_UNICAST_ADDR &&
+	       SA_RX <= J1939_MAX_UNICAST_ADDR,
+	       "SA_TX and SA_RX must be two different unicast addresses");
+
+/* An arbitrary TP size inside the TP range, and one that needs ETP. */
+#define TP_SIZE			128
+#define ETP_SIZE		2000
+_Static_assert(TP_SIZE > J1939_SF_MAX_SIZE, "TP_SIZE must need TP");
+_Static_assert(TP_SIZE < J1939_TP_MAX_SIZE, "TP_SIZE must fit TP");
+_Static_assert(ETP_SIZE > J1939_TP_MAX_SIZE, "ETP_SIZE must need ETP");
+
+/*
+ * Longest gap the spec allows before a BAM data packet (SAE J1939-21:2001
+ * section 5.12.3). The kernel waits 50 ms, see j1939_session_tx_rts() and
+ * j1939_session_tx_dat().
+ */
+#define BAM_PKT_GAP_MAX_MS	200
+
+FIXTURE(j1939_base)
+{
+	int ifindex;
+	int tx;
+	int rx;
+	int rx_no_bcast;	/* a receiver without SO_BROADCAST */
+	bool bcast;
+};
+
+FIXTURE_SETUP(j1939_base)
+{
+	self->tx = -1;
+	self->rx = -1;
+	self->rx_no_bcast = -1;
+	J1939_SETUP_IFINDEX(self);
+}
+
+FIXTURE_TEARDOWN(j1939_base)
+{
+	if (self->tx >= 0)
+		close(self->tx);
+	if (self->rx >= 0)
+		close(self->rx);
+	if (self->rx_no_bcast >= 0)
+		close(self->rx_no_bcast);
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
+	self->bcast = bcast;
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
+	int timeout_ms = J1939_RECV_TIMEOUT_MS;
+	uint8_t *tx_buf;
+	bool ok;
+
+	/* a BAM message arrives only after all its packet gaps */
+	if (self->bcast && size > J1939_SF_MAX_SIZE)
+		timeout_ms += J1939_NUM_PKTS(size) * BAM_PKT_GAP_MAX_MS;
+
+	tx_buf = malloc(size);
+	if (!tx_buf) {
+		fprintf(stderr, "# alloc failed\n");
+		return false;
+	}
+	fill_pattern(tx_buf, size);
+
+	errno = 0;
+	ok = send_recv_verify_ok(self->tx, self->rx, tx_buf, size, timeout_ms);
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
+/* A single-frame broadcast reaches only a receiver with SO_BROADCAST. */
+TEST_F(j1939_base, bcast_needs_so_broadcast)
+{
+	uint8_t tx_buf[J1939_SF_MAX_SIZE];
+	uint8_t rx_buf[J1939_SF_MAX_SIZE];
+	int enable = 1;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, true));
+	self->rx_no_bcast = j1939_open(self->ifindex, SA_RX, PGN_PDU2);
+	ASSERT_GE(self->rx_no_bcast, 0)
+		TH_LOG("open rx_no_bcast failed: %d", errno);
+
+	/* the receiver with SO_BROADCAST shows that the frame went out */
+	ASSERT_TRUE(send_recv_verify_ok(self->tx, self->rx, tx_buf,
+					sizeof(tx_buf), J1939_RECV_TIMEOUT_MS));
+	EXPECT_EQ(recv_timeout(self->rx_no_bcast, rx_buf, sizeof(rx_buf),
+			       J1939_NEG_RECV_TIMEOUT_MS), -1)
+		TH_LOG("broadcast received without SO_BROADCAST");
+
+	/*
+	 * Set SO_BROADCAST and send again. The frame must arrive now.
+	 * That shows the first frame was dropped for the missing flag,
+	 * not for another reason.
+	 */
+	ASSERT_EQ(setsockopt(self->rx_no_bcast, SOL_SOCKET, SO_BROADCAST,
+			     &enable, sizeof(enable)), 0);
+	EXPECT_TRUE(send_recv_verify_ok(self->tx, self->rx_no_bcast, tx_buf,
+					sizeof(tx_buf), J1939_RECV_TIMEOUT_MS))
+		TH_LOG("broadcast not received even with SO_BROADCAST");
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

