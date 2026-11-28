Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795869657;
	b=kDaygZIosMLJ8VjIh0mmuVZ7RVedp++bVHFsVqv7203No3BWKa2TbU1C/OejO6BYf4I5
	 1uc83z3+PPcrHjpAQQVQkqOXSCyIPZKNzWGx/JeDDv6a9/6ynZVsGOufP+GJLaZBv8prl
	 Ip3M5R7l/yb28dFl+B5KJQEcxgWcUJHiQ1TL9G6enjr5LwAOuksUquSo8Y9vfjyY/WAe9
	 u5mRG+M+5tlosj3/BbUL6uF5wz70R9K+on+wjKioJ3dBB2xuhTRZ7qPm6m4vBcjpJyzSn
	 DhO3/+fnwYkdObAfNOnkR5kTQJonndnhUZm6DUWbjmNHYB2W5EK2DlIX+sh8okZmeQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869657;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=W6qflxXbE2JH81f0EWPGRxEtAeBh1QNpuKHq/YUiTyw=;
	b=qlEK82HMvSa5nutWhWVqGS/qKklPx8ob3l7+/J+vA2m5lV50RPxt5ywZxUnQW3KpYVUI
	 GIP5d42bQErNn1adagpwsQkaJOa7BiEnc7JIBLp5JXoI7gT44vLdkOSKiA3U5ffZL/21U
	 m/BJbBLoWwFgkqqf80++MEa7lATsmmnz3iJvXgAZ02rkBLZ12+rxEAptoSeQ7dN0lNkUO
	 cnPxdjzxPR/CElYt5wpfxCjRQiY+HSzJFQfZWOwrYpVTOCqCgkClc8VCy+OFrIetzXThz
	 IB1UjYSOvedE5fWecawFTN1O7aHF9IhZOrA7FzevL+6kJF+yugkWTP6bngdm4VA7CUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PzVeX4Lz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1C606A689;
	Sat, 28 Nov 2026 12:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C1C606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PzVeX4Lz
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B50E3205A98;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6qflxXbE2JH81f0EWPGRxEtAeBh1QNpuKHq/YUiTyw=;
	b=PzVeX4Lzan16pelnYfksmD0lpegG+F8HX6oVtsBlXLvmgmt55If13vZ0Yv05mmRy4QlGEZ
	hGXIb35cmebrvu9L2Lty3IOHa3qLFbWOHnbL0sOyvHv3aO56usxJw0WdP2maZusHTcUv3a
	4jAQmZ0+K8M98DEtdwZiS3twdjln9L+R6zPXY+gLCbAajk3EWpM/F1aFC/30/WX2tX+CoD
	H/mPOSNiCwl7pjhUxdUn6z2sVWkF/077k9Uc0IQQ1ca0CQplogIdGUQCKFM3GZHSKqSJ3q
	IBknjY2seQuoAbKmSAJ98RXtg14ToGeouS92f1JTnHYLyNvzADXkaJ/RoH43qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6qflxXbE2JH81f0EWPGRxEtAeBh1QNpuKHq/YUiTyw=;
	b=enQEZlcTFlJfqs+8Wf//IYfCn4BKUWNd9+99V03pWmr1ddnYgxMNuVodi8ME9jZwqGqlJj
	8WaZ5g59SPGjGHz9dU+nO1aHUFfqnTWkHTyote1yBExlGT0+7F1Fm+ZA7WZGB/DIPxI9KJ
	yqIv9GLxYQbwrxfVa/at67J+HqYqjQuk7ZhVuuIHOAeDm6HwJ01WzaHC1ut/DchP977ZQ/
	aaiFo0vt4e0Jtlgck6QgpSgnXPlZ7uqcFeX/tK2Zcn+PCeggjNVc/ergQ3hKmDyNYfHlwr
	YspJB4r+YuHbdJrISFudeo9WlQ+esWg7G6Lcc2DfrcohHGbhzNovM+cFzJisdA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=dX/FiElEf7Lry+Xrocy0UTF8tEOsiyM16OG6UI1uDNkHbtjDTq0xZOEz5HrcKW5JroipMN
	mw0jn/ykBBe39Gmjqo+fcBOvGtl+SRG51sZ2U9AOJIlf1aC8gdJRUeiW0pGg2/CPUDs8iY
	NKQHKRd0E/vPbSYE4y/yNKmU1mIXFOfdGc2umXgMnRbsgymZ3NXuO3vV+lGxpd2KwdmUcV
	K4MAUAuvMcDoTgJIMmCPipxFCfRt5XGCpaDlH9FHnEQWUnyr0aPEtQezvBLR2DOdkmEZ2E
	gW2YWCE2LskEnEuSnCm/MUOXekmK3PBrXC9PFaC4bykdQL7cgpHAKdH4m1jFBQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 93156380CB7; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sat, 28 Nov 2026 13:40:44 +0100
