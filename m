Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795869655;
	b=0W63UWzmePBSmNuzYv/RUq+hEkCbMdmVmhBQOvN3CcJAf4zYfh2Q+FZ6rTB3xMqmBcrO
	 0l7TWTUUp/C46nOarkXd/yZbhaNz7UItpiucAc8CS7bwpIacOW0sKMPMcrDU0M+i9UuK1
	 hwI/rsRXq1ul67HZ/6aqKSWyFLg5PprOSr2R/HRzQwuAw76yhxoeWRfvJJ2CFuJUEksKM
	 FH0ePF+rtWJwHUAvT78Cba9hzHd16PnLywQHYKtmWdjWCAYWOjPdzYI/t8c4Da4SRii0i
	 uflNqmk9PX1PCQe7neu23FrLFdRljtXkVI7+HckXRdhmFsf4t9LrEjTLU7dUADA3I8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869655;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=vfFiO+/YZdKveCB73DVeQ47eqpX9l8T0lrHMDJudGcA=;
	b=UGGfAMXhgJuXnF52Dn7ZzuR897GmGBX3p6NgqZRCmXMFVAlz1MCTHoxfrvy9JS0m9AsX
	 yj0Cvzk10EvHql/VJxFpf0qEei6FqcHxoED/LSZg0DCcNXmfVBjpOg3XWXebwJbdzJG9G
	 BxmvxyeNI1g6HL6yhCod7GHc8rNmSrvZSWzSxrWUv6Oohyag7U9gnS6UAFx/DC9tdzQdA
	 4MTX4bDc+HtL4mNN9zCRhh+vHGihcqfrkOXD/gRKIef58xlgG7jmVuj8uzebpFdmvFyTK
	 J5RPRM7Y8JOEvrlkMZJ7E9PnS2SdcDzva6ONJS+N/O+PTTLOVdbnr73l8wx0dPeXhAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="WiPJHP/M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D3606A31C;
	Sat, 28 Nov 2026 12:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE5D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WiPJHP/M
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ADC48205A51;
	Sat, 28 Nov 2026 13:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfFiO+/YZdKveCB73DVeQ47eqpX9l8T0lrHMDJudGcA=;
	b=WiPJHP/MnmfrBO4v8uCS1SiRME2/5YeV5VWnalLkgApUgEWDE5tV7x2dz6D0mkCBsZ5hQ0
	1NDoYV+4j88W3pmVWOgq2NuanLDnewz6qIZwkSrGiIdcvrl5g/AnjOSEgSzlzqufPF22Ax
	TJrQdsJnGbDUePJTlN72UWD0NuOE4rAtyTHe5FX3MZRhIukluRAEz84sljaKxYGdNCzxDm
	UoCfmyb9IK/XEOfKnEpH5JiYNn/92RmbXGr0FPx8ORcP89gLzsuKGXqrX1P8Hm+rodPbxU
	z+JIpE5dwy8tP3UKnJ21BdTnM9SOdtWVtOUaY9j1bzampme+gku74N46wIsbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795869644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfFiO+/YZdKveCB73DVeQ47eqpX9l8T0lrHMDJudGcA=;
	b=Dn2SCYlcqhQaTC8A08jtpHmQK8DJDgwUlgSX4ZBLZp/wagpCwO2Ioj6D23Zxn8JZ0DtXMi
	7QgMa//TmfuF6L1q8V3RSUgXK3LDfaXEgUes7XbacbkivI2T5HLDawpbN7agaRpVWbTFl2
	ViV+9INQRU9jux5pN+Q5/INxPBXQl9fN/HHweSPg0cg3xPvsRPbjMe3nIQItmShaMYZjd+
	vG7U9obwjirspo7Xgzatw1/sU8gr9bDRM6y7bDzTZCqQvXgqqsRV1J3WZal7J2WG7RgyP1
	0IFbIOP2T+GutQ+cR+IsYCtX0ksRLDf1cbtm8hyaSKV7AUGL/lm75pfLQqT6aw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795869644; a=rsa-sha256;
	cv=none;
	b=TR0j3x91KQ+fTxWbD6hUiptJy3dAFmG2QMMSOQ/3iclJfF+cpACglAt7cGA496SzCdoite
	rtsHxSfmsIjjQjzB0cbqj2WzeKlYw1cfHUE+AcSpoNi36ayu1jh/77nGrPCNckb7ZcWw8Y
	jXVyxvKLYpZ6zZhSdvcyHAzvN+pGnEKyh1PQRXZ83ZeGUZCKnDCxPffSTnuBP2XDIEosvg
	tlFfOuDLfpqxguz9Czi0tULF7KI4MAh4Q3FuJsgNPrOfUNhKpfDiI4OZFhG0DisAl1QVaJ
	EzFlg6QYp62GM78lJ9V8furpMqiFLDWWci/+DAcvWSusizzHSs0LWUVFkb/PDg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 91128380C95; Sat, 28 Nov 2026 13:40:44 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Sat, 28 Nov 2026 13:40:43 +0100
Subject: [PATCH can-next v6 2/9] selftests: can: add J1939 test helper
 header and library
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
Message-Id: <20261128-j1939-selftests-v6-2-a9dc9140dee6@pengutronix.de>
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

Add code shared by the later J1939 selftests. j1939_helpers.h and
j1939_helpers.c hold the C helpers for socket setup, timed receive and
CAN id encoding. They also hold the helpers for TP and ETP frames. Only
the multi-frame tests build those frames. j1939_tests.h holds the parts
that use the kselftest harness: the fixture setup macros and
j1939_test_main(). j1939_lib.sh holds the vcan setup and cleanup and the
test runner. A wrapper sources j1939_lib.sh and runs the test binary of
the same name.

j1939_lib.sh runs the tests only on vcan interfaces that it creates
itself. The tests that follow send frames as other nodes, so they must
not run on a real CAN bus.

By default the CAN_RAW peer gets its own vcan. The new j1939_gw sets up
CAN gateway rules that route frames between that vcan and the vcan of
the J1939 sockets. On one shared interface, the peer can read a frame
before the stack has handled the echo of that frame. A quick reply from
the peer then cancels a transport session. Behind the gateway, with RPS
turned off on the peer's vcan, the peer sees the frame only after the
stack has handled its echo. If RPS cannot be turned off, j1939_lib.sh
warns. J1939_SHARED_IF=1 runs the tests on one interface, with a
warning.

open_raw_rcvbuf() pins the test thread to the CPU it runs on. On
PREEMPT_RT, when a tool moved the test between CPUs while other tasks
sent CAN frames, a CAN_RAW reader on the J1939 interface saw the peer's
frames out of order. The peer's frames enter the stack through
netif_rx(), which keeps the order only per CPU. If the pinning fails,
the test warns and runs unpinned.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): why does config not enable CAN_J1939, CAN_RAW and CAN_GW
in this patch?
A: No test uses the library yet. Patch 3 adds the first test and these
options with it.

