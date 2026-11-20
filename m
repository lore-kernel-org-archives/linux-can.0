Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167971;
	b=IULuZQyJEalj1/plq3mIuMXXe8l2/352Wfc45kyVKnLoKFpjOdLZvD/bis8zB1BryoZY
	 vwHpd65spLXf+zoNHmrgk4i+oO7oouFErceWuWJ/gLPLW4FmYIEE+utJM32scKGRYage8
	 rLZVG7y+u+BNMAqjl9Ly6OSR0phhqoblXwj8wPecxGCK65f+lv20x66QLdRlP9R1UYqF4
	 cAMA2+JaagBNjMihOilBQWGUDcGlOol8tRhStQxrzzykLcunuHp+ClpSNxjYHhOdxqVy9
	 xWnKJxt+y7FfRNG4eiWA5AuZh/SugTh+gSn/YBZb4N43DTHHviMup4Zw9y858RHuTHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167971;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=cdjamrctm37NW/HtQi7+atMY/a9ZkskPhTplMcDPNy0=;
	b=HOAlY+aPPfQB4jJRMtmIx7EzMqB9faB5MzYJWlhXyp0r/mvh/qPZiTUdFi2zntLCU0Fc
	 +3PKzEVPxMSKQ76smQT8GjXe1ZCekKNHdl+YNd34YbTSK/WHKD/+i5H4EULRcUkV8xSVZ
	 ky46Tz/qWB/Ss/+uOIEhA1veDFjhfzmv9RkHfH0uGTXU9wQr/Edf6KsxCOYWqkwv5NYmk
	 9YgrU9AY5i9V7vyD8vo5SgCF33+uYl/mT06p6+FG8RAgTWJmy6aswTWgoiPzUAN7FQBmH
	 jRH/8blsNj3LgSwS/yoIlmyhfnMkT1rPoPOY3g3cxgxhwiy9L3esOMr/lDscZvZrPvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CaXUIWAA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443F606A32A;
	Fri, 20 Nov 2026 09:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5443F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=CaXUIWAA
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 64694202618;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdjamrctm37NW/HtQi7+atMY/a9ZkskPhTplMcDPNy0=;
	b=CaXUIWAAYE50MftckzRfpXjAEX/P8xOjjgAkdiV2DxiA7fBiaKpq4ayoA+4JWUcBaCEXWG
	JDEQMtEn4gWI4kisIL0NSqnkF2bvzb5Rr7R2aN79oXiozjr0Tw5ZorUtdaYe+QciL5Gq0/
	3vrxqzKABV48C0HwOnNBkcGZeW3VbNZytfW/72emS9Di92gZIOkuD2nv20R79Vgn9S2IsA
	9CVu/d3WLmSs7MyyayeoPAA03hBvChQrlZf0xY0UJwEh9E698S17PEfYayusN7B/eBH0Jz
	WGWlWUZPjGt8FfviCpPoRjKjqTPRLevaWRneQNJD3wesrY64qz0XmPN1c6IGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdjamrctm37NW/HtQi7+atMY/a9ZkskPhTplMcDPNy0=;
	b=LhJLOFtUjsPYPRsttwVWQWJ4tAyIw0+AUi7lqvLGjGXije+/ynKumV9m+jkHR3h3pSud4a
	u9eLty0ufuz4+foHTqedCSZ2XUou1K7IT661L0pS/XAhiOWht3eJnlRIt1/eko5DZOcMFa
	SxPsYyTy8JDxVK5Fgf2bbQyMXd79JTx8zgcJvwiNf7W6JgRCrKnrKXWlVjJMSR//03A0Dm
	w08ruGg7NpKvFylzMIvANrbpY3lWNYL1sAAGRZv1MpKFVGN7A9a9nX12Jo8QAu2Iks+iDK
	0MbrDzrBTe7rCN1piln0zlfA2LDjRethjb8HqUQOzbfAAvT1PNkDIijc4DQMQA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=TqAO+/wzMeRXwnKGDg9AYy1u9FN+LIzoQ2YMt6VxowLtpVhsaeUikanRFRFGIL4y9p7zeb
	eekp/oUalEB0PGDoDA/I6xMC0fKXHzTvYaDt4hNSyeThU9K3MNynZRebWIz7rTmZWSSN54
	a+x+T6nMlGqjLYFUTyULnTYS/kpqj2uGF89vrYAerEGTOuET2OAd0i4W9gP/Ly8bVFuaii
	q7ZG7NCSKlwsKejgHDZRpoDQ8ub4wk6L0qbW6SqGVAT+0SDiECby1nfJcOobDccvc7hsSR
	VCy8ZRadZrAEjRvtLkqbJn+uLAtFJ4esh0g0mnTH/s3lelmhlk3QnJDV+QDZqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4DFF0380E3F; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:46:00 +0100
