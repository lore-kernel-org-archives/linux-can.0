Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809074;
	b=NhMXtzcWgSNchkyvAeHu9JI3SQQine2/x9z0OIYANN1SMt5bgAdjznPJ+nvMnyTk04bf
	 ifTyC0lMHuhiUeLVVqotNd3hnZMn3Zalid+3jw1wQTT7cEcdNFrddHI7lkyq/LaD8y93D
	 OsTR51gRVT4UwKe02zryIQDf67Vul8TQw0Cd8fBg1BMAu1yd3wq++ecHNqTYwe6JQaXDt
	 a0EFm9u7RMTWiAeiCr+yXwe1zU3K0ngm+zjfr0jfRcRdCEYUqBiMzv8iqRtsoLTRlKgMt
	 OGdmNPDHlqn5qFfQ+RS1rOOPt680z6G4DBODnZTBtx90894SHYOzbzfRpryFM7glKYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809074;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=jhH1Z7GA8MknwJTUBo+S+kN/z3yguhZyhTqE3ZQrWkw=;
	b=qU+kn3ZvK0ywi/3plmu1V+NzTSkHfGhFghYwKcy5npmSwV9pFveNclpLLMP8oQrF3d8e
	 RdyOJXqPdg0+6qS774oOyD8lTmgNgRs4ZdN/+ToBYlU+C99KHI7LxAHEaSa0VSg1RJ8/W
	 TuKOiYaCnChJ7eWd++rEI1xe9lgzLDBFLICEcW/GJeQncXu6+JvGYzGZxdw+JZmcjyyUP
	 5itnie6AwjW8QYQyMt66gj977g9aTCTItFgAAtTenedrO6MwS7DzTBqUaRDvBSTSs0QjM
	 eZhPRyZ99Rvv/TC/sd32FWrOAkY2Iz2kQlaTYZtpyXl2dh1suU8lqXfqlA4IKvW6DOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=N8KUCd3z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627EA6082BC0;
	Wed,  4 Nov 2026 16:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627EA6082BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=N8KUCd3z
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 99BBF202BBB;
	Wed, 04 Nov 2026 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhH1Z7GA8MknwJTUBo+S+kN/z3yguhZyhTqE3ZQrWkw=;
	b=N8KUCd3zLYErza+DsT9HsnH0SjUeLAJWFKRLl6EBbuWTlcmjzeFgCCQsIKhSA7DfimgJyW
	vGD/h5wz6UMUVzNpA1N2iEXc5G0DpjQBylXIK3+Ir/41ynRmhsRELsxdPDU1Yagm8MRCp8
	j/m9/dK+rfbXN0pl7i852XoEqTQj7CFq6K1wtCvoFRp5zvswvFzlGcFRFwe7OyjcJM+utN
	oHMoBT7xGzhIh1cMRwPz3pnPCsWhiOV5hZE/Bk/wOBM+w+GAmioPwBDt9XwlwJOr4UwI6t
	WmgzR/pEVhfyV+wZ7fUrhF8AUC4xmRe4APg/2Lxgx7YFrAnCT1v8EKl18maPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhH1Z7GA8MknwJTUBo+S+kN/z3yguhZyhTqE3ZQrWkw=;
	b=OnVMaTc0TBJ/W1oUbMa4sd4riwrUGHcG6c7twNI4MwmsWHwVODP/GEyyGsus/udYOUPwQV
	eCmsbJAOetW3QdjL0qLdyAc6o3c+Bbr8X7Dgn9C0cnoavTjgeEhUwG+4wuIfGHbowYBaSD
	FsDYaiENixlXT84SB5ssQitx7+ATc5pI/8lSFH/XnPt+2HiwX6MCgL+y/A0WM/Lm1lC0UC
	Uc/gGp/2CVetwTkgGDf/vY+bPT8wCj86QlzgDfvhvu5vQ4Bp1UYbfMJqBTTp5NvLPbEFAN
	jUMCsUSTtP3crRkKiViIWFvlrlwk7mlJfuAc35sdu4HLytTqtszulKrtSOiv4Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809067; a=rsa-sha256;
	cv=none;
	b=chfzOze/0OdxIYrgEvckFl46mjb9hkx3eYKV9MMsLMmmWkZ21beF2VeLcNtMaykSWJPjB9
	Qhk/f3U0I73KA+bAf4K/J1TWyHsLYcT+5JjxCA05V4d6BILXJw+dCyD0DflFui4MrH4ClF
	OkaIOfJgWT7nj01H0r4cnIdLdyelM0QHCRyS8CUNh+ImcQH9MMpeMPZCp8XvcvpjhKXinm
	Km1CNpMGH6Oj81r0vMxF9Nl+VKlXHtsOscgBTzzlaG0c6qYe3Y5WquRjDmYICGO5hUgY2n
	6uV6TTvMeIDz4NTQMI+K6F/saPgYGDRUUy6F8lRBL/Y59NJyZIn7nvOK8Z1zWg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 53897380AE3; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:20 +0100
