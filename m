Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991357;
	b=v1PTGpVO/3sAD61deBJXKF7VRMmYNohCJHg1BGKHmjl8zf859zCSB7MW57d4uFZxRTFk
	 L28JhNQG78CK2orcxl9ElyGObJH8n6HvAebv1Qd8EWyl/po4aZyYXnLhRI/AmnZvUg5nG
	 0HTGn9bc72PhAVqkoEG0JAabTQe/dAnXloL9kHbMzlOZl7nwOBGz0+v72KtmQr0hN1XgD
	 XB/+goHcEwm9mQSLaTz2nxIRnnDJKekMG2oVpGUhFtzFHBGFmFcUNpr/bsjgYn4YSsOsB
	 H/oQBHSZ9J4bwSPUalp2UgVh/hUOr2FJMbbQ+qVBr65DzIQNBrek8Yo7iX2wFwOK8KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991357;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=FOhJhSNRB8z8+ddCny2w6JmdqdlGrOLdNKtjjNLYnZo=;
	b=LF/NzIQDbDNtPVHi1dpUo+zZ90ebfY2qYbLntWrME2CBEzd/1Q6O+iqrR+09WvMdZLj+
	 4w1n7JL5FGPnOXIeAgWeUU2Zo3q42hm6ayNVaWALTIbx4imPZdkd5scDOReU8s0pZ4pih
	 KbxjkXmj0S65Fvs21inD18EyxeeiWd674scd8tmMXktmiA9pVbthuyBDzhvlMoqa58IT/
	 3l1o6k0XOxkvBzv3s5PeLUA8YUQ4C2wjqgQn33HqiO4LIv+sozWFZan3yNsqdA8msrVlF
	 XquDVO+mu4cuD8Rk+sxiCgoKMP9CYSMwQJR0OsMkOJ64gui2i84l6LwEYh5pMoRWcIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O4HCY0Rk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98E606A32A;
	Wed, 18 Nov 2026 08:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E98E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O4HCY0Rk
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D85C4205A87;
	Wed, 18 Nov 2026 09:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOhJhSNRB8z8+ddCny2w6JmdqdlGrOLdNKtjjNLYnZo=;
	b=O4HCY0RkSDGVjEz5YtHat2umSRgiGiYSCfuQlviZLIQk5Rcz6nEgIN1iCVUT2OZ6MR90xX
	fC+uBr7by1Hu4Y15Mi7khDbKuiI57RRAbxepRccB4IeIy8n/STD6/A+3DZNkdLB9O3zBSR
	IeuKGY848EthKzZ++7zfN/84J8IKkNGpkn/yWGDxp6Zic0MzGj9/eXIBxWcN8Ev6AqA+Yc
	FhtKuUE60iXgZ2QcNQbPQ8SFPi/Mp2qimVGLKNXGp5smRzvp9kIGMmGb7x1PC2EXByRP7I
	4nMGYxdFlIiWOgMlRL2G1jsz0gL0Q/Qo26zqbExNxo7JzunWPNpLe8J89a7vVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794991347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOhJhSNRB8z8+ddCny2w6JmdqdlGrOLdNKtjjNLYnZo=;
	b=dwZOTPSIgdBbgCH4BVUblcuwqbTDcl0LLA3ERG2IFFe2Z6OC65psjX2SNUlcCmfMdkIuRs
	Ly3pN6M/6p/cSvRkO/2bVswZRT4S/Ijj/A8G7VkF6QZfYyUpv4DcFj6DE+iW80WAz/Oycq
	o7zS0itxmSlseaq1aXi7TgKuE5GW92saZknUKAtQyLD3SuHhI8Qju0NVLPHdeifXG+YDjM
	yUT99r35WMtMhvyI+8xPyh++dLSfUBAix+9Zp/27AB+cGCbx74yD/xgnJliKN32cPTGWM9
	Le8JTC+rOgWwcGa0HhXTBxc8BRTgBioMUIsTCqetaj/Yn9D2lAp22/IDqnllpg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794991347; a=rsa-sha256;
	cv=none;
	b=ATFVaLu6Bu3DbkRr3qQNQy75Hgc7wMku8WQdj6FmvyHTA6fvJQmGIOkFesNIqHiTeiKIir
	1zPCUG/f0HBnRo6rpmtZlWta2UqDNfKC1rRGoyCUzm61Qu6j/fSYnwHjQJYosdwR7UNOjk
	Yu+J6iyg1UA2yc+H8eHSOehL/7ywjA49RiBs/SW92bTAsGqQLFx1R/4+kBAOea/BfF0f6b
	eZOSGk5Xu7XqXU99x6Lg+5TmxKppkkuGCt6E1NsEhc7PcwYR2bCU8ELyBYeWIs1HAS/Peh
	WbDQuYxrJO8vgkpvZZVTX+Iy7LsorKKe+k8qEzoSJoisDoR00XiX56ZkalIdXQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id B536A381D15; Wed, 18 Nov 2026 09:42:27 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 18 Nov 2026 09:42:19 +0100
