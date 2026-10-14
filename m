Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469B55C330;
	Wed, 14 Oct 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992683; cv=pass; b=TMoVGc8CVSCmeNgMtaVUqwTz3kFRTNf+Qf88XcUajgbuUPMvIM1QViUUg/y+B0J1MQ6OjMJQ3vUUWhIcc9DdvDbN5+j7XE2K2aoAmvvrelonLwj++KV7UmteXHWDYshvtoY1UV055h88jhUmjYppf+odIqp0qLIUL+7PVh/Qquw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992683; c=relaxed/simple;
	bh=J2ccaNOPW+EaZZsMJQfLNQ2fWLJ/p8F3BBwaWLEdB9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBMuuCj8DKU5MNx6qLg9YQuM9hFGGWHT4S7QzRDTvxdjWT/btwD2dNS/JdUchs1tmwfrIuO/HOh0aOVAS92lTrXNGLTHyijbMgUCWLNdgt+HzzrsZw+h6gJumv5RKrWoWXcSChWVAd8aWG/r84ncSnWQYzAjI9z68uky3TTs8Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=b7s08Kwl; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="b7s08Kwl"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 20EEF201BAB;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF3lYak3vat4AxScAREkSdfIFmJyPG4Qtxyf8ws33Jw=;
	b=b7s08KwlRDF4d9wF3HxiLz1J9Dve9Ej/+FrlIH6a2A3uVigsEDhxy2QrAGTI2sU5kCj99h
	dpwLe/EiAVzRJa9Tp7SDIEIpi64K1LwINH1GMrebgJpemQZTSrnUKi7p5dt9nvvd0boVa/
	FXN5g2W4r8dsSeOK4ZHth1dGE284nALFHUiWCXhhRXGDkdylKVNX5RJICHC/tRbsBe2bdT
	LKcrkW9C/QTKLRdmYHqZXDDg/4nXR/eEW9keaxlvixafWT50eLYa/O5hwPR+1CWJVD1E9Z
	7Oaljebxg5gcJ4qH+1G00CV1RwAD1K3eE9r7C45tIZVsXgeSr3XSaD2L3Nhr0A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=Hs8M9ogViyibs3U7BSzzVqyeRGi2zBiv8FCCGYR4Dp/MdTntaz6z9EMz8u0r1S4FMOdgfR
	borMvopGdRKflCSJkQj6izloStwD+6v/6WMhHm5JyFnYlNJd/Ok79zLmz013nBczAsftzz
	XZw1JtVxrbeldf14uYAWgScrR1nr1FdGYq+GhHikLFZoKtUL+zwftho0nCtTjLnK/OPB0m
	iJ4YpCqfE/tZBO2HDNej0yurxfmr46elxmtrhULbcIRbgIpreL5d46J1JmGVXhcv9tkAgM
	VQA6YNNZZEJ9L9VbUodG0K6Xd71MELKotxVwPDP2fuuCRx56CvEp+xvN8yuKGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF3lYak3vat4AxScAREkSdfIFmJyPG4Qtxyf8ws33Jw=;
	b=Ob3mMzQUaU0LHx8IVrNSlemNaATaypdWDn7HQv3Cbd5zCmpoxJICuuiC8Yl5Sm4PjpdVuI
	DaY4U1mYStUrpLULxvXXSmTNhMrL0jJug8DLsHTSp4mI+5rf6hHsXnS5nIIiUAi5JgEmG9
	baEnNgpxYlb0IRQHC3Dz31shu2kv2LASarvogrybS2MfKXsDHiWqoTbejvSs3khDkok+js
	zv1ejjsmkhqEtwbgVmNd7xiPMsas8zY7ZblfzP7n5p6QF4TGFDGKbh+Uc+XiZvzg3JeHlM
	wDFV4rtRa7CykGJAbXsD1yVzIRXPJd35V4bQlVN+2Und5qE/3VfgIRQoh1XyUw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 079BF381B0F; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 1/8] selftests: can: add J1939 test helper header and library
