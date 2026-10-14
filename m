Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6455D88D;
	Wed, 14 Oct 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992682; cv=pass; b=pkimUOxEbQAMqZECtKnRT7vzTo2KkEcRJoeXPg9yNmcuECnk3yQJAWe/ioAPKZyven5LkE1Y+bjwZaKnTUH4EK7yWsEUvmfeyYYwBpRQs49v2VCQfu8MjrMtiByo4aKqQMCf590Rw5L2JSJuXLkNXWx4m7XxkxLVGyx3CHpRWx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992682; c=relaxed/simple;
	bh=DeNL2OTPtjlMKP7KufnVCpmok83W9jAxWC+rjZT1XQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVk//ne8miH2h3s1IVLpCSYuQn846cOsT30UrOI4MLuW1VAmPtrHe/nDIHn9l99Jy7Dm5/11jafwFEdbMTkBX2LwoHpEAcJ2b7kpv4IhAcq7dfTIX55bN0Nckb0/2uK1WL0gF7RT9X7nMTspipkn/IsZZPMzW8KfPpsnJvfo0O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CWUfAWGS; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CWUfAWGS"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2715D201D58;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcbnqA/Bukux1RL876/g7/qEteC0Lkt18DrWrFo7pNE=;
	b=CWUfAWGS9snzFn0mXMYVIzLAPv+kvfNSgpfasWWLJz8Nbmz/JWatHx8HNeBnCjnWJcRhly
	idj391T6R2+o6NnJDl1UQEx/TX11wF+jgrtyR+yNNeLAfGtVgyp6EBuvlTRsHvWgf1Vqsk
	3449iMMOpDPrsNV1i67EPIJsDu+s5OXDcMKc2uAp5WEpjcIm3uIyatm56qAxPkZTSdTLgK
	iQ8f3PdETHa/GUuMm6acpu/NnGkJnOHsTI3pm3cl4iESzsI90A0lNYg6urF4fv0/wmOaGk
	QBKS8CDRatfiQmZ2/u57bilvpFq/mLpL16iY5o7o77WbrZopDdb/98B/242Igw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=I/MLfKOBMi/WiOhwPZ1891z3fkkuFlQK6Lz/v+ktHofo1b9vsbE40tZVDgo8pC0Y8uN7oa
	SKrmEp+fwWMQBsfsZ9g+NisQM0J+PsJGSmeS1ITU5hFaxawpfDYgwjGa1Z4wZFvN/p6edE
	U4XkpxXGqJaBtY8v8pLQGDEAIrDmaqt3qnHN0K3/tZsUroqOcHFIk2/jVS3zUboeNlFIRh
	RN134BLQ+/umQIQCK529yfEgfZ8ECsLBTl/ad9n5sIQNLUWrCcMyHMT2dQ0aYwMIQSkkct
	ADBBHURcMmr/OdOHB9MknAjm83aJ1luq4LyoEzWOnuHOi0AUMuA8w5jD5/w8Eg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RcbnqA/Bukux1RL876/g7/qEteC0Lkt18DrWrFo7pNE=;
	b=SLwvVGBUPIJTPAfXzSFVGDviCzdILDP1XPzLDW4whHKRi70bSiVEh+NnbwzbrJ7ltVwneW
	yOoHBeparnSOOLXGeO5L31lGda59g1fqsLIoCMmuz2DMMyWDasKs4Vrdjel3kvrVFvHF1I
	MLV14rwwzw94EmDBTqd6wWXtC4hM2gc/lLhX/Gc93iZdMkvw99SBQ2A8RR55WkWRTktWqs
	C7fmQ8PEdlKHQZVuYIX2cTWEj+e5CHQOql0vWYCa1bz+Y+kbVSbe7WURAMMTDCeuRqd88m
	INKY4h6T43n5JziLNvLq0YjFsxsOPsmJpBaus1RQaCKqj8e7cS8duEoBWLqIqQ==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 1349138505D; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 3/8] selftests: can: add J1939 socket option and metadata tests
Date: Wed, 14 Oct 2026 17:44:29 +0200
Message-ID: <20261014154435.3577983-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014154435.3577983-1-o.rempel@pengutronix.de>
References: <20261014154435.3577983-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest covering the J1939 socket options and send metadata: the
PGN filter (SO_J1939_FILTER), the send priority (SO_J1939_SEND_PRIO,
observed on the wire via a CAN_RAW peer), the promisc flag, destination
addressing via sendto(), a wrong-family bind, and the TX-completion
error-queue notification (SO_J1939_ERRQUEUE / SO_TIMESTAMPING), including
that it is labelled SCM_TSTAMP_ACK. setsockopt values are also read back
with getsockopt.

This is the first J1939 test to open a CAN_RAW socket, so enable
CONFIG_CAN_RAW in the test config.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   2 +
 tools/testing/selftests/net/can/config        |   1 +
 .../selftests/net/can/test_j1939_opts.c       | 305 ++++++++++++++++++
 .../selftests/net/can/test_j1939_opts.sh      |   5 +
 5 files changed, 314 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/test_j1939_opts.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_opts.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 0ab563fe9ddf..427eed83e49e 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
 test_j1939_base