Subject: [PATCH can-next v6 3/9] selftests: can: add J1939 base functional
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
Message-Id: <20261128-j1939-selftests-v6-3-a9dc9140dee6@pengutronix.de>
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

Add a functional selftest for the SAE J1939 socket interface. It sends
between CAN_J1939 sockets over a vcan interface and checks payload
integrity for single frame, TP and ETP sizes, the boundaries between
them, and single-frame and BAM broadcast. A single-frame broadcast
reaches a receiver only with SO_BROADCAST.

Enable CONFIG_CAN_J1939, CONFIG_CAN_RAW and CONFIG_CAN_GW in the test
config: CAN_RAW for the CAN_RAW peer of the later tests, CAN_GW for the
gateway that j1939_lib.sh sets up. This test opens no CAN_RAW socket and
skips only without CAN_J1939.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v6:
- pass J1939_NEEDS_NONE instead of 0 to j1939_test_main()
- coding style: declare flags apart from its use, add braces

Changes in v5:
- No changes.

Changes in v4:
- add CONFIG_CAN_GW to config, for the gateway of j1939_lib.sh
- set J1939_NO_PEER=1 in the wrapper, this test needs no CAN_RAW peer
- do not skip without CAN_RAW, this test opens no CAN_RAW socket; the v2
  note that every test needs CAN_RAW was wrong (sashiko, Chaosheng Qu)
- add recv_none_ok(), which also fails on a socket error, and use it for
  the negative receive check
- give the broadcast sent after SO_BROADCAST is set its own payload, so a
  late first frame cannot pass as the second one

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
 tools/testing/selftests/net/can/Makefile           |  14 +-
 tools/testing/selftests/net/can/config             |   3 +
 tools/testing/selftests/net/can/j1939_helpers.c    |  11 +
 tools/testing/selftests/net/can/j1939_helpers.h    |   8 +
 tools/testing/selftests/net/can/test_j1939_base.c  | 241 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_base.sh |   7 +
 7 files changed, 283 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 30cd8b40d0f885fdf8c3855d231c9d3ec7c7c112..e566019425c84f362d9cb0dffc5e733dc90a4ce1 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 j1939_gw
+test_j1939_base
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 7f16586006104652c9872008d3eec860416486ed..fffc58e1de5893aac14f3d75df06ecf06a488b82 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,14 +4,24 @@ top_srcdir = ../../../../..
 
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
+
 # sets up the CAN gateway for j1939_lib.sh
 TEST_GEN_FILES += j1939_gw
 
 include ../../lib.mk
+
+# the J1939 tests link the shared helper code
+$(filter $(OUTPUT)/test_j1939_%,$(TEST_GEN_FILES)): j1939_helpers.c
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 188f7979667097071401f84cc8e81d17f838af85..e124727f63b6464742ef0723cd748c10f3b96ff1 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,6 @@
 CONFIG_CAN=m
 CONFIG_CAN_DEV=m
+CONFIG_CAN_GW=m
+CONFIG_CAN_J1939=m
+CONFIG_CAN_RAW=m
 CONFIG_CAN_VCAN=m
diff --git a/tools/testing/selftests/net/can/j1939_helpers.c b/tools/testing/selftests/net/can/j1939_helpers.c
index 5aefd0e61a54b316508a68c045a7ab84bc3fdd90..539702520a9215831bb6136ac29b36a3a92363ab 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.c
+++ b/tools/testing/selftests/net/can/j1939_helpers.c
@@ -243,6 +243,17 @@ static ssize_t recv_timeout(int s, void *buf, size_t len, int timeout_ms)
 	return recv(s, buf, len, 0);
 }
 