Date: Wed, 14 Oct 2026 17:44:27 +0200
Message-ID: <20261014154435.3577983-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154435.3577983-1-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add two shared pieces used by all of the J1939 selftests that follow:

 - j1939_tests.h: the common C helpers, as static inline functions and
   macros grouped and documented by purpose, so each test .c keeps to the
   behaviour it checks rather than the socket and wire plumbing.
 - j1939_lib.sh: the shared vcan setup/cleanup and test runner; a wrapper
   just sets J1939_TEST_PROG and sources it.

They remove boilerplate the tests would otherwise repeat: resolving the
test interface, opening and connecting CAN_J1939 sockets, opening a
CAN_RAW socket, poll()+recv() and send/verify helpers, CAN-ID and
PGN/NAME encoding, the raw TP/ETP frame building blocks, and vcan
bring-up in every shell wrapper.

No tests use them yet; the following patches add the tests on top.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/Makefile      |   2 +
 tools/testing/selftests/net/can/j1939_lib.sh  |  74 +++
 tools/testing/selftests/net/can/j1939_tests.h | 460 ++++++++++++++++++
 3 files changed, 536 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/j1939_lib.sh
 create mode 100644 tools/testing/selftests/net/can/j1939_tests.h

diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 5b82e60a03e7..e2092c289109 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := test_raw_filter.sh
 
