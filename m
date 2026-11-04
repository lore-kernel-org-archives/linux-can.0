Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809071;
	b=1I/HznPWtAcyUiqXmT9TyLe1eYipJLnhu++cQNM9wG2u1bfn2+76sDbo60jIci6O5Rgp
	 P01tQSUf1NO14Uz6T8thgnpjpRvwx/tY0/g7Dfyy4r6V47Jp/XAgSOHy2RgsZrs8DrHby
	 OLntyxDat/mlYJrxRIo+5pxWZKcxGs6MfEPMTNum8OhfD0fM29uTDyXil//wqoIh1TNcf
	 jzJcs4I816BKwYmfKhI3UqCnX5hHIcrEJ3ZpoL3kXnvNULK0oAVbgaSztE++YiKfSawKx
	 ykQSQHZcH00c3dfYlZyXrKFpbFoMv4+DwuMKMks6CsDIr+yIZTZ0C/0S3Q2Lwub3Y8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809071;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=0psDsJ3DNkv0/bqXialkiQTYHTx75Qq8VdUzQ+UpAaE=;
	b=B9ES//gZKkwkrI4h/BIHTWVxIYbEWLgRqsjp2XOZ/18x6A9Pdw/v7X/P5xwFFC/u1fpb
	 qIDUkFm/goIcP74sOcPgH+keREWoMRMiTkcNHBdi1/ampqdYz2M0hTJSaCOhr8i0JjPeO
	 U2mWZg9GOJWPZj6SyymTluNuCGnDejieXQFs/pI0JCn+jgnleOeUe7u4GKebD892FBZ20
	 AiSaI49aKFCtn8gwYCEZW30bWVtbgoHLu0VMXTJpFS4qcqc9UPpGr+ywno+GKQBfRMbaZ
	 jev8EH5X1pRgwZKD4LiIIYZJUVGSlYOdbEOF4x/pvCNgB6VLTJjsGqlZbziMsD7P8JQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O9+tOGhS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F09606A334;
	Wed,  4 Nov 2026 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5F09606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O9+tOGhS
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 73AAD202BB7;
	Wed, 04 Nov 2026 17:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0psDsJ3DNkv0/bqXialkiQTYHTx75Qq8VdUzQ+UpAaE=;
	b=O9+tOGhSAAz1QqSSJCZf4dhkFYf1Csx5FLf8p3MHG4W1VI5amkRE2fII10sXtXg0RoPRJQ
	NjF+wMLuQyDU1xsp+ycnqyh/p2+5qyKzlg5tZVwtNJjSTj127aQGXw/U+xhto2MVpGNC3O
	xNiS0iGYI38gwPXY9pVhdsTQd32c3b99dscVHbYp70rQzhbgjjrV0sWcjhxECGf/ENJ8zJ
	TU6z9+SJATiXroHwB6mSFu9jxLh3M8xESMsF6XxP1Qww6auuKWS7U1hd++I/1oiH9VnfYQ
	V7ZaJvfOaCXYpfTejW9LaFFEoBu8BDEccTzhlcVWpan18Ta4/ZS+EXhRVO+qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793809063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0psDsJ3DNkv0/bqXialkiQTYHTx75Qq8VdUzQ+UpAaE=;
	b=OABA31QBEBBwxKtrZG1Cwm4stj6UHIJvfQYh32DJIeSCUKAC/IsAu6KGRn4U8p92awuHZy
	KBBOrRRHklwWU/3GlDm48ktisy10Q54r8HZvcqBdncVIvUU+P4VmoePBIgerbPHzfRY0R8
	CirCbcNt50bbGC4/m3HV5S1ysLFQRb57XByUkzAOM7D9ozW7qClHB8JyLqL4ldDG8ZDxSW
	YOqaHQvkDpSp2y1uLn6riyMdByDaTZrdDWKNjpxuRHO33RyQykwG8QhmKbiGgLGLtWTjuT
	nScnIu4j2ka9Ia8Xe/NyoYB5gomcLn3As3y7Bx4mwkDC+UfvMTcAA4uiZsAQyw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793809063; a=rsa-sha256;
	cv=none;
	b=R/Wq0mIyrEKaKfj6gDYr4aUIlfxN5DkV1M2RiYasUdyR3ThfHtMPynYpA3q0wka1Ts29Ti
	jXC8D6T4faTtxvmPTIql+DBMiB4aU7HA9mm+3izZ6O4OjFNfJKn2cCKZCbq6m30AxEy220
	doZBSaUrzxOOLvdrhy6FnSO5e241vjdmvrXK7IaDSNM3j69xxZbo3Wtd+Vs0eIetbP3qsX
	Oi13qVEjFHcKDGdYJHnNO5Ja2N9TP8+DGUx23cja4gvPgMh2qvoKrk0TrMNr5tbB76RFxC
	VYM2umpx4ascmT5Wy+oe0Ig6ie7h/MsaMf3o5hg2wOwITbopAo5/WMC6tpKRWA==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 519B9380A2C; Wed, 04 Nov 2026 17:17:43 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 04 Nov 2026 17:17:19 +0100
Subject: [PATCH can-next v2 4/9] selftests: can: add J1939 socket option
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
Message-Id: <20261104-j1939-selftests-v2-4-cf797c83317b@pengutronix.de>
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

