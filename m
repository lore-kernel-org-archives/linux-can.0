Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809071;
	b=hmmo7ovlX1mIfrmy9sxIpaffxesMs0lYE1fitWhZNFdT9GAI1dIUiRa9Pvm08+GMrZy/
	 Cv28ejNiqL3I8fTQXiTlyQ/d4Q+3t7bmNxijY2RYbG+8xTUXUbm+CQwjVEX0kdiC6lLed
	 C4qD5kTZRr0qGHSZ+L9UOW7rmemKT4WqpmTTLqX+ErpEckn36nFiu6kGqhL8V+Rtlizaf
	 xeo8zZT8wKQ16xk2fPPa8euUqr9IYPoaetyqk4HptH13maIeFrkxjJSjZJfvw1kpQvHOc
	 dCYi1KIueEgUu7/zzT+ITAuPOTX9PTLXn9ui4Iy65VD9bBTTGWwqoYgnvkAErcbqOFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=IbIZpbkrQo5648skyF/T886hI4/BmbX4cB8NoPim83I=;
	b=YN9Uqa+5qwbjuvhUlwTDYVEhnUMlTIjSzoeojg/TjwdIF/5VQCKG7oPjvk+/XOEscseb
	 4cZfGmwXAjHIohtXDSYbcxqnCEGS88ClFlzf/fkvVg6fuKOQwH6PWPr2qPGsLOP8ViQwu
	 Azo7nOXB0r39tDUNjVASzeJ98Ogcqj52o6E02Ve0EvNw7SrgpRIUUrn15dhVwQGbZoXmb
	 1E181h2ykuDD0o8FIKuf1rcPYpuErMibQR3AZLdFZ+b4Xf1SCEzr/p9MesOSI7Sc0izm+
	 V3ESR7txhW/aUCFNx3EtzZSwmh5GrD29ORXBhu+ycQd1nSxqOLFJvnvB+iz9rVE9KdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=c74pCZ6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6A606A33B;
	Wed,  4 Nov 2026 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F6A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=c74pCZ6Z
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 63AFD202BB6;
	Wed, 04 Nov 2026 17:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbIZpbkrQo5648skyF/T886hI4/BmbX4cB8NoPim83I=;
	b=c74pCZ6ZAJTd0wyPa5wm1ItxN9cKzVwWWKm+k/SmDpD7uKKROXLqUxylc5g9oRYt9llZh6
	EejLzE8NnZQtgj04TdQI7/rScgHbmITqXjBEo0MFMgkWwpV2iKQSeghj50VZnCid1m0sM6
	SlnuT6AEr82h4zMhU6NpCucITtK+q8VjUx77Sq7OtHsNRLMzMzzSF69veaj0U8LUxzCKxj
	YVL0GA+nzvrcGfSA3UaMeTtNWGjLjuauBP4PFG3imyc/G8pM2o2z09AUKaXoNrzoaL8UQs
	5oIrEh2IkSv759DfPl6/GQ2sJsd4VsD/VZHAByB8XG+jYzqDGnV2yKsXl6nOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbIZpbkrQo5648skyF/T886hI4/BmbX4cB8NoPim83I=;
	b=P2OF+FcpzIwuFiaB7/j8+R+F5r3dlOjQNJicwMV0665mk775TSZ6nYw6AH7zoJfnmiCA9u
	XQ1WucHuI3u2vBSKB4Pif4w1KoYC+KJ2DAj8Ua8QtEMdmtCLHcWMwKpUH6M9Fephj32GdI
	VBpGfkNpbeiPdWdfoAYhB57X+pV3lD2Z/80TVhhG7FFvansfsYV1v7FrsdB8LRVS/Lndwd
	wGRvRK27UcMYfzQMapPsGmoaJc6SDebwkirgD4so81bc30O4A4aWewo8ubNyRhF9PtfIwV
	Pi6WHS5FOAZ4S6QIUk2EhaDUwcOFHJeabjMMYv3fUqjMwWsRGfqH8Vfx01xfcA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809063; a=rsa-sha256;
	cv=none;
	b=OnoIRC98Pp+xC8rN/l3zg5SJE6ttvlRPpL9JeQgYs+e+FbVcO3nst71OWbqF7nbWd9GIv2
	I/vEFZqLybz0P3H/gw37j8BzuPVi5FM9c962QCamBvbwFqI7naFqntJv7lr0Dj5Dg+L1WF
	cBRoJevC7QLxfOwYqBI0+/TPuTgECYBhMeg6W/P48b0fXwMA13JyB6f6IJvhXbYLAy6euQ
	7Ma2Ege2mZJN8X4UijNEX/nozz4uwNxuch6VQZDMLLaG3a7qzBLWeORJEJ6zltA7Z+j8E4
	nbVeC4h35TUYUeQ598QUZRSOYFiPxDCW9IpZS7jE/ub1uL+chuLz3uW4/HDX4A==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 4D5CD38099C; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:17 +0100