Q (sashiko): can the peer's frames reach the stack out of order?
A: On PREEMPT_RT, yes. In a PREEMPT_RT QEMU guest, the ETP receive test
of patch 7 failed in 73 to 78 of 100 runs when a tool moved the test
between CPUs while other tasks sent CAN frames. A CAN_RAW reader on the
J1939 interface saw the same frames out of order, so the order was lost
before J1939. Without the CPU moves, and on non-RT kernels, no run
failed. The tool sets the CPU affinity itself, so the pin was not tested
under its CPU moves.

Q: why pin in open_raw_rcvbuf() and not for the whole test program?
A: A pin for the whole program would also bind the concurrency stress
test of patch 5, which opens no peer and should run on all CPUs. Each
test runs in its own child process, so the pin ends with the test.

Q: why does a j1939_gw that cannot run fail the test, but one that
exits with an error only skips it?
A: The Makefile builds j1939_gw with the tests, so if it cannot run,
the build is broken. It exits with an error when it cannot add the
rules, for example without can-gw in the kernel.

Q: can timespec_diff_ms() overflow on 32-bit, where long is 32 bits?
A: No. A static assert checks that NSEC_PER_SEC and NSEC_PER_MSEC are
long long, so timespec_diff_ms() multiplies in long long. The result in
ms fits a long.

Changes in v6:
- pin a test to one CPU when it opens the CAN_RAW peer, against the
  reordering of the peer's frames on PREEMPT_RT (sashiko)
- make the helpers that only j1939_helpers.c uses static and drop them
  from the header; drop the local ARRAY_SIZE()
- add J1939_NEEDS_NONE; J1939_NEEDS_RAW is a #define now
- j1939_tests.h includes kselftest_harness.h
- shorten the C warnings, so each format string fits on its print line
- j1939_gw: print the netlink socket error with the program name
- j1939_lib.sh: add j1939_skip() and rps_off(); test the exit status
  with [ ]; fail, not skip, when j1939_gw cannot run or crashes
- move the timespec_diff_ms() static assert to j1939_helpers.c
- fix comments that no longer matched the code
- coding style: declaration order, braces, prototype wrapping, sorted
  includes, blank lines; split the loop condition in recv_match_ok()

Changes in v5:
- j1939_lib.sh: turn RPS off on the peer's vcan, or warn if that fails;
  with RPS off, the peer sees a frame after its echo is handled (sashiko)
- drop put_name(); its only user, the address-claim tests, is gone
- no test forges Address Claims any more; drop that from the text

Changes in v4:
- put the CAN_RAW peer on its own vcan behind the CAN gateway, set up by
  the new j1939_gw (sashiko)
- J1939_SHARED_IF=1 keeps the peer on CANIF, with a warning
- load can-gw, and skip with a hint if the gateway cannot be set up
- J1939_NO_PEER=1 in a wrapper sets up no peer vcan and no gateway; a
  test that passes J1939_NEEDS_RAW then fails at start
- bind open_raw() and open_raw_rcvbuf() to CANIF_RAW and drop their
  ifindex argument; they fail unless the test passed J1939_NEEDS_RAW
- skip for missing CAN_RAW support only if the test passes
  J1939_NEEDS_RAW to j1939_test_main() (sashiko, Chaosheng Qu)
- cite the section that gives the Data Page bit position

Changes in v3:
- say which protocol is missing before skipping (sashiko)
- say in the J1939_RECV_TIMEOUT_MS comment that it covers whole messages
  too
- say whether CANIF already exists or cannot be created
- add static asserts for the type of NSEC_PER_SEC and NSEC_PER_MSEC and
  for the control-frame layout
- fix comments that did not match the code
- do not repeat the test name in the SKIP line
- move the helper code from the header to j1939_helpers.c and
  j1939_helpers.h; j1939_tests.h keeps the parts that use the harness

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- replace the J1939_TEST_MAIN() macro with j1939_test_main(), called
  from a small main() in each test
- fix a -Wstringop-truncation warning in j1939_if_index()
- add a relaxed (default) and a strict (J1939_STRICT_TIMING) timing mode
- skip, not fail, when the kernel lacks CAN_RAW (sashiko)
- name all constants and add static asserts for dependent values
- return bool from success/failure helpers named *_ok(), avoid casts
- receive into a buffer one byte longer than expected, so that a longer
  message fails the check (sashiko)
- j1939_lib.sh: run only on a vcan it creates, drop the real CAN path
  (sashiko)
- j1939_lib.sh: trap only EXIT (sashiko)
- j1939_lib.sh: run the test binary from the script directory
- j1939_lib.sh: fix the shellcheck warnings
- j1939_lib.sh: take the test binary name from the wrapper name, and say
  why the setup is skipped
---
 tools/testing/selftests/net/can/.gitignore      |   1 +
 tools/testing/selftests/net/can/Makefile        |   4 +
 tools/testing/selftests/net/can/j1939_gw.c      | 128 ++++++
 tools/testing/selftests/net/can/j1939_helpers.c | 516 ++++++++++++++++++++++++
 tools/testing/selftests/net/can/j1939_helpers.h | 284 +++++++++++++
 tools/testing/selftests/net/can/j1939_lib.sh    | 171 ++++++++
 tools/testing/selftests/net/can/j1939_tests.h   |  99 +++++
 7 files changed, 1203 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc837f7dca4f2b0c03d1dc0c1b30c57671..30cd8b40d0f885fdf8c3855d231c9d3ec7c7c112 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+j1939_gw
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 3adaa13dcbfa303c4be2bb6a9b5dbdac76d68260..7f16586006104652c9872008d3eec860416486ed 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -6,8 +6,12 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := test_raw_filter.sh
 
+TEST_FILES := j1939_lib.sh
+
 TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
 TEST_GEN_FILES := test_raw_filter
