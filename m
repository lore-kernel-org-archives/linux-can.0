Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795869655;
	b=129CdJZxmZdmtzbGmyqIiVECFWGU3U/xeRz9rnJJ2urhOksZXuGBm41HdNqloXBFf0ZN
	 RgeUPvw3TdIrKru2rP9Uy6h77oEKR4xylR/DE/RFkPiCZh9AMWL/iwA2n6Lc3Om9uRQc9
	 DAd2FtBpS151TJo/1MnWLcH3/E/SxbeFDar5vjwLoF2ChZqyU52dQti+jT+SDaj9SVRUE
	 Pj+FNl5I543Sv7ZJk96N4znR6YB/o5AgVGRJWCmS+XXLypp3JgeNCJLs6C+8QS9WpYsTs
	 nRZ5R0d0ZiV8GGfJV5ZErN/GIjw187EB0EwDBjhCFA2uuo1bEPcgufqbgVDFv+RKZUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=twb1TBklYq0sobYrnWVeHHgZSl4q321cg05ObaDYep8=;
	b=JRWDXN76leYxP69jzZG+lZdN0APOD0tO6hdw7gcWR1BXdGWWOf9aC+nk51f7Xs3Bl9DE
	 DsdSPte/lHLQhWbByNDWQ69Q8/vLpQC59GTJKFOwWBEdYpD5Th2IL4R2lSACFjypQquxj
	 F4v2tMxLGOPgjnupbBz8E26ib6tQusubFLpdvLtiuQMyXLsrte4PuE+Xj18iFsDUPS9V+
	 Y+Mc93uhUD/E+Mr19WOEi3efYiHqTFWCajov8SdzgKYyUkaG4yQXtL6YgwFbLJ5USN9Pq
	 7OAXBxpoo93D8NSjf0pTsK4wqpMh8OK2QdISkRYG/yxTgd9oqsAsIZeyecUauDMfwGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJ982Dg2;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE700606A321;
	Sat, 28 Nov 2026 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE700606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LJ982Dg2
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B6FB2205ADA;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twb1TBklYq0sobYrnWVeHHgZSl4q321cg05ObaDYep8=;
	b=LJ982Dg2OjhwZYBSEvb5G9ISMqxN+O1vR0XWyPJEha2EyYFcHFUdYYV3VI4H2a5LByrQX4
	XwH7ouiWM5Qjm0CpUEYXYm7Obaq91T4+BHtht/aNSaxgvulUbFaHCByO4kihjrwtb3DobH
	iMrhl7SaKK01btbBH2XYaVFiYFxwaWx7WZ2S2bn6EkE+g8xGKXwVKs7CLA6Al/ohXMx5pB
	tOcXJ5lXuygNst+vhQs0F1CJFFNGTHa83ApNVSHZLTReJ4rF4AURbI6NtCyKoEsHvovwNb
	B8qBMlH3cTSac7Mhc0LimjUqtO+tDFMnyCivOyfGe8gKaGb/vnueIdm4bZk0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twb1TBklYq0sobYrnWVeHHgZSl4q321cg05ObaDYep8=;
	b=RsEQgIUNMWbOeYJmdOlq452rSXtrGXZYVpJmvwTPQbMjErVohg45NMB+AntvKkfnaugsTD
	f6kWhL1vNpccULaRs5v2j/i9yDWElI48R9DTjEilyaexwcGYVljaw3DvnnqIicgN/s2YGs
	6O8QNHTOvd+HZMEhzfDwqyCnlIlVKQrBomrZ34sIu0IIE8JlvIWxi+l8OIIKurOjfGxImR
	TxykxZAX5PmaAXhHQ9QVVL54IDV3v/ptS6YajsOXrqEQdHMRErOZ8p9AG62PwMoAYEFEUC
	NpseBEADCHlaF5fwm/B0op3uz2JPbPTzbb+OOh7yDutNlJwKOgq+YirKCLEsfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=FetE7uLTRowfkvQBYPqm0GhWODcHbruhYQPiz9s2FRSo/5yC7eny1qpKFfRCz9KHKL9+kz
	AkwWSiNZbQLZr4l5VkU03mkUw/WzEUenldfrK1Dib/skXoP/e2VwE90Lgt/z7QBh18Ibv4
	56nXjCfTyS316wsnlfdvnIgXzQGiWvDiSpv8JeKeRl0hXrCthofDg8XtYu4UMTWs+qx5Bv
	G58CidQXKYUSRJZt+3rdZxIJaX/gskPJMtDIPgwSNFatSpHCPtuq0ZxTHbZnOCsz0KVBCo
	PvIdWciIblVeb/FQeKepgIhkfB57k4nIz7CH7r18spIrhrJN4A7l7vChkA3/Ww==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 96DAB3811A8; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sat, 28 Nov 2026 13:40:46 +0100