Subject: [PATCH can-next v2 5/9] selftests: can: add J1939 addressing and
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
Message-Id: <20261104-j1939-selftests-v2-5-cf797c83317b@pengutronix.de>
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

Add a selftest for J1939 NAME-based addressing and address claiming. In
the two conflict tests, a lower NAME takes the address from the socket
and a higher NAME does not. A stress test runs several TP sessions at the
same time, each with its own payload.

The kernel lets a NAME use a claimed address only 250 ms after the
claim. The tests do not sleep for a fixed time. They retry the first send
until it succeeds, and two of them also check that it does not succeed
well before the hold-off ends. With J1939_STRICT_TIMING set, it must also
succeed soon after the hold-off ends. The early and late limits are
guesses.

In the NAME-addressed test the receiver is bound to a NAME and no
address, so the frame reaches it only through the kernel's NAME match.

The test that loses its address waits until the kernel has mapped the
winning NAME before it closes its sockets. If the last socket closes
while the hold-off timer of a claim is still pending, the kernel keeps a
reference to the interface and deleting it hangs.

The NAME is serialized onto the wire byte-wise (put_name) so the tests
behave the same on big- and little-endian hosts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): can the forged Address Claims take an address from another
ECU on a real bus?
A: No. j1939_lib.sh runs the tests only on a vcan it creates.

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
 tools/testing/selftests/net/can/j1939_tests.h      |   7 +-
 tools/testing/selftests/net/can/test_j1939_addr.c  | 679 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_addr.sh |   4 +
 5 files changed, 691 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 81c6e5e4396ac789e0ac1ebad4f11d0f7ef9cbaa..c9b50d4865c4a1f7523b96516669d7fc6e0d151c 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+test_j1939_addr
 test_j1939_base
 test_j1939_opts
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 009ea9a53178a9218c11181150e9693bc3da2fdb..d72095ad7d849d8a35c20e9c5bdaa81bc194bc64 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -7,6 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 LOCAL_HDRS := j1939_tests.h
 
 TEST_PROGS := \
+	test_j1939_addr.sh \
 	test_j1939_base.sh \
 	test_j1939_opts.sh \
 	test_raw_filter.sh \
diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
index 639e000ac5e8631e7ebfc1548a7b14892fa61b32..bb22faa323e3d7de87a0a9a447216caaeb6b4b52 100644
--- a/tools/testing/selftests/net/can/j1939_tests.h
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -18,7 +18,12 @@
  *
  * Timing modes: timer checks use relaxed bounds by default, so that slow
  * machines such as QEMU in CI pass. Set J1939_STRICT_TIMING in the
- * environment (any value) for tight bounds on a real machine.
+ * environment (any value) for tight bounds on a real machine:
+ *
+ *	J1939_STRICT_TIMING=1 ./test_j1939_addr.sh
+ *
+ * Where a bound differs between the modes, the check picks it with
+ * j1939_timing_ms().
  */
 #ifndef __SELFTESTS_NET_CAN_J1939_TESTS_H__
 #define __SELFTESTS_NET_CAN_J1939_TESTS_H__
diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
new file mode 100644
index 0000000000000000000000000000000000000000..02f9e504b567f148b904cd0b95fae6ebbbf13cac
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 addressing and concurrency selftests.
+ *
+ * Cover NAME-based addressing and address claiming: binding a NAME and reading
+ * it back, the bound source address appearing in the CAN id, a sender reaching
+ * a peer by NAME, the Address Claimed frame on the wire and the kernel's
+ * hold-off after it, address-claim contention where the lower NAME wins, and
+ * a stress run of many concurrent transport sessions.
+ *
+ * Run by test_j1939_addr.sh, see j1939_tests.h.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* fixed unicast addresses, arbitrary */
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define SA_CLAIM		0x50
+#define SA_DST			0x60
+
+/* stress session i sends from SA_STRESS_TX + i to SA_STRESS_RX + i */
+#define SA_STRESS_TX		0x40
+#define SA_STRESS_RX		0x20
+
+/* NAMEs, arbitrary but for the order of the three conflict NAMEs */
+#define NAME_TX			0x00000000c0ffee01ULL
+#define NAME_RX			0x00000000c0ffee02ULL
+/*
+ * Industry Group, NAME bits 62-60. Bit 63, Arbitrary Address Capable, stays
+ * clear.
+ */
+#define NAME_IG_SHIFT		60
+#define NAME_IG_BITS		3
+#define NAME_IG(ig)		((ig) * (1ULL << NAME_IG_SHIFT))
+/*
+ * NAME_LOWER has the lower Industry Group but the higher bottom byte, and
+ * NAME_HIGHER the reverse, so a kernel that compares byte-swapped NAMEs
+ * picks the wrong winner in the conflict tests.
+ */
+#define NAME_CLAIM		(NAME_IG(4) | 0xc0ffee40)
+#define NAME_LOWER		(NAME_IG(2) | 0xc0ffee60)	/* wins */
+#define NAME_HIGHER		(NAME_IG(5) | 0xc0ffee20)	/* loses */
+_Static_assert(((NAME_CLAIM | NAME_LOWER | NAME_HIGHER) >> NAME_IG_SHIFT) <
+	       1U << NAME_IG_BITS,
+	       "the Industry Group must fit its bits, so bit 63 stays clear");
+_Static_assert(NAME_LOWER < NAME_CLAIM && NAME_CLAIM < NAME_HIGHER,
+	       "NAME_CLAIM must lie between NAME_LOWER and NAME_HIGHER");
+_Static_assert((NAME_HIGHER & UINT8_MAX) < (NAME_CLAIM & UINT8_MAX),
+	       "a byte-swapped NAME compare must reverse the order");
+_Static_assert((NAME_CLAIM & UINT8_MAX) < (NAME_LOWER & UINT8_MAX),
+	       "a byte-swapped NAME compare must reverse the order");
+/* the data of an Address Claimed frame is the NAME */
+_Static_assert(sizeof(name_t) == CAN_MAX_DLEN, "a NAME must fill one frame");
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
+/* the stress addresses lie below all fixed ones, which all differ */
+_Static_assert(SA_STRESS_RX + STRESS_N <= SA_STRESS_TX &&
+	       SA_STRESS_TX + STRESS_N <= SA_CLAIM &&
+	       SA_CLAIM < SA_DST && SA_CLAIM < SA_TX && SA_CLAIM < SA_RX &&
+	       SA_DST != SA_TX && SA_DST != SA_RX && SA_TX != SA_RX,
+	       "test addresses overlap");
+
+/* ends of a pipe(2) fd pair */
+enum { PIPE_RD, PIPE_WR, PIPE_NUM };
+
+/* bytes of the data frames that send_data() and its *_after_claim_ok() send */
+#define SEND_DATA_LEN		CAN_MAX_DLEN
+
+/*
+ * The kernel lets a NAME use a claimed address only ACLAIM_HOLDOFF_MS after
+ * the Address Claimed frame (j1939_ecu_timer_start() in
+ * net/can/j1939/bus.c). Before that, a send from or to that NAME fails with
+ * EADDRNOTAVAIL.
+ *
+ * The first send must succeed no earlier than ACLAIM_MIN_MS and no later
+ * than ACLAIM_MAX_MS (strict: ACLAIM_STRICT_MAX_MS), in the tests that time
+ * it. A defended address must stay ours, and the contender must get none,
+ * until that latest time. ACLAIM_MARGIN_MS is a guess.
+ */
+#define ACLAIM_HOLDOFF_MS	250
+#define ACLAIM_MARGIN_MS	50
+#define ACLAIM_MIN_MS		(ACLAIM_HOLDOFF_MS - ACLAIM_MARGIN_MS)
+#define ACLAIM_MAX_MS		J1939_RECV_TIMEOUT_MS
+#define ACLAIM_STRICT_MAX_MS	(ACLAIM_HOLDOFF_MS + ACLAIM_MARGIN_MS)
+#define ACLAIM_RETRY_MS		25	/* retry interval, arbitrary */
+
+_Static_assert(ACLAIM_MARGIN_MS < ACLAIM_HOLDOFF_MS,
+	       "ACLAIM_MIN_MS must stay above zero");
+_Static_assert(ACLAIM_STRICT_MAX_MS <= ACLAIM_MAX_MS,
+	       "strict mode must not allow more than relaxed mode");
+
+static int j1939_open_name(int ifindex, name_t name, uint8_t sa, pgn_t pgn)
+{
+	return j1939_open_flags(ifindex, name, sa, pgn, J1939_OPEN_NONE);
+}
+
+/*
+ * Wait on obs until deadline for an Address Claimed frame that carries
+ * name_bytes; skip other claims. On failure errno is set, ETIMEDOUT at the
+ * deadline.
+ */
+static bool recv_claim_name_ok(int obs,
+			       const uint8_t name_bytes[sizeof(name_t)],
+			       const struct timespec *deadline)
+{
+	/* one spare byte: a longer message shows up as a wrong length */
+	uint8_t rx[sizeof(name_t) + 1];
+	const ssize_t want_len = sizeof(name_t);
+	struct timespec now;
+	long left_ms;
+	ssize_t n;
+
+	for (;;) {
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		left_ms = timespec_diff_ms(&now, deadline);
+		if (left_ms <= 0) {
+			errno = ETIMEDOUT;
+			return false;
+		}
+
+		errno = 0;
+		n = recv_timeout(obs, rx, sizeof(rx), left_ms);
+		if (n < 0) {
+			if (!errno)	/* poll() timed out */
+				errno = ETIMEDOUT;
+			return false;
+		}
+
+		if (n == want_len && !memcmp(rx, name_bytes, sizeof(name_t)))
+			return true;
+	}
+}
+
+/*
+ * Send an Address Claimed frame for (sa, name) from the raw socket, so that
+ * the kernel maps name to sa, and set *t0 to the time just before it is sent.
+ * Return once the kernel has handled it: j1939_can_recv()
+ * (net/can/j1939/main.c) runs j1939_ac_recv() before j1939_sk_recv(), so a
+ * J1939 socket that receives the claim proves it.
+ *
+ * The caller must keep another J1939 socket bound on ifindex; closing the
+ * last one would drop the mapping. On failure errno is set, ETIMEDOUT if the
+ * claim did not come back within J1939_RECV_TIMEOUT_MS.
+ */
+static bool forge_address_claim_ok(int raw, int ifindex, uint8_t sa,
+				   name_t name, struct timespec *t0)
+{
+	uint8_t name_bytes[sizeof(name_t)];
+	struct timespec deadline;
+	bool ok = false;
+	int obs, err;
+
+	obs = j1939_open_flags(ifindex, J1939_NO_NAME, J1939_NO_ADDR,
+			       J1939_PGN_ADDRESS_CLAIMED, J1939_OPEN_BCAST);
+	if (obs < 0)
+		return false;
+
+	put_name(name_bytes, name);
+	clock_gettime(CLOCK_MONOTONIC, t0);
+	deadline_after_ms(&deadline, J1939_RECV_TIMEOUT_MS);
+	if (send_raw8_ok(raw, J1939_PRIO_DEFAULT, J1939_PGN_ADDRESS_CLAIMED,
+			 J1939_NO_ADDR, sa, name_bytes))
+		ok = recv_claim_name_ok(obs, name_bytes, &deadline);
+
+	err = errno;
+	close(obs);
+	errno = err;
+	return ok;
+}
+
+static int aclaim_max_ms(void)
+{
+	return j1939_timing_ms(ACLAIM_MAX_MS, ACLAIM_STRICT_MAX_MS);
+}
+
+/*
+ * The first sendto() after an Address Claimed frame (send() if dst is NULL).
+ * t0 is the time just before the claim was sent. Retry a failed sendto()
+ * every ACLAIM_RETRY_MS until aclaim_max_ms() after t0. Sets *elapsed_ms to
+ * the time from t0 to the end of the last try.
+ *
+ * Returns true if a send succeeded in time. On false, errno is ETIMEDOUT if
+ * the send succeeded too late (the data was sent), EIO if it sent only part
+ * of the data, else the errno of sendto().
+ */
+static bool send_after_claim_ok(int s, const void *buf, size_t len,
+				const struct sockaddr_can *dst,
+				const struct timespec *t0, long *elapsed_ms)
+{
+	int max_ms = aclaim_max_ms();
+	/* a NULL dst with length 0 makes sendto() act as send() */
+	socklen_t dst_len = dst ? sizeof(*dst) : 0;
+	ssize_t want_len = len, ret;
+	struct timespec now;
+
+	for (;;) {
+		ret = sendto(s, buf, len, 0, (const struct sockaddr *)dst,
+			     dst_len);
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		*elapsed_ms = timespec_diff_ms(t0, &now);
+
+		if (ret >= 0 && ret != want_len) {
+			errno = EIO;
+			return false;
+		}
+		if (*elapsed_ms > max_ms) {
+			if (ret == want_len)
+				errno = ETIMEDOUT;
+			return false;
+		}
+		if (ret == want_len)
+			return true;
+		usleep(ACLAIM_RETRY_MS * USEC_PER_MSEC);
+	}
+}
+
+/*
+ * Check that every sendto() to dst fails with EADDRNOTAVAIL, tried every
+ * ACLAIM_RETRY_MS until aclaim_max_ms() after t0, the latest time a claim may
+ * take effect. One try could hide a claim that the kernel applies late. On
+ * false, errno is that of the last sendto(), or 0 if it succeeded.
+ */
+static bool send_refused_ok(int s, const void *buf, size_t len,
+			    const struct sockaddr_can *dst,
+			    const struct timespec *t0)
+{
+	int max_ms = aclaim_max_ms();
+	struct timespec now;
+
+	for (;;) {
+		if (j1939_sendto_addr(s, buf, len, dst) >= 0) {
+			errno = 0;
+			return false;
+		}
+		if (errno != EADDRNOTAVAIL)
+			return false;
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		if (timespec_diff_ms(t0, &now) > max_ms)
+			return true;
+		usleep(ACLAIM_RETRY_MS * USEC_PER_MSEC);
+	}
+}
+
+/*
+ * One TP round-trip. The payload depends on sa_tx, so a receiver that gets the
+ * data of another session fails. After the setup, write one byte to ready,
+ * close it and wait until the parent closes go, so that all sessions start
+ * together.
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
+	int rx;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_addr)
+{
+	self->tx = -1;
+	self->rx = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+}
+
+FIXTURE_TEARDOWN(j1939_addr)
+{
+	if (self->tx >= 0)
+		close(self->tx);
+	if (self->rx >= 0)
+		close(self->rx);
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
+	self->raw = open_raw(self->ifindex);
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
+/*
+ * NAME based addressing reaches the socket bound to that NAME.
+ *
+ * The peer must have claimed its address before it is reachable by NAME, so
+ * inject an Address Claimed message for (SA_RX, NAME_RX) first. The sender
+ * uses a static source address and resolves the destination by NAME.
+ */
+TEST_F(j1939_addr, name_addressing)
+{
+	uint8_t tx_buf[CAN_MAX_DLEN];
+	struct timespec t0;
+	long elapsed_ms;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	/*
+	 * Bind the receiver to NAME_RX and no address, so it gets the frame
+	 * only if the kernel matches the destination NAME. The forged claim
+	 * maps NAME_RX -> SA_RX.
+	 */
+	self->rx = j1939_open_name(self->ifindex, NAME_RX, J1939_NO_ADDR,
+				   PGN_TEST);
+	ASSERT_GE(self->rx, 0);
+
+	self->raw = open_raw(self->ifindex);
+	ASSERT_GE(self->raw, 0);
+
+	ASSERT_TRUE(forge_address_claim_ok(self->raw, self->ifindex, SA_RX,
+					   NAME_RX, &t0))
+		TH_LOG("failed to inject address claim: %d", errno);
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_TRUE(j1939_connect_name_ok(self->tx, self->ifindex, NAME_RX,
+					  J1939_NO_ADDR, PGN_TEST))
+		TH_LOG("connect to peer NAME failed: %d", errno);
+
+	ASSERT_TRUE(send_after_claim_ok(self->tx, tx_buf, sizeof(tx_buf), NULL,
+					&t0, &elapsed_ms))
+		TH_LOG("send to peer NAME failed after %ld ms: %s",
+		       elapsed_ms, strerror(errno));
+	/* but not before the kernel's hold-off after the claim */
+	EXPECT_GE(elapsed_ms, ACLAIM_MIN_MS)
+		TH_LOG("peer NAME reachable after only %ld ms", elapsed_ms);
+
+	EXPECT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				   J1939_RECV_TIMEOUT_MS));
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
+/*
+ * Claim an address the way j1939acd would: bind a NAME to an address and send
+ * an Address Claimed message. Returns the (still open) socket on success, and
+ * in *t0 the time just before the claim was sent.
+ */
+static int claim_addr(int ifindex, name_t name, uint8_t sa,
+		      struct timespec *t0)
+{
+	uint8_t name_bytes[sizeof(name_t)];
+	int s;
+
+	s = j1939_open_flags(ifindex, name, sa, J1939_NO_PGN, J1939_OPEN_BCAST);
+	if (s < 0)
+		return -1;
+
+	put_name(name_bytes, name);
+	clock_gettime(CLOCK_MONOTONIC, t0);
+	if (!j1939_sendto_ok(s, name_bytes, sizeof(name_bytes), ifindex,
+			     J1939_NO_NAME, J1939_NO_ADDR,
+			     J1939_PGN_ADDRESS_CLAIMED)) {
+		close(s);
+		return -1;
+	}
+
+	return s;
+}
+
+/* The destination of the data frames, PGN_TEST to SA_DST. */
+static void fill_data_dst(struct sockaddr_can *dst, int ifindex)
+{
+	j1939_fill_sockaddr(dst, ifindex, J1939_NO_NAME, SA_DST, PGN_TEST);
+}
+
+static ssize_t send_data(int s, int ifindex)
+{
+	uint8_t data[SEND_DATA_LEN] = {};
+	struct sockaddr_can dst;
+
+	fill_data_dst(&dst, ifindex);
+	return j1939_sendto_addr(s, data, sizeof(data), &dst);
+}
+
+/* send_data(), as the first send after a claim; see send_after_claim_ok() */
+static bool send_data_after_claim_ok(int s, int ifindex,
+				     const struct timespec *t0,
+				     long *elapsed_ms)
+{
+	uint8_t data[SEND_DATA_LEN] = {};
+	struct sockaddr_can dst;
+
+	fill_data_dst(&dst, ifindex);
+	return send_after_claim_ok(s, data, sizeof(data), &dst, t0, elapsed_ms);
+}
+
+/*
+ * claim_addr() sends with the default priority to the global address, from
+ * the address in *ctx (a uint8_t).
+ */
+static bool match_addr_claimed(canid_t id, const void *ctx)
+{
+	const uint8_t *sa = ctx;
+
+	return j1939_id_prio(id) == J1939_PRIO_DEFAULT &&
+	       j1939_id_pf(id) == J1939_PF(J1939_PGN_ADDRESS_CLAIMED) &&
+	       j1939_id_ps(id) == J1939_NO_ADDR &&
+	       j1939_id_sa(id) == *sa;
+}
+
+/* Sending an Address Claimed message puts it on the wire and claims. */
+TEST_F(j1939_addr, address_claim_send)
+{
+	uint8_t name_bytes[sizeof(name_t)];
+	const uint8_t claim_sa = SA_CLAIM;
+	struct can_frame frame;
+	struct timespec t0;
+	long elapsed_ms;
+
+	put_name(name_bytes, NAME_CLAIM);
+
+	self->raw = open_raw(self->ifindex);
+	ASSERT_GE(self->raw, 0);
+
+	self->tx = claim_addr(self->ifindex, NAME_CLAIM, SA_CLAIM, &t0);
+	ASSERT_GE(self->tx, 0)
+		TH_LOG("address claim failed: %d", errno);
+
+	ASSERT_TRUE(recv_match_ok(self->raw, J1939_RECV_TIMEOUT_MS, &frame,
+				  match_addr_claimed, &claim_sa))
+		TH_LOG("no Address Claimed frame seen on the wire");
+	EXPECT_EQ(frame.can_dlc, sizeof(name_bytes));
+	EXPECT_EQ(memcmp(frame.data, name_bytes, sizeof(name_bytes)), 0)
+		TH_LOG("Address Claimed frame does not carry NAME_CLAIM");
+
+	EXPECT_TRUE(send_data_after_claim_ok(self->tx, self->ifindex, &t0,
+					     &elapsed_ms))
+		TH_LOG("transmit from claimed address failed after %ld ms: %s",
+		       elapsed_ms, strerror(errno));
+	/* but not before the kernel's hold-off after the claim */
+	EXPECT_GE(elapsed_ms, ACLAIM_MIN_MS)
+		TH_LOG("claimed address usable after only %ld ms", elapsed_ms);
+}
+
+/*
+ * Claim SA_CLAIM with NAME_CLAIM and check that we can send, then forge a claim
+ * for SA_CLAIM with the @contender NAME, sent at *forge_t0. Store the result
+ * of the next send in *tx_ret, with errno as that send set it. Returns false
+ * if a setup step failed.
+ */
+static bool ac_conflict_probe_ok(FIXTURE_DATA(j1939_addr) *self,
+				 name_t contender, ssize_t *tx_ret,
+				 struct timespec *forge_t0)
+{
+	struct timespec t0;
+	long elapsed_ms;
+
+	self->raw = open_raw(self->ifindex);
+	if (self->raw < 0)
+		return false;
+	self->tx = claim_addr(self->ifindex, NAME_CLAIM, SA_CLAIM, &t0);
+	if (self->tx < 0)
+		return false;
+
+	/* baseline: we own the address and can transmit */
+	if (!send_data_after_claim_ok(self->tx, self->ifindex, &t0,
+				      &elapsed_ms))
+		return false;
+
+	if (!forge_address_claim_ok(self->raw, self->ifindex, SA_CLAIM,
+				    contender, forge_t0))
+		return false;
+
+	/*
+	 * One plain send, no retry: the kernel has already handled the
+	 * contending claim (see forge_address_claim_ok()), so the result must
+	 * be final now. A retry could hide a wrong first result.
+	 */
+	*tx_ret = send_data(self->tx, self->ifindex);
+	return true;
+}
+
+/* A higher-priority competing claim takes the address away from us. */
+TEST_F(j1939_addr, ac_conflict_lose)
+{
+	uint8_t data[SEND_DATA_LEN] = {};
+	struct sockaddr_can winner;
+	struct timespec forge_t0;
+	long elapsed_ms;
+	ssize_t tx_ret;
+
+	ASSERT_TRUE(ac_conflict_probe_ok(self, NAME_LOWER, &tx_ret,
+					 &forge_t0));
+
+	EXPECT_LT(tx_ret, 0)
+		TH_LOG("transmit still succeeded after losing the address");
+	EXPECT_EQ(errno, EADDRNOTAVAIL);
+
+	/*
+	 * Keep the sockets open until the kernel maps NAME_LOWER at the end
+	 * of its hold-off. If the last socket closes while that timer is
+	 * pending, the kernel keeps a reference to the interface and
+	 * deleting it hangs.
+	 */
+	self->rx = j1939_open(self->ifindex, SA_RX, J1939_NO_PGN);
+	ASSERT_GE(self->rx, 0);
+	j1939_fill_sockaddr(&winner, self->ifindex, NAME_LOWER, J1939_NO_ADDR,
+			    PGN_TEST);
+	EXPECT_TRUE(send_after_claim_ok(self->rx, data, sizeof(data), &winner,
+					&forge_t0, &elapsed_ms))
+		TH_LOG("send to NAME_LOWER failed after %ld ms: %s",
+		       elapsed_ms, strerror(errno));
+}
+
+/* A lower-priority competing claim does not take our address. */
+TEST_F(j1939_addr, ac_conflict_defend)
+{
+	uint8_t data[SEND_DATA_LEN] = {};
+	struct sockaddr_can loser;
+	struct timespec forge_t0;
+	ssize_t tx_ret;
+
+	ASSERT_TRUE(ac_conflict_probe_ok(self, NAME_HIGHER, &tx_ret,
+					 &forge_t0));
+
+	EXPECT_EQ(tx_ret, SEND_DATA_LEN)
+		TH_LOG("lost the address to a lower-priority claim");
+
+	self->rx = j1939_open(self->ifindex, SA_RX, J1939_NO_PGN);
+	ASSERT_GE(self->rx, 0);
+	j1939_fill_sockaddr(&loser, self->ifindex, NAME_HIGHER, J1939_NO_ADDR,
+			    PGN_TEST);
+	EXPECT_TRUE(send_refused_ok(self->rx, data, sizeof(data), &loser,
+				    &forge_t0))
+		TH_LOG("no EADDRNOTAVAIL for the lower-priority NAME: %s",
+		       errno ? strerror(errno) : "it was sent");
+
+	EXPECT_EQ(send_data(self->tx, self->ifindex), SEND_DATA_LEN)
+		TH_LOG("lost the address later to a lower-priority claim");
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv);
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

