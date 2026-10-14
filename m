Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2155C1B2;
	Wed, 14 Oct 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992682; cv=pass; b=Xc9c+4qa9ogOSYXJcWxHe1eL5g6OdobF2uehJ7udAIPgw/jlB4j7e41MGmHeI4Yt6/lbkT/nDjbUNJLVM4hCBjy9jmN5mz4sfWsfR+9mr+4pOI+Ngo0+UbFjfX7cYPPGAkVAozWNCbq9ClTgwiwPTUgi10pMz+1OF4ViYLFOIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992682; c=relaxed/simple;
	bh=LeYMDJHwvTtxyxIShwDrupv5/VDAmKk/4qfp2Eu+u2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXCzsCsu00m8L0lWm73lXCyyJHzjj/OpKYgYw8ZrIsu+yZyaSf6n7QnqhI7gRjaFUBK+dUclT7dcV5FZQa6IJPjSt4hDw36vsh9PSUe/gsphTDZc4sJ/NcS2JhLj/fSMb/MM1mlm43uXBkhyoE9P7mEvrHcKh4yNo/k5D7IUptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YW0Znjpf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YW0Znjpf"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1E52E201B6D;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrO9onTy7802HQJJ5sLpmxfpUxHCbFTVXsckDEIeA3g=;
	b=YW0Znjpflt+PHTEmsKcSkfZz7tTJl5c7eatpVVpBD7EyG6nNqZUh3vXdAptv+v1J5Q8nPU
	I1zUaNFVbUHnU5UBoQ/Ln+JNEARRG/sTQYA2RkTAd5WP5V/gD+V6kqj/AOgZIXY6Hd24T8
	odeo9NpOpUk/ZiLHnfFF/h9doT6akNtVmyURJEPP+fbGxqds6k9lR7ihX90VNb2LJRwOlT
	iDJRwdT8gpQspkXsfEHueS2EUvL3uLqVjb2o65sjrFeaihgAsXyGxi9urtJ50da8olr7pW
	LaUl5CADuzqAja9bpCCUwssd0Y+CglGIIdteu/PbAiih5LUp0i+tfraEWJ5WuA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=E3PNA1MgbysCWy7IUxpLeRLM+4MqZmeh0WTeYrca0Yex/7TGauFn8GPx5BzjlI6j46FI24
	R0uVI+OxGv8xxTVvj3AIUDMWaG5AGwtOlCOVCsyApuslEeueAM1tabYXsz2FNXH4IJV8GD
	H8C3UEfJczWnLwF0imfRKYTsAfeNElHba7bgFw2+TJi+76wFshboqq/N+ngESh+lOxsChI
	p5GzkhIyE6RH+FXENflRxuuevz1v5dU9SzmR0Ha2I1zjORw19b2zQZepK4OBvhw6WZpaai
	HMMUFk6ctoGFrsEPVcxFr3vzfrf1E1fUInmexv8R0oe3ZQ6VympmfNNYNcobzQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrO9onTy7802HQJJ5sLpmxfpUxHCbFTVXsckDEIeA3g=;
	b=TuxocBao1GgSKa3PxYJWl0yA7pdGjopsIN1RsBWXOTLmo3P9MSyK146jN2IrT/WrNWVUJx
	cDuvux9B/FPs2z+ntkPTOnlKJ/sVLVo3DYKgX9tBmGdGTfbSFK7x3ndR5NibAd+hlDerFi
	mf7AJyFiWSpOeFtH1GFUI/t0qmMVlqmzrM0LcyyfRmaJ4gezNbD6hG+DRJ443qfo1j+4FV
	BgEbKPchpGTuJiAAkJBAto0cIearIsZDef8qiKo1ZVeK2dLwgBTCasL5dCOoGU5G05FFZA
	Pneg/gvkteP6ewRhtcEfzJRCR5eWl5Qp4MbodDhcaQnxSb35ZvZZuP5p5NCriQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 0E1FB381CD2; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 2/8] selftests: can: add J1939 base functional tests
Date: Wed, 14 Oct 2026 17:44:28 +0200
Message-ID: <20261014154435.3577983-3-o.rempel@pengutronix.de>
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

Add a functional selftest for the SAE J1939 socket interface. It runs two
CAN_J1939 sockets (a sender and a receiver) over a vcan interface and
checks payload integrity across the transport-size transitions: single
frame (PDU1), Transport Protocol, Extended Transport Protocol, the exact
size boundaries around those transitions, and single-frame and BAM
broadcast (PDU2).

Declare j1939_tests.h as a local header dependency and enable
CONFIG_CAN_J1939 in the test config.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |  10 +-
 tools/testing/selftests/net/can/config        |   1 +
 .../selftests/net/can/test_j1939_base.c       | 160 ++++++++++++++++++
 .../selftests/net/can/test_j1939_base.sh      |   5 +
 5 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/test_j1939_base.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_base.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc837f..0ab563fe9ddf 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_j1939_base
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index e2092c289109..cf4bd2461a6c 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,10 +4,16 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := test_raw_filter.sh
+LOCAL_HDRS := j1939_tests.h
+
+TEST_PROGS := \
+	test_raw_filter.sh \
+	test_j1939_base.sh \
 
 TEST_FILES := j1939_lib.sh
 