+TEST_FILES := j1939_lib.sh
+
 TEST_GEN_FILES := test_raw_filter
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/j1939_lib.sh b/tools/testing/selftests/net/can/j1939_lib.sh
new file mode 100644
index 000000000000..7b7fff228b16
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_lib.sh
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Shared bring-up for the J1939 selftest wrappers. A wrapper sets
+# J1939_TEST_PROG to its test binary and sources this file:
+#
+#	J1939_TEST_PROG=test_j1939_base
+#	source "$(dirname "$0")/j1939_lib.sh"
+#
+# It sets up (and tears down) the CAN interface named by CANIF (a vcan by
+# default), runs the test binary through the kselftest net lib and reports the
+# result.
+
+ALL_TESTS="j1939_run"
+
+net_dir=$(dirname "$0")/..
+source "$net_dir/lib.sh"
+
+export CANIF=${CANIF:-"vcan0"}
+# 250 kbit/s: ISO 11783-2:2002 §3.6 (nominal 4 us bit time); same value in SAE
+# J1939-11:2006 §3.12. J1939-15:1999 §3.14 Table 1 defers to J1939-11.
+# Only the real-CAN path uses this; the default vcan ignores bitrate.
+BITRATE=${BITRATE:-250000}
+
+# Only undo what this script actually did: delete a vcan we created, and bring
+# down an interface only if we brought it up. A failed setup() (e.g. CANIF
+# already exists) must not disturb a pre-existing interface.
+created=0
+brought_up=0
+
+setup()
+{
+	if [[ $CANIF == vcan* ]]; then
+		ip link add name "$CANIF" type vcan || exit $ksft_skip
+		created=1
+	else
+		ip link set dev "$CANIF" type can bitrate "$BITRATE" || exit $ksft_skip
+	fi
+	ip link set dev "$CANIF" up || exit $ksft_skip
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
+	./"$J1939_TEST_PROG"
+	rc=$?
+	# The test binary exits ksft_skip when CANIF is missing or the kernel
+	# lacks CAN_J1939; keep that a skip instead of letting check_err turn
+	# any non-zero into a failure.
+	if ((rc == ksft_skip)); then
+		ret_set_ksft_status $ksft_skip "$J1939_TEST_PROG"
+	else
+		check_err $rc
+	fi
+	log_test "$J1939_TEST_PROG"
+}
+
+trap cleanup EXIT INT TERM
+setup
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
new file mode 100644
index 000000000000..dd70a7d60ec7
--- /dev/null
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -0,0 +1,460 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Shared helpers for the J1939 selftests.
+ *
+ * The individual tests are standalone kselftest binaries, so the common
+ * boilerplate (interface lookup, socket open/connect, timed receive, CAN-ID
+ * encoding and the CANIF/main() plumbing) lives here as static inline helpers.
+ *
+ * The including .c file must include "kselftest_harness.h" before this header
+ * (the J1939_TEST_MAIN() macro uses KSFT_SKIP and test_harness_run()).
+ */
+#ifndef __SELFTESTS_NET_CAN_J1939_TESTS_H__
+#define __SELFTESTS_NET_CAN_J1939_TESTS_H__
+
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
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(a)		(sizeof(a) / sizeof((a)[0]))
+#endif
+
+/* Harness patience for an expected frame (not a protocol timer). */
+#define J1939_RECV_TIMEOUT_MS	2000
+
+/*
+ * Timeout for a check that expects no frame. Long enough that a real
+ * local frame would have arrived, so a timeout means "nothing came".
+ * Much shorter than J1939_RECV_TIMEOUT_MS, to keep the test fast.
+ */
+#define J1939_NEG_RECV_TIMEOUT_MS	300
+
+/* kernel's default J1939 TX priority (net/can/j1939 seeds 6). */
+#define J1939_PRIO_DEFAULT	6
+
+/* J1939 PGN helpers: PF >= 0xf0 selects PDU2 (broadcast, no destination). */
+#define J1939_PF(pgn)		(((pgn) >> 8) & 0xff)
+#define J1939_PS(pgn)		((pgn) & 0xff)
+#define J1939_IS_PDU1(pgn)	(J1939_PF(pgn) < 0xf0)
+
+/* Decoders for the fields of a received 29-bit CAN id (mask with CAN_EFF_MASK). */
+#define J1939_ID_PRIO(id)	(((id) >> 26) & 0x7)
+#define J1939_ID_PF(id)		(((id) >> 16) & 0xff)
+#define J1939_ID_PS(id)		(((id) >> 8) & 0xff)
+#define J1939_ID_SA(id)		((id) & 0xff)
+
+/* Number of 7-byte TP/ETP DT packets needed for len bytes, rounded up. */
+#define J1939_NUM_PKTS(len)	(((len) + 6) / 7)
+
+/*
+ * Size of a CAN_RAW receive buffer large enough for a full ETP burst.
+ * A generous round-number headroom, not a computed minimum; applied
+ * best-effort via SO_RCVBUFFORCE.
+ */
+#define J1939_RAW_BIG_RCVBUF	(8 * 1024 * 1024)
+
+/* Flags for j1939_open_flags(). */
+#define J1939_OPEN_BCAST	(1 << 0)
+
+/* Set by J1939_TEST_MAIN() from the CANIF environment variable. */
+static char CANIF[IFNAMSIZ];
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
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name) - 1);
+	if (ioctl(s, SIOCGIFINDEX, &ifr) >= 0)
+		idx = ifr.ifr_ifindex;
+	close(s);
+	return idx;
+}
+
+/*
+ * FIXTURE_SETUP helper: resolve CANIF's ifindex into self->ifindex and abort the
+ * test if it cannot be found. Used as a statement: J1939_SETUP_IFINDEX(self);
+ */
+#define J1939_SETUP_IFINDEX(self)					       \
+	do {								       \
+		(self)->ifindex = j1939_if_index();			       \
+		ASSERT_GE((self)->ifindex, 0)				       \
+			TH_LOG("failed to resolve ifindex for '%s': %d",       \
+			       CANIF, errno);				       \
+	} while (0)
+
+/* Open a J1939 socket bound to (name, sa, pgn); flags may set J1939_OPEN_BCAST. */
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
+	if ((flags & J1939_OPEN_BCAST) &&
+	    setsockopt(s, SOL_SOCKET, SO_BROADCAST, &one, sizeof(one))) {
+		close(s);
+		return -1;
+	}
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
+	return j1939_open_flags(ifindex, J1939_NO_NAME, sa, pgn, 0);
+}
+
+/* Connect a J1939 socket to the peer (name, da, pgn). */
+static inline int j1939_connect_name(int s, int ifindex, name_t name,
+				     uint8_t da, pgn_t pgn)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_CAN,
+		.can_ifindex = ifindex,
+	};
+
+	addr.can_addr.j1939.name = name;
+	addr.can_addr.j1939.addr = da;
+	addr.can_addr.j1939.pgn = pgn;
+	return connect(s, (struct sockaddr *)&addr, sizeof(addr));
+}
+
+static inline int j1939_connect(int s, int ifindex, uint8_t da, pgn_t pgn)
+{
+	return j1939_connect_name(s, ifindex, J1939_NO_NAME, da, pgn);
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
+/* sendto() len bytes from buf to the J1939 (name, da, pgn) destination. */
+static inline int j1939_sendto(int s, const void *buf, size_t len, int ifindex,
+			       name_t name, uint8_t da, pgn_t pgn)
+{
+	struct sockaddr_can dst;
+
+	j1939_fill_sockaddr(&dst, ifindex, name, da, pgn);
+	return sendto(s, buf, len, 0, (struct sockaddr *)&dst, sizeof(dst));
+}
+
+/*
+ * Open a CAN_RAW socket on ifindex. rcvbuf > 0 requests that SO_RCVBUFFORCE
+ * size (best-effort: a failure is logged, not fatal).
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
+	if (rcvbuf > 0 &&
+	    setsockopt(s, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(rcvbuf)))
+		fprintf(stderr, "%s: SO_RCVBUFFORCE(%d) failed: %d\n",
+			__func__, rcvbuf, errno);
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
+		close(s);
+		return -1;
+	}
+	return s;
+}
+
+static inline int open_raw(int ifindex)
+{
+	return open_raw_rcvbuf(ifindex, 0);
+}
+
+/*
+ * FIXTURE_SETUP helper: open a CAN_RAW socket on self->ifindex into self->raw
+ * with the given SO_RCVBUFFORCE size (0 for the default) and abort the test if
+ * it cannot be opened. Used as a statement: J1939_SETUP_RAW(self, rcvbuf);
+ */
+#define J1939_SETUP_RAW(self, rcvbuf)					       \
+	do {								       \
+		(self)->raw = open_raw_rcvbuf((self)->ifindex, (rcvbuf));      \
+		ASSERT_GE((self)->raw, 0)				       \
+			TH_LOG("failed to open raw socket: %d", errno);	       \
+	} while (0)
+
+/* poll() + recv(): returns the recv() result, or -1 on timeout/error. */
+static inline int recv_timeout(int s, void *buf, size_t len, int timeout_ms)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLIN };
+
+	if (poll(&pfd, 1, timeout_ms) <= 0)
+		return -1;
+	return recv(s, buf, len, 0);
+}
+
+/* Send len bytes on tx and verify they arrive byte-for-byte on rx. 0 / -1. */
+static inline int send_recv_verify(int tx, int rx, const void *buf, size_t len,
+				   int timeout_ms)
+{
+	uint8_t *rx_buf = malloc(len);
+	int rc = -1;
+
+	if (!rx_buf)
+		return -1;
+	if (send(tx, buf, len, 0) == (ssize_t)len &&
+	    recv_timeout(rx, rx_buf, len, timeout_ms) == (int)len &&
+	    memcmp(buf, rx_buf, len) == 0)
+		rc = 0;
+	free(rx_buf);
+	return rc;
+}
+
+/* Encode a J1939 single frame the way the kernel does on transmit. */
+static inline canid_t j1939_canid(uint8_t prio, pgn_t pgn, uint8_t da,
+				  uint8_t sa)
+{
+	canid_t id = CAN_EFF_FLAG | ((canid_t)prio << 26) | (pgn << 8) | sa;
+
+	if (J1939_IS_PDU1(pgn))
+		id |= (canid_t)da << 8;
+	return id;
+}
+
+/* Start an 8-byte TP/ETP control frame: unused CM bytes are 0xff, byte 0 = cmd. */
+static inline void ctl_dat_init(uint8_t *dat, uint8_t cmd)
+{
+	memset(dat, 0xff, 8);
+	dat[0] = cmd;
+}
+
+/* Embed a 24-bit PGN into a TP/ETP control frame (bytes 5..7, little endian). */
+static inline void put_pgn(uint8_t *dat, pgn_t pgn)
+{
+	dat[5] = pgn;
+	dat[6] = pgn >> 8;
+	dat[7] = pgn >> 16;
+}
+
+/* Serialize a 64-bit NAME little-endian into an 8-byte buffer (host-agnostic). */
+static inline void put_name(uint8_t *dat, name_t name)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		dat[i] = (uint8_t)(name >> (8 * i));
+}
+
+/* Little-endian codecs for the TP/ETP CM multi-byte fields (host-agnostic). */
+static inline void put_le16(uint8_t *p, uint16_t v)
+{
+	p[0] = v;
+	p[1] = v >> 8;
+}
+
+static inline void put_le24(uint8_t *p, uint32_t v)
+{
+	p[0] = v;
+	p[1] = v >> 8;
+	p[2] = v >> 16;
+}
+
+static inline void put_le32(uint8_t *p, uint32_t v)
+{
+	p[0] = v;
+	p[1] = v >> 8;
+	p[2] = v >> 16;
+	p[3] = v >> 24;
+}
+
+static inline uint16_t get_le16(const uint8_t *p)
+{
+	return (uint16_t)(p[0] | (p[1] << 8));
+}
+
+static inline uint32_t get_le24(const uint8_t *p)
+{
+	return (uint32_t)p[0] | ((uint32_t)p[1] << 8) | ((uint32_t)p[2] << 16);
+}
+
+static inline uint32_t get_le32(const uint8_t *p)
+{
+	return (uint32_t)p[0] | ((uint32_t)p[1] << 8) |
+	       ((uint32_t)p[2] << 16) | ((uint32_t)p[3] << 24);
+}
+
+/* Send one 8-byte J1939-encoded frame (any PGN) with the given priority. */
+static inline int send_raw8(int raw, uint8_t prio, pgn_t pgn, uint8_t da,
+			    uint8_t sa, const uint8_t dat[8])
+{
+	struct can_frame f = {};
+
+	f.can_id = j1939_canid(prio, pgn, da, sa);
+	f.can_dlc = 8;
+	memcpy(f.data, dat, 8);
+	return write(raw, &f, sizeof(f)) == (int)sizeof(f) ? 0 : -1;
+}
+
+/* Send a TP/ETP data (DT) frame carrying seq + up to 7 payload bytes. */
+static inline int send_dt(int raw, uint8_t prio, pgn_t dat_pgn, uint8_t da,
+			  uint8_t sa, uint8_t seq, const uint8_t *payload,
+			  size_t off, size_t total)
+{
+	struct can_frame f = {};
+	size_t n;
+
+	/* off >= total would make the size_t subtraction total - off underflow. */
+	if (off >= total)
+		return -1;
+	n = total - off;
+	if (n > 7)
+		n = 7;
+	f.can_id = j1939_canid(prio, dat_pgn, da, sa);
+	f.can_dlc = 8;
+	memset(f.data, 0xff, 8);
+	f.data[0] = seq;
+	memcpy(&f.data[1], payload + off, n);
+	return write(raw, &f, sizeof(f)) == (int)sizeof(f) ? 0 : -1;
+}
+
+/* Elapsed milliseconds between two CLOCK_MONOTONIC samples. */
+static inline long timespec_diff_ms(const struct timespec *a, const struct timespec *b)
+{
+	return (b->tv_sec - a->tv_sec) * 1000 + (b->tv_nsec - a->tv_nsec) / 1000000;
+}
+
+/* Poll+recv on raw until match() accepts a frame, else timeout. 0/-1. */
+static inline int recv_match(int raw, int timeout_ms, struct can_frame *frame,
+			     bool (*match)(canid_t id, const void *ctx),
+			     const void *ctx)
+{
+	struct pollfd pfd = { .fd = raw, .events = POLLIN };
+	struct timespec now, deadline;
+	int remaining = timeout_ms;
+
+	/*
+	 * Non-matching frames (other traffic on the bus) must not refresh the
+	 * timeout, or a busy bus would keep the loop alive forever. Poll against
+	 * a fixed deadline and shrink the budget after every frame.
+	 */
+	clock_gettime(CLOCK_MONOTONIC, &deadline);
+	deadline.tv_sec += timeout_ms / 1000;
+	deadline.tv_nsec += (long)(timeout_ms % 1000) * 1000000;
+	if (deadline.tv_nsec >= 1000000000) {
+		deadline.tv_sec++;
+		deadline.tv_nsec -= 1000000000;
+	}
+	while (remaining > 0 && poll(&pfd, 1, remaining) > 0) {
+		if (recv(raw, frame, sizeof(*frame), 0) < 0)
+			return -1;
+		if (match(frame->can_id & CAN_EFF_MASK, ctx))
+			return 0;
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		remaining = timespec_diff_ms(&now, &deadline);
+	}
+	return -1;
+}
+
+struct j1939_peer_match { uint8_t want_pf, want_da; };
+static inline bool match_peer_dest(canid_t id, const void *ctx)
+{
+	const struct j1939_peer_match *m = ctx;
+
+	return J1939_ID_PF(id) == m->want_pf &&
+	       J1939_ID_PS(id) == m->want_da;		/* destination */
+}
+
+/* Receive the next frame whose CAN-id PF == want_pf addressed to want_da (PS). */
+static inline int recv_for_peer(int raw, uint8_t want_pf, uint8_t want_da,
+				struct can_frame *frame, int timeout_ms)
+{
+	struct j1939_peer_match m = { .want_pf = want_pf, .want_da = want_da };
+
+	return recv_match(raw, timeout_ms, frame, match_peer_dest, &m);
+}
+
+/* recv_for_peer() + check the control command byte; 0 on match, -1 otherwise. */
+static inline int recv_ctl_cmd(int raw, uint8_t want_pf, uint8_t want_da,
+			       struct can_frame *frame, int timeout_ms,
+			       uint8_t want_cmd)
+{
+	if (recv_for_peer(raw, want_pf, want_da, frame, timeout_ms))
+		return -1;
+	return frame->data[0] == want_cmd ? 0 : -1;
+}
+
+/* Fill buf with a deterministic, position-dependent byte pattern. */
+static inline void fill_pattern(uint8_t *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = (uint8_t)(i ^ (i >> 8) ^ 0x3c);
+}
+
+/*
+ * Define main(): require CANIF in the environment and a kernel that supports
+ * CAN_J1939, then run the harness. Skip (rather than fail) when either is
+ * missing, per the kselftest skip contract.
+ */
+#define J1939_TEST_MAIN()						       \
+int main(int argc, char **argv)						       \
+{									       \
+	char *ifname = getenv("CANIF");					       \
+	int probe;							       \
+									       \
+	if (!ifname) {							       \
+		fprintf(stderr,						       \
+			"CANIF environment variable must contain the test interface\n"); \
+		return KSFT_SKIP;					       \
+	}								       \
+	strncpy(CANIF, ifname, sizeof(CANIF) - 1);			       \
+									       \
+	probe = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);			       \
+	if (probe < 0) {						       \
+		if (errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT)	       \
+			return KSFT_SKIP;				       \
+	} else {							       \
+		close(probe);						       \
+	}								       \
+	return test_harness_run(argc, argv);				       \
+}
+
+#endif /* __SELFTESTS_NET_CAN_J1939_TESTS_H__ */
-- 
2.47.3