Add a selftest for the J1939 socket options and send metadata. The send
priority is checked on the wire via a CAN_RAW peer, and the option values
are read back with getsockopt.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
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
 tools/testing/selftests/net/can/j1939_tests.h      |  67 ++++++
 tools/testing/selftests/net/can/test_j1939_opts.c  | 266 +++++++++++++++++++++
 tools/testing/selftests/net/can/test_j1939_opts.sh |   4 +
 5 files changed, 339 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index ac9a3abe416f924998b4b337df3ea6a3891ca3de..81c6e5e4396ac789e0ac1ebad4f11d0f7ef9cbaa 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_j1939_base
+test_j1939_opts
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 9068dd77fb903b6098bc36fbc4cf8075937eb66e..009ea9a53178a9218c11181150e9693bc3da2fdb 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -8,6 +8,7 @@ LOCAL_HDRS := j1939_tests.h
 
 TEST_PROGS := \
 	test_j1939_base.sh \
+	test_j1939_opts.sh \
 	test_raw_filter.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
index 78eb35f5b6b06847e7b004e827ea437b3bb8b38a..639e000ac5e8631e7ebfc1548a7b14892fa61b32 100644
--- a/tools/testing/selftests/net/can/j1939_tests.h
+++ b/tools/testing/selftests/net/can/j1939_tests.h
@@ -41,6 +41,8 @@
 #include <linux/can.h>
 #include <linux/can/raw.h>
 #include <linux/can/j1939.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
 
 #include "clock-helpers.h"
 
@@ -671,6 +673,71 @@ static inline bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
 	return frame->data[J1939_CM_CMD_OFF] == want_cmd;
 }
 
+/*
+ * Enable the error queue of s with SOF_TIMESTAMPING_TX_ACK only: a finished
+ * send then queues one TX-completion ACK, or an abort entry if the session
+ * fails (__j1939_sk_errqueue() in net/can/j1939/socket.c). The kernel reads
+ * these flags when the session ends, so this may come after the send.
+ */
+static inline bool errqueue_enable_ack_ok(int s)
+{
+	int tstamp_flags = SOF_TIMESTAMPING_TX_ACK;
+	int enable = 1;
+
+	/* setsockopt(SO_J1939_ERRQUEUE) returns the flag value, not 0 */
+	if (setsockopt(s, SOL_CAN_J1939, SO_J1939_ERRQUEUE, &enable,
+		       sizeof(enable)) < 0)
+		return false;
+
+	return !setsockopt(s, SOL_SOCKET, SO_TIMESTAMPING, &tstamp_flags,
+			   sizeof(tstamp_flags));
+}
+
+/* Does the error-queue message msg carry the TX-completion ACK? */
+static inline bool msg_has_tstamp_ack(struct msghdr *msg)
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
+		if (serr->ee_origin == SO_EE_ORIGIN_TIMESTAMPING &&
+		    serr->ee_info == SCM_TSTAMP_ACK)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Read one message from the error queue of s, set up by
+ * errqueue_enable_ack_ok(), and check that it is the TX-completion ACK. Each
+ * entry then carries one cmsg, SCM_J1939_ERRQUEUE; no message data is read (no
+ * iovec is passed).
+ */
+static inline bool errqueue_read_ack_ok(int s)
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
+	    recvmsg(s, &msg, MSG_ERRQUEUE) < 0)
+		return false;
+
+	return msg_has_tstamp_ack(&msg);
+}
+
 /* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
 #define J1939_PATTERN_SEED	0x3c
 
diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
new file mode 100644
index 0000000000000000000000000000000000000000..10d0e379840277cddbe9d1f5090f900ce7dd65dc
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -0,0 +1,266 @@
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
+#include <time.h>
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
+
+/* any valid priority but the default */
+#define PRIO_SET		3
+_Static_assert(PRIO_SET != J1939_PRIO_DEFAULT,
+	       "PRIO_SET must differ from the default");
+
+/* a message that needs TP, so that the kernel runs a session to ACK */
+#define ERRQUEUE_MSG_SIZE	128
+_Static_assert(ERRQUEUE_MSG_SIZE > J1939_SF_MAX_SIZE,
+	       "ERRQUEUE_MSG_SIZE must need TP");
+_Static_assert(ERRQUEUE_MSG_SIZE <= J1939_TP_MAX_SIZE,
+	       "ERRQUEUE_MSG_SIZE must fit TP");
+
+/* Read the next CAN frame from a raw socket and return its J1939 priority. */
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
+/* Set an int J1939 sockopt, read it back, and return the value (or -1). */
+static int sockopt_roundtrip(int s, int optname, int val)
+{
+	int got = -1;
+	socklen_t len = sizeof(got);
+
+	if (setsockopt(s, SOL_CAN_J1939, optname, &val, sizeof(val)) < 0)
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
+	uint8_t tx_buf[CAN_MAX_DLEN];
+	uint8_t rx_buf[CAN_MAX_DLEN];
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
+	/* PGN_B must be dropped by the filter */
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME, SA_RX, PGN_B))
+		TH_LOG("sendto PGN_B failed: %d", errno);
+	EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_NEG_RECV_TIMEOUT_MS), -1)
+		TH_LOG("PGN_B was received but should have been filtered out");
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
+	return j1939_test_main(argc, argv);
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