-TEST_GEN_FILES := test_raw_filter
+TEST_GEN_FILES := \
+	test_raw_filter \
+	test_j1939_base \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 188f79796670..52a186bd1055 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,4 @@
 CONFIG_CAN=m
 CONFIG_CAN_DEV=m
 CONFIG_CAN_VCAN=m
+CONFIG_CAN_J1939=m
diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
new file mode 100644
index 000000000000..59f1448b7fb2
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 base functional selftests.
+ *
+ * Run two SOCK_DGRAM/CAN_J1939 sockets (a sender and a receiver) over a vcan
+ * interface and verify payload integrity across the transport-size transitions:
+ * a single frame (PDU1), Transport Protocol, Extended Transport Protocol, the
+ * exact boundaries between them, and single-frame and BAM broadcast (PDU2).
+ *
+ * The vcan interface is set up by the caller (see test_j1939_base.sh); its name
+ * is passed via the CANIF environment variable.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define PGN_PDU1		0x0ab00	/* PF 0xab (< 240): destination specific */
+#define PGN_PDU2		0x0feee	/* PF 0xfe (>= 240): broadcast */
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
+ * first. Returns 0 on success, -1 otherwise.
+ */
+static int pair_up(FIXTURE_DATA(j1939_base) *self, uint8_t rx_addr,
+		   uint8_t tx_dst, pgn_t pgn, int bcast)
+{
+	int flags = bcast ? J1939_OPEN_BCAST : 0;
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
+				   flags);
+	if (self->rx < 0) {
+		fprintf(stderr, "# open rx failed: %d\n", errno);
+		return -1;
+	}
+
+	self->tx = j1939_open_flags(self->ifindex, J1939_NO_NAME, SA_TX,
+				   J1939_NO_PGN, flags);
+	if (self->tx < 0) {
+		fprintf(stderr, "# open tx failed: %d\n", errno);
+		return -1;
+	}
+
+	if (j1939_connect(self->tx, self->ifindex, tx_dst, pgn)) {
+		fprintf(stderr, "# connect tx failed: %d\n", errno);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Send a deterministic payload of the given size on tx and verify it is
+ * received byte for byte on rx. Returns 0 on success, -1 otherwise.
+ */
+static int roundtrip(FIXTURE_DATA(j1939_base) *self, size_t size)
+{
+	uint8_t *tx_buf;
+	int rc;
+
+	tx_buf = malloc(size);
+	if (!tx_buf) {
+		fprintf(stderr, "# alloc failed\n");
+		return -1;
+	}
+	fill_pattern(tx_buf, size);
+
+	rc = send_recv_verify(self->tx, self->rx, tx_buf, size,
+			      J1939_RECV_TIMEOUT_MS);
+	if (rc)
+		fprintf(stderr, "# round-trip failed at size %zu, errno %d\n",
+			size, errno);
+
+	free(tx_buf);
+	return rc;
+}
+
+/* single frame (<= 8 bytes), unicast PDU1. */
+TEST_F(j1939_base, single_frame_pdu1)
+{
+	ASSERT_EQ(pair_up(self, SA_RX, SA_RX, PGN_PDU1, 0), 0);
+	EXPECT_EQ(roundtrip(self, 8), 0);
+}
+
+/* Transport Protocol (9 .. 1785 bytes), unicast. */
+TEST_F(j1939_base, tp_roundtrip)
+{
+	ASSERT_EQ(pair_up(self, SA_RX, SA_RX, PGN_PDU1, 0), 0);
+	EXPECT_EQ(roundtrip(self, 128), 0);
+}
+
+/* Extended Transport Protocol (> 1785 bytes), unicast. */
+TEST_F(j1939_base, etp_roundtrip)
+{
+	ASSERT_EQ(pair_up(self, SA_RX, SA_RX, PGN_PDU1, 0), 0);
+	EXPECT_EQ(roundtrip(self, 2000), 0);
+}
+
+/* exact size boundaries around single / TP / ETP transitions. */
+TEST_F(j1939_base, size_boundaries)
+{
+	static const size_t sizes[] = { 8, 9, 1785, 1786 };
+	size_t k;
+
+	for (k = 0; k < ARRAY_SIZE(sizes); k++) {
+		ASSERT_EQ(pair_up(self, SA_RX, SA_RX, PGN_PDU1, 0), 0);
+		EXPECT_EQ(roundtrip(self, sizes[k]), 0)
+			TH_LOG("failed at boundary size %zu", sizes[k]);
+	}
+}
+
+/* single-frame broadcast, PDU2. */
+TEST_F(j1939_base, single_frame_broadcast_pdu2)
+{
+	ASSERT_EQ(pair_up(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, 1), 0);
+	EXPECT_EQ(roundtrip(self, 8), 0);
+}
+
+/* BAM (broadcast transport). */
+TEST_F(j1939_base, bam_broadcast)
+{
+	ASSERT_EQ(pair_up(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, 1), 0);
+	EXPECT_EQ(roundtrip(self, 128), 0);
+}
+
+J1939_TEST_MAIN();
diff --git a/tools/testing/selftests/net/can/test_j1939_base.sh b/tools/testing/selftests/net/can/test_j1939_base.sh
new file mode 100755
index 000000000000..3cd2b14a74bb
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+J1939_TEST_PROG=test_j1939_base
+source "$(dirname "$0")/j1939_lib.sh"
-- 
2.47.3

