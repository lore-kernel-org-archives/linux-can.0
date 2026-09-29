Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65883E49FD;
	Tue, 29 Sep 2026 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661897; cv=none; b=bbq05kGZj0BR01t1b249WmC7Hkpu36eArckk4C9WI5apE8AIAgdelr6JT3nMj8B65QJhqQWsAVkMqN+KZ7fc/o8DkKUbB2u5YhjhuWCIp4LUxPYnCV/EMJFrHO1UNQttpvcMUSfN2ou2NqcsKrH06l5wV9wsBX27o60Q/YBdtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661897; c=relaxed/simple;
	bh=Rb3NmnSDlO+//5WJLtTPrpbNk2i7MEfTaZIJnflnl+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CthHZWhHEy9tp0VQ4sVNUxnx+FdD+xS4IuRf+cUjcNKEOq5HzT9a1Nm7cAuGjBt3Aw8UzjpvU7MW60SDlR4Eg9U+7hyvb9/hmpBeqeBHnnByhHMV/QEsY0D1DtOQWzTk8HTnQJYBUQulIBoiU1Clp4UsA2aD6QCAs0XIib+bP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UFZV/+e7; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UFZV/+e7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ue
	UUTvCgmVupjHXe5REbTlxoHe7iYV8BJ6D/WrUs4m8=; b=UFZV/+e7RMMZDTpSN6
	wY8BsynJplp9nq6rjyAfJ1MxZFCQ9nsZyjSPgHz90oDC99hPbkhULuTRyJDZCfIs
	IuxXcJkkZEMlOVoNpG0gGBkUr3I0WhcsGP2PfGkynHPDgTSFBPzpvP7g85OxctrM
	0mLP3j6r3PAN0+gt1QK+sppw8=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn9yvrVLtq8trKBQ--.20713S2;
	Tue, 29 Sep 2026 14:04:28 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Kaixuan Li <kaixuanli0131@gmail.com>
Subject: [PATCH v3] selftests: can: add isotp frame-type tests
Date: Tue, 29 Sep 2026 14:04:26 +0800
Message-ID: <20260929060427.2631865-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9yvrVLtq8trKBQ--.20713S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfWF1Utw4Uuw4xtFy7WF4Uurg_yoW5JFy3Jo
	Z3Gw43Kw15Kr15uFs8KF10gr4fuF4jyry5Jw4fJrs5JFnFqryYgryF9w4fWFsxAr409rZ8
	XFZ3Z3ySqFWktrn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjBMNUUUUU
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5A3ZT2q7VO3+SAAA3h

isotp_rcv() used to separate the Classic CAN from the CAN FD transport
channel by skb->len alone.  A CAN XL frame whose canxl_frame.len makes
skb->len equal CAN_MTU or CANFD_MTU passed that check and was then read
as a struct canfd_frame, whose len field overlaps canxl_frame.flags --
and CANXL_XLF (0x80) is mandatory, so that length is always past
CANFD_MAX_DLEN.  The flow control path used it unbounded and the socket
reported EBADMSG for a frame it never asked for.

The tree has no isotp test at all, so add one that pins the behaviour
down on both channels and keeps any future fix honest in both
directions.  Suite:

  - an XL frame must not be mistaken for a flow control frame on the
    Classic CAN channel (skb->len == CAN_MTU)
  - the same on the CAN FD channel (skb->len == CANFD_MTU)
  - a well-formed flow control frame must still be accepted, on both
    channels
  - a frame with wrong padding must still be reported, so that padding
    validation cannot be weakened to make the cases above pass

The acceptance cases require positive evidence rather than the mere
absence of an error: the socket has to act on the CTS and start sending
Consecutive Frames.  An XL frame is likewise only injected after the
receiver has been observed to enter ISOTP_WAIT_FC; that state is reached
through a First Frame, and a First Frame only goes out when the payload
does not fit into a Single Frame.  Without those preconditions the
injected frame is dropped at the state check and a case would pass for
the wrong reason.

The two cases that inject a CAN XL frame skip when the interface cannot
carry them, and the CAN FD acceptance case skips on an interface that does
not carry CAN FD frames.  The two Classic CAN cases run on any CAN
interface, so a host without CAN XL support still gets flow control and
padding coverage.  A CANIF that does not name an existing interface skips
as well, since it is the caller's choice of device.