+# sets up the CAN gateway for j1939_lib.sh
+TEST_GEN_FILES += j1939_gw
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/j1939_gw.c b/tools/testing/selftests/net/can/j1939_gw.c
new file mode 100644
index 0000000000000000000000000000000000000000..bfcfe852b5ee9c75913c4854fa2ce718bee5fac2
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_gw.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Add CAN gateway (CONFIG_CAN_GW) rules that route frames both ways between
+ * two interfaces. j1939_lib.sh uses this because iproute2 cannot set up these
+ * rules. The kernel removes a rule when its interface is deleted.
+ *
+ * Usage: j1939_gw IF_A IF_B
+ */
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <net/if.h>
+#include <sys/socket.h>
+
+#include <linux/can.h>
+#include <linux/can/gw.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+/* an RTM_NEWROUTE request for a CAN->CAN rule, see net/can/gw.c */
+struct cgw_req {
+	struct nlmsghdr nh;
+	struct rtcanmsg rtcan;
+	struct rtattr src_attr;
+	__u32 src_ifindex;
+	struct rtattr dst_attr;
+	__u32 dst_ifindex;
+};
+
+struct cgw_ack {
+	struct nlmsghdr nh;
+	struct nlmsgerr err;
+};
+
+_Static_assert(offsetof(struct cgw_req, src_attr) ==
+	       NLMSG_SPACE(sizeof(struct rtcanmsg)),
+	       "the attributes must follow the aligned rtcanmsg");
+_Static_assert(offsetof(struct cgw_req, dst_attr) ==
+	       offsetof(struct cgw_req, src_attr) + RTA_SPACE(sizeof(__u32)),
+	       "the attributes must be packed as netlink aligns them");
+
+/* Add a rule from src to dst; return 0 or a negative errno. */
+static int cgw_add(int nl, unsigned int src, unsigned int dst)
+{
+	struct cgw_req req = {
+		.nh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = RTM_NEWROUTE,
+			.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		},
+		.rtcan = {
+			.can_family = AF_CAN,
+			.gwtype = CGW_TYPE_CAN_CAN,
+			/*
+			 * a vcan has no bus, so only the echo reaches the
+			 * sockets on dst
+			 */
+			.flags = CGW_FLAGS_CAN_ECHO,
+		},
+		.src_attr = {
+			.rta_len = RTA_LENGTH(sizeof(req.src_ifindex)),
+			.rta_type = CGW_SRC_IF,
+		},
+		.src_ifindex = src,
+		.dst_attr = {
+			.rta_len = RTA_LENGTH(sizeof(req.dst_ifindex)),
+			.rta_type = CGW_DST_IF,
+		},
+		.dst_ifindex = dst,
+	};
+	struct cgw_ack ack;
+
+	if (send(nl, &req, sizeof(req), 0) < 0)
+		return -errno;
+	if (recv(nl, &ack, sizeof(ack), 0) < 0)
+		return -errno;
+
+	if (ack.nh.nlmsg_type != NLMSG_ERROR)
+		return -EPROTO;
+	return ack.err.error;
+}
+
+enum {
+	ARG_IF_A = 1,
+	ARG_IF_B,
+	ARG_COUNT	/* argc, including argv[0] */
+};
+
+int main(int argc, char **argv)
+{
+	unsigned int if_a, if_b;
+	int nl, ret;
+
+	if (argc != ARG_COUNT) {
+		fprintf(stderr, "usage: %s IF_A IF_B\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	if_a = if_nametoindex(argv[ARG_IF_A]);
+	if_b = if_nametoindex(argv[ARG_IF_B]);
+	if (!if_a || !if_b) {
+		fprintf(stderr, "%s: unknown interface\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	nl = socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (nl < 0) {
+		fprintf(stderr, "%s: netlink socket: %s\n", argv[0],
+			strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	ret = cgw_add(nl, if_a, if_b);
+	if (!ret)
+		ret = cgw_add(nl, if_b, if_a);
+
+	close(nl);
+	if (ret) {
+		fprintf(stderr, "%s: cannot add CAN gateway rule: %s\n",
+			argv[0], strerror(-ret));
+		return EXIT_FAILURE;
+	}
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/net/can/j1939_helpers.c b/tools/testing/selftests/net/can/j1939_helpers.c
new file mode 100644
index 0000000000000000000000000000000000000000..5aefd0e61a54b316508a68c045a7ab84bc3fdd90
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_helpers.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/* Code of the shared J1939 selftest helpers, see j1939_helpers.h. */
+#include <sched.h>
+#include <sys/ioctl.h>
+
+#include "j1939_helpers.h"
+
+char CANIF[IFNAMSIZ];
+char CANIF_RAW[IFNAMSIZ];
+bool j1939_needs_raw;
+
+int j1939_id_prio(canid_t id)
+{
+	return (id >> J1939_ID_PRIO_SHIFT) & J1939_ID_PRIO_MASK;
+}
+
+int j1939_id_pgn(canid_t id)
+{
+	return (id >> J1939_ID_PGN_SHIFT) & J1939_PGN_MAX;
+}
+
+static int j1939_id_pf(canid_t id)
+{
+	return J1939_PF(j1939_id_pgn(id));
+}
+
+int j1939_id_ps(canid_t id)
+{
+	return j1939_id_pgn(id) & UINT8_MAX;
+}
+
+int j1939_id_sa(canid_t id)
+{
+	return id & UINT8_MAX;
+}
+
+bool j1939_is_data_frame(canid_t can_id)
+{
+	return (can_id & (CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_ERR_FLAG)) ==
+	       CAN_EFF_FLAG;
+}
+
+/* Pin the calling thread to the CPU it runs on; any one CPU keeps the order. */
+static bool j1939_pin_cpu_ok(void)
+{
+	cpu_set_t set;
+	int cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0)
+		return false;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	return !sched_setaffinity(0, sizeof(set), &set);
+}
+
+int j1939_timing_ms(int relaxed_ms, int strict_ms)
+{
+	return getenv("J1939_STRICT_TIMING") ? strict_ms : relaxed_ms;
+}
+
+static int if_index(const char *ifname)
+{
+	struct ifreq ifr = {};
+	int idx = -1;
+	int s;
+
+	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	if (s < 0)
+		return -1;
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
+	if (!ioctl(s, SIOCGIFINDEX, &ifr))
+		idx = ifr.ifr_ifindex;
+	close(s);
+	return idx;
+}
+
+int j1939_if_index(void)
+{
+	return if_index(CANIF);
+}
+
+/* Fill a sockaddr_can with the J1939 address (name, addr, pgn). */
+static void j1939_fill_sockaddr(struct sockaddr_can *out, int ifindex,
+				name_t name, uint8_t addr, pgn_t pgn)
+{
+	memset(out, 0, sizeof(*out));
+	out->can_family = AF_CAN;
+	out->can_ifindex = ifindex;
+	out->can_addr.j1939.name = name;
+	out->can_addr.j1939.addr = addr;
+	out->can_addr.j1939.pgn = pgn;
+}
+
+int j1939_open_flags(int ifindex, name_t name, uint8_t sa, pgn_t pgn, int flags)
+{
+	struct sockaddr_can addr;
+	int one = 1;
+	int s;
+
+	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	if (s < 0)
+		return -1;
+
+	if ((flags & J1939_OPEN_BCAST) &&
+	    setsockopt(s, SOL_SOCKET, SO_BROADCAST, &one, sizeof(one))) {
+		close(s);
+		return -1;
+	}
+
+	j1939_fill_sockaddr(&addr, ifindex, name, sa, pgn);
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+int j1939_open(int ifindex, uint8_t sa, pgn_t pgn)
+{
+	return j1939_open_flags(ifindex, J1939_NO_NAME, sa, pgn,
+				J1939_OPEN_NONE);
+}
+
+/* Connect a J1939 socket to the peer (name, da, pgn). */
+static bool j1939_connect_name_ok(int s, int ifindex, name_t name, uint8_t da,
+				  pgn_t pgn)
+{
+	struct sockaddr_can addr;
+
+	j1939_fill_sockaddr(&addr, ifindex, name, da, pgn);
+	return !connect(s, (struct sockaddr *)&addr, sizeof(addr));
+}
+
+bool j1939_connect_ok(int s, int ifindex, uint8_t da, pgn_t pgn)
+{
+	return j1939_connect_name_ok(s, ifindex, J1939_NO_NAME, da, pgn);
+}
+
+/* sendto() len bytes from buf to the J1939 destination dst. */
+static ssize_t j1939_sendto_addr(int s, const void *buf, size_t len,
+				 const struct sockaddr_can *dst)
+{
+	return sendto(s, buf, len, 0, (const struct sockaddr *)dst,
+		      sizeof(*dst));
+}
+
+/* sendto() len bytes from buf to the J1939 (name, da, pgn) destination. */
+static ssize_t j1939_sendto(int s, const void *buf, size_t len, int ifindex,
+			    name_t name, uint8_t da, pgn_t pgn)
+{
+	struct sockaddr_can dst;
+
+	j1939_fill_sockaddr(&dst, ifindex, name, da, pgn);
+	return j1939_sendto_addr(s, buf, len, &dst);
+}
+
+bool j1939_sendto_ok(int s, const void *buf, size_t len, int ifindex,
+		     name_t name, uint8_t da, pgn_t pgn)
+{
+	ssize_t want_len = len;
+
+	return j1939_sendto(s, buf, len, ifindex, name, da, pgn) == want_len;
+}
+
+bool send_all_ok(int s, const void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return send(s, buf, len, 0) == want_len;
+}
+
+bool write_all_ok(int fd, const void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return write(fd, buf, len) == want_len;
+}
+
+bool read_all_ok(int fd, void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return read(fd, buf, len) == want_len;
+}
+
+int open_raw_rcvbuf(int rcvbuf)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+	};
+	int s;
+
+	if (!j1939_needs_raw) {
+		fprintf(stderr, "# %s: the test did not pass J1939_NEEDS_RAW\n",
+			__func__);
+		errno = EINVAL;
+		return -1;
+	}
+
+	/*
+	 * On PREEMPT_RT, CPU moves under CAN load reordered the peer's frames;
+	 * netif_rx() keeps the order only per CPU.
+	 */
+	if (!j1939_pin_cpu_ok()) {
+		fprintf(stderr, "# %s: cannot pin to one CPU: %d\n", __func__,
+			errno);
+	}
+
+	addr.can_ifindex = if_index(CANIF_RAW);
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+
+	if (rcvbuf != J1939_RAW_RCVBUF_DEFAULT &&
+	    setsockopt(s, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf,
+		       sizeof(rcvbuf))) {
+		fprintf(stderr, "# %s: SO_RCVBUFFORCE(%d) failed: %d\n",
+			__func__, rcvbuf, errno);
+	}
+
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+int open_raw(void)
+{
+	return open_raw_rcvbuf(J1939_RAW_RCVBUF_DEFAULT);
+}
+
+/* poll() + recv(): returns the recv() result, or -1 on timeout/error. */
+static ssize_t recv_timeout(int s, void *buf, size_t len, int timeout_ms)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+
+	if (poll(&pfd, 1, timeout_ms) <= 0)
+		return -1;
+	return recv(s, buf, len, 0);
+}
+
+bool recvfrom_verify_ok(int s, const void *want, size_t len, int timeout_ms,
+			struct sockaddr_can *src)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+	socklen_t src_len = sizeof(*src);
+	ssize_t want_len = len;
+	uint8_t *rx_buf;
+	ssize_t n = -1;
+	size_t rx_len;
+	bool ok;
+
+	rx_len = len + 1;
+	rx_buf = malloc(rx_len);
+	if (!rx_buf)
+		return false;
+
+	if (poll(&pfd, 1, timeout_ms) > 0) {
+		n = recvfrom(s, rx_buf, rx_len, 0, (struct sockaddr *)src,
+			     &src_len);
+	}
+	ok = n == want_len && !memcmp(want, rx_buf, len);
+
+	free(rx_buf);
+	return ok;
+}
+
+bool recv_verify_ok(int s, const void *want, size_t len, int timeout_ms)
+{
+	return recvfrom_verify_ok(s, want, len, timeout_ms, NULL);
+}
+
+bool send_recv_verify_ok(int tx, int rx, const void *buf, size_t len,
+			 int timeout_ms)
+{
+	if (!send_all_ok(tx, buf, len))
+		return false;
+	return recv_verify_ok(rx, buf, len, timeout_ms);
+}
+
+bool recv_frame_ok(int raw, struct can_frame *frame, int timeout_ms)
+{
+	ssize_t want_len = sizeof(*frame);
+
+	return recv_timeout(raw, frame, sizeof(*frame), timeout_ms) == want_len;
+}
+
+/*
+ * Build the 29-bit CAN id of a J1939 frame. prio must fit in
+ * J1939_ID_PRIO_BITS, and the PS byte of a PDU1 pgn must be 0.
+ */
+static canid_t j1939_canid(uint8_t prio, pgn_t pgn, uint8_t da, uint8_t sa)
+{
+	canid_t id;
+
+	id = CAN_EFF_FLAG | (prio << J1939_ID_PRIO_SHIFT) |
+	     (pgn << J1939_ID_PGN_SHIFT) | sa;
+
+	/* PDU1: the destination goes into the PS byte; PDU2 ignores da */
+	if (J1939_IS_PDU1(pgn))
+		id |= da << J1939_ID_PGN_SHIFT;
+	return id;
+}
+
+void cm_dat_init(uint8_t *dat, uint8_t cmd)
+{
+	memset(dat, J1939_FILL_BYTE, CAN_MAX_DLEN);
+	dat[J1939_CM_CMD_OFF] = cmd;
+}
+
+static void put_le(uint8_t *p, uint32_t v, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		p[i] = v >> (CHAR_BIT * i);
+}
+
+static uint32_t get_le(const uint8_t *p, size_t n)
+{
+	uint32_t v = 0;
+	size_t i;
+
+	for (i = 0; i < n; i++) {
+		uint32_t byte = p[i];
+
+		v |= byte << (CHAR_BIT * i);
+	}
+	return v;
+}
+
+void put_le16(uint8_t *p, uint16_t v)
+{
+	put_le(p, v, sizeof(v));
+}
+
+void put_le24(uint8_t *p, uint32_t v)
+{
+	put_le(p, v, J1939_LE24_LEN);
+}
+
+void put_le32(uint8_t *p, uint32_t v)
+{
+	put_le(p, v, sizeof(v));
+}
+
+uint16_t get_le16(const uint8_t *p)
+{
+	return get_le(p, sizeof(uint16_t));
+}
+
+uint32_t get_le24(const uint8_t *p)
+{
+	return get_le(p, J1939_LE24_LEN);
+}
+
+uint32_t get_le32(const uint8_t *p)
+{
+	return get_le(p, sizeof(uint32_t));
+}
+
+void put_pgn(uint8_t *dat, pgn_t pgn)
+{
+	put_le24(&dat[J1939_CM_PGN_OFF], pgn);
+}
+
+bool send_raw8_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da, uint8_t sa,
+		  const uint8_t dat[CAN_MAX_DLEN])
+{
+	struct can_frame f = {};
+
+	f.can_id = j1939_canid(prio, pgn, da, sa);
+	f.can_dlc = CAN_MAX_DLEN;
+	memcpy(f.data, dat, CAN_MAX_DLEN);
+	return write_all_ok(raw, &f, sizeof(f));
+}
+
+size_t j1939_dt_chunk_len(size_t size, size_t off)
+{
+	size_t n;
+
+	n = size - off;
+	return n < J1939_DT_DATA_LEN ? n : J1939_DT_DATA_LEN;
+}
+
+bool send_dt_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da, uint8_t sa,
+		uint8_t seq, const uint8_t *payload, size_t off, size_t size)
+{
+	uint8_t dat[CAN_MAX_DLEN];
+
+	/* a DT frame carries at least one payload byte from off */
+	if (off >= size)
+		return false;
+
+	memset(dat, J1939_FILL_BYTE, sizeof(dat));
+	dat[J1939_DT_SEQ_OFF] = seq;
+	memcpy(&dat[J1939_DT_DATA_OFF], payload + off,
+	       j1939_dt_chunk_len(size, off));
+	return send_raw8_ok(raw, prio, dt_pgn, da, sa, dat);
+}
+
+_Static_assert(__builtin_types_compatible_p(__typeof__(NSEC_PER_SEC),
+					    long long) &&
+	       __builtin_types_compatible_p(__typeof__(NSEC_PER_MSEC),
+					    long long),
+	       "timespec_diff_ms() needs signed long long arithmetic");
+
+long timespec_diff_ms(const struct timespec *a, const struct timespec *b)
+{
+	return ((b->tv_sec - a->tv_sec) * NSEC_PER_SEC +
+		(b->tv_nsec - a->tv_nsec)) / NSEC_PER_MSEC;
+}
+
+/* Set *deadline to timeout_ms from now on CLOCK_MONOTONIC. */
+static void deadline_after_ms(struct timespec *deadline, int timeout_ms)
+{
+	clock_gettime(CLOCK_MONOTONIC, deadline);
+	deadline->tv_sec += timeout_ms / MSEC_PER_SEC;
+	deadline->tv_nsec += (timeout_ms % MSEC_PER_SEC) * NSEC_PER_MSEC;
+	if (deadline->tv_nsec >= NSEC_PER_SEC) {
+		deadline->tv_sec++;
+		deadline->tv_nsec -= NSEC_PER_SEC;
+	}
+}
+
+/*
+ * Poll and recv on raw until match() accepts a frame, or time out. match()
+ * gets the raw can_id; the j1939_id_*() decoders mask the flag bits. Other
+ * traffic must not extend the wait, so poll against a fixed deadline.
+ */
+static bool recv_match_ok(int raw, int timeout_ms, struct can_frame *frame,
+			  bool (*match)(canid_t id, const void *ctx),
+			  const void *ctx)
+{
+	struct pollfd pfd = { .fd = raw, .events = POLLIN };
+	struct timespec now, deadline;
+	int remaining = timeout_ms;
+
+	deadline_after_ms(&deadline, timeout_ms);
+
+	while (remaining > 0) {
+		if (poll(&pfd, 1, remaining) <= 0)
+			return false;
+		if (recv(raw, frame, sizeof(*frame), 0) < 0)
+			return false;
+		if (j1939_is_data_frame(frame->can_id) &&
+		    match(frame->can_id, ctx))
+			return true;
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		remaining = timespec_diff_ms(&now, &deadline);
+	}
+	return false;
+}
+
+struct j1939_peer_match {
+	uint8_t want_pf;
+	uint8_t want_da;
+	uint8_t want_sa;
+};
+
+static bool match_peer_dest(canid_t id, const void *ctx)
+{
+	const struct j1939_peer_match *m = ctx;
+
+	return j1939_id_pf(id) == m->want_pf &&
+	       j1939_id_ps(id) == m->want_da &&
+	       j1939_id_sa(id) == m->want_sa;
+}
+
+bool recv_for_peer_ok(int raw, uint8_t want_pf, uint8_t want_da,
+		      uint8_t want_sa, struct can_frame *frame, int timeout_ms)
+{
+	struct j1939_peer_match m = {
+		.want_pf = want_pf,
+		.want_da = want_da,
+		.want_sa = want_sa,
+	};
+
+	return recv_match_ok(raw, timeout_ms, frame, match_peer_dest, &m);
+}
+
+bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da, uint8_t want_sa,
+		    struct can_frame *frame, int timeout_ms, uint8_t want_cmd)
+{
+	if (!recv_for_peer_ok(raw, want_pf, want_da, want_sa, frame,
+			      timeout_ms))
+		return false;
+	return frame->data[J1939_CM_CMD_OFF] == want_cmd;
+}
+
+/* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
+#define J1939_PATTERN_SEED	0x3c
+
+void fill_pattern(uint8_t *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = i ^ (i >> CHAR_BIT) ^ J1939_PATTERN_SEED;
+}
+
+bool can_proto_missing(int type, int proto)
+{
+	int probe;
+
+	probe = socket(PF_CAN, type, proto);
+	if (probe < 0)
+		return errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT;
+
+	close(probe);
+	return false;
+}
diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..13a458cab51a6d9f35d764fb768c70da29bf02a0
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_helpers.h
@@ -0,0 +1,284 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Shared helpers for the J1939 selftests.
+ *
+ * The individual tests are standalone kselftest binaries. This header
+ * declares the helpers they share, and j1939_helpers.c holds their code.
+ * The parts that use the kselftest harness are in j1939_tests.h.
+ *
+ * Helpers named *_ok() return true on success and false on failure, with
+ * errno set where a system call failed. Helpers that return a file
+ * descriptor or an ifindex return -1 on failure.
+ *
+ * Timing modes: timer checks use relaxed bounds by default, so that slow
+ * machines such as QEMU in CI pass. Set J1939_STRICT_TIMING in the
+ * environment (any value) for tight bounds on a real machine.
+ */
+#ifndef __SELFTESTS_NET_CAN_J1939_HELPERS_H__
+#define __SELFTESTS_NET_CAN_J1939_HELPERS_H__
+
+#include <errno.h>
+#include <limits.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <net/if.h>
+#include <sys/socket.h>
+#include <linux/can.h>
+#include <linux/can/j1939.h>
+#include <linux/can/raw.h>
+#include <linux/if.h>
+
+#include "clock-helpers.h"
+
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+#endif
+
+/*
+ * How long to wait for an expected frame or message. Not a protocol timer: a
+ * guess with room for a slow VM.
+ */
+#define J1939_RECV_TIMEOUT_MS	2000
+
+/*
+ * Timeout for a check that expects no frame. Long enough that a real
+ * local frame would have arrived, so a timeout means "nothing came".
+ * Much shorter than J1939_RECV_TIMEOUT_MS, to keep the test fast. A guess.
+ */
+#define J1939_NEG_RECV_TIMEOUT_MS	300
+_Static_assert(J1939_NEG_RECV_TIMEOUT_MS < J1939_RECV_TIMEOUT_MS,
+	       "J1939_NEG_RECV_TIMEOUT_MS must be the shorter timeout");
+
+/* Send priority of a new J1939 socket, see j1939_sk_init() in the kernel. */
+#define J1939_PRIO_DEFAULT	6
+
+/* Unused data bytes are sent as 0xff (SAE J1939-21:2001 Figures 14, 15). */
+#define J1939_FILL_BYTE		0xff
+
+/*
+ * PGN fields: PF is the second byte, PS the low byte. A PF of at least
+ * J1939_PDU2_PF_MIN selects PDU2, and PS is not an address
+ * (SAE J1939-21:2001 sections 5.1.2 and 5.2.5).
+ */
+#define J1939_PGN_PF_SHIFT	CHAR_BIT	/* below PF: the PS byte */
+#define J1939_PDU2_PF_MIN	0xf0
+#define J1939_PF(pgn)		(((pgn) >> J1939_PGN_PF_SHIFT) & UINT8_MAX)
+#define J1939_IS_PDU1(pgn)	(J1939_PF(pgn) < J1939_PDU2_PF_MIN)
+
+/* Data Page bit of a PGN (SAE J1939-21:2001 sections 5.1.2 and 5.2.3) */
+#define J1939_PGN_DP		0x10000
+
+/*
+ * Fields of the 29-bit CAN id (SAE J1939-21:2001 section 5.2): the priority,
+ * then the PGN, whose PS byte holds the destination of a PDU1 frame, then
+ * the source address in the low byte. The j1939_id_*() decoders mask their
+ * field, so they take a can_id with the CAN_*_FLAG bits still set.
+ */
+#define J1939_ID_PRIO_BITS	3
+#define J1939_ID_PRIO_SHIFT	(CAN_EFF_ID_BITS - J1939_ID_PRIO_BITS)
+#define J1939_ID_PRIO_MASK	((1U << J1939_ID_PRIO_BITS) - 1)
+#define J1939_ID_PGN_SHIFT	CHAR_BIT	/* below the PGN: the SA byte */
+_Static_assert(((J1939_PGN_MAX + 1) << J1939_ID_PGN_SHIFT) ==
+	       1U << J1939_ID_PRIO_SHIFT,
+	       "the PGN field must end where the priority starts");
+
+int j1939_id_prio(canid_t id);
+int j1939_id_pgn(canid_t id);
+int j1939_id_ps(canid_t id);
+int j1939_id_sa(canid_t id);
+
+/* Bytes in a 24-bit field of a TP or ETP control frame. */
+#define J1939_LE24_LEN		3
+
+/*
+ * Byte offsets in TP and ETP frames (SAE J1939-21:2001 Figures 14 and 15,
+ * ISO 11783-6:2004 K.2.2.1 and K.2.3).
+ */
+#define J1939_CM_CMD_OFF	0	/* control byte */
+#define J1939_CM_PGN_OFF	5	/* message PGN, J1939_LE24_LEN bytes */
+#define J1939_DT_SEQ_OFF	0	/* sequence number */
+#define J1939_DT_DATA_OFF	1	/* first payload byte */
+_Static_assert(J1939_CM_PGN_OFF + J1939_LE24_LEN == CAN_MAX_DLEN,
+	       "the message PGN is the last field of a control frame");
+
+/* Sizes and limits. */
+#define J1939_SF_MAX_SIZE	CAN_MAX_DLEN	/* largest single frame */
+
+/* payload bytes in one TP/ETP data (DT) frame */
+#define J1939_DT_DATA_LEN	(CAN_MAX_DLEN - J1939_DT_DATA_OFF)
+
+/* highest TP sequence number: the field is one byte */
+#define J1939_DT_SEQ_MAX	UINT8_MAX
+
+/* largest TP message; anything larger needs ETP */
+#define J1939_TP_MAX_SIZE	(J1939_DT_SEQ_MAX * J1939_DT_DATA_LEN)
+_Static_assert(J1939_TP_MAX_SIZE == 1785,
+	       "SAE J1939-21:2001 section 5.10.1.1 gives 1785 bytes");
+
+/* number of TP/ETP DT packets needed for len bytes, rounded up */
+#define J1939_NUM_PKTS(len)	DIV_ROUND_UP((len), J1939_DT_DATA_LEN)
+
+/*
+ * J1939 uses 29-bit data frames only. Its CAN filter in net/can/j1939/main.c
+ * drops RTR frames, and error frames never reach it.
+ */
+bool j1939_is_data_frame(canid_t can_id);
+
+/*
+ * Size of a CAN_RAW receive buffer for every frame of the largest ETP test
+ * message. A guess with plenty of headroom, not computed. Set best-effort
+ * via SO_RCVBUFFORCE.
+ */
+#define J1939_RAW_BIG_RCVBUF	(8 * 1024 * 1024)
+
+/* Flags for j1939_open_flags(). */
+#define J1939_OPEN_NONE		0
+#define J1939_OPEN_BCAST	0x1
+
+/* rcvbuf value for open_raw_rcvbuf(): keep the default receive buffer. */
+#define J1939_RAW_RCVBUF_DEFAULT	0
+
+/*
+ * Set by j1939_test_main() from the environment: CANIF is the interface of
+ * the J1939 sockets, CANIF_RAW is the interface of the CAN_RAW peer and
+ * defaults to CANIF.
+ */
+extern char CANIF[IFNAMSIZ];
+extern char CANIF_RAW[IFNAMSIZ];
+
+/* Set by j1939_test_main(): the test passed J1939_NEEDS_RAW. */
+extern bool j1939_needs_raw;
+
+/*
+ * Return relaxed_ms by default, or strict_ms if J1939_STRICT_TIMING is set in
+ * the environment. See "Timing modes" at the top of this file.
+ */
+int j1939_timing_ms(int relaxed_ms, int strict_ms);
+
+/* Resolve the ifindex of the interface named by CANIF. */
+int j1939_if_index(void);
+
+/*
+ * Open a J1939 socket bound to (name, sa, pgn); flags may set
+ * J1939_OPEN_BCAST.
+ */
+int j1939_open_flags(int ifindex, name_t name, uint8_t sa, pgn_t pgn,
+		     int flags);
+
+/* Open a J1939 socket bound to (sa, pgn) with no NAME and no broadcast. */
+int j1939_open(int ifindex, uint8_t sa, pgn_t pgn);
+
+/* Connect a J1939 socket to the peer (da, pgn), with no NAME. */
+bool j1939_connect_ok(int s, int ifindex, uint8_t da, pgn_t pgn);
+
+/* One sendto() that sent all len bytes; no retry. */
+bool j1939_sendto_ok(int s, const void *buf, size_t len, int ifindex,
+		     name_t name, uint8_t da, pgn_t pgn);
+
+/* One send(), write() or read() that moved all len bytes; no retry. */
+bool send_all_ok(int s, const void *buf, size_t len);
+bool write_all_ok(int fd, const void *buf, size_t len);
+bool read_all_ok(int fd, void *buf, size_t len);
+
+/*
+ * Open a CAN_RAW socket on CANIF_RAW. This also pins the calling thread to
+ * the CPU it runs on, or warns if that fails. Unless rcvbuf is
+ * J1939_RAW_RCVBUF_DEFAULT, request that SO_RCVBUFFORCE size (best-effort: a
+ * failure is logged, not fatal). Fail with EINVAL if the test did not pass
+ * J1939_NEEDS_RAW to j1939_test_main().
+ */
+int open_raw_rcvbuf(int rcvbuf);
+
+/* open_raw_rcvbuf() with the default receive buffer. */
+int open_raw(void);
+
+/*
+ * recvfrom() one message on s within timeout_ms, check that it is the len
+ * bytes in want, and return the sender in *src unless src is NULL. The buffer
+ * has one spare byte, so a longer message fails the check.
+ */
+bool recvfrom_verify_ok(int s, const void *want, size_t len, int timeout_ms,
+			struct sockaddr_can *src);
+
+/* recvfrom_verify_ok() without the sender. */
+bool recv_verify_ok(int s, const void *want, size_t len, int timeout_ms);
+
+/* Send len bytes on tx and verify they arrive byte-for-byte on rx. */
+bool send_recv_verify_ok(int tx, int rx, const void *buf, size_t len,
+			 int timeout_ms);
+
+/* Receive one whole CAN frame from a raw socket within timeout_ms. */
+bool recv_frame_ok(int raw, struct can_frame *frame, int timeout_ms);
+
+/*
+ * Start a TP/ETP control frame: every byte J1939_FILL_BYTE, then the control
+ * byte cmd.
+ */
+void cm_dat_init(uint8_t *dat, uint8_t cmd);
+
+/*
+ * Little-endian codecs for the multi-byte fields of TP/ETP connection
+ * management (CM) frames (host-agnostic).
+ */
+void put_le16(uint8_t *p, uint16_t v);
+void put_le24(uint8_t *p, uint32_t v);
+void put_le32(uint8_t *p, uint32_t v);
+uint16_t get_le16(const uint8_t *p);
+uint32_t get_le24(const uint8_t *p);
+uint32_t get_le32(const uint8_t *p);
+
+/* Embed the PGN of the transported message into a TP/ETP control frame. */
+void put_pgn(uint8_t *dat, pgn_t pgn);
+
+/*
+ * Send one J1939-encoded frame of CAN_MAX_DLEN bytes. prio is the J1939
+ * priority, 0 (highest) to 7; the PS byte of a PDU1 pgn must be 0.
+ */
+bool send_raw8_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da, uint8_t sa,
+		  const uint8_t dat[CAN_MAX_DLEN]);
+
+/*
+ * Payload bytes of the DT frame that starts at offset off of a message of
+ * size bytes; off must be below size.
+ */
+size_t j1939_dt_chunk_len(size_t size, size_t off);
+
+/*
+ * Send a TP/ETP data (DT) frame: sequence number seq and up to
+ * J1939_DT_DATA_LEN bytes from offset off of payload, a message of size
+ * bytes.
+ */
+bool send_dt_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da, uint8_t sa,
+		uint8_t seq, const uint8_t *payload, size_t off, size_t size);
+
+/* Milliseconds from a to b (negative if b is earlier), CLOCK_MONOTONIC. */
+long timespec_diff_ms(const struct timespec *a, const struct timespec *b);
+
+/*
+ * Receive the next frame whose CAN-id PF == want_pf, sent from want_sa to
+ * want_da (PS).
+ */
+bool recv_for_peer_ok(int raw, uint8_t want_pf, uint8_t want_da,
+		      uint8_t want_sa, struct can_frame *frame, int timeout_ms);
+
+/* recv_for_peer_ok() and check that the control byte is want_cmd. */
+bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da, uint8_t want_sa,
+		    struct can_frame *frame, int timeout_ms, uint8_t want_cmd);
+
+/*
+ * Fill buf with a deterministic, position-dependent byte pattern. The
+ * i >> CHAR_BIT term makes each 256-byte block of the first 64 KiB differ.
+ */
+void fill_pattern(uint8_t *buf, size_t len);
+
+/* Is the CAN protocol proto missing from this kernel? */
+bool can_proto_missing(int type, int proto);
+
+#endif /* __SELFTESTS_NET_CAN_J1939_HELPERS_H__ */
diff --git a/tools/testing/selftests/net/can/j1939_lib.sh b/tools/testing/selftests/net/can/j1939_lib.sh
new file mode 100644
index 0000000000000000000000000000000000000000..afea744608fdaf7f072939620b440eb65d49b71f
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_lib.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared bring-up for the J1939 selftest wrappers. A wrapper sources this
+# file and runs the test binary of the same name, without .sh:
+#
+#	source "$(dirname "$0")/j1939_lib.sh"
+#
+# By default it creates and deletes two vcan interfaces: CANIF (default vcan0)
+# for the J1939 sockets and CANIF_RAW (default vcan1) for the CAN_RAW peer. It
+# routes frames between them with the CAN gateway, runs the test binary through
+# the kselftest net lib and reports the result. The tests send frames as other
+# nodes, so they must not run on a real CAN bus. The test is skipped if an
+# interface name does not start with "vcan".
+#
+# J1939_SHARED_IF=1 puts the peer on CANIF and needs no gateway. The peer may
+# then read a frame before the stack has handled the echo of that frame, and a
+# quick reply from the peer can cancel a TP session. Behind the gateway, with
+# RPS turned off on CANIF_RAW, the peer reads each frame only after the stack
+# has handled its echo; if RPS cannot be turned off, setup() warns.
+#
+# A wrapper whose test opens no CAN_RAW socket sets J1939_NO_PEER=1 before it
+# sources this file. Then the library sets up no CANIF_RAW vcan and no
+# gateway. A test that passes J1939_NEEDS_RAW fails at start.
+#
+# For the J1939_STRICT_TIMING timing mode, see j1939_helpers.h.
+
+# shellcheck disable=SC2034 # used by tests_run in lib.sh
+ALL_TESTS="j1939_run"
+
+test_dir=$(dirname "$0")
+net_dir=$test_dir/..
+# shellcheck source=../lib.sh
+source "$net_dir/lib.sh"
+
+export CANIF=${CANIF:-"vcan0"}
+
+# where the CAN_RAW peer runs: gateway (default), shared or none
+if [ "${J1939_NO_PEER:-0}" = 1 ]; then
+	export J1939_NO_PEER
+	unset CANIF_RAW
+	j1939_peer=none
+elif [ "${J1939_SHARED_IF:-0}" = 1 ]; then
+	export CANIF_RAW=$CANIF
+	j1939_peer=shared
+else
+	export CANIF_RAW=${CANIF_RAW:-"vcan1"}
+	j1939_peer=gateway
+fi
+
+J1939_TEST_PROG=$(basename "$0" .sh)
+
+# Undo only what this script did: delete a vcan we created, and bring
+# down an interface only if we brought it up. A failed setup() (e.g. an
+# interface already exists) must not disturb a pre-existing interface.
+created=()
+brought_up=()
+
+j1939_skip()
+{
+	echo "SKIP: $1"
+	exit "$ksft_skip"
+}
+
+vcan_setup()
+{
+	local dev=$1
+
+	if [[ $dev != vcan* ]]; then
+		j1939_skip "interface name '$dev' does not start with vcan"
+	fi
+
+	if ip link show "$dev" >/dev/null 2>&1; then
+		j1939_skip "$dev already exists; delete it and run the test again"
+	fi
+
+	if ! ip link add name "$dev" type vcan; then
+		j1939_skip "cannot create $dev (no vcan support or no permission)"
+	fi
+	created+=("$dev")
+
+	if ! ip link set dev "$dev" up; then
+		j1939_skip "cannot bring up $dev"
+	fi
+	brought_up+=("$dev")
+}
+
+# With RPS, the peer could get a frame on another CPU before the stack
+# has handled its echo. An empty mask reads as zeros and commas.
+rps_off()
+{
+	local rps=/sys/class/net/$1/queues/rx-0/rps_cpus
+
+	[ -e "$rps" ] || return 0
+	[ -n "$(tr -d '0,\n' < "$rps")" ] || return 0
+	echo 0 2>/dev/null > "$rps"
+}
+
+setup()
+{
+	local gw=$test_dir/j1939_gw
+	local rc
+
+	vcan_setup "$CANIF"
+
+	# shared or none: no second vcan
+	[ "$j1939_peer" = gateway ] || return 0
+
+	if [ "$CANIF_RAW" = "$CANIF" ]; then
+		j1939_skip "CANIF_RAW is CANIF ($CANIF); set another CANIF_RAW or J1939_SHARED_IF=1"
+	fi
+
+	vcan_setup "$CANIF_RAW"
+
+	if ! rps_off "$CANIF_RAW"; then
+		echo "WARNING: RPS stays on for $CANIF_RAW; the peer can overtake the stack's echo"
+	fi
+
+	# rtnetlink does not load can-gw on demand
+	modprobe -q can-gw 2>/dev/null
+
+	"$gw" "$CANIF" "$CANIF_RAW"
+	rc=$?
+
+	# shell: 126 not executable, 127 not found, 128+n killed by signal n
+	if [ "$rc" -ge 126 ]; then
+		echo "FAIL: $gw did not run or crashed (exit $rc)"
+		exit "$ksft_fail"
+	fi
+
+	if [ "$rc" -ne 0 ]; then
+		j1939_skip "cannot route $CANIF <-> $CANIF_RAW (can-gw?); try J1939_SHARED_IF=1"
+	fi
+}
+
+cleanup()
+{
+	local dev
+
+	for dev in "${brought_up[@]}"; do
+		ip link set dev "$dev" down 2>/dev/null
+	done
+	for dev in "${created[@]}"; do
+		ip link delete "$dev" 2>/dev/null
+	done
+}
+
+j1939_run()
+{
+	local rc
+
+	"$test_dir/$J1939_TEST_PROG"
+	rc=$?
+
+	# The test binary exits ksft_skip when it cannot run (see
+	# j1939_test_main()); keep that a skip instead of letting check_err
+	# turn any non-zero into a failure.
+	if [ "$rc" -eq "$ksft_skip" ]; then
+		ret_set_ksft_status "$ksft_skip" ""
+	else
+		check_err "$rc"
+	fi
+	log_test "$J1939_TEST_PROG"
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
new file mode 100644
index 0000000000000000000000000000000000000000..df8604d65fa2b13842d470f00e13084e5dee905d
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * The parts of the J1939 selftest helpers that use the kselftest harness:
+ * the fixture setup macros and j1939_test_main(). The other helpers are in
+ * j1939_helpers.h, which this header includes.
+ *
+ * Each test binary is run by its .sh wrapper (see j1939_lib.sh), which sets up
+ * the vcan interfaces and passes their names in the CANIF and CANIF_RAW
+ * environment variables; with J1939_NO_PEER=1 it passes no CANIF_RAW.
+ */
+#ifndef __SELFTESTS_NET_CAN_J1939_TESTS_H__
+#define __SELFTESTS_NET_CAN_J1939_TESTS_H__
+
+#include "kselftest_harness.h"
+#include "j1939_helpers.h"
+
+/*
+ * FIXTURE_SETUP helper: resolve CANIF's ifindex into self->ifindex and abort
+ * the test if it cannot be found. Used as a statement:
+ * J1939_SETUP_IFINDEX(self);
+ */
+#define J1939_SETUP_IFINDEX(self)					       \
+	do {								       \
+		(self)->ifindex = j1939_if_index();			       \
+		ASSERT_GE((self)->ifindex, 0)				       \
+			TH_LOG("failed to resolve ifindex for '%s': %d",       \
+			       CANIF, errno);				       \
+	} while (0)
+
+/*
+ * FIXTURE_SETUP helper: open a CAN_RAW socket on CANIF_RAW into self->raw
+ * with the given SO_RCVBUFFORCE size (or J1939_RAW_RCVBUF_DEFAULT) and abort
+ * the test if it cannot be opened. This also pins the test to one CPU, see
+ * open_raw_rcvbuf(). Used as a statement: J1939_SETUP_RAW(self, rcvbuf);
+ */
+#define J1939_SETUP_RAW(self, rcvbuf)					       \
+	do {								       \
+		(self)->raw = open_raw_rcvbuf(rcvbuf);			       \
+		ASSERT_GE((self)->raw, 0)				       \
+			TH_LOG("failed to open raw socket: %d", errno);	       \
+	} while (0)
+
+/*
+ * Flags for j1939_test_main(): what the test binary needs besides CAN_J1939.
+ */
+#define J1939_NEEDS_NONE	0
+#define J1939_NEEDS_RAW		0x1	/* opens CAN_RAW sockets */
+
+/*
+ * Body of each test's main(): require CANIF in the environment and a kernel
+ * with CAN_J1939, then run the harness. J1939_NEEDS_RAW marks a test that
+ * opens CAN_RAW sockets; only such a test may open them. It needs CAN_RAW
+ * support and fails at start if the wrapper set J1939_NO_PEER=1. A missing
+ * protocol skips the test. Warn when the CAN_RAW peer shares CANIF (see
+ * j1939_lib.sh).
+ */
+static inline int j1939_test_main(int argc, char **argv, unsigned int flags)
+{
+	const char *raw_ifname;
+	const char *no_peer;
+	const char *ifname;
+
+	ifname = getenv("CANIF");
+	if (!ifname) {
+		fprintf(stderr, "# CANIF must name the test interface\n");
+		return KSFT_SKIP;
+	}
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
+
+	raw_ifname = getenv("CANIF_RAW");
+	if (!raw_ifname || !*raw_ifname)
+		raw_ifname = ifname;
+	strncpy(CANIF_RAW, raw_ifname, sizeof(CANIF_RAW) - 1);
+
+	j1939_needs_raw = flags & J1939_NEEDS_RAW;
+	no_peer = getenv("J1939_NO_PEER");
+	if (j1939_needs_raw && no_peer && !strcmp(no_peer, "1")) {
+		fprintf(stderr, "# J1939_NO_PEER=1, but CAN_RAW peer needed\n");
+		return KSFT_FAIL;
+	}
+
+	if (can_proto_missing(SOCK_DGRAM, CAN_J1939)) {
+		fprintf(stderr, "# kernel lacks CAN_J1939\n");
+		return KSFT_SKIP;
+	}
+	if (j1939_needs_raw && can_proto_missing(SOCK_RAW, CAN_RAW)) {
+		fprintf(stderr, "# kernel lacks CAN_RAW\n");
+		return KSFT_SKIP;
+	}
+
+	if (j1939_needs_raw && !strcmp(CANIF_RAW, CANIF)) {
+		fprintf(stderr, "# WARNING: peer shares %s; TP/ETP may fail\n",
+			CANIF);
+	}
+
+	return test_harness_run(argc, argv);
+}
+
+#endif /* __SELFTESTS_NET_CAN_J1939_TESTS_H__ */

-- 
2.47.3

