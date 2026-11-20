Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167973;
	b=q+t0tCGQOwvLTNLZVdr9IrS44riRnsWZ4qqd7jMGRG/ISu+5kaaoJ3cZJzFgKs+IAvMi
	 AyXQxgxWXpO55/qhw1hrPXadmob7ETWgf3kPlwcCqD00G1YigsjcLDGt500xurAR/rUGZ
	 IAzxYbz68ShTy+Y0wbKl8F/jkYksg/XPFSqu75GUvheqM/aTdOqYHwbu+sSE1FEr8DhxP
	 pCoxBI1dfHAmBrdbl+73MWVcVCc4mJRPFaaXigUBt3gbF8PXpiHkFUhYaPjD045WF6sNX
	 QYRfZkuw/NPK+5CX6B8o+pHfy49a7j9sFlZqLJ3xCXu8olpprcJt0m/KZiNaZdolEfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=59TjC0219Ksr55TlNJ270zdr657i7Pqhv2xG/lXLoTo=;
	b=WaMC2fAhUBwgPNCTqOJQLTGtZsSFhIsNTqqRb64QnnLIqwCOJ4XL03i4M9i5EkVBf6nW
	 uPGQKMCwLjaQAWsbxuBEfloRpfvUQjV5qk47cIPOFFqWi9YOk0wYfF5sXHiJDIPwdqxqK
	 eQmAv0MjFKANR5QnHjU9gDRnq3vTGMg6sfQO0fTOWNeDYEC/RD4u+aVw4mnKecLap9YFu
	 ZmRBDHxtiDE+Hin9VXtS9WV70QzW9Y2ny+UYFwLfqGvld3Z6HMxVH6QK02DnTIrGZqFS5
	 f3irgmZqHHgtkoesQZxd84ui4MGCM3ZvPL9/vsbM1PtUfy+Wl98UvS1dMtHDCcMhFAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GDRherpR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B560A2626;
	Fri, 20 Nov 2026 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A06B560A2626
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GDRherpR
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8D7C0205B48;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59TjC0219Ksr55TlNJ270zdr657i7Pqhv2xG/lXLoTo=;
	b=GDRherpRYTh5JGLFkvLTYtcR7h0w9a+AWSi3SopUyR/fmPk6DEZh2a6D1WqRXZ5V93wJTp
	EnJPIRvueO4TNtY8X+aoE7WxrpvEB0R0OW9Gj6ySbUQdAnJ3NigVXC1QVHM5szJneqWwF7
	aDCDBJHipEQf7L3xFvsJwClxJ6wqwO4uEsimCOpELRF+TY5G5Sq8gclzMv/eoU7pmg7SKI
	fnZ1Cd/4BQHHtqPYm22cGd1h4nh0PqQP6KBrzc4Haa85xEeYW1wgM3shp2HwsrAxyMheNb
	tUXX9l1MOrAwt/Egx0t9lnRZA/D6VVapLTcVt1Aaxy8MvbdxC1KcOEf/u/8mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59TjC0219Ksr55TlNJ270zdr657i7Pqhv2xG/lXLoTo=;
	b=G5UGOQvipxL5fvhXHPVQ9ZJyRS8s2/cP7dl8/FAQfe15v4Akev//itLfP++A6IcGqVcTzk
	9tw2rbp0K3pWTOvj3v2PmKpsoD7whwluU4F2m56aEMmPYqyqpvBez5tNeCO6nMPIjfnzmF
	L5OlAUnmw1U+1HxXk0Qky8NteLqYc3pXaFIpVtEeyBH5+BzIszvNNijQUeD/YnJnkL3sRw
	lPAt++gkPFMsEzhaGvTz0BrRKW/nYt1sJdNVQ0NB321YaW+ccB5Di2gU0XEyais80ykCiJ
	2AkuPyP2mqD/X3GYa718Z8duAEay1mprQzHpQWgW4w7IaeYDVxCNN9XAejd//w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=X1SDUt38sSuRQPIz4Oa6S/E81uNxV6I91WPjI+h/NSDi+vYJWvriMQff54umIuz/qSTxqq
	5AaLsYYilm+AVqZUeTdx1P1HfoyTrHn0RLBQZv2fHfLEPCt6Sqql/93/o6+HiWMBvFn1vN
	U1oGHyV82J7zg9gJAfvoRQapmWwY4zH0H7FdoEtHbCvOX22lFHuXAlTy3TWMGzSX6JJuy/
	q9hhW2/8eXZ2Y0iYNmZ5rtZQ+T2r8tgABoVVdAPesUpvBgRsOWO0PHshmrQPRCy9viLWt3
	LrA2DilCeH/w37C9F5loW6kQMAVDuTeyY/zpTGD4CyRtW7EED1MgxQ2g02NYqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 51B6C381830; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:46:02 +0100