Subject: [PATCH can-next v4 4/9] selftests: can: add J1939 socket option
 and metadata tests
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
Message-Id: <20261118-j1939-selftests-v4-4-756768d32ff2@pengutronix.de>
References: <20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de>
In-Reply-To: <20261118-j1939-selftests-v4-0-756768d32ff2@pengutronix.de>
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

Add a selftest for the J1939 socket options and send metadata. The send
priority is checked on the wire via a CAN_RAW peer, and the option values
are read back with getsockopt. The test also covers the SO_J1939_FILTER
PGN whitelist, unconnected sendto(), a bind() with a wrong address family
and the SO_J1939_ERRQUEUE TX-completion ACK.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): setsockopt() for SO_J1939_PROMISC and SO_J1939_ERRQUEUE
returns 1 on success, not 0. Why does the test accept that?
A: It is a stack bug. j1939_sk_setsockopt_flag() returns the value that
the caller passed, not 0. A negative value sets the flag too, and the
call then fails. For -1 the errno is 1 (EPERM). This series changes no
kernel code. The tests set only 0 and 1. They accept any return value
>= 0, so they pass with or without a fix.

Changes in v4:
- pass J1939_NEEDS_RAW to j1939_test_main()
- filter_pgn: after the ordering barrier, wait for a late PGN_B with
  recv_none_ok() instead of one non-blocking read (sashiko, Chaosheng Qu)

Changes in v3:
- add j1939_set_flag_ok(), with a comment that the return value is a
  stack bug (sashiko)
- assert that PRIO_SET is a valid unprivileged priority
- assert that PGN_A and PGN_B are valid PDU1 PGNs with PS 0, and that
  SA_TX and SA_RX are two different unicast addresses
- fail the error-queue read on a truncated cmsg, and check ee_errno
- check SO_J1939_SEND_PRIO strictly in the round-trip test; errno is 0
  when only the value read back is wrong
- check that the filter drops PGN_B with an ordering barrier, not a
  timeout
- fix comments that did not match the code
- put the new helpers in j1939_helpers.c and j1939_helpers.h

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, add static asserts, avoid casts, return bool from
  helpers named *_ok() and fill test payloads with fill_pattern()
- raw_prio(): take only a J1939 data frame; no other node sends on the
  vcan that j1939_lib.sh now creates (sashiko)
- check the errno of bind() with a wrong address family
- request only the TX ACK timestamp, the one the test checks
- also clear the PROMISC and ERRQUEUE flags and read them back
- move CONFIG_CAN_RAW to the base patch
- keep the raw socket in the fixture; without CAN_RAW the test is now
  skipped (sashiko)
- keep the Makefile and .gitignore lists sorted; the wrapper no longer
  sets J1939_TEST_PROG
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   1 +
 tools/testing/selftests/net/can/j1939_helpers.c    |  56 ++++
 tools/testing/selftests/net/can/j1939_helpers.h    |  29 ++
 tools/testing/selftests/net/can/test_j1939_opts.c  | 307 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 6 files changed, 398 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index e566019425c84f362d9cb0dffc5e733dc90a4ce1..75c078a2492e8e4b15bcd045fce97eede349ad39 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 j1939_gw
 test_j1939_base