The wrapper only removes the interface when it is the one that created
it.  CANIF defaults to vcan0, which on a developer's machine may already
be up and carrying traffic, and the exit trap is installed before setup
runs, so removing it unconditionally tears down an interface the test did
not own.

Review pointed out two things, both of which are addressed here:

  - The two buffers that hold a CAN XL frame were plain unsigned char
    arrays cast to struct canxl_frame *, which asks the compiler for more
    alignment than the array guarantees and makes the frame access a
    strict-aliasing question.  Declare the struct instead.  The one field
    that has to be written through a byte offset is written through a
    char pointer, so the test does not depend on byte order either.
    While here, compare the interface mtu as an int: iface_mtu() returns
    -1 for a missing interface, which would otherwise compare as
    CAN FD capable.

  - open_observer() and open_injector() requested CAN_RAW_XL_FRAMES
    unconditionally, so on a kernel that does not know the option every
    case failed -- including the two Classic CAN cases that never look at
    an XL frame.  Gate that one request on the has_xl probe.  The Classic
    and CAN FD cases keep running and skip only what the interface or the
    kernel cannot do.  CAN_RAW_FD_FRAMES is still requested
    unconditionally, since the Classic CAN cases need it for their own
    First Frame.

The .sh is unchanged from v2.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
Changes in v3:
- declare the CAN XL frame buffers as struct canxl_frame instead of
  casting unsigned char arrays, which removes both the alignment
  requirement and the aliasing question; write the one overlapping byte
  through a char pointer, so the test is byte order independent
- compare the interface mtu as an int, so a missing interface (-1) is not
  reported as CAN FD capable
- request CAN_RAW_XL_FRAMES only when the has_xl probe says the interface
  carries XL frames, so a kernel without that option still runs the
  Classic CAN and CAN FD cases instead of failing all five
- the .sh is unchanged from v2

Link: https://lore.kernel.org/all/20260928114551.2148536-1-quchaosheng000406@163.com/
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   4 +-
 tools/testing/selftests/net/can/config             |   1 +
 .../selftests/net/can/test_isotp_frame_type.c      | 574 +++++++++++++++++++++
 .../selftests/net/can/test_isotp_frame_type.sh     |  57 ++
 5 files changed, 635 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc8..fa0a3f798 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_isotp_frame_type
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 5b82e60a0..7d6be87bd 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -4,8 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := test_raw_filter.sh
+TEST_PROGS := test_raw_filter.sh test_isotp_frame_type.sh
 
-TEST_GEN_FILES := test_raw_filter
+TEST_GEN_FILES := test_raw_filter test_isotp_frame_type
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 188f79796..848f3a8d8 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,4 @@
 CONFIG_CAN=m
 CONFIG_CAN_DEV=m
 CONFIG_CAN_VCAN=m