Subject: [PATCH can-next v2 2/9] selftests: can: add J1939 test helper
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
Message-Id: <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
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

Add the code the later J1939 selftests share: j1939_tests.h with the C
helpers (socket setup, timed receive, CAN id encoding), and j1939_lib.sh
with the vcan setup and cleanup and the test runner. A wrapper sources
j1939_lib.sh and runs the test binary of the same name.

j1939_lib.sh runs the tests only on a vcan that it creates itself. The
tests that follow send frames as other nodes and forge Address Claims, so
they must not run on a real CAN bus.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q: can timespec_diff_ms() overflow on 32-bit, where long is 32 bits?
A: No. NSEC_PER_SEC comes from clock-helpers.h as 1000000000LL, so the
product is computed in long long; the result in ms fits a long.

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
 tools/testing/selftests/net/can/Makefile      |   2 +
 tools/testing/selftests/net/can/j1939_lib.sh  |  86 +++
 tools/testing/selftests/net/can/j1939_tests.h | 724 ++++++++++++++++++++++++++
 3 files changed, 812 insertions(+)

diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 3adaa13dcbfa303c4be2bb6a9b5dbdac76d68260..953f4538740984d7342f6e264ac13fadc0790ed2 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := test_raw_filter.sh
 
+TEST_FILES := j1939_lib.sh
+
 TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
 TEST_GEN_FILES := test_raw_filter