Subject: [PATCH can-next v5 5/9] selftests: can: add J1939 addressing and
 concurrency tests
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
Message-Id: <20261120-j1939-selftests-v5-5-fdf4c242a37e@pengutronix.de>
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

Add a selftest for J1939 NAME binding and source addresses: a socket
bound to a NAME reads it back with getsockname(), and a socket bound to
a source address sends frames with that address in the CAN id. A stress
test runs several TP sessions at the same time, each with its own
payload.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v5:
- drop the address-claim tests and their helpers; they had to work
  around a known stack bug in the claim hold-off (sashiko)
- the teardown no longer waits out a claim hold-off
- move the J1939_STRICT_TIMING example in j1939_helpers.h to patch 8

Changes in v4:
- pass J1939_NEEDS_RAW to j1939_test_main()
- open_raw() binds to CANIF_RAW and takes no ifindex
- ac_conflict_lose: check that the winning NAME is not reachable well
  before the hold-off ends (sashiko, Chaosheng Qu)
- use recv_none_ok() for the negative receive check

Changes in v3:
- wait out the claim hold-off in the teardown of a failed test, so that
  a failure does not hang the interface delete (sashiko)
- assert that the claim retry is shorter than the strict window and than
  1 s, and that the fixed addresses are unicast
- check that a receiver bound to another NAME gets nothing, and that the
  lost address stays lost after the winner is mapped
- check that a send from a claimed NAME carries the claimed address
- assert that the claim test data fits one frame
- fix comments that did not match the code

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, add static asserts, avoid casts and return bool
  from helpers named *_ok()
- retry the first send after a claim instead of a fixed 300 ms sleep
  (sashiko)
- wait until the kernel has handled a forged claim (sashiko)
- check the kernel's 250 ms hold-off after a claim; in strict mode the
  first send must also succeed soon after it ends
- bind the receiver of the NAME test to a NAME only (sashiko)
- stress: give each session its own payload (sashiko), start all
  sessions together and check the source address of each message
- stress: if a fork() fails, still reap the children (sashiko)
- check the priority, destination and NAME of the Address Claimed frame
- in the test that loses its address, wait until the kernel has mapped
  the winning NAME before closing the sockets
- check that the losing NAME of a defended claim gets no address
- keep the Makefile and .gitignore lists sorted; the wrapper no longer
  sets J1939_TEST_PROG
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   1 +
 tools/testing/selftests/net/can/test_j1939_addr.c  | 222 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 4 files changed, 228 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 75c078a2492e8e4b15bcd045fce97eede349ad39..1a6e89cdceb4a337648ca1062a6095c0168b76d4 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 j1939_gw
+test_j1939_addr
 test_j1939_base
 test_j1939_opts
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index dc5fc9d3b61e4b49a98b176e68c2635aaa4cad08..51ce18682f3044e932e9d8854872ec563b129040 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -7,6 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 LOCAL_HDRS := j1939_helpers.h j1939_tests.h ../../clock-helpers.h
 
 TEST_PROGS := \
+	test_j1939_addr.sh \
 	test_j1939_base.sh \
 	test_j1939_opts.sh \
 	test_raw_filter.sh \
diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
new file mode 100644
index 0000000000000000000000000000000000000000..efa92e79b147b88e965659752a3ff681d54fc11c
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 addressing and concurrency selftests.
+ *
+ * Cover binding a NAME and reading it back, and the bound source address in
+ * the CAN id. Also run many concurrent transport sessions.
+ *
+ * Run by test_j1939_addr.sh, see j1939_tests.h.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/wait.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* fixed unicast addresses, arbitrary */
+#define SA_TX			0x80
+#define SA_RX			0x90
+
+/* stress session i sends from SA_STRESS_TX + i to SA_STRESS_RX + i */
+#define SA_STRESS_TX		0x40
+#define SA_STRESS_RX		0x20
+
+/* NAME, arbitrary */
+#define NAME_TX			0x00000000c0ffee01ULL
+
+/* PGN, arbitrary */
+#define PGN_TEST		0x0ab00
+_Static_assert(J1939_IS_PDU1(PGN_TEST), "PGN_TEST must be PDU1");
+
+/* stress run, arbitrary tuning */
+#define STRESS_N		8
+#define STRESS_SIZE		128	/* a TP size */
+_Static_assert(STRESS_SIZE > J1939_SF_MAX_SIZE, "STRESS_SIZE must need TP");
+_Static_assert(STRESS_SIZE <= J1939_TP_MAX_SIZE, "STRESS_SIZE must fit TP");
+/* the stress addresses lie below the fixed ones, which differ */
+_Static_assert(SA_STRESS_RX + STRESS_N <= SA_STRESS_TX &&
+	       SA_STRESS_TX + STRESS_N <= SA_TX &&
+	       SA_STRESS_TX + STRESS_N <= SA_RX && SA_TX != SA_RX,
+	       "test addresses overlap");
+_Static_assert((SA_TX <= J1939_MAX_UNICAST_ADDR) &&
+	       (SA_RX <= J1939_MAX_UNICAST_ADDR),
+	       "the fixed addresses must be unicast");
+
+/* ends of a pipe(2) fd pair */
+enum { PIPE_RD, PIPE_WR, PIPE_NUM };
+
+static int j1939_open_name(int ifindex, name_t name, uint8_t sa, pgn_t pgn)
+{
+	return j1939_open_flags(ifindex, name, sa, pgn, J1939_OPEN_NONE);
+}
+
+/*
+ * One TP transfer from sa_tx to sa_rx. The payload depends on sa_tx, so a
+ * receiver that gets the data of another session fails. After the setup, write
+ * one byte to ready, close it and wait until the parent closes go, so that all
+ * sessions start together.
+ * Returns the exit status of the child process.
+ */
+static int stress_child(int ifindex, uint8_t sa_tx, uint8_t sa_rx, int ready,
+			int go)
+{
+	uint8_t tx_buf[STRESS_SIZE];
+	int tx, rx, rc = EXIT_FAILURE;
+	struct sockaddr_can src;
+	bool setup, signalled;
+	char c = 0;	/* the sync byte, any value */
+	size_t i;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+	for (i = 0; i < sizeof(tx_buf); i++)
+		tx_buf[i] ^= sa_tx;
+
+	rx = j1939_open(ifindex, sa_rx, PGN_TEST);
+	tx = j1939_open(ifindex, sa_tx, J1939_NO_PGN);
+	setup = rx >= 0 && tx >= 0 &&
+		j1939_connect_ok(tx, ifindex, sa_rx, PGN_TEST);
+
+	/*
+	 * Signal even after a setup error, and close ready at once: then the
+	 * parent gets EOF, not a hang, if a child dies before its write.
+	 */
+	signalled = write_all_ok(ready, &c, sizeof(c));
+	close(ready);
+
+	/* read() returns 0 at EOF, when the parent closes go */
+	if (!signalled || read(go, &c, sizeof(c)) != 0 || !setup)
+		goto out;
+
+	if (!send_all_ok(tx, tx_buf, sizeof(tx_buf)))
+		goto out;
+
+	if (recvfrom_verify_ok(rx, tx_buf, sizeof(tx_buf),
+			       J1939_RECV_TIMEOUT_MS, &src) &&
+	    src.can_addr.j1939.addr == sa_tx)
+		rc = EXIT_SUCCESS;
+out:
+	if (rx >= 0)
+		close(rx);
+	if (tx >= 0)
+		close(tx);
+	return rc;
+}
+
+FIXTURE(j1939_addr)
+{
+	int ifindex;
+	int tx;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_addr)
+{
+	self->tx = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+}
+
+FIXTURE_TEARDOWN(j1939_addr)
+{
+	if (self->tx >= 0)
+		close(self->tx);
+	if (self->raw >= 0)
+		close(self->raw);
+}
+
+/* Bind with a NAME and read it back with getsockname(2). */
+TEST_F(j1939_addr, name_bind_getsockname)
+{
+	struct sockaddr_can addr = {};
+	socklen_t len = sizeof(addr);
+
+	self->tx = j1939_open_name(self->ifindex, NAME_TX, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0)
+		TH_LOG("bind with NAME failed: %d", errno);
+
+	ASSERT_EQ(getsockname(self->tx, (struct sockaddr *)&addr, &len), 0);
+	EXPECT_EQ(addr.can_addr.j1939.name, NAME_TX);
+	EXPECT_EQ(addr.can_addr.j1939.addr, SA_TX);
+}
+
+/* The bound source address is used as source address on the wire. */
+TEST_F(j1939_addr, source_sa_on_wire)
+{
+	uint8_t buf[CAN_MAX_DLEN] = {};
+	struct can_frame frame;
+
+	self->raw = open_raw();
+	ASSERT_GE(self->raw, 0);
+
+	/* static source address: no address claim needed to transmit */
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_TRUE(j1939_connect_name_ok(self->tx, self->ifindex,
+					  J1939_NO_NAME, SA_RX, PGN_TEST));
+
+	ASSERT_TRUE(send_all_ok(self->tx, buf, sizeof(buf)));
+
+	ASSERT_TRUE(recv_frame_ok(self->raw, &frame, J1939_RECV_TIMEOUT_MS));
+	ASSERT_TRUE(j1939_is_data_frame(frame.can_id))
+		TH_LOG("CAN id 0x%08x is not a 29-bit data frame",
+		       frame.can_id);
+	EXPECT_EQ(j1939_id_sa(frame.can_id), SA_TX)
+		TH_LOG("source address on wire is 0x%02x, expected 0x%02x",
+		       j1939_id_sa(frame.can_id), SA_TX);
+}
+
+/* Many concurrent transport-protocol sessions run without corruption. */
+TEST_F(j1939_addr, stress_concurrent_sessions)
+{
+	int i, n, ready[PIPE_NUM], go[PIPE_NUM], failed = 0;
+	pid_t pids[STRESS_N];
+	char c;
+
+	ASSERT_EQ(pipe(ready), 0);
+	ASSERT_EQ(pipe(go), 0);
+
+	for (n = 0; n < STRESS_N; n++) {
+		pids[n] = fork();
+		if (pids[n] < 0)
+			break;
+		if (pids[n] == 0) {
+			close(ready[PIPE_RD]);
+			close(go[PIPE_WR]);
+			_exit(stress_child(self->ifindex, SA_STRESS_TX + n,
+					   SA_STRESS_RX + n, ready[PIPE_WR],
+					   go[PIPE_RD]));
+		}
+	}
+
+	close(ready[PIPE_WR]);
+	close(go[PIPE_RD]);
+
+	/* wait until all children are set up, then start them */
+	for (i = 0; i < n; i++)
+		if (!read_all_ok(ready[PIPE_RD], &c, sizeof(c)))
+			break;
+	close(ready[PIPE_RD]);
+	close(go[PIPE_WR]);
+
+	for (i = 0; i < n; i++) {
+		int status;
+
+		if (waitpid(pids[i], &status, 0) < 0 ||
+		    !WIFEXITED(status) || WEXITSTATUS(status) != EXIT_SUCCESS)
+			failed++;
+	}
+
+	ASSERT_EQ(n, STRESS_N)
+		TH_LOG("fork failed after %d of %d children", n, STRESS_N);
+	EXPECT_EQ(failed, 0)
+		TH_LOG("%d of %d concurrent sessions failed", failed, STRESS_N);
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv, J1939_NEEDS_RAW);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_addr.sh b/tools/testing/selftests/net/can/test_j1939_addr.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