+test_j1939_opts
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index ee677904c74537037e7e64ae73a177fe3b2f3a38..dc5fc9d3b61e4b49a98b176e68c2635aaa4cad08 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -8,6 +8,7 @@ LOCAL_HDRS := j1939_helpers.h j1939_tests.h ../../clock-helpers.h
 
 TEST_PROGS := \
 	test_j1939_base.sh \
+	test_j1939_opts.sh \
 	test_raw_filter.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/net/can/j1939_helpers.c b/tools/testing/selftests/net/can/j1939_helpers.c
index 57a2e2219055a45754bc4bb2911c6ec485da06d0..b7490c335d8b70ca511167edcde75082ed6250b7 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.c
+++ b/tools/testing/selftests/net/can/j1939_helpers.c
@@ -467,6 +467,62 @@ bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
 	return frame->data[J1939_CM_CMD_OFF] == want_cmd;
 }
 
+bool j1939_set_flag_ok(int s, int optname, int val)
+{
+	return setsockopt(s, SOL_CAN_J1939, optname, &val, sizeof(val)) >= 0;
+}
+
+bool errqueue_enable_ack_ok(int s)
+{
+	int tstamp_flags = SOF_TIMESTAMPING_TX_ACK;
+
+	if (!j1939_set_flag_ok(s, SO_J1939_ERRQUEUE, 1))
+		return false;
+
+	return !setsockopt(s, SOL_SOCKET, SO_TIMESTAMPING, &tstamp_flags,
+			   sizeof(tstamp_flags));
+}
+
+bool msg_has_tstamp_ack(struct msghdr *msg)
+{
+	struct cmsghdr *cmsg;
+
+	for (cmsg = CMSG_FIRSTHDR(msg); cmsg; cmsg = CMSG_NXTHDR(msg, cmsg)) {
+		struct sock_extended_err *serr;
+
+		if (cmsg->cmsg_level != SOL_CAN_J1939 ||
+		    cmsg->cmsg_type != SCM_J1939_ERRQUEUE)
+			continue;
+
+		serr = (struct sock_extended_err *)CMSG_DATA(cmsg);
+		if (serr->ee_errno == ENOMSG &&
+		    serr->ee_origin == SO_EE_ORIGIN_TIMESTAMPING &&
+		    serr->ee_info == SCM_TSTAMP_ACK)
+			return true;
+	}
+	return false;
+}
+
+bool errqueue_read_ack_ok(int s)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLERR };
+	union {
+		char buf[CMSG_SPACE(sizeof(struct sock_extended_err))];
+		struct cmsghdr align;	/* portable cmsg alignment */
+	} ctrl;
+	struct msghdr msg = {
+		.msg_control = ctrl.buf,
+		.msg_controllen = sizeof(ctrl.buf),
+	};
+
+	if (poll(&pfd, 1, J1939_RECV_TIMEOUT_MS) <= 0 ||
+	    recvmsg(s, &msg, MSG_ERRQUEUE) < 0 ||
+	    msg.msg_flags & MSG_CTRUNC)
+		return false;
+
+	return msg_has_tstamp_ack(&msg);
+}
+
 void fill_pattern(uint8_t *buf, size_t len)
 {
 	size_t i;
diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
index 941e6573f815f08cbf95d8b3f6e6fd5a90211423..af2d35371b851ea65100d4a5a66f38817477c82f 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.h
+++ b/tools/testing/selftests/net/can/j1939_helpers.h
@@ -35,6 +35,8 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 #include <linux/can/j1939.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
 
 #include "clock-helpers.h"
 
@@ -338,6 +340,33 @@ bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
 		    uint8_t want_sa, struct can_frame *frame,
 		    int timeout_ms, uint8_t want_cmd);
 