+bool recv_none_ok(int s)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+	uint8_t drop;
+
+	if (poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS) == 0)
+		return true;
+	recv(s, &drop, sizeof(drop), MSG_DONTWAIT);
+	return false;
+}
+
 bool recvfrom_verify_ok(int s, const void *want, size_t len, int timeout_ms,
 			struct sockaddr_can *src)
 {
diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
index 13a458cab51a6d9f35d764fb768c70da29bf02a0..2716ca68f3b8283625bdd6c36c596e31ba8ae6b1 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.h
+++ b/tools/testing/selftests/net/can/j1939_helpers.h
@@ -199,6 +199,14 @@ int open_raw_rcvbuf(int rcvbuf);
 /* open_raw_rcvbuf() with the default receive buffer. */
 int open_raw(void);
 
+/*
+ * Return true if poll() on s times out after J1939_NEG_RECV_TIMEOUT_MS.
+ * Otherwise (a message, a socket error or a poll() failure) do one recv()
+ * with MSG_DONTWAIT and return false. That recv() drops a waiting message
+ * or clears a pending socket error.
+ */
+bool recv_none_ok(int s);
+
 /*
  * recvfrom() one message on s within timeout_ms, check that it is the len
  * bytes in want, and return the sender in *src unless src is NULL. The buffer
diff --git a/tools/testing/selftests/net/can/test_j1939_base.c b/tools/testing/selftests/net/can/test_j1939_base.c
new file mode 100644
index 0000000000000000000000000000000000000000..6e3e103cd9b3e96fd9785e66c45a5f9a4d0e5cae
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.c
@@ -0,0 +1,241 @@
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
+	int flags;
+
+	flags = bcast ? J1939_OPEN_BCAST : J1939_OPEN_NONE;
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
+	if (!ok) {
+		fprintf(stderr, "# round-trip failed at size %zu: %s\n", size,
+			errno ? strerror(errno) : "no or wrong data");
+	}
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
+	uint8_t second_buf[J1939_SF_MAX_SIZE];
+	uint8_t tx_buf[J1939_SF_MAX_SIZE];
+	int enable = 1;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+	memcpy(second_buf, tx_buf, sizeof(second_buf));
+	second_buf[0] ^= UINT8_MAX;
+
+	ASSERT_TRUE(pair_up_ok(self, SA_RX, J1939_NO_ADDR, PGN_PDU2, true));
+	self->rx_no_bcast = j1939_open(self->ifindex, SA_RX, PGN_PDU2);
+	ASSERT_GE(self->rx_no_bcast, 0)
+		TH_LOG("open rx_no_bcast failed: %d", errno);
+
+	/* the receiver with SO_BROADCAST shows that the frame went out */
+	ASSERT_TRUE(send_recv_verify_ok(self->tx, self->rx, tx_buf,
+					sizeof(tx_buf), J1939_RECV_TIMEOUT_MS));
+	EXPECT_TRUE(recv_none_ok(self->rx_no_bcast))
+		TH_LOG("a receiver without SO_BROADCAST got a frame or error");
+
+	/*
+	 * Set SO_BROADCAST and send a second frame. It must arrive now.
+	 * That shows the first frame was dropped for the missing flag,
+	 * not for another reason. The second frame has its own payload,
+	 * so a late first frame cannot be mistaken for it.
+	 */
+	ASSERT_EQ(setsockopt(self->rx_no_bcast, SOL_SOCKET, SO_BROADCAST,
+			     &enable, sizeof(enable)), 0);
+	EXPECT_TRUE(send_recv_verify_ok(self->tx, self->rx_no_bcast,
+					second_buf, sizeof(second_buf),
+					J1939_RECV_TIMEOUT_MS))
+		TH_LOG("second broadcast missing or not the expected payload");
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv, J1939_NEEDS_NONE);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_base.sh b/tools/testing/selftests/net/can/test_j1939_base.sh
new file mode 100755
index 0000000000000000000000000000000000000000..dd19cd469651a7b48a799f1d1337041972f2be14
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_base.sh
@@ -0,0 +1,7 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# test_j1939_base opens no CAN_RAW socket
+# shellcheck disable=SC2034 # read by j1939_lib.sh
+J1939_NO_PEER=1
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