Subject: [PATCH can-next v5 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
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
Message-Id: <20261120-j1939-selftests-v5-7-fdf4c242a37e@pengutronix.de>
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

Add Transport Protocol (TP) and Extended Transport Protocol (ETP)
round-trip tests in both directions, with a CAN_RAW socket as the
transport peer. The raw peer sees the frames as they are on the wire, so
a framing bug in the kernel cannot cancel out against its own decoder.

The tests use a PGN with the DP bit set and check it in each control
frame the kernel sends. In the TX tests, the peer's EOMA must end the
session. The kernel then queues a TX-completion ACK on the socket's
error queue. No ACK may come before the EOMA.

The stack updates a session from the loopback echo of its own TP and
ETP frames. A CAN_RAW peer on the same vcan can read that echo first.
If the peer replies quickly, the stack can cancel the session. By
default the peer runs on its own vcan behind the CAN gateway that
j1939_lib.sh sets up. j1939_lib.sh also turns RPS off on that vcan, so
the peer gets each frame only after the stack has handled its echo; it
warns if it cannot. J1939_SHARED_IF=1 puts the peer back on the same
vcan, with a warning.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q (sashiko): can the echo race make test_j1939_multi fail at random in
a default kselftest run? Should the tests stay out of the default run,
be marked XFAIL, or wait for the stack to handle each echo?
A: Not in our runs. By default the peer runs behind the CAN gateway
(patch 2), which has the effect of waiting for the echo. The gateway
forwards a frame with can_send(), and the gateway's copy for the peer
goes through netif_rx() to the backlog of the same CPU. So the stack
handles its echo before the peer gets the frame. RPS must be off on the
peer's vcan; j1939_lib.sh turns it off, or warns if it cannot.
We ran the whole series on a kernel that delays its handling of the CTS
echo in a receive session by 20 ms. test_j1939_multi failed in 14 of
100 runs on one shared vcan; 8 of the 14 failures were in the tests
that this patch adds. It failed in none of 100 runs behind the gateway.
The peer shares the vcan in two cases: with J1939_SHARED_IF=1, and in a
direct run without a separate CANIF_RAW. In both cases the test prints
a warning. XFAIL is not used because, as Chaosheng pointed out,
kselftest counts XFAIL as a pass and would hide a real failure. The fix
belongs in the stack; this series changes no kernel code.

Q (Chaosheng Qu): why not move test_j1939_multi.sh to
TEST_PROGS_EXTENDED?
A: Behind the gateway the race did not show up in our runs. With RPS
off, the gateway keeps the stack ahead of the peer (see the echo-race
Q&A). So the tests stay in the default run, where they can catch
regressions.

Changes in v5:
- j1939_lib.sh now turns RPS off on the peer's vcan, or warns if it
  cannot; say so (sashiko)
- errqueue_empty_ok(): a socket error also sets POLLERR; say so in its
  comment and in the log text (sashiko)

Changes in v4:
- pass J1939_NEEDS_RAW to j1939_test_main()
- describe the echo race in the commit message and reword the file
  comment; the peer now runs behind the CAN gateway (sashiko, Chaosheng Qu)

Changes in v3:
- describe the known stack race in a comment at the top of the file
  (sashiko)
- assert that the addresses are two different unicast ones and that
  PGN_DATA is a valid PDU2 PGN
- assert that the last DT frames and the last ETP block are partial
- pass the buffer size to the ETP helpers
- check the RTS packets-per-CTS byte (the total or no limit), the fill
  bytes of each DT frame and the length of the kernel's control frames
- say in the logs which check failed: any error-queue entry before the
  EOMA, and a malformed ETP CTS or DPO
- use a TP size above 255 bytes, so the high byte of the size field
  counts
- fix comments that did not match the code
- put errqueue_empty_ok() in j1939_helpers.c and j1939_helpers.h

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants, add static asserts, avoid casts and return bool
  from helpers named *_ok()
- fail at once on a CTS for 0 packets, a CTS that does not ask for the
  next packet, or a DPO that does not match the CTS
- check the source address of the kernel's TP/ETP frames
- check the packet count in each CTS: all packets left, capped by the
  RTS limit for TP and by a full block for ETP
- check the PGN in each control frame the kernel sends, with a PGN that
  has the DP bit set
- check that the peer's EOMA ends a TP or ETP TX session with a
  TX-completion ACK, and that no ACK comes before it (sashiko)
- a reassembled message longer than the one sent now fails (sashiko)
- check the sequence number and the length of each DT frame the kernel
  sends (sashiko)
- keep the Makefile and .gitignore lists sorted; the wrapper no longer
  sets J1939_TEST_PROG
---
 tools/testing/selftests/net/can/.gitignore         |   1 +
 tools/testing/selftests/net/can/Makefile           |   1 +
 tools/testing/selftests/net/can/j1939_helpers.c    |   7 +
 tools/testing/selftests/net/can/j1939_helpers.h    |   6 +
 tools/testing/selftests/net/can/test_j1939_multi.c | 682 +++++++++++++++++++++
 .../testing/selftests/net/can/test_j1939_multi.sh  |   4 +
 6 files changed, 701 insertions(+)

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 6c6b18a9deda7f4a7c2b4ef9fbbc980a5b36811b..c6071caef4e9050902f4e03abe3e093753a01026 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -2,6 +2,7 @@
 j1939_gw
 test_j1939_addr
 test_j1939_base
+test_j1939_multi
 test_j1939_opts
 test_j1939_wire
 test_raw_filter
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index e97e10e92e417bc70049e533ca7490c66c971897..8ac7f3281da152c38efeb123653c622aad68adcf 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -9,6 +9,7 @@ LOCAL_HDRS := j1939_helpers.h j1939_tests.h ../../clock-helpers.h
 TEST_PROGS := \
 	test_j1939_addr.sh \
 	test_j1939_base.sh \
+	test_j1939_multi.sh \
 	test_j1939_opts.sh \
 	test_j1939_wire.sh \
 	test_raw_filter.sh \
diff --git a/tools/testing/selftests/net/can/j1939_helpers.c b/tools/testing/selftests/net/can/j1939_helpers.c
index 9e07bb277a4615d97dff59e3059357459972975c..7f93b1816311d83ecbac05dd5cb9263ca4a11b4c 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.c
+++ b/tools/testing/selftests/net/can/j1939_helpers.c
@@ -515,6 +515,13 @@ bool errqueue_read_ack_ok(int s)
 	return msg_has_tstamp_ack(&msg);
 }
 