+/*
+ * Set the J1939 flag option optname (SO_J1939_PROMISC or SO_J1939_ERRQUEUE)
+ * to val. A stack bug makes setsockopt() return val instead of 0 on success
+ * (j1939_sk_setsockopt_flag()), so any value >= 0 counts as success.
+ */
+bool j1939_set_flag_ok(int s, int optname, int val);
+
+/*
+ * Enable the error queue of s with SOF_TIMESTAMPING_TX_ACK only: a finished
+ * send then queues one TX-completion ACK, or an abort entry if the session
+ * fails (__j1939_sk_errqueue() in net/can/j1939/socket.c). The kernel reads
+ * the timestamping flags when the session ends, so the caller may call this
+ * function after the send, as long as the session has not ended.
+ */
+bool errqueue_enable_ack_ok(int s);
+
+/* Does the error-queue message msg carry the TX-completion ACK? */
+bool msg_has_tstamp_ack(struct msghdr *msg);
+
+/*
+ * Read one message from the error queue of s, set up by
+ * errqueue_enable_ack_ok(), and check that it is the TX-completion ACK. With
+ * those flags the kernel returns each entry with one cmsg, SCM_J1939_ERRQUEUE.
+ * No iovec is passed, so no message data is read.
+ */
+bool errqueue_read_ack_ok(int s);
+
 /* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
 #define J1939_PATTERN_SEED	0x3c
 
diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
new file mode 100644
index 0000000000000000000000000000000000000000..36734df3420eaced3735f4f1438bca5e7abd65c2
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 socket option and metadata selftests.
+ *
+ * On top of the basic transport, cover the user-visible J1939 socket options
+ * and addressing: the SO_J1939_FILTER PGN whitelist, the SO_J1939_SEND_PRIO
+ * send priority seen in the CAN id (via a CAN_RAW peer, including the kernel's
+ * default), unconnected sendto(2), a wrong-family bind rejection,
+ * SO_J1939_ERRQUEUE TX-completion notifications, and set/getsockopt
+ * round-trips of SO_J1939_SEND_PRIO, SO_J1939_PROMISC and SO_J1939_ERRQUEUE.
+ *
+ * Run by test_j1939_opts.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* arbitrary addresses */
+#define SA_TX			0x80
+#define SA_RX			0x90
+
+/* two different destination-specific PGNs, otherwise arbitrary */
+#define PGN_A			0x0ab00
+#define PGN_B			0x0cd00
+_Static_assert(J1939_IS_PDU1(PGN_A) && J1939_IS_PDU1(PGN_B) && PGN_A != PGN_B,
+	       "PGN_A and PGN_B must be two different PDU1 PGNs");
+_Static_assert((PGN_A & UINT8_MAX) == 0 && (PGN_B & UINT8_MAX) == 0,
+	       "the kernel rejects a PDU1 PGN whose PS byte is not 0");
+_Static_assert(PGN_A <= J1939_PGN_MAX && PGN_B <= J1939_PGN_MAX,
+	       "PGN_A and PGN_B must be valid PGNs");
+_Static_assert(SA_TX != SA_RX && SA_TX <= J1939_MAX_UNICAST_ADDR &&
+	       SA_RX <= J1939_MAX_UNICAST_ADDR,
+	       "SA_TX and SA_RX must be two different unicast addresses");
+
+/*
+ * SO_J1939_SEND_PRIO values below this one need CAP_NET_ADMIN
+ * (j1939_sk_setsockopt()).
+ */
+#define PRIO_MIN_UNPRIV		2
+
+/* a valid priority that needs no privilege and differs from the default */
+#define PRIO_SET		3
+_Static_assert(PRIO_SET >= PRIO_MIN_UNPRIV && PRIO_SET <= J1939_ID_PRIO_MASK &&
+	       PRIO_SET != J1939_PRIO_DEFAULT,
+	       "PRIO_SET must be a valid, unprivileged, non-default priority");
+
+/*
+ * An arbitrary size that needs TP, so that the ACK ends a multi-frame
+ * session.
+ */
+#define ERRQUEUE_MSG_SIZE	128
+_Static_assert(ERRQUEUE_MSG_SIZE > J1939_SF_MAX_SIZE,
+	       "ERRQUEUE_MSG_SIZE must need TP");
+_Static_assert(ERRQUEUE_MSG_SIZE <= J1939_TP_MAX_SIZE,
+	       "ERRQUEUE_MSG_SIZE must fit TP");
+
+/*
+ * Read the next CAN frame from a raw socket and return its J1939 priority, or
+ * -1 on timeout or if it is not a J1939 data frame.
+ */
+static int raw_prio(int raw, int timeout_ms)
+{
+	struct can_frame frame;
+
+	if (!recv_frame_ok(raw, &frame, timeout_ms) ||
+	    !j1939_is_data_frame(frame.can_id))
+		return -1;
+	return j1939_id_prio(frame.can_id);
+}
+
+/*
+ * Set an int J1939 sockopt, read it back, and return the value read, or -1 if
+ * a call fails. errno is 0 if both calls succeed. SO_J1939_SEND_PRIO must
+ * return 0; the flag options go through j1939_set_flag_ok().
+ */
+static int sockopt_roundtrip(int s, int optname, int val)
+{
+	int got = -1;
+	socklen_t len = sizeof(got);
+	bool set_ok;
+
+	errno = 0;
+	if (optname == SO_J1939_SEND_PRIO)
+		set_ok = !setsockopt(s, SOL_CAN_J1939, optname, &val,
+				     sizeof(val));
+	else
+		set_ok = j1939_set_flag_ok(s, optname, val);
+	if (!set_ok)
+		return -1;
+	if (getsockopt(s, SOL_CAN_J1939, optname, &got, &len) < 0)
+		return -1;
+	return got;
+}
+
+FIXTURE(j1939_opts)
+{
+	int ifindex;
+	int tx;
+	int rx;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_opts)
+{
+	self->tx = -1;
+	self->rx = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+
+	J1939_SETUP_RAW(self, J1939_RAW_RCVBUF_DEFAULT);
+}
+
+FIXTURE_TEARDOWN(j1939_opts)
+{
+	if (self->tx >= 0)
+		close(self->tx);
+	if (self->rx >= 0)
+		close(self->rx);
+	if (self->raw >= 0)
+		close(self->raw);
+}
+
+/* SO_J1939_FILTER whitelists PGN_A; PGN_A is received, PGN_B is dropped. */
+TEST_F(j1939_opts, filter_pgn)
+{
+	struct j1939_filter filt = {
+		.pgn = PGN_A,
+		.pgn_mask = J1939_PGN_MAX,
+	};
+	struct sockaddr_can src = {};
+	uint8_t tx_buf[CAN_MAX_DLEN];
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	self->rx = j1939_open(self->ifindex, SA_RX, J1939_NO_PGN);
+	ASSERT_GE(self->rx, 0);
+	ASSERT_EQ(setsockopt(self->rx, SOL_CAN_J1939, SO_J1939_FILTER,
+			     &filt, sizeof(filt)), 0)
+		TH_LOG("SO_J1939_FILTER failed: %d", errno);
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	/* PGN_A must pass the filter */
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_A))
+		TH_LOG("sendto PGN_A failed: %d", errno);
+	EXPECT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				   J1939_RECV_TIMEOUT_MS))
+		TH_LOG("PGN_A was not received despite matching filter");
+
+	/*
+	 * The filter must drop PGN_B. Send PGN_B, then PGN_A, and read PGN_A.
+	 * A leaked PGN_B shows up before PGN_A, or during the recv_none_ok()
+	 * wait after it.
+	 */
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_B))
+		TH_LOG("sendto PGN_B failed: %d", errno);
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_A))
+		TH_LOG("sendto PGN_A failed: %d", errno);
+	ASSERT_TRUE(recvfrom_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				       J1939_RECV_TIMEOUT_MS, &src))
+		TH_LOG("PGN_A after PGN_B was not received");
+	EXPECT_EQ(src.can_addr.j1939.pgn, filt.pgn)
+		TH_LOG("PGN_B was received before PGN_A");
+	EXPECT_TRUE(recv_none_ok(self->rx))
+		TH_LOG("rx got another frame or an error after PGN_A");
+}
+
+/* Without SO_J1939_SEND_PRIO the kernel's default priority is used. */
+TEST_F(j1939_opts, send_prio_default)
+{
+	uint8_t buf[CAN_MAX_DLEN] = {};
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, buf, sizeof(buf), self->ifindex,
+				    J1939_NO_NAME, SA_RX, PGN_A));
+
+	EXPECT_EQ(raw_prio(self->raw, J1939_RECV_TIMEOUT_MS),
+		  J1939_PRIO_DEFAULT);
+}
+
+/* SO_J1939_SEND_PRIO changes the priority carried in the CAN id. */
+TEST_F(j1939_opts, send_prio_set)
+{
+	int prio = PRIO_SET;
+	uint8_t buf[CAN_MAX_DLEN] = {};
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_EQ(setsockopt(self->tx, SOL_CAN_J1939, SO_J1939_SEND_PRIO,
+			     &prio, sizeof(prio)), 0)
+		TH_LOG("SO_J1939_SEND_PRIO failed: %d", errno);
+
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, buf, sizeof(buf), self->ifindex,
+				    J1939_NO_NAME, SA_RX, PGN_A));
+
+	EXPECT_EQ(raw_prio(self->raw, J1939_RECV_TIMEOUT_MS), PRIO_SET);
+}
+
+/* An unconnected socket can address a peer via sendto(2). */
+TEST_F(j1939_opts, sendto_unconnected)
+{
+	uint8_t tx_buf[CAN_MAX_DLEN];
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX,
+				    PGN_A));
+
+	EXPECT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				   J1939_RECV_TIMEOUT_MS));
+}
+
+/* A bind(2) with a wrong address family is rejected. */
+TEST_F(j1939_opts, bind_wrong_family)
+{
+	struct sockaddr_can addr = {
+		.can_family = AF_INET,
+		.can_ifindex = self->ifindex,
+	};
+	int s;
+
+	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
+	ASSERT_GE(s, 0);
+	EXPECT_LT(bind(s, (struct sockaddr *)&addr, sizeof(addr)), 0)
+		TH_LOG("bind with AF_INET unexpectedly succeeded");
+	EXPECT_EQ(errno, EINVAL);
+	close(s);
+}
+
+/* SO_J1939_ERRQUEUE delivers TX completion notifications for a TP send. */
+TEST_F(j1939_opts, errqueue_tx_completion)
+{
+	uint8_t tx_buf[ERRQUEUE_MSG_SIZE];
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	ASSERT_TRUE(errqueue_enable_ack_ok(self->tx))
+		TH_LOG("enabling the error queue failed: %d", errno);
+
+	/* A receiver lets the TP session complete and be acknowledged. */
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX,
+				    PGN_A));
+
+	ASSERT_TRUE(recv_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				   J1939_RECV_TIMEOUT_MS));
+
+	EXPECT_TRUE(errqueue_read_ack_ok(self->tx))
+		TH_LOG("no SCM_TSTAMP_ACK TX completion on the error queue");
+}
+
+/* getsockopt(2) reads back SO_J1939_SEND_PRIO. */
+TEST_F(j1939_opts, getsockopt_send_prio)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_SEND_PRIO, PRIO_SET),
+		  PRIO_SET)
+		TH_LOG("SO_J1939_SEND_PRIO round-trip failed: %d", errno);
+}
+
+/* getsockopt(2) reads back the SO_J1939_PROMISC flag, set and cleared. */
+TEST_F(j1939_opts, getsockopt_promisc)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_PROMISC, true), true)
+		TH_LOG("SO_J1939_PROMISC set round-trip failed: %d", errno);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_PROMISC, false), false)
+		TH_LOG("SO_J1939_PROMISC clear round-trip failed: %d", errno);
+}
+
+/* getsockopt(2) reads back the SO_J1939_ERRQUEUE flag, set and cleared. */
+TEST_F(j1939_opts, getsockopt_errqueue)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_ERRQUEUE, true), true)
+		TH_LOG("SO_J1939_ERRQUEUE set round-trip failed: %d", errno);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_ERRQUEUE, false), false)
+		TH_LOG("SO_J1939_ERRQUEUE clear round-trip failed: %d", errno);
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv, J1939_NEEDS_RAW);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_opts.sh b/tools/testing/selftests/net/can/test_j1939_opts.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_opts.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