diff --git a/tools/testing/selftests/net/can/j1939_lib.sh b/tools/testing/selftests/net/can/j1939_lib.sh
new file mode 100644
index 0000000000000000000000000000000000000000..87228c692a13a8aad899f622519ebcb539b241e4
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_lib.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared bring-up for the J1939 selftest wrappers. A wrapper sources this
+# file and runs the test binary of the same name, without .sh:
+#
+#	source "$(dirname "$0")/j1939_lib.sh"
+#
+# It creates (and deletes) the vcan named by CANIF (vcan0 by default), runs the
+# test binary through the kselftest net lib and reports the result. The tests
+# send frames as other nodes and forge Address Claims, so they must not run on
+# a real CAN bus: a CANIF whose name does not start with "vcan" is skipped.
+#
+# For the J1939_STRICT_TIMING timing mode, see j1939_tests.h.
+
+# shellcheck disable=SC2034 # used by tests_run in lib.sh
+ALL_TESTS="j1939_run"
+
+net_dir=$(dirname "$0")/..
+# shellcheck source=../lib.sh
+source "$net_dir/lib.sh"
+
+export CANIF=${CANIF:-"vcan0"}
+J1939_TEST_PROG=$(basename "$0" .sh)
+
+# Undo only what this script did: delete a vcan we created, and bring
+# down an interface only if we brought it up. A failed setup() (e.g. CANIF
+# already exists) must not disturb a pre-existing interface.
+created=0
+brought_up=0
+
+setup()
+{
+	if [[ $CANIF != vcan* ]]; then
+		echo "SKIP: CANIF name '$CANIF' does not start with vcan"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip link add name "$CANIF" type vcan; then
+		echo "SKIP: cannot create $CANIF" \
+		     "(already exists, or no vcan support)"
+		exit "$ksft_skip"
+	fi
+	created=1
+
+	if ! ip link set dev "$CANIF" up; then
+		echo "SKIP: cannot bring up $CANIF"
+		exit "$ksft_skip"
+	fi
+	brought_up=1
+}
+
+cleanup()
+{
+	if [ "$brought_up" = 1 ]; then
+		ip link set dev "$CANIF" down 2>/dev/null
+	fi
+	if [ "$created" = 1 ]; then
+		ip link delete "$CANIF" 2>/dev/null
+	fi
+}
+
+j1939_run()
+{
+	local rc
+
+	"$(dirname "$0")/$J1939_TEST_PROG"
+	rc=$?
+
+	# The test binary exits ksft_skip when it cannot run (see
+	# j1939_test_main()); keep that a skip instead of letting check_err
+	# turn any non-zero into a failure.
+	if ((rc == ksft_skip)); then
+		ret_set_ksft_status "$ksft_skip" "$J1939_TEST_PROG"
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
index 0000000000000000000000000000000000000000..78eb35f5b6b06847e7b004e827ea437b3bb8b38a
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -0,0 +1,724 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Shared helpers for the J1939 selftests.
+ *
+ * The individual tests are standalone kselftest binaries, so the common
+ * boilerplate (interface lookup, socket open/connect, timed receive, CAN-ID
+ * encoding and the CANIF/main() plumbing) lives here as static inline helpers.
+ *
+ * The including .c file must include "kselftest_harness.h" before this header
+ * (j1939_test_main() uses KSFT_SKIP and test_harness_run()).
+ *
+ * Each test binary is run by its .sh wrapper (see j1939_lib.sh), which sets up
+ * the vcan interface and passes its name in the CANIF environment variable.
+ *
+ * Helpers named *_ok() return true on success and false on failure, with
+ * errno set where a system call failed. Helpers that return a file
+ * descriptor or a length return -1 on failure.
+ *
+ * Timing modes: timer checks use relaxed bounds by default, so that slow
+ * machines such as QEMU in CI pass. Set J1939_STRICT_TIMING in the
+ * environment (any value) for tight bounds on a real machine.
+ */
+#ifndef __SELFTESTS_NET_CAN_J1939_TESTS_H__
+#define __SELFTESTS_NET_CAN_J1939_TESTS_H__
+
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <poll.h>
+#include <stdint.h>
+#include <errno.h>
+#include <time.h>
+
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <linux/if.h>
+#include <linux/can.h>
+#include <linux/can/raw.h>
+#include <linux/can/j1939.h>
+
+#include "clock-helpers.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(a)		(sizeof(a) / sizeof((a)[0]))
+#endif
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+#endif
+
+/*
+ * How long to wait for an expected frame. Not a protocol timer: a guess with
+ * room for a slow VM.
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
+ * J1939_PDU2_PF_MIN selects PDU2: broadcast, and PS is not an address
+ * (SAE J1939-21:2001 sections 5.1.2 and 5.2.5).
+ */
+#define J1939_PGN_PF_SHIFT	CHAR_BIT	/* below PF: the PS byte */
+#define J1939_PDU2_PF_MIN	0xf0
+#define J1939_PF(pgn)		(((pgn) >> J1939_PGN_PF_SHIFT) & UINT8_MAX)
+#define J1939_IS_PDU1(pgn)	(J1939_PF(pgn) < J1939_PDU2_PF_MIN)
+/* Data Page bit of a PGN (SAE J1939-21:2001 section 5.2.3) */
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
+_Static_assert((J1939_PGN_MAX + 1) << J1939_ID_PGN_SHIFT ==
+	       1U << J1939_ID_PRIO_SHIFT,
+	       "the PGN field must end where the priority starts");
+
+static inline int j1939_id_prio(canid_t id)
+{
+	return (id >> J1939_ID_PRIO_SHIFT) & J1939_ID_PRIO_MASK;
+}
+
+static inline int j1939_id_pgn(canid_t id)
+{
+	return (id >> J1939_ID_PGN_SHIFT) & J1939_PGN_MAX;
+}
+
+static inline int j1939_id_pf(canid_t id)
+{
+	return J1939_PF(j1939_id_pgn(id));
+}
+
+static inline int j1939_id_ps(canid_t id)
+{
+	return j1939_id_pgn(id) & UINT8_MAX;
+}
+
+static inline int j1939_id_sa(canid_t id)
+{
+	return id & UINT8_MAX;
+}
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
+
+/* Sizes and limits. */
+#define J1939_SF_MAX_SIZE	CAN_MAX_DLEN	/* largest single frame */
+/* payload bytes in one TP/ETP data (DT) frame */
+#define J1939_DT_DATA_LEN	(CAN_MAX_DLEN - J1939_DT_DATA_OFF)
+/* highest TP sequence number: the field is one byte */
+#define J1939_DT_SEQ_MAX	UINT8_MAX
+/* largest TP message; anything larger needs ETP */
+#define J1939_TP_MAX_SIZE	(J1939_DT_SEQ_MAX * J1939_DT_DATA_LEN)
+_Static_assert(J1939_TP_MAX_SIZE == 1785,
+	       "SAE J1939-21:2001 section 5.10.1.1 gives 1785 bytes");
+/* number of TP/ETP DT packets needed for len bytes, rounded up */
+#define J1939_NUM_PKTS(len)	DIV_ROUND_UP(len, J1939_DT_DATA_LEN)
+
+/*
+ * J1939 uses 29-bit data frames only (no RTR, no error frames), see
+ * net/can/j1939/main.c.
+ */
+static inline bool j1939_is_data_frame(canid_t can_id)
+{
+	return (can_id & (CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_ERR_FLAG)) ==
+	       CAN_EFF_FLAG;
+}
+
+/*
+ * Size of a CAN_RAW receive buffer large enough for a full ETP burst.
+ * A round number with headroom, not a computed minimum. Set best-effort
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
+/* Set by j1939_test_main() from the CANIF environment variable. */
+static char CANIF[IFNAMSIZ];
+
+/*
+ * Return relaxed_ms by default, or strict_ms if J1939_STRICT_TIMING is set in
+ * the environment. See "Timing modes" at the top of this file.
+ */
+static inline int j1939_timing_ms(int relaxed_ms, int strict_ms)
+{
+	return getenv("J1939_STRICT_TIMING") ? strict_ms : relaxed_ms;
+}
+
+/* Resolve the ifindex of the test interface named by CANIF. */
+static inline int j1939_if_index(void)
+{
+	struct ifreq ifr = {};
+	int s, idx = -1;
+
+	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	if (s < 0)
+		return -1;
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", CANIF);
+	if (ioctl(s, SIOCGIFINDEX, &ifr) >= 0)
+		idx = ifr.ifr_ifindex;
+	close(s);
+	return idx;
+}
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
+ * Open a J1939 socket bound to (name, sa, pgn); flags may set
+ * J1939_OPEN_BCAST.
+ */
+static inline int j1939_open_flags(int ifindex, name_t name, uint8_t sa,
+				   pgn_t pgn, int flags)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = ifindex,
+	};
+	int s, one = 1;
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
+	addr.can_addr.j1939.name = name;
+	addr.can_addr.j1939.addr = sa;
+	addr.can_addr.j1939.pgn = pgn;
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+/* Open a J1939 socket bound to (sa, pgn) with no NAME and no broadcast. */
+static inline int j1939_open(int ifindex, uint8_t sa, pgn_t pgn)
+{
+	return j1939_open_flags(ifindex, J1939_NO_NAME, sa, pgn,
+				J1939_OPEN_NONE);
+}
+
+/* Connect a J1939 socket to the peer (name, da, pgn). */
+static inline bool j1939_connect_name_ok(int s, int ifindex, name_t name,
+					 uint8_t da, pgn_t pgn)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = ifindex,
+	};
+
+	addr.can_addr.j1939.name = name;
+	addr.can_addr.j1939.addr = da;
+	addr.can_addr.j1939.pgn = pgn;
+	return !connect(s, (struct sockaddr *)&addr, sizeof(addr));
+}
+
+static inline bool j1939_connect_ok(int s, int ifindex, uint8_t da, pgn_t pgn)
+{
+	return j1939_connect_name_ok(s, ifindex, J1939_NO_NAME, da, pgn);
+}
+
+/* Fill a sockaddr_can describing a J1939 (name, da, pgn) destination. */
+static inline void j1939_fill_sockaddr(struct sockaddr_can *addr, int ifindex,
+				       name_t name, uint8_t da, pgn_t pgn)
+{
+	memset(addr, 0, sizeof(*addr));
+	addr->can_family = AF_CAN;
+	addr->can_ifindex = ifindex;
+	addr->can_addr.j1939.name = name;
+	addr->can_addr.j1939.addr = da;
+	addr->can_addr.j1939.pgn = pgn;
+}
+
+/* sendto() len bytes from buf to the J1939 destination dst. */
+static inline ssize_t j1939_sendto_addr(int s, const void *buf, size_t len,
+					const struct sockaddr_can *dst)
+{
+	return sendto(s, buf, len, 0, (const struct sockaddr *)dst,
+		      sizeof(*dst));
+}
+
+/* sendto() len bytes from buf to the J1939 (name, da, pgn) destination. */
+static inline ssize_t j1939_sendto(int s, const void *buf, size_t len,
+				   int ifindex, name_t name, uint8_t da,
+				   pgn_t pgn)
+{
+	struct sockaddr_can dst;
+
+	j1939_fill_sockaddr(&dst, ifindex, name, da, pgn);
+	return j1939_sendto_addr(s, buf, len, &dst);
+}
+
+/* One j1939_sendto() that sent all len bytes; no retry. */
+static inline bool j1939_sendto_ok(int s, const void *buf, size_t len,
+				   int ifindex, name_t name, uint8_t da,
+				   pgn_t pgn)
+{
+	ssize_t want_len = len;
+
+	return j1939_sendto(s, buf, len, ifindex, name, da, pgn) == want_len;
+}
+
+/* One send(), write() or read() that moved all len bytes; no retry. */
+static inline bool send_all_ok(int s, const void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return send(s, buf, len, 0) == want_len;
+}
+
+static inline bool write_all_ok(int fd, const void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return write(fd, buf, len) == want_len;
+}
+
+static inline bool read_all_ok(int fd, void *buf, size_t len)
+{
+	ssize_t want_len = len;
+
+	return read(fd, buf, len) == want_len;
+}
+
+/*
+ * Open a CAN_RAW socket on ifindex. Unless rcvbuf is J1939_RAW_RCVBUF_DEFAULT,
+ * request that SO_RCVBUFFORCE size (best-effort: a failure is logged, not
+ * fatal).
+ */
+static inline int open_raw_rcvbuf(int ifindex, int rcvbuf)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = ifindex,
+	};
+	int s;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+
+	if (rcvbuf != J1939_RAW_RCVBUF_DEFAULT &&
+	    setsockopt(s, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(rcvbuf)))
+		fprintf(stderr, "# %s: SO_RCVBUFFORCE(%d) failed: %d\n",
+			__func__, rcvbuf, errno);
+
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+static inline int open_raw(int ifindex)
+{
+	return open_raw_rcvbuf(ifindex, J1939_RAW_RCVBUF_DEFAULT);
+}
+
+/*
+ * FIXTURE_SETUP helper: open a CAN_RAW socket on self->ifindex into self->raw
+ * with the given SO_RCVBUFFORCE size (or J1939_RAW_RCVBUF_DEFAULT) and abort
+ * the test if it cannot be opened. Used as a statement:
+ * J1939_SETUP_RAW(self, rcvbuf);
+ */
+#define J1939_SETUP_RAW(self, rcvbuf)					       \
+	do {								       \
+		(self)->raw = open_raw_rcvbuf((self)->ifindex, (rcvbuf));      \
+		ASSERT_GE((self)->raw, 0)				       \
+			TH_LOG("failed to open raw socket: %d", errno);	       \
+	} while (0)
+
+/* poll() + recv(): returns the recv() result, or -1 on timeout/error. */
+static inline ssize_t recv_timeout(int s, void *buf, size_t len,
+				   int timeout_ms)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+
+	if (poll(&pfd, 1, timeout_ms) <= 0)
+		return -1;
+	return recv(s, buf, len, 0);
+}
+
+/*
+ * recvfrom() one message on s within timeout_ms, check that it is the len
+ * bytes in want, and return the sender in *src unless src is NULL. The buffer
+ * has one spare byte, so a longer message fails the check.
+ */
+static inline bool recvfrom_verify_ok(int s, const void *want, size_t len,
+				      int timeout_ms, struct sockaddr_can *src)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+	socklen_t src_len = sizeof(*src);
+	uint8_t *rx_buf = malloc(len + 1);
+	ssize_t want_len = len, n = -1;
+	bool ok;
+
+	if (!rx_buf)
+		return false;
+
+	if (poll(&pfd, 1, timeout_ms) > 0)
+		n = recvfrom(s, rx_buf, len + 1, 0, (struct sockaddr *)src,
+			     &src_len);
+	ok = n == want_len && !memcmp(want, rx_buf, len);
+
+	free(rx_buf);
+	return ok;
+}
+
+/* recvfrom_verify_ok() without the sender. */
+static inline bool recv_verify_ok(int s, const void *want, size_t len,
+				  int timeout_ms)
+{
+	return recvfrom_verify_ok(s, want, len, timeout_ms, NULL);
+}
+
+/* Send len bytes on tx and verify they arrive byte-for-byte on rx. */
+static inline bool send_recv_verify_ok(int tx, int rx, const void *buf,
+				       size_t len, int timeout_ms)
+{
+	if (!send_all_ok(tx, buf, len))
+		return false;
+	return recv_verify_ok(rx, buf, len, timeout_ms);
+}
+
+/* Receive one whole CAN frame from a raw socket within timeout_ms. */
+static inline bool recv_frame_ok(int raw, struct can_frame *frame,
+				 int timeout_ms)
+{
+	ssize_t want_len = sizeof(*frame);
+
+	return recv_timeout(raw, frame, sizeof(*frame), timeout_ms) == want_len;
+}
+
+/* Encode a J1939 single frame the way the kernel does on transmit. */
+static inline canid_t j1939_canid(uint8_t prio, pgn_t pgn, uint8_t da,
+				  uint8_t sa)
+{
+	canid_t id = CAN_EFF_FLAG | (prio << J1939_ID_PRIO_SHIFT) |
+		     (pgn << J1939_ID_PGN_SHIFT) | sa;
+
+	/* the destination goes into the PS byte of the PGN field */
+	if (J1939_IS_PDU1(pgn))
+		id |= da << J1939_ID_PGN_SHIFT;
+	return id;
+}
+
+/*
+ * Start a TP/ETP control frame: every byte J1939_FILL_BYTE, then the control
+ * byte cmd.
+ */
+static inline void cm_dat_init(uint8_t *dat, uint8_t cmd)
+{
+	memset(dat, J1939_FILL_BYTE, CAN_MAX_DLEN);
+	dat[J1939_CM_CMD_OFF] = cmd;
+}
+
+/*
+ * Serialize a 64-bit NAME little-endian into a buffer of sizeof(name_t)
+ * bytes (host-agnostic).
+ */
+static inline void put_name(uint8_t *dat, name_t name)
+{
+	size_t i;
+
+	for (i = 0; i < sizeof(name); i++)
+		dat[i] = name >> (CHAR_BIT * i);
+}
+
+/* Little-endian codecs for the TP/ETP CM multi-byte fields (host-agnostic). */
+static inline void put_le(uint8_t *p, uint32_t v, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		p[i] = v >> (CHAR_BIT * i);
+}
+
+static inline uint32_t get_le(const uint8_t *p, size_t n)
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
+static inline void put_le16(uint8_t *p, uint16_t v)
+{
+	put_le(p, v, sizeof(v));
+}
+
+static inline void put_le24(uint8_t *p, uint32_t v)
+{
+	put_le(p, v, J1939_LE24_LEN);
+}
+
+static inline void put_le32(uint8_t *p, uint32_t v)
+{
+	put_le(p, v, sizeof(v));
+}
+
+static inline uint16_t get_le16(const uint8_t *p)
+{
+	return get_le(p, sizeof(uint16_t));
+}
+
+static inline uint32_t get_le24(const uint8_t *p)
+{
+	return get_le(p, J1939_LE24_LEN);
+}
+
+static inline uint32_t get_le32(const uint8_t *p)
+{
+	return get_le(p, sizeof(uint32_t));
+}
+
+/* Embed the PGN of the transported message into a TP/ETP control frame. */
+static inline void put_pgn(uint8_t *dat, pgn_t pgn)
+{
+	put_le24(&dat[J1939_CM_PGN_OFF], pgn);
+}
+
+/* Send one J1939-encoded frame of CAN_MAX_DLEN bytes with priority prio. */
+static inline bool send_raw8_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da,
+				uint8_t sa, const uint8_t dat[CAN_MAX_DLEN])
+{
+	struct can_frame f = {};
+
+	f.can_id = j1939_canid(prio, pgn, da, sa);
+	f.can_dlc = CAN_MAX_DLEN;
+	memcpy(f.data, dat, CAN_MAX_DLEN);
+	return write_all_ok(raw, &f, sizeof(f));
+}
+
+/*
+ * Payload bytes of the DT frame that starts at offset off of a message of
+ * size bytes; off must be below size.
+ */
+static inline size_t j1939_dt_chunk_len(size_t size, size_t off)
+{
+	size_t n = size - off;
+
+	return n < J1939_DT_DATA_LEN ? n : J1939_DT_DATA_LEN;
+}
+
+/*
+ * Send a TP/ETP data (DT) frame: sequence number seq and up to
+ * J1939_DT_DATA_LEN bytes from offset off of payload, a message of size
+ * bytes.
+ */
+static inline bool send_dt_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da,
+			      uint8_t sa, uint8_t seq, const uint8_t *payload,
+			      size_t off, size_t size)
+{
+	uint8_t dat[CAN_MAX_DLEN];
+
+	/*
+	 * off >= size would make the size_t subtraction size - off
+	 * underflow.
+	 */
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
+/* Milliseconds from a to b (negative if b is earlier), CLOCK_MONOTONIC. */
+static inline long timespec_diff_ms(const struct timespec *a,
+				    const struct timespec *b)
+{
+	return ((b->tv_sec - a->tv_sec) * NSEC_PER_SEC +
+		(b->tv_nsec - a->tv_nsec)) / NSEC_PER_MSEC;
+}
+
+/* Set *deadline to timeout_ms from now on CLOCK_MONOTONIC. */
+static inline void deadline_after_ms(struct timespec *deadline, int timeout_ms)
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
+static inline bool recv_match_ok(int raw, int timeout_ms,
+				 struct can_frame *frame,
+				 bool (*match)(canid_t id, const void *ctx),
+				 const void *ctx)
+{
+	struct pollfd pfd = { .fd = raw, .events = POLLIN };
+	struct timespec now, deadline;
+	int remaining = timeout_ms;
+
+	deadline_after_ms(&deadline, timeout_ms);
+
+	while (remaining > 0 && poll(&pfd, 1, remaining) > 0) {
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
+struct j1939_peer_match { uint8_t want_pf, want_da, want_sa; };
+
+static inline bool match_peer_dest(canid_t id, const void *ctx)
+{
+	const struct j1939_peer_match *m = ctx;
+
+	return j1939_id_pf(id) == m->want_pf &&
+	       j1939_id_ps(id) == m->want_da &&		/* destination */
+	       j1939_id_sa(id) == m->want_sa;		/* source */
+}
+
+/*
+ * Receive the next frame whose CAN-id PF == want_pf, sent from want_sa to
+ * want_da (PS).
+ */
+static inline bool recv_for_peer_ok(int raw, uint8_t want_pf, uint8_t want_da,
+				    uint8_t want_sa, struct can_frame *frame,
+				    int timeout_ms)
+{
+	struct j1939_peer_match m = {
+		.want_pf = want_pf, .want_da = want_da, .want_sa = want_sa,
+	};
+
+	return recv_match_ok(raw, timeout_ms, frame, match_peer_dest, &m);
+}
+
+/* recv_for_peer_ok() and check that the control byte is want_cmd. */
+static inline bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
+				  uint8_t want_sa, struct can_frame *frame,
+				  int timeout_ms, uint8_t want_cmd)
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
+/*
+ * Fill buf with a deterministic, position-dependent byte pattern. The
+ * i >> CHAR_BIT term makes each 256-byte block differ, so a misplaced packet
+ * shows up.
+ */
+static inline void fill_pattern(uint8_t *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = i ^ (i >> CHAR_BIT) ^ J1939_PATTERN_SEED;
+}
+
+/* Is the CAN protocol proto missing from this kernel? */
+static inline bool can_proto_missing(int type, int proto)
+{
+	int probe = socket(PF_CAN, type, proto);
+
+	if (probe < 0)
+		return errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT;
+
+	close(probe);
+	return false;
+}
+
+/*
+ * Body of each test's main(): require CANIF in the environment and a kernel
+ * that supports CAN_J1939 and CAN_RAW, then run the harness. Skip when any
+ * of them is missing.
+ */
+static inline int j1939_test_main(int argc, char **argv)
+{
+	char *ifname = getenv("CANIF");
+
+	if (!ifname) {
+		fprintf(stderr, "# CANIF must name the test interface\n");
+		return KSFT_SKIP;
+	}
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
+
+	if (can_proto_missing(SOCK_DGRAM, CAN_J1939) ||
+	    can_proto_missing(SOCK_RAW, CAN_RAW))
+		return KSFT_SKIP;
+
+	return test_harness_run(argc, argv);
+}
+
+#endif /* __SELFTESTS_NET_CAN_J1939_TESTS_H__ */

-- 
2.47.3