+CONFIG_CAN_ISOTP=m
diff --git a/tools/testing/selftests/net/can/test_isotp_frame_type.c b/tools/testing/selftests/net/can/test_isotp_frame_type.c
new file mode 100644
index 000000000..4f693467f
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_isotp_frame_type.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that isotp_rcv() separates the CAN transport channels by frame type,
+ * not by frame length alone.
+ *
+ * A CAN XL frame whose canxl_frame.len makes skb->len equal CAN_MTU or
+ * CANFD_MTU passes the length-only check that used to guard isotp_rcv().
+ * The frame is then read as a struct canfd_frame, whose len field overlaps
+ * canxl_frame.flags -- and CANXL_XLF (0x80) is mandatory, so that length is
+ * always past CANFD_MAX_DLEN.  The flow control path used it unbounded and the
+ * socket reported EBADMSG for a frame it never asked for.
+ *
+ * Every case runs on both channels (Classic CAN and CAN FD).  A CAN XL frame
+ * is only ever injected after the receiver is confirmed to be in
+ * ISOTP_WAIT_FC: that state is reached only by a First Frame, and a First
+ * Frame only goes out when the payload does not fit into a Single Frame.
+ * Without that precondition an injected frame is discarded at the state check
+ * and the case would pass for the wrong reason (this is not hypothetical --
+ * the first version of this test did exactly that and reported a false
+ * negative on the CAN FD channel).
+ *
+ * The last case of each channel is the opposite control: a well-formed frame
+ * with wrong padding must still be reported, so that the guard cannot be
+ * "passed" by disabling padding validation altogether.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <net/if.h>
+
+#include <linux/can.h>
+#include <linux/can/isotp.h>
+#include <linux/can/raw.h>
+
+#include "kselftest_harness.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
+#define ID_RX 0x123
+#define ID_TX 0x456
+
+/* optional extended addressing would shift every PCI byte */
+#define RX_FLAGS (CAN_ISOTP_RX_PADDING | CAN_ISOTP_CHK_PAD_LEN | \
+		  CAN_ISOTP_CHK_PAD_DATA)
+
+char CANIF[IFNAMSIZ];
+
+static int ifindex_of(const char *ifname)
+{
+	struct ifreq ifr = { 0 };
+	int s, ret;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFINDEX, &ifr) < 0 ? -1 : ifr.ifr_ifindex;
+	close(s);
+	return ret;
+}
+
+/* Does the interface reject a CAN XL frame of this size?  Returns the number
+ * of bytes accepted, or -1 when the send itself failed.
+ */
+static int iface_mtu(const char *ifname)
+{
+	struct ifreq ifr = { 0 };
+	int s, ret;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFMTU, &ifr) < 0 ? -1 : ifr.ifr_mtu;
+	close(s);
+	return ret;
+}
+
+static bool require_iface(int mtu)
+{
+	return mtu >= 0;
+}
+
+/* Returns the frame length the interface accepts for a CAN XL frame, or -1. */
+static int iface_max_xl_len(const char *ifname)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	struct canxl_frame cxl = { 0 };
+	int s, one = 1, ret = -1;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+
+	addr.can_ifindex = ifindex_of(ifname);
+	if (addr.can_ifindex < 0)
+		goto out;
+	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &one, sizeof(one)) < 0)
+		goto out;
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		goto out;
+
+	cxl.prio = ID_RX;
+	cxl.flags = CANXL_XLF;
+	cxl.len = CANFD_MTU - CANXL_HDR_SIZE;
+	if (send(s, &cxl, CANFD_MTU, 0) == CANFD_MTU)
+		ret = CANFD_MTU;
+out:
+	close(s);
+	return ret;
+}
+
+static int make_isotp_socket(const char *ifname, unsigned int rx_id,
+			     unsigned int tx_id, unsigned int flags,
+			     unsigned char rxpad, unsigned char mtu,
+			     unsigned char tx_dl)
+{
+	struct sockaddr_can addr = { 0 };
+	struct can_isotp_options opt = { 0 };
+	struct can_isotp_ll_options ll = { 0 };
+	struct timeval tv = { .tv_sec = 2 };
+	int s;
+
+	s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+	if (s < 0)
+		return -1;
+
+	opt.flags = flags;
+	opt.rxpad_content = rxpad;
+	opt.txpad_content = 0xAA;
+	if (setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opt, sizeof(opt)) < 0)
+		goto err;
+	ll.mtu = mtu;
+	ll.tx_dl = tx_dl;
+	if (setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll, sizeof(ll)) < 0)
+		goto err;
+	if (setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) < 0)
+		goto err;
+
+	addr.can_family = AF_CAN;
+	addr.can_ifindex = ifindex_of(ifname);
+	addr.can_addr.tp.rx_id = rx_id;
+	addr.can_addr.tp.tx_id = tx_id;
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		goto err;
+	return s;
+err:
+	close(s);
+	return -1;
+}
+
+/* Wait for the First Frame of a transfer, which is what proves the receiver is
+ * in ISOTP_WAIT_FC.  The First Frame carries N_PCI type 1.
+ */
+static int wait_for_first_frame(int obs, unsigned int tx_id)
+{
+	struct canfd_frame f;
+	int i;
+
+	for (i = 0; i < 80; i++) {
+		fd_set fds;
+		struct timeval tv = { .tv_usec = 20000 };
+		ssize_t n;
+
+		FD_ZERO(&fds);
+		FD_SET(obs, &fds);
+		if (select(obs + 1, &fds, NULL, NULL, &tv) <= 0)
+			continue;
+		n = recv(obs, &f, sizeof(f), MSG_DONTWAIT);
+		/* the First Frame is CAN_MTU bytes on the Classic channel and
+		 * CANFD_MTU bytes on the CAN FD channel -- both carry can_id at
+		 * the same offset, so one buffer serves for both
+		 */
+		if ((n == CAN_MTU || n == CANFD_MTU) && f.can_id == tx_id &&
+		    (f.data[0] & 0xF0) == 0x10)
+			return 0;
+	}
+	return -1;
+}
+
+/* After a valid CTS the stack starts sending Consecutive Frames, so seeing
+ * one on the bus is positive evidence that the flow control frame was not
+ * merely tolerated but actually acted upon.  A Consecutive Frame carries
+ * N_PCI type 2.
+ */
+static int wait_for_consecutive_frame(int obs, unsigned int tx_id)
+{
+	struct canfd_frame f;
+	int i;
+
+	for (i = 0; i < 80; i++) {
+		fd_set fds;
+		struct timeval tv = { .tv_usec = 20000 };
+		ssize_t n;
+
+		FD_ZERO(&fds);
+		FD_SET(obs, &fds);
+		if (select(obs + 1, &fds, NULL, NULL, &tv) <= 0)
+			continue;
+		n = recv(obs, &f, sizeof(f), MSG_DONTWAIT);
+		if ((n == CAN_MTU || n == CANFD_MTU) && f.can_id == tx_id &&
+		    (f.data[0] & 0xF0) == 0x20)
+			return 0;
+	}
+	return -1;
+}
+
+/* Bring an isotp receiver into ISOTP_WAIT_FC.
+ *
+ * The payload has to be larger than the Single Frame capacity, otherwise the
+ * stack sends a Single Frame and never leaves ISOTP_SENDING.
+ */
+static int arm_receiver(const char *ifname, int rx, int obs, int payload_len)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	unsigned char payload[2048];
+
+	memset(payload, 'A', sizeof(payload));
+	addr.can_ifindex = ifindex_of(ifname);
+	addr.can_addr.tp.rx_id = ID_TX;
+	addr.can_addr.tp.tx_id = ID_RX;
+	if (sendto(rx, payload, payload_len, 0,
+		   (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		return -1;
+	return wait_for_first_frame(obs, ID_TX);
+}
+
+/* Inject a CAN XL frame whose skb->len is exactly frame_len bytes */
+static int inject_xl(int tx, unsigned int frame_len)
+{
+	struct canxl_frame cxl = { 0 };
+
+	cxl.prio = ID_RX;
+	cxl.flags = CANXL_XLF | 0x7f;	/* read back as canfd_frame.len */
+	cxl.sdt = 0;
+	cxl.len = frame_len - CANXL_HDR_SIZE;
+	/* byte 8 overlaps canfd_frame.data[0]: N_PCI = flow control, CTS.
+	 * Written through a char pointer rather than as canxl_frame.af so that
+	 * the test does not depend on the host byte order.
+	 */
+	((unsigned char *)&cxl)[8] = 0x30;
+	return send(tx, &cxl, frame_len, 0) == (ssize_t)frame_len ? 0 : -1;
+}
+
+static void drain(int s)
+{
+	struct timeval tv = { 0 };
+	unsigned char buf[4096];
+	fd_set fds;
+
+	for (;;) {
+		FD_ZERO(&fds);
+		FD_SET(s, &fds);
+		if (select(s + 1, &fds, NULL, NULL, &tv) <= 0)
+			return;
+		if (recv(s, buf, sizeof(buf), MSG_DONTWAIT) <= 0)
+			return;
+	}
+}
+
+/* Did the socket report an error caused by a frame it never asked for? */
+static int rx_reports_ebadmsg(int rx)
+{
+	int i;
+
+	for (i = 0; i < 30; i++) {
+		unsigned char buf[64];
+
+		usleep(25000);
+		if (recv(rx, buf, sizeof(buf), MSG_DONTWAIT) < 0 &&
+		    (errno == EBADMSG || errno == EPROTO))
+			return 1;
+	}
+	return 0;
+}
+
+FIXTURE(isotp_frame_type) {
+	int rx;
+	int obs;	/* raw socket on the same interface */
+	int tx;		/* injector, CAN_RAW_XL_FRAMES enabled */
+	int has_fd;	/* the interface carries CAN FD frames (mtu >= CANFD_MTU) */
+	int has_xl;	/* the interface carries CAN XL frames */
+	int mtu;	/* -1 when the interface does not exist */
+};
+
+/* Outside the kernel, CAN XL support is not a property of the interface
+ * alone: the option may not exist at all.  Ask for XL frames only when the
+ * probe above has shown that the interface carries them, so that a kernel
+ * which does not know CAN_RAW_XL_FRAMES still runs the cases that never
+ * look at an XL frame.  CAN_RAW_FD_FRAMES stays unconditional, because the
+ * Classic CAN cases need it for their own First Frame.
+ */
+static int open_observer(const char *ifname, int has_xl)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	int s, one = 1;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+	addr.can_ifindex = ifindex_of(ifname);
+	if (addr.can_ifindex < 0)
+		goto err;
+	/* the First Frame is a CAN FD frame: without this the observer is
+	 * blind and the precondition check below reports a false alarm
+	 */
+	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &one, sizeof(one)) < 0)
+		goto err;
+	if (has_xl &&
+	    setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &one, sizeof(one)) < 0)
+		goto err;
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		goto err;
+	return s;
+err:
+	close(s);
+	return -1;
+}
+
+static int open_injector(const char *ifname, int has_xl)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	int s, one = 1;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+	addr.can_ifindex = ifindex_of(ifname);
+	if (addr.can_ifindex < 0)
+		goto err;
+	/* this socket also sends the plain CAN FD case, so ask for FD
+	 * explicitly rather than relying on XL implying it
+	 */
+	if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &one, sizeof(one)) < 0)
+		goto err;
+	if (has_xl &&
+	    setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &one, sizeof(one)) < 0)
+		goto err;
+	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0)
+		goto err;
+	return s;
+err:
+	close(s);
+	return -1;
+}
+
+FIXTURE_SETUP(isotp_frame_type)
+{
+	if (!CANIF[0])
+		SKIP(return, "CANIF is not set");
+
+	self->rx = -1;
+	self->obs = -1;
+	self->tx = -1;
+	/* isotp_bind() rejects ll.mtu > dev->mtu, so the Classic channel
+	 * needs any CAN device, the FD channel needs an FD-capable one, and
+	 * only the two cases that inject a CAN XL frame need anything more.
+	 * A missing interface is a skip, not a failure: CANIF names whatever
+	 * device the caller happens to have.
+	 */
+	self->mtu = iface_mtu(CANIF);
+	/* mtu is -1 when the interface does not exist: compare as int, or a
+	 * missing interface would report itself as CAN FD capable
+	 */
+	self->has_fd = self->mtu >= (int)CANFD_MTU;
+	self->has_xl = iface_max_xl_len(CANIF) > 0;
+}
+
+FIXTURE_TEARDOWN(isotp_frame_type)
+{
+	if (self->rx >= 0)
+		close(self->rx);
+	if (self->obs >= 0)
+		close(self->obs);
+	if (self->tx >= 0)
+		close(self->tx);
+}
+
+/* --- Classic CAN channel: a CAN XL frame can be exactly CAN_MTU bytes --- */
+
+TEST_F(isotp_frame_type, classic_xl_frame_is_not_a_flow_control_frame)
+{
+	int payload_len = 100;	/* > 7, so a First Frame is sent */
+
+	if (!require_iface(self->mtu))
+		SKIP(return, "interface %s does not exist", CANIF);
+	if (!self->has_xl)
+		SKIP(return, "interface does not carry CAN XL frames");
+
+	self->rx = make_isotp_socket(CANIF, ID_RX, ID_TX, RX_FLAGS, 0xAA,
+				     CAN_MTU, 8);
+	ASSERT_GE(self->rx, 0);
+
+	self->obs = open_observer(CANIF, self->has_xl);
+	ASSERT_GE(self->obs, 0);
+	self->tx = open_injector(CANIF, self->has_xl);
+	ASSERT_GE(self->tx, 0);
+
+	drain(self->obs);
+	ASSERT_EQ(arm_receiver(CANIF, self->rx, self->obs, payload_len), 0)
+		TH_LOG("receiver never reached ISOTP_WAIT_FC");
+
+	ASSERT_EQ(inject_xl(self->tx, CAN_MTU), 0);
+
+	EXPECT_EQ(rx_reports_ebadmsg(self->rx), 0)
+		TH_LOG("an XL frame was reported as a malformed FC frame");
+}
+
+TEST_F(isotp_frame_type, classic_well_formed_flow_control_is_accepted)
+{
+	struct can_frame cf;
+
+	if (!require_iface(self->mtu))
+		SKIP(return, "interface %s does not exist", CANIF);
+
+	/* plain Classic CAN traffic: runs on any CAN interface */
+	self->rx = make_isotp_socket(CANIF, ID_RX, ID_TX, RX_FLAGS, 0xAA,
+				     CAN_MTU, 8);
+	ASSERT_GE(self->rx, 0);
+	self->obs = open_observer(CANIF, self->has_xl);
+	ASSERT_GE(self->obs, 0);
+	self->tx = open_injector(CANIF, self->has_xl);
+	ASSERT_GE(self->tx, 0);
+
+	drain(self->obs);
+	ASSERT_EQ(arm_receiver(CANIF, self->rx, self->obs, 100), 0);
+
+	/* a genuine Classic CAN flow control frame, padded as configured */
+	memset(&cf, 0, sizeof(cf));
+	cf.can_id = ID_RX;
+	cf.len = 8;
+	cf.data[0] = 0x30;	/* N_PCI flow control, CTS */
+	memset(&cf.data[1], 0xAA, 7);
+	ASSERT_EQ(send(self->tx, &cf, sizeof(cf), 0), (ssize_t)sizeof(cf));
+
+	/* positive evidence, not merely the absence of an error: the socket
+	 * has to act on the CTS and start sending Consecutive Frames
+	 */
+	EXPECT_EQ(wait_for_consecutive_frame(self->obs, ID_TX), 0)
+		TH_LOG("the flow control frame was not acted upon");
+	EXPECT_EQ(rx_reports_ebadmsg(self->rx), 0)
+		TH_LOG("a well-formed flow control frame was rejected");
+}
+
+/* --- the same acceptance check on the CAN FD channel --- */
+
+TEST_F(isotp_frame_type, fd_well_formed_flow_control_is_accepted)
+{
+	struct canfd_frame cf;
+
+	if (!require_iface(self->mtu))
+		SKIP(return, "interface %s does not exist", CANIF);
+	if (!self->has_fd)
+		SKIP(return, "interface does not carry CAN FD frames");
+
+	self->rx = make_isotp_socket(CANIF, ID_RX, ID_TX, RX_FLAGS, 0xAA,
+				     CANFD_MTU, 64);
+	ASSERT_GE(self->rx, 0);
+	self->obs = open_observer(CANIF, self->has_xl);
+	ASSERT_GE(self->obs, 0);
+	self->tx = open_injector(CANIF, self->has_xl);
+	ASSERT_GE(self->tx, 0);
+
+	drain(self->obs);
+	/* > 62 bytes, so the First Frame is a CAN FD frame as well */
+	ASSERT_EQ(arm_receiver(CANIF, self->rx, self->obs, 800), 0);
+
+	memset(&cf, 0, sizeof(cf));
+	cf.can_id = ID_RX;
+	cf.flags = CANFD_FDF;
+	cf.len = 12;		/* padlen(12) == 12 */
+	cf.data[0] = 0x30;	/* N_PCI flow control, CTS */
+	cf.data[1] = 0;		/* block size */
+	cf.data[2] = 0;		/* separation time */
+	memset(&cf.data[3], 0xAA, 9);
+	ASSERT_EQ(send(self->tx, &cf, sizeof(cf), 0), (ssize_t)sizeof(cf));
+
+	EXPECT_EQ(wait_for_consecutive_frame(self->obs, ID_TX), 0)
+		TH_LOG("the flow control frame was not acted upon");
+	EXPECT_EQ(rx_reports_ebadmsg(self->rx), 0)
+		TH_LOG("a well-formed flow control frame was rejected");
+}
+
+/* --- The same collision, one length gate further up --- */
+
+TEST_F(isotp_frame_type, fd_xl_frame_is_not_a_flow_control_frame)
+{
+	int payload_len = 800;	/* > 62, so a First Frame is sent */
+
+	if (!require_iface(self->mtu))
+		SKIP(return, "interface %s does not exist", CANIF);
+	if (!self->has_xl)
+		SKIP(return, "interface does not carry CAN XL frames");
+
+	self->rx = make_isotp_socket(CANIF, ID_RX, ID_TX, RX_FLAGS, 0xAA,
+				     CANFD_MTU, 64);
+	ASSERT_GE(self->rx, 0);
+	self->obs = open_observer(CANIF, self->has_xl);
+	ASSERT_GE(self->obs, 0);
+	self->tx = open_injector(CANIF, self->has_xl);
+	ASSERT_GE(self->tx, 0);
+
+	drain(self->obs);
+	ASSERT_EQ(arm_receiver(CANIF, self->rx, self->obs, payload_len), 0)
+		TH_LOG("receiver never reached ISOTP_WAIT_FC");
+
+	ASSERT_EQ(inject_xl(self->tx, CANFD_MTU), 0);
+
+	EXPECT_EQ(rx_reports_ebadmsg(self->rx), 0)
+		TH_LOG("an XL frame was reported as malformed on the FD channel");
+}
+
+/* --- The guard must not turn padding validation off --- */
+
+TEST_F(isotp_frame_type, wrong_padding_is_still_reported)
+{
+	struct sockaddr_can addr = { .can_family = AF_CAN };
+	unsigned char payload[100];
+	int sender;
+
+	if (!require_iface(self->mtu))
+		SKIP(return, "interface %s does not exist", CANIF);
+
+	/* this case carries only Classic CAN frames: the point is that the
+	 * frame-type guard must not disable padding validation, and that is
+	 * observable without any XL support
+	 */
+	/* the receiver insists on a padding byte the sender does not use */
+	self->rx = make_isotp_socket(CANIF, ID_RX, ID_TX, RX_FLAGS, 0xBB,
+				     CAN_MTU, 8);
+	ASSERT_GE(self->rx, 0);
+	sender = make_isotp_socket(CANIF, ID_TX, ID_RX, CAN_ISOTP_TX_PADDING,
+				   0xAA, CAN_MTU, 8);
+	ASSERT_GE(sender, 0);
+
+	memset(payload, 'B', sizeof(payload));
+	addr.can_ifindex = ifindex_of(CANIF);
+	addr.can_addr.tp.rx_id = ID_TX;
+	addr.can_addr.tp.tx_id = ID_RX;
+	ASSERT_GT(sendto(sender, payload, sizeof(payload), 0,
+			 (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	EXPECT_EQ(rx_reports_ebadmsg(self->rx), 1)
+		TH_LOG("padding validation no longer reports a malformed frame");
+	close(sender);
+}
+
+int main(int argc, char **argv)
+{
+	char *ifname = getenv("CANIF");
+
+	if (!ifname) {
+		printf("CANIF environment variable must contain the test interface\n");
+		return KSFT_FAIL;
+	}
+	if (strlen(ifname) >= sizeof(CANIF)) {
+		printf("CANIF is too long\n");
+		return KSFT_FAIL;
+	}
+	memcpy(CANIF, ifname, strlen(ifname) + 1);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/net/can/test_isotp_frame_type.sh b/tools/testing/selftests/net/can/test_isotp_frame_type.sh
new file mode 100755
index 000000000..a4f808256
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_isotp_frame_type.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS="
+	test_isotp_frame_type
+"
+
+net_dir=$(dirname $0)/..
+source $net_dir/lib.sh
+
+export CANIF=${CANIF:-"vcan0"}
+
+# set only when setup() creates the interface
+created=
+
+setup()
+{
+	if [[ $CANIF != vcan* ]]; then
+		echo "test_isotp_frame_type requires a vcan device" >&2
+		exit $ksft_skip
+	fi
+
+	# CANIF defaults to vcan0, which may already exist and be in use; only
+	# take it down again if this run is the one that created it.
+	if ip link show dev $CANIF >/dev/null 2>&1; then
+		echo "$CANIF already exists, leaving it in place" >&2
+	else
+		ip link add name $CANIF type vcan || exit $ksft_skip
+		created=1
+	fi
+
+	# a vcan device defaults to CANXL_MTU, so it carries every frame
+	# type this test needs without further configuration
+	ip link set dev $CANIF mtu 2060 2>/dev/null
+	ip link set dev $CANIF up
+}
+
+cleanup()
+{
+	[[ -n $created ]] || return
+	ip link set dev $CANIF down
+	ip link delete $CANIF
+}
+
+test_isotp_frame_type()
+{
+	./test_isotp_frame_type
+	check_err $?
+	log_test "test_isotp_frame_type"
+}
+
+trap cleanup EXIT
+setup
+
+tests_run
+
+exit $EXIT_STATUS