Subject: [PATCH can-next v6 5/9] selftests: can: add J1939 addressing and
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
Message-Id: <20261128-j1939-selftests-v6-5-a9dc9140dee6@pengutronix.de>
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

Add a selftest for J1939 NAME binding and source addresses: a socket
bound to a NAME reads it back with getsockname(), and a socket bound to
a source address sends frames with that address in the CAN id. A stress
test runs several TP sessions at the same time, each with its own
payload.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes in v6:
- use j1939_connect_ok() where no NAME is needed
- coding style: one check per condition, braces, declaration order

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
 tools/testing/selftests/net/can/test_j1939_addr.c  | 233 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 4 files changed, 239 insertions(+)

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
index 31d23949b88f36b56c0e36d6fdf160e162c99185..1d036194738842062fa25fb5ade95100f07d0167 100644
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
index 0000000000000000000000000000000000000000..dc01df14f8d7af4f63ce33ef3a355da17da680a4
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 addressing and concurrency selftests.
+ *
+ * Cover binding a NAME and reading it back, and the bound source address in
+ * the CAN id. Also run many concurrent transport sessions.
+ *
+ * Run by test_j1939_addr.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
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
+	struct sockaddr_can src;
+	int rc = EXIT_FAILURE;
+	bool setup, signalled;
+	char c = 0;	/* the sync byte, any value */
+	int tx, rx;
+	size_t i;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+	for (i = 0; i < sizeof(tx_buf); i++)
+		tx_buf[i] ^= sa_tx;
+
+	rx = j1939_open(ifindex, sa_rx, PGN_TEST);
+	tx = j1939_open(ifindex, sa_tx, J1939_NO_PGN);
+	setup = rx >= 0 && tx >= 0;
+	if (setup)
+		setup = j1939_connect_ok(tx, ifindex, sa_rx, PGN_TEST);
+
+	/*
+	 * Signal even after a setup error, and close ready at once: then the
+	 * parent gets EOF, not a hang, if a child dies before its write.
+	 */
+	signalled = write_all_ok(ready, &c, sizeof(c));
+	close(ready);
+
+	if (!signalled)
+		goto out;
+	/* read() returns 0 at EOF, when the parent closes go */
+	if (read(go, &c, sizeof(c)) != 0)
+		goto out;
+	if (!setup)
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
+	ASSERT_TRUE(j1939_connect_ok(self->tx, self->ifindex, SA_RX, PGN_TEST));
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
+	pid_t pids[STRESS_N];
+	int ready[PIPE_NUM];
+	int go[PIPE_NUM];
+	int failed = 0;
+	int i, n;
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
+	for (i = 0; i < n; i++) {
+		if (!read_all_ok(ready[PIPE_RD], &c, sizeof(c)))
+			break;
+	}
+	close(ready[PIPE_RD]);
+	close(go[PIPE_WR]);
+
+	for (i = 0; i < n; i++) {
+		int status;
+
+		if (waitpid(pids[i], &status, 0) < 0) {
+			failed++;
+			continue;
+		}
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != EXIT_SUCCESS)
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