+bool errqueue_empty_ok(int s)
+{
+	struct pollfd pfd = { .fd = s, .events = POLLERR };
+
+	return poll(&pfd, 1, J1939_NEG_RECV_TIMEOUT_MS) == 0;
+}
+
 void fill_pattern(uint8_t *buf, size_t len)
 {
 	size_t i;
diff --git a/tools/testing/selftests/net/can/j1939_helpers.h b/tools/testing/selftests/net/can/j1939_helpers.h
index 7e8cab2ded5509fec0270beec534e581af5d9680..ac9f2cd43b4983a68ffaf0c5d3512bf839292031 100644
--- a/tools/testing/selftests/net/can/j1939_helpers.h
+++ b/tools/testing/selftests/net/can/j1939_helpers.h
@@ -361,6 +361,12 @@ bool msg_has_tstamp_ack(struct msghdr *msg);
  */
 bool errqueue_read_ack_ok(int s);
 
+/*
+ * Does POLLERR stay clear on s for J1939_NEG_RECV_TIMEOUT_MS? An error-queue
+ * entry or a pending socket error sets it. Also false if poll() fails.
+ */
+bool errqueue_empty_ok(int s);
+
 /* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
 #define J1939_PATTERN_SEED	0x3c
 
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.c b/tools/testing/selftests/net/can/test_j1939_multi.c
new file mode 100644
index 0000000000000000000000000000000000000000..6edce7493892b0eaaa0e3249dd921b08fa67df5e
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.c
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 multi-frame wire selftests: TP and ETP against CAN_RAW.
+ *
+ * A CAN_RAW socket plays the transport peer against the kernel J1939 stack,
+ * in both directions. It takes the other side of the RTS/CTS/DT/EOMA
+ * exchange, for TP with a short message and for ETP with a payload that
+ * spans several CTS blocks (DPO windows).
+ *
+ * Known stack race: the stack updates a session from the loopback echo of
+ * its own TP and ETP frames. A CAN_RAW peer on the same vcan can read
+ * that echo first. If the peer replies quickly, the stack can cancel the
+ * session. See j1939_lib.sh for where the peer runs. The fix belongs in
+ * the stack; this file does not work around it.
+ *
+ * Run by test_j1939_multi.sh, see j1939_tests.h.
+ */
+#include <errno.h>
+
+#include "kselftest_harness.h"
+#include "j1939_tests.h"
+
+/* arbitrary addresses */
+#define SA_LOCAL		0x90	/* the J1939 socket under test */
+#define SA_PEER			0x20	/* the CAN_RAW transport peer */
+_Static_assert((SA_LOCAL != SA_PEER) &&
+	       (SA_LOCAL <= J1939_MAX_UNICAST_ADDR) &&
+	       (SA_PEER <= J1939_MAX_UNICAST_ADDR),
+	       "SA_LOCAL and SA_PEER must be two different unicast addresses");
+/*
+ * transported message PGN, an arbitrary PDU2 PGN with the DP bit set so a
+ * PGN cut to 16 bits fails the check
+ */
+#define PGN_DATA		(J1939_PGN_DP | 0x0feef)
+_Static_assert(PGN_DATA & J1939_PGN_DP, "PGN_DATA must have the DP bit set");
+_Static_assert(!J1939_IS_PDU1(PGN_DATA) && PGN_DATA <= J1939_PGN_MAX,
+	       "PGN_DATA must be a valid PDU2 PGN");
+
+/*
+ * Priority for the TP and ETP frames this test injects as the CAN_RAW
+ * peer. SAE J1939-21:2001 lists 7 as the TP.CM/TP.DT default and
+ * ISO 11783-6:2004 Annex K gives 6 for ETP. The stack checks neither, so
+ * one value serves both.
+ */
+#define PRIO			7
+
+/*
+ * PGNs, control bytes and field byte offsets (_OFF) of TP (SAE J1939-21:2001
+ * sections 5.10.3 and 5.10.4) and ETP (ISO 11783-6:2004 K.2.2.1 and K.2.3).
+ */
+
+/* PGNs */
+#define TP_CM			0x0ec00
+#define TP_DT			0x0eb00
+#define ETP_CM			0x0c800
+#define ETP_DT			0x0c700
+
+/* control bytes */
+#define TP_CMD_RTS		0x10
+#define TP_CMD_CTS		0x11
+#define TP_CMD_EOMA		0x13
+
+#define ETP_CMD_RTS		0x14
+#define ETP_CMD_CTS		0x15
+#define ETP_CMD_DPO		0x16
+#define ETP_CMD_EOMA		0x17
+
+/* field offsets */
+#define TP_RTS_SIZE_OFF		1	/* le16 */
+#define TP_RTS_PKTS_OFF		3
+#define TP_RTS_MAX_PKTS_OFF	4
+/* TP.CM_RTS max packets per CTS: no limit (SAE J1939-21:2001 section 5.10.3) */
+#define TP_RTS_NO_LIMIT		0xff
+#define TP_CTS_PKTS_OFF		1
+#define TP_CTS_NEXT_OFF		2
+#define TP_EOMA_SIZE_OFF	1	/* le16 */
+#define TP_EOMA_PKTS_OFF	3
+
+#define ETP_RTS_SIZE_OFF	1	/* le32 */
+#define ETP_CTS_PKTS_OFF	1
+#define ETP_CTS_NEXT_OFF	2	/* le24 */
+#define ETP_DPO_PKTS_OFF	1
+#define ETP_DPO_BASE_OFF	2	/* le24, packets before this block */
+#define ETP_EOMA_SIZE_OFF	1	/* le32 */
+
+/*
+ * largest ETP.CTS packet count: the field is one byte. It is also the
+ * kernel's ETP block (pkt.block, applied in j1939_session_tx_cts()).
+ */
+#define ETP_CTS_MAX_PKTS	UINT8_MAX
+/* TP and ETP packet numbers start at 1 */
+#define TP_FIRST_PKT		1
+/* TP counts DT sequence numbers from the start of the message */
+#define TP_BASE_PKT		0
+
+/*
+ * arbitrary message sizes, within the asserts below: TP of several
+ * packets and above 255 bytes, ETP of several ETP.CTS blocks
+ */
+#define TP_SIZE			300
+_Static_assert(TP_SIZE > J1939_SF_MAX_SIZE, "TP_SIZE must need TP");
+_Static_assert(TP_SIZE <= J1939_TP_MAX_SIZE, "TP_SIZE must fit TP");
+_Static_assert(TP_SIZE > UINT8_MAX,
+	       "TP_SIZE must use the high byte of the TP.CM size field");
+_Static_assert(TP_SIZE % J1939_DT_DATA_LEN != 0,
+	       "the last TP DT frame must be partial, so its fill is checked");
+
+#define ETP_SIZE		6000U
+_Static_assert(ETP_SIZE > J1939_TP_MAX_SIZE, "ETP_SIZE must need ETP");
+_Static_assert(J1939_NUM_PKTS(ETP_SIZE) > ETP_CTS_MAX_PKTS,
+	       "ETP_SIZE must span several ETP.CTS blocks");
+_Static_assert(ETP_SIZE % J1939_DT_DATA_LEN != 0,
+	       "the last ETP DT frame must be partial, so its fill is checked");
+_Static_assert(J1939_NUM_PKTS(ETP_SIZE) % ETP_CTS_MAX_PKTS != 0,
+	       "the last ETP block must be partial");
+
+/* an RTS per-CTS limit as large as the message: all packets in one CTS */
+#define TP_CTS_ALL		J1939_NUM_PKTS(TP_SIZE)
+_Static_assert(TP_CTS_ALL <= UINT8_MAX, "the TP.CM packet counts are one byte");
+
+FIXTURE(j1939_multi)
+{
+	int ifindex;
+	int j1939;
+	int raw;
+};
+
+FIXTURE_SETUP(j1939_multi)
+{
+	self->j1939 = -1;
+	self->raw = -1;
+
+	J1939_SETUP_IFINDEX(self);
+
+	J1939_SETUP_RAW(self, J1939_RAW_BIG_RCVBUF);
+}
+
+FIXTURE_TEARDOWN(j1939_multi)
+{
+	if (self->j1939 >= 0)
+		close(self->j1939);
+	if (self->raw >= 0)
+		close(self->raw);
+}
+
+/*
+ * Finish a TP/ETP control frame by embedding its data PGN and sending it on the
+ * control PGN. dat must already hold the command and its command-specific
+ * bytes.
+ */
+static bool send_cm_frame_ok(int raw, uint8_t prio, pgn_t cm_pgn, uint8_t da,
+			     uint8_t sa, uint8_t *dat, pgn_t data_pgn)
+{
+	put_pgn(dat, data_pgn);
+	return send_raw8_ok(raw, prio, cm_pgn, da, sa, dat);
+}
+
+/* send_cm_frame_ok() from the peer to the kernel, for PGN_DATA. */
+static bool peer_send_cm_ok(int raw, pgn_t cm_pgn, uint8_t *dat)
+{
+	return send_cm_frame_ok(raw, PRIO, cm_pgn, SA_LOCAL, SA_PEER, dat,
+				PGN_DATA);
+}
+
+/*
+ * Receive the next control frame on cm_pgn from the kernel to the peer and
+ * check that it is a full frame with the control byte cmd and PGN_DATA.
+ */
+static bool recv_kernel_cm_ok(int raw, pgn_t cm_pgn, uint8_t cmd,
+			      struct can_frame *frame, int timeout_ms)
+{
+	if (!recv_cm_cmd_ok(raw, J1939_PF(cm_pgn), SA_PEER, SA_LOCAL, frame,
+			    timeout_ms, cmd))
+		return false;
+
+	return frame->len == CAN_MAX_DLEN &&
+	       get_le24(&frame->data[J1939_CM_PGN_OFF]) == PGN_DATA;
+}
+
+/*
+ * Build and send a TP.CM_RTS: message size, total packets and max packets/CTS.
+ */
+static bool send_tp_rts_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da,
+			   uint8_t sa, uint16_t size, uint8_t total_pkts,
+			   uint8_t max_cts_pkts)
+{
+	uint8_t dat[CAN_MAX_DLEN];
+
+	cm_dat_init(dat, TP_CMD_RTS);
+	put_le16(&dat[TP_RTS_SIZE_OFF], size);
+	dat[TP_RTS_PKTS_OFF] = total_pkts;
+	dat[TP_RTS_MAX_PKTS_OFF] = max_cts_pkts;
+	return send_cm_frame_ok(raw, prio, TP_CM, da, sa, dat, pgn);
+}
+
+/*
+ * Send a burst of @count DT frames for the block starting at the 1-based packet
+ * @next, each carrying up to J1939_DT_DATA_LEN payload bytes from the matching
+ * absolute offset. The first frame has sequence number @first_seq: TP numbers
+ * packets across the whole message (@next), ETP starts again at TP_FIRST_PKT
+ * in each DPO block.
+ */
+static bool send_dt_burst_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da,
+			     uint8_t sa, unsigned int next, unsigned int count,
+			     const uint8_t *payload, size_t size,
+			     unsigned int first_seq)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		size_t abs_pkt = (next - 1) + i;
+		uint8_t seq = first_seq + i;
+
+		if (!send_dt_ok(raw, prio, dt_pgn, da, sa, seq, payload,
+				abs_pkt * J1939_DT_DATA_LEN, size))
+			return false;
+	}
+	return true;
+}
+
+/* send_dt_burst_ok() for TP, which numbers packets across the message */
+static bool send_tp_dt_burst_ok(int raw, uint8_t da, uint8_t sa,
+				unsigned int next, unsigned int count,
+				const uint8_t *payload, size_t size)
+{
+	return send_dt_burst_ok(raw, PRIO, TP_DT, da, sa, next, count, payload,
+				size, next);
+}
+
+/*
+ * Check a CTS or ETP.CTS from the kernel that asks for cts_pkts packets from
+ * the 1-based packet next. The peer has sent `sent` of num_pkts packets, so
+ * the kernel must ask for packet sent + 1 and for
+ * min(cts_limit, num_pkts - sent) packets, see j1939_session_tx_cts(). No
+ * frame is lost here, so no resend is expected
+ * (SAE J1939-21:2001 section 5.10.3.2 allows one for TP).
+ */
+static bool cts_accept_ok(unsigned int cts_pkts, unsigned int next,
+			  unsigned int sent, unsigned int num_pkts,
+			  unsigned int cts_limit)
+{
+	unsigned int want = num_pkts - sent;
+
+	if (want > cts_limit)
+		want = cts_limit;
+	if (cts_pkts == want && next == sent + 1)
+		return true;
+
+	fprintf(stderr, "# CTS for %u packets from %u, want %u from %u\n",
+		cts_pkts, next, want, sent + 1);
+	return false;
+}
+
+/*
+ * Answer each CTS from the kernel with a DT burst from the peer, until
+ * num_pkts are delivered. Each CTS must ask for cts_limit packets, or for the
+ * rest, see cts_accept_ok().
+ */
+static bool tp_serve_cts_ok(int raw, const uint8_t *payload, size_t size,
+			    unsigned int num_pkts, unsigned int cts_limit)
+{
+	unsigned int sent = 0;
+	struct can_frame frame;
+
+	while (sent < num_pkts) {
+		unsigned int cts_pkts, next;
+
+		if (!recv_kernel_cm_ok(raw, TP_CM, TP_CMD_CTS, &frame,
+				       J1939_RECV_TIMEOUT_MS))
+			return false;
+
+		cts_pkts = frame.data[TP_CTS_PKTS_OFF];
+		next = frame.data[TP_CTS_NEXT_OFF];	/* 1-based */
+		if (!cts_accept_ok(cts_pkts, next, sent, num_pkts, cts_limit))
+			return false;
+
+		if (!send_tp_dt_burst_ok(raw, SA_LOCAL, SA_PEER, next, cts_pkts,
+					 payload, size))
+			return false;
+
+		sent += cts_pkts;
+	}
+	return true;
+}
+
+/*
+ * Answer each ETP.CTS from the kernel with a DPO and the block's DT frames,
+ * until all size bytes of payload are delivered. Each ETP.CTS must ask
+ * for a full block of ETP_CTS_MAX_PKTS packets, or for the rest.
+ */
+static bool etp_rx_serve_cts_ok(int raw, const uint8_t *payload, size_t size)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(size), sent = 0;
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	while (sent < num_pkts) {
+		unsigned int cts_pkts, next;
+
+		if (!recv_kernel_cm_ok(raw, ETP_CM, ETP_CMD_CTS, &frame,
+				       J1939_RECV_TIMEOUT_MS)) {
+			fprintf(stderr, "# no well-formed ETP CTS after %u/%u packets\n",
+				sent, num_pkts);
+			return false;
+		}
+
+		cts_pkts = frame.data[ETP_CTS_PKTS_OFF];
+		next = get_le24(&frame.data[ETP_CTS_NEXT_OFF]);	/* 1-based */
+		if (!cts_accept_ok(cts_pkts, next, sent, num_pkts,
+				   ETP_CTS_MAX_PKTS))
+			return false;
+
+		cm_dat_init(dat, ETP_CMD_DPO);
+		dat[ETP_DPO_PKTS_OFF] = cts_pkts;
+		put_le24(&dat[ETP_DPO_BASE_OFF], next - 1);
+		if (!peer_send_cm_ok(raw, ETP_CM, dat))
+			return false;
+
+		if (!send_dt_burst_ok(raw, PRIO, ETP_DT, SA_LOCAL, SA_PEER,
+				      next, cts_pkts, payload, size,
+				      TP_FIRST_PKT))
+			return false;
+
+		sent += cts_pkts;
+	}
+	return true;
+}
+
+/* Message offset of a DT frame's payload; base_pkt as for unpack_dt_into() */
+static size_t dt_off(const struct can_frame *frame, unsigned int base_pkt)
+{
+	return (base_pkt + (frame->data[J1939_DT_SEQ_OFF] - 1)) *
+	       J1939_DT_DATA_LEN;
+}
+
+/*
+ * Scatter a received DT frame's payload into buf, a message of size bytes,
+ * at the offset implied by its sequence number. base_pkt is the number of
+ * packets before this block (TP_BASE_PKT for TP, the DPO offset for ETP);
+ * seq counts from 1 inside the block.
+ */
+static void unpack_dt_into(uint8_t *buf, size_t size, unsigned int base_pkt,
+			   const struct can_frame *frame)
+{
+	size_t off = dt_off(frame, base_pkt);
+
+	/* drop a frame with a bad sequence number instead of overrunning buf */
+	if (off >= size)
+		return;
+
+	memcpy(buf + off, &frame->data[J1939_DT_DATA_OFF],
+	       j1939_dt_chunk_len(size, off));
+}
+
+/* Are the bytes after the payload in a DT frame all J1939_FILL_BYTE? */
+static bool dt_fill_ok(const struct can_frame *frame, size_t size,
+		       unsigned int base_pkt)
+{
+	size_t off = dt_off(frame, base_pkt);
+	size_t i;
+
+	if (off >= size)
+		return true;	/* a bad sequence number fails elsewhere */
+	for (i = J1939_DT_DATA_OFF + j1939_dt_chunk_len(size, off);
+	     i < CAN_MAX_DLEN; i++)
+		if (frame->data[i] != J1939_FILL_BYTE)
+			return false;
+	return true;
+}
+
+/*
+ * Receive count DT frames on dt_pgn from the kernel and scatter them into
+ * buf, a message of size bytes; base_pkt as for unpack_dt_into(). Each frame
+ * must have CAN_MAX_DLEN bytes (the kernel pads the last one with
+ * J1939_FILL_BYTE, see j1939_tp_tx_dat(), and dt_fill_ok() checks it) and the
+ * sequence number TP_FIRST_PKT + i. That holds for an ETP block and for a TP
+ * CTS window that starts at the first packet.
+ */
+static bool recv_dt_block_ok(int raw, pgn_t dt_pgn, uint8_t *buf, size_t size,
+			     unsigned int base_pkt, unsigned int count)
+{
+	struct can_frame frame;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (!recv_for_peer_ok(raw, J1939_PF(dt_pgn), SA_PEER, SA_LOCAL,
+				      &frame, J1939_RECV_TIMEOUT_MS)) {
+			fprintf(stderr, "# missing DT %u of %u\n",
+				i + TP_FIRST_PKT, count);
+			return false;
+		}
+		if (frame.len != CAN_MAX_DLEN ||
+		    frame.data[J1939_DT_SEQ_OFF] != TP_FIRST_PKT + i) {
+			fprintf(stderr, "# DT %u of %u: len %u, seq %u\n",
+				i + TP_FIRST_PKT, count, frame.len,
+				frame.data[J1939_DT_SEQ_OFF]);
+			return false;
+		}
+		if (!dt_fill_ok(&frame, size, base_pkt)) {
+			fprintf(stderr, "# DT %u of %u: bad fill bytes\n",
+				i + TP_FIRST_PKT, count);
+			return false;
+		}
+		unpack_dt_into(buf, size, base_pkt, &frame);
+	}
+	return true;
+}
+
+/*
+ * Open a TP RX j1939 socket and send the RTS for a TP_SIZE message that
+ * starts a receive session.
+ */
+static bool tp_rx_open_and_send_rts_ok(int *j1939, int raw, int ifindex,
+				       uint8_t cts_limit)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, PGN_DATA);
+	if (*j1939 < 0)
+		return false;
+
+	return send_tp_rts_ok(raw, PRIO, PGN_DATA, SA_LOCAL, SA_PEER, TP_SIZE,
+			      J1939_NUM_PKTS(TP_SIZE), cts_limit);
+}
+
+/*
+ * TP-RX round-trip: open the j1939 socket, drive a full TP receive from the
+ * raw peer advertising cts_limit packets per CTS, and verify the reassembled
+ * payload against the sent pattern. Each CTS must ask for cts_limit packets,
+ * or for the rest, see cts_accept_ok(). The kernel's EOMA frame is returned
+ * via *eoma_out.
+ */
+static bool tp_rx_roundtrip_ok(FIXTURE_DATA(j1939_multi) *self,
+			       uint8_t cts_limit,
+			       struct can_frame *eoma_out)
+{
+	uint8_t payload[TP_SIZE];
+
+	fill_pattern(payload, sizeof(payload));
+
+	if (!tp_rx_open_and_send_rts_ok(&self->j1939, self->raw, self->ifindex,
+					cts_limit))
+		return false;
+
+	if (!tp_serve_cts_ok(self->raw, payload, TP_SIZE,
+			     J1939_NUM_PKTS(TP_SIZE), cts_limit))
+		return false;
+
+	if (!recv_kernel_cm_ok(self->raw, TP_CM, TP_CMD_EOMA, eoma_out,
+			       J1939_RECV_TIMEOUT_MS))
+		return false;
+
+	return recv_verify_ok(self->j1939, payload, sizeof(payload),
+			      J1939_RECV_TIMEOUT_MS);
+}
+
+/*
+ * TP RX: the CAN_RAW peer transmits a TP message to the J1939 socket.
+ * raw sends RTS, then answers each CTS from the kernel with DT frames.
+ */
+TEST_F(j1939_multi, tp_rx_from_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+
+	/* the RTS allows all packets in one CTS */
+	ASSERT_TRUE(tp_rx_roundtrip_ok(self, TP_CTS_ALL, &frame))
+		TH_LOG("TP RX round-trip against the raw peer failed");
+
+	/* frame is the kernel's EOMA */
+	EXPECT_EQ(get_le16(&frame.data[TP_EOMA_SIZE_OFF]), TP_SIZE);
+	EXPECT_EQ(frame.data[TP_EOMA_PKTS_OFF], num_pkts);
+}
+
+/*
+ * Start a TP/ETP transmit session from the J1939 socket: open a socket bound
+ * to SA_LOCAL with no PGN, connect to the peer, send the size bytes of
+ * payload and collect the kernel's RTS from the raw peer (cm_pgn/rts_cmd
+ * select TP or ETP). *j1939 holds the fd before connect() or send() can
+ * fail, so the fixture teardown closes it.
+ */
+static bool tx_start_session_ok(int *j1939, int raw, int ifindex,
+				const void *payload, size_t size,
+				pgn_t cm_pgn, uint8_t rts_cmd,
+				struct can_frame *rts)
+{
+	*j1939 = j1939_open(ifindex, SA_LOCAL, J1939_NO_PGN);
+	if (*j1939 < 0)
+		return false;
+
+	if (!j1939_connect_ok(*j1939, ifindex, SA_PEER, PGN_DATA))
+		return false;
+
+	if (!send_all_ok(*j1939, payload, size))
+		return false;
+
+	return recv_kernel_cm_ok(raw, cm_pgn, rts_cmd, rts,
+				 J1939_RECV_TIMEOUT_MS);
+}
+
+static bool tp_tx_start_session_ok(FIXTURE_DATA(j1939_multi) *self,
+				   const void *payload, size_t size,
+				   struct can_frame *rts)
+{
+	return tx_start_session_ok(&self->j1939, self->raw, self->ifindex,
+				   payload, size, TP_CM, TP_CMD_RTS, rts);
+}
+
+static bool etp_tx_start_session_ok(FIXTURE_DATA(j1939_multi) *self,
+				    const void *payload, size_t size,
+				    struct can_frame *rts)
+{
+	return tx_start_session_ok(&self->j1939, self->raw, self->ifindex,
+				   payload, size, ETP_CM, ETP_CMD_RTS, rts);
+}
+
+/*
+ * TP TX: the J1939 socket transmits a TP message to the CAN_RAW peer.
+ * raw answers the kernel's RTS with a CTS, collects the DT frames and
+ * acknowledges with EOMA, which completes the session. The socket then
+ * gets the TX-completion ACK.
+ */
+TEST_F(j1939_multi, tp_tx_to_raw)
+{
+	uint8_t payload[TP_SIZE], rx_buf[TP_SIZE];
+	unsigned int num_pkts = J1939_NUM_PKTS(TP_SIZE);
+	struct can_frame frame;
+	uint8_t dat[CAN_MAX_DLEN];
+
+	fill_pattern(payload, sizeof(payload));
+	memset(rx_buf, 0, sizeof(rx_buf));
+
+	ASSERT_TRUE(tp_tx_start_session_ok(self, payload, sizeof(payload),
+					   &frame));
+	ASSERT_TRUE(errqueue_enable_ack_ok(self->j1939));
+
+	EXPECT_EQ(get_le16(&frame.data[TP_RTS_SIZE_OFF]), TP_SIZE);
+	EXPECT_EQ(frame.data[TP_RTS_PKTS_OFF], num_pkts);
+	EXPECT_TRUE(frame.data[TP_RTS_MAX_PKTS_OFF] == num_pkts ||
+		    frame.data[TP_RTS_MAX_PKTS_OFF] == TP_RTS_NO_LIMIT);
+
+	/* request all packets in one CTS, starting at the first */
+	cm_dat_init(dat, TP_CMD_CTS);
+	dat[TP_CTS_PKTS_OFF] = num_pkts;
+	dat[TP_CTS_NEXT_OFF] = TP_FIRST_PKT;
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, TP_CM, dat));
+
+	ASSERT_TRUE(recv_dt_block_ok(self->raw, TP_DT, rx_buf, TP_SIZE,
+				     TP_BASE_PKT, num_pkts));
+	EXPECT_TRUE(errqueue_empty_ok(self->j1939))
+		TH_LOG("error-queue entry or socket error before the EOMA");
+
+	cm_dat_init(dat, TP_CMD_EOMA);
+	put_le16(&dat[TP_EOMA_SIZE_OFF], TP_SIZE);
+	dat[TP_EOMA_PKTS_OFF] = num_pkts;
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, TP_CM, dat));
+
+	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
+	EXPECT_TRUE(errqueue_read_ack_ok(self->j1939))
+		TH_LOG("no TX-completion ACK after the EOMA");
+}
+
+/*
+ * ETP RX: the CAN_RAW peer transmits an ETP message to the J1939 socket.
+ * The kernel requests blocks with ETP.CTS; raw answers each with a DPO and
+ * the block's DT frames. The payload spans several ETP.CTS blocks.
+ */
+TEST_F(j1939_multi, etp_rx_from_raw)
+{
+	static uint8_t payload[ETP_SIZE];
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	fill_pattern(payload, ETP_SIZE);
+
+	self->j1939 = j1939_open(self->ifindex, SA_LOCAL, PGN_DATA);
+	ASSERT_GE(self->j1939, 0);
+
+	cm_dat_init(dat, ETP_CMD_RTS);
+	put_le32(&dat[ETP_RTS_SIZE_OFF], ETP_SIZE);
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, ETP_CM, dat));
+
+	ASSERT_TRUE(etp_rx_serve_cts_ok(self->raw, payload, sizeof(payload)));
+
+	ASSERT_TRUE(recv_kernel_cm_ok(self->raw, ETP_CM, ETP_CMD_EOMA, &frame,
+				      J1939_RECV_TIMEOUT_MS))
+		TH_LOG("no well-formed ETP EOMA from kernel after last DT");
+	EXPECT_EQ(get_le32(&frame.data[ETP_EOMA_SIZE_OFF]), ETP_SIZE);
+
+	EXPECT_TRUE(recv_verify_ok(self->j1939, payload, ETP_SIZE,
+				   J1939_RECV_TIMEOUT_MS))
+		TH_LOG("J1939 socket did not get the exact ETP message");
+}
+
+/*
+ * Ask the kernel for the next ETP block of cts_pkts packets, after got
+ * packets are already received. Check its DPO and receive the block into
+ * rx_buf, a message of size bytes.
+ */
+static bool etp_tx_serve_block_ok(FIXTURE_DATA(j1939_multi) *self,
+				  uint8_t *rx_buf, size_t size,
+				  unsigned int got, unsigned int cts_pkts)
+{
+	unsigned int next = got + 1;		/* 1-based */
+	unsigned int dpo_num, dpo_base_pkt;
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+
+	cm_dat_init(dat, ETP_CMD_CTS);
+	dat[ETP_CTS_PKTS_OFF] = cts_pkts;
+	put_le24(&dat[ETP_CTS_NEXT_OFF], next);
+	if (!peer_send_cm_ok(self->raw, ETP_CM, dat))
+		return false;
+
+	if (!recv_kernel_cm_ok(self->raw, ETP_CM, ETP_CMD_DPO, &frame,
+			       J1939_RECV_TIMEOUT_MS)) {
+		fprintf(stderr, "# no well-formed DPO after %u packets\n", got);
+		return false;
+	}
+
+	dpo_num = frame.data[ETP_DPO_PKTS_OFF];
+	dpo_base_pkt = get_le24(&frame.data[ETP_DPO_BASE_OFF]);
+	if (dpo_num != cts_pkts || dpo_base_pkt != got) {
+		fprintf(stderr,
+			"# DPO for %u packets after %u, want %u after %u\n",
+			dpo_num, dpo_base_pkt, cts_pkts, got);
+		return false;
+	}
+
+	return recv_dt_block_ok(self->raw, ETP_DT, rx_buf, size, dpo_base_pkt,
+				dpo_num);
+}
+
+/*
+ * ETP TX: the J1939 socket transmits an ETP message to the CAN_RAW peer.
+ * raw requests the data in blocks of up to ETP_CTS_MAX_PKTS packets
+ * (ETP.CTS). For each block the kernel sends a DPO and the DT frames. The
+ * EOMA from raw completes the session, and the socket then gets the
+ * TX-completion ACK.
+ */
+TEST_F(j1939_multi, etp_tx_to_raw)
+{
+	unsigned int num_pkts = J1939_NUM_PKTS(ETP_SIZE);
+	static uint8_t payload[ETP_SIZE], rx_buf[ETP_SIZE];
+	uint8_t dat[CAN_MAX_DLEN];
+	struct can_frame frame;
+	unsigned int got = 0;
+
+	fill_pattern(payload, ETP_SIZE);
+	memset(rx_buf, 0, sizeof(rx_buf));
+
+	ASSERT_TRUE(etp_tx_start_session_ok(self, payload, ETP_SIZE, &frame));
+	ASSERT_TRUE(errqueue_enable_ack_ok(self->j1939));
+
+	EXPECT_EQ(get_le32(&frame.data[ETP_RTS_SIZE_OFF]), ETP_SIZE);
+
+	while (got < num_pkts) {
+		unsigned int cts_pkts = num_pkts - got;
+
+		if (cts_pkts > ETP_CTS_MAX_PKTS)
+			cts_pkts = ETP_CTS_MAX_PKTS;
+
+		ASSERT_TRUE(etp_tx_serve_block_ok(self, rx_buf, sizeof(rx_buf),
+						  got, cts_pkts))
+			TH_LOG("ETP block after %u/%u packets failed", got,
+			       num_pkts);
+		got += cts_pkts;
+	}
+	EXPECT_TRUE(errqueue_empty_ok(self->j1939))
+		TH_LOG("error-queue entry or socket error before the EOMA");
+
+	cm_dat_init(dat, ETP_CMD_EOMA);
+	put_le32(&dat[ETP_EOMA_SIZE_OFF], ETP_SIZE);
+	ASSERT_TRUE(peer_send_cm_ok(self->raw, ETP_CM, dat));
+
+	EXPECT_EQ(memcmp(payload, rx_buf, sizeof(payload)), 0);
+	EXPECT_TRUE(errqueue_read_ack_ok(self->j1939))
+		TH_LOG("no TX-completion ACK after the EOMA");
+}
+
+int main(int argc, char **argv)
+{
+	return j1939_test_main(argc, argv, J1939_NEEDS_RAW);
+}
diff --git a/tools/testing/selftests/net/can/test_j1939_multi.sh b/tools/testing/selftests/net/can/test_j1939_multi.sh
new file mode 100755
index 0000000000000000000000000000000000000000..61f65365ec568f928b58bc4f892f97e9ec887027
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_multi.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source "$(dirname "$0")/j1939_lib.sh"

-- 
2.47.3