+test_j1939_opts
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index cf4bd2461a6c..24a57edb912c 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -9,11 +9,13 @@ LOCAL_HDRS := j1939_tests.h
 TEST_PROGS := \
 	test_raw_filter.sh \
 	test_j1939_base.sh \
+	test_j1939_opts.sh \
 
 TEST_FILES := j1939_lib.sh
 
 TEST_GEN_FILES := \
 	test_raw_filter \
 	test_j1939_base \
+	test_j1939_opts \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 52a186bd1055..908342600101 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -2,3 +2,4 @@ CONFIG_CAN=m
 CONFIG_CAN_DEV=m
 CONFIG_CAN_VCAN=m
 CONFIG_CAN_J1939=m
+CONFIG_CAN_RAW=m
diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
new file mode 100644
index 000000000000..f761a42db213
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 socket option and metadata selftests.
+ *
+ * On top of the basic transport, cover the user-visible J1939 socket options and
+ * addressing: the SO_J1939_FILTER PGN whitelist, the SO_J1939_SEND_PRIO send
+ * priority seen in the CAN id (via a CAN_RAW peer, including the default of 6),
+ * unconnected sendto(2), a wrong-family bind rejection, and SO_J1939_ERRQUEUE
+ * TX-completion notifications.
+ *
+ * The vcan interface is set up by the caller (see test_j1939_opts.sh); its name
+ * is passed via the CANIF environment variable.
+ */
+#include <errno.h>
+#include <time.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+#include <linux/net_tstamp.h>
+#include <linux/errqueue.h>
+
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define PGN_A			0x0ab00
+#define PGN_B			0x0cd00
+#define PRIO_SET		3
+/*
+ * Worst-case error-queue drain budget: each iteration can block up to
+ * J1939_RECV_TIMEOUT_MS, so this bounds the drain time. A generous cap; only one
+ * ACK is expected.
+ */
+#define ERRQUEUE_POLL_RETRIES	8
+
+/* Read the next CAN frame from a raw socket and return its J1939 priority. */
+static int raw_prio(int raw, int timeout_ms)
+{
+	struct can_frame frame;
+
+	if (recv_timeout(raw, &frame, sizeof(frame), timeout_ms) < 0)
+		return -1;
+	return (int)J1939_ID_PRIO(frame.can_id & CAN_EFF_MASK);
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
+	J1939_SETUP_RAW(self, 0);
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
+	uint8_t tx_buf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+	uint8_t rx_buf[8];
+	int ret;
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
+	ret = j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			   J1939_NO_NAME, SA_RX, PGN_A);
+	ASSERT_EQ(ret, (int)sizeof(tx_buf))
+		TH_LOG("sendto PGN_A failed: %d", errno);
+	EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_RECV_TIMEOUT_MS), (int)sizeof(tx_buf))
+		TH_LOG("PGN_A was not received despite matching filter");
+
+	/* PGN_B must be dropped by the filter */
+	ret = j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			   J1939_NO_NAME, SA_RX, PGN_B);
+	ASSERT_EQ(ret, (int)sizeof(tx_buf))
+		TH_LOG("sendto PGN_B failed: %d", errno);
+	EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_NEG_RECV_TIMEOUT_MS), -1)
+		TH_LOG("PGN_B was received but should have been filtered out");
+}
+
+/* without SO_J1939_SEND_PRIO the J1939 default priority (6) is used. */
+TEST_F(j1939_opts, send_prio_default)
+{
+	uint8_t buf[8] = {};
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	ASSERT_EQ(j1939_sendto(self->tx, buf, sizeof(buf), self->ifindex,
+			       J1939_NO_NAME, SA_RX, PGN_A),
+		  (int)sizeof(buf));
+
+	EXPECT_EQ(raw_prio(self->raw, J1939_RECV_TIMEOUT_MS), J1939_PRIO_DEFAULT);
+}
+
+/* SO_J1939_SEND_PRIO changes the priority carried in the CAN id. */
+TEST_F(j1939_opts, send_prio_set)
+{
+	int prio = PRIO_SET;
+	uint8_t buf[8] = {};
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_EQ(setsockopt(self->tx, SOL_CAN_J1939, SO_J1939_SEND_PRIO,
+			     &prio, sizeof(prio)), 0)
+		TH_LOG("SO_J1939_SEND_PRIO failed: %d", errno);
+
+	ASSERT_EQ(j1939_sendto(self->tx, buf, sizeof(buf), self->ifindex,
+			       J1939_NO_NAME, SA_RX, PGN_A),
+		  (int)sizeof(buf));
+
+	EXPECT_EQ(raw_prio(self->raw, J1939_RECV_TIMEOUT_MS), PRIO_SET);
+}
+
+/* an unconnected socket can address a peer via sendto(2). */
+TEST_F(j1939_opts, sendto_unconnected)
+{
+	uint8_t tx_buf[8] = { 9, 8, 7, 6, 5, 4, 3, 2 };
+	uint8_t rx_buf[8];
+
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	ASSERT_EQ(j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			       J1939_NO_NAME, SA_RX, PGN_A),
+		  (int)sizeof(tx_buf));
+
+	ASSERT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_RECV_TIMEOUT_MS), (int)sizeof(tx_buf));
+	EXPECT_EQ(memcmp(tx_buf, rx_buf, sizeof(tx_buf)), 0);
+}
+
+/* bind(2) with a wrong address family is rejected. */
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
+	close(s);
+}
+
+/* SO_J1939_ERRQUEUE delivers TX completion notifications for a TP send. */
+TEST_F(j1939_opts, errqueue_tx_completion)
+{
+	int enable = 1;
+	int ts = SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_TX_SCHED |
+		 SOF_TIMESTAMPING_OPT_ID;
+	uint8_t tx_buf[128], rx_buf[128];
+	int got_ack = 0, i;
+
+	memset(tx_buf, 0x5a, sizeof(tx_buf));
+
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	/*
+	 * setsockopt(SO_J1939_ERRQUEUE) returns the flag value (1) on success
+	 * rather than 0, so only check for a non-negative result.
+	 */
+	ASSERT_GE(setsockopt(self->tx, SOL_CAN_J1939, SO_J1939_ERRQUEUE,
+			     &enable, sizeof(enable)), 0)
+		TH_LOG("SO_J1939_ERRQUEUE failed: %d", errno);
+	ASSERT_EQ(setsockopt(self->tx, SOL_SOCKET, SO_TIMESTAMPING,
+			     &ts, sizeof(ts)), 0)
+		TH_LOG("SO_TIMESTAMPING failed: %d", errno);
+
+	/* A receiver lets the TP session complete and be acknowledged. */
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+
+	ASSERT_EQ(j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			       J1939_NO_NAME, SA_RX, PGN_A),
+		  (int)sizeof(tx_buf));
+
+	ASSERT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_RECV_TIMEOUT_MS), (int)sizeof(tx_buf));
+
+	/*
+	 * Collect the TX-completion (ACK) from the error queue. Allow a few extra
+	 * iterations because other control messages may arrive before the ACK.
+	 */
+	for (i = 0; i < ERRQUEUE_POLL_RETRIES && !got_ack; i++) {
+		struct pollfd pfd = { .fd = self->tx, .events = POLLERR };
+		union {
+			char buf[CMSG_SPACE(sizeof(struct sock_extended_err)) +
+				 CMSG_SPACE(sizeof(struct scm_timestamping))];
+			struct cmsghdr align;	/* portable cmsg alignment */
+		} ctrl;
+		char data[128];
+		struct iovec iov = { .iov_base = data, .iov_len = sizeof(data) };
+		struct msghdr msg = {
+			.msg_iov = &iov,
+			.msg_iovlen = 1,
+			.msg_control = ctrl.buf,
+			.msg_controllen = sizeof(ctrl.buf),
+		};
+		struct cmsghdr *cmsg;
+
+		if (poll(&pfd, 1, J1939_RECV_TIMEOUT_MS) <= 0)
+			break;
+		if (recvmsg(self->tx, &msg, MSG_ERRQUEUE) < 0)
+			break;
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			struct sock_extended_err *serr;
+
+			if (cmsg->cmsg_level != SOL_CAN_J1939 ||
+			    cmsg->cmsg_type != SCM_J1939_ERRQUEUE)
+				continue;
+			serr = (struct sock_extended_err *)CMSG_DATA(cmsg);
+			if (serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING)
+				continue;
+			/* The TX-completion notification must be SCM_TSTAMP_ACK. */
+			if (serr->ee_info == SCM_TSTAMP_ACK)
+				got_ack = 1;
+		}
+	}
+
+	EXPECT_EQ(got_ack, 1)
+		TH_LOG("no SCM_TSTAMP_ACK TX completion on the error queue");
+}
+
+/* getsockopt reads back SO_J1939_SEND_PRIO. */
+TEST_F(j1939_opts, getsockopt_send_prio)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_SEND_PRIO, PRIO_SET),
+		  PRIO_SET)
+		TH_LOG("SO_J1939_SEND_PRIO round-trip failed: %d", errno);
+}
+
+/* getsockopt reads back the SO_J1939_PROMISC flag. */
+TEST_F(j1939_opts, getsockopt_promisc)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_PROMISC, 1), 1)
+		TH_LOG("SO_J1939_PROMISC round-trip failed: %d", errno);
+}
+
+/* getsockopt reads back the SO_J1939_ERRQUEUE flag. */
+TEST_F(j1939_opts, getsockopt_errqueue)
+{
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	EXPECT_EQ(sockopt_roundtrip(self->tx, SO_J1939_ERRQUEUE, 1), 1)
+		TH_LOG("SO_J1939_ERRQUEUE round-trip failed: %d", errno);
+}
+
+J1939_TEST_MAIN();
diff --git a/tools/testing/selftests/net/can/test_j1939_opts.sh b/tools/testing/selftests/net/can/test_j1939_opts.sh
new file mode 100755
index 000000000000..5d76c56f24a4
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_opts.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+J1939_TEST_PROG=test_j1939_opts
+source "$(dirname "$0")/j1939_lib.sh"
-- 
2.47.3

