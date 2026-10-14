Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31D55D895;
	Wed, 14 Oct 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992682; cv=pass; b=trRCveDKhszTfuvVdmtf+wAER+N0oe1bdDsMUniG8H0VX/xjPndWwkvdPKlTcPhuSavzzW8dSZ8sp7KiEDfgrU9etecSAkeQECLDOFMgiT/6SiLUkM0DoemobpxOK3oB9tEcYT1jlraga3gRqwho+Cl4h3cKMCgHRL2ssfyxYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992682; c=relaxed/simple;
	bh=qz6/MQm80SbuNM3A8i61ctkYwMubUAHIDb6ptEs5ai8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8XUd2VR6tgdTuX+6gXrBceLJkvOVpLfn2l5DjzW/A6je3uKh/zo+eRohRYOtmNsc+KgKx44h7Z6M7ovaWh6AstUSNA4jDrlsKv45wQ76j7KQ1QlBIUaPrw9tF5YI7HbY2cR5hqRA94keP4D8l5BCuR3I7vyGDr/lFupaXVNO1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=LmyS0Vzy; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="LmyS0Vzy"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2FC92201F04;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkR8HBcbgFqaNrkNAMX+CuL+Pc92QLmewtfTX3Z9TMk=;
	b=LmyS0VzyAGnRF16+rG4Hbwqkn7rQOb+ku6Pmz+feCvuiHU7NKKjw7pwMh7rLuB3bywd0hL
	ZaEtAcoCsLmL+jPOD5FhdWroXZ4cjcArarGhTKUrrR9sFA0aVTud99Z0z9aMp6Vm/l0BQj
	dleJHmcZJWWKpkvlYJ5JoY8c4yYkgknKcsDlVvNFEtcBgUdtlF2iFtgSM8u2fWjErJjjM5
	hmAm7DDanl8/tigARHZ2G3gGn5VuwvnYcMpL1FIo/N5fyNEDsImDm4gU/E6VaKk3hnX6BB
	679C6JUWnrS4FVRA8XvtinS/af0j+a/kmtiVkhSee5By4zGkbdBRPbD8vGi2uA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=TxjUMt49mj0NIvMCn5quBc0nKTtW/M94aHuJD2aUdjpiqWUoOrL+i9uZH450vWxAf5xFDu
	u+yEt2qZ0mXwARt+FzlCx+Ib2z9ERXB/ZLfuQzMXhpWEp75VOOobVfnITKIk0vl0XHqquN
	rZOg1Z3C3jxFuZT61uX+LYXlnYDojKQl5KQeobiZi1gX3zBvn3G53eQORnhZG07Xsh5mcc
	+b4XPvAfWIX3LzwGlbAsgybLoQWmeHya+ISD0t7F7MAeOlZ41iR4an7aR71xmdREDpDP9S
	6SORSmXiDaPM6gfQtJXh67dQV8Ce319CBfw40uQXiFe7ld0mzPFLZF5FLx4fHg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkR8HBcbgFqaNrkNAMX+CuL+Pc92QLmewtfTX3Z9TMk=;
	b=gl7PKG2s07OBOD8kj8TINbe1d2OSxcPBMeWg2i6Fo3gQ9OVSGhklAdB64zahwEe5mBYYDi
	8bWX1wPvS5c0P1iaFHCx4EqerUA2EVDKydFyDBuMbUW0sm65OuRvuQSwWq/5AXiq5fkV3q
	ol4bZjnu7dZnEXRNscDarkxTK980DKvZy1NCYyTzhh5ovW9vuGaIuoCTnQ6OuuGqhxaJyn
	N/hb8TwGZWI1LQqLiQINOybBGCuHXR75+kmwrhaflaeSShecR0fdAoXChlQAhq2rUFewdW
	sucDQSG6otcPv/gMO0zCoR8QWOUcT7/RUBnwejKBAKLxuJO8qNoBUjlySrUIgg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 181E338786B; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 4/8] selftests: can: add J1939 addressing and concurrency tests
Date: Wed, 14 Oct 2026 17:44:30 +0200
Message-ID: <20261014154435.3577983-5-o.rempel@pengutronix.de>
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

Add a selftest for J1939 NAME-based addressing and address claiming:
binding and reading back a NAME, the source address seen on the wire,
NAME-addressed transfers (with a forged Address Claimed), the Address
Claimed a socket emits, and address-claim conflicts where the contender
with the higher NAME loses and the one with the lower NAME keeps the
address. It also runs several concurrent transport sessions as a stress
check.

The NAME is serialized onto the wire byte-wise (put_name) so the tests
behave the same on big- and little-endian hosts.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/testing/selftests/net/can/.gitignore    |   1 +
 tools/testing/selftests/net/can/Makefile      |   2 +
 .../selftests/net/can/test_j1939_addr.c       | 336 ++++++++++++++++++
 .../selftests/net/can/test_j1939_addr.sh      |   5 +
 4 files changed, 344 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/test_j1939_addr.c
 create mode 100755 tools/testing/selftests/net/can/test_j1939_addr.sh

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 427eed83e49e..7ca63a19472c 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -2,3 +2,4 @@
 test_raw_filter
 test_j1939_base
 test_j1939_opts
+test_j1939_addr
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 24a57edb912c..6e4176a1b985 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	test_raw_filter.sh \
 	test_j1939_base.sh \
 	test_j1939_opts.sh \
+	test_j1939_addr.sh \
 
 TEST_FILES := j1939_lib.sh
 
@@ -17,5 +18,6 @@ TEST_GEN_FILES := \
 	test_raw_filter \
 	test_j1939_base \
 	test_j1939_opts \
+	test_j1939_addr \
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/test_j1939_addr.c b/tools/testing/selftests/net/can/test_j1939_addr.c
new file mode 100644
index 000000000000..8b1b093f0839
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * J1939 addressing and concurrency selftests.
+ *
+ * Cover NAME-based addressing and address claiming: binding a NAME and reading
+ * it back, the bound source address appearing in the CAN id, a sender reaching a
+ * peer by NAME, address-claim contention where the lower NAME wins, and a stress
+ * run of many concurrent transport sessions.
+ *
+ * The vcan interface is set up by the caller (see test_j1939_addr.sh); its name
+ * is passed via the CANIF environment variable.
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
+#define SA_TX			0x80
+#define SA_RX			0x90
+#define NAME_TX			0x00000000c0ffee01ULL
+#define NAME_RX			0x00000000c0ffee02ULL
+#define PGN_TEST		0x0ab00
+#define STRESS_N		8	/* arbitrary test tuning */
+#define STRESS_SIZE		128	/* arbitrary test tuning */
+#define ACLAIM_SETTLE_US	300000	/* settle: empirical, not spec */
+
+/* Open a J1939 socket bound to (name, sa, pgn). */
+static int j1939_open_name(int ifindex, name_t name, uint8_t sa, pgn_t pgn)
+{
+	return j1939_open_flags(ifindex, name, sa, pgn, 0);
+}
+
+/*
+ * Inject an Address Claimed message (PGN 0xee00, global destination) for the
+ * given source address and NAME via a raw socket, so the kernel learns the
+ * NAME <-> address mapping. The kernel does not claim addresses itself.
+ */
+static int forge_address_claim(int raw, uint8_t sa, name_t name)
+{
+	uint8_t nb[8];
+
+	put_name(nb, name);
+	if (send_raw8(raw, J1939_PRIO_DEFAULT, J1939_PGN_ADDRESS_CLAIMED,
+		      J1939_NO_ADDR, sa, nb))
+		return -1;
+	/* give the kernel RX path a moment to process the claim */
+	usleep(ACLAIM_SETTLE_US);
+	return 0;
+}
+
+/* One independent transport-protocol round-trip; returns 0 on success. */
+static int stress_child(int ifindex, uint8_t sa_tx, uint8_t sa_rx)
+{
+	uint8_t tx_buf[STRESS_SIZE];
+	int tx, rx, rc = 1;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+
+	rx = j1939_open_name(ifindex, J1939_NO_NAME, sa_rx, PGN_TEST);
+	tx = j1939_open_name(ifindex, J1939_NO_NAME, sa_tx, J1939_NO_PGN);
+	if (rx < 0 || tx < 0)
+		goto out;
+	if (j1939_connect_name(tx, ifindex, J1939_NO_NAME, sa_rx, PGN_TEST))
+		goto out;
+
+	if (send_recv_verify(tx, rx, tx_buf, sizeof(tx_buf),
+			     J1939_RECV_TIMEOUT_MS) == 0)
+		rc = 0;
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
+/* bind with a NAME and read it back with getsockname(2). */
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
+/* the bound source address is used as source address on the wire. */
+TEST_F(j1939_addr, source_sa_on_wire)
+{
+	uint8_t buf[8] = {};
+	struct can_frame frame;
+	int ret;
+
+	self->raw = open_raw(self->ifindex);
+	ASSERT_GE(self->raw, 0);
+
+	/* static source address: no address claim needed to transmit */
+	self->tx = j1939_open_name(self->ifindex, J1939_NO_NAME, SA_TX,
+			      J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_EQ(j1939_connect_name(self->tx, self->ifindex, J1939_NO_NAME,
+				SA_RX, PGN_TEST), 0);
+
+	ASSERT_EQ(send(self->tx, buf, sizeof(buf), 0), (int)sizeof(buf));
+
+	ret = recv_timeout(self->raw, &frame, sizeof(frame), J1939_RECV_TIMEOUT_MS);
+	ASSERT_GT(ret, 0);
+	EXPECT_EQ((int)J1939_ID_SA(frame.can_id), SA_TX)
+		TH_LOG("source address on wire is 0x%02x, expected 0x%02x",
+		       (unsigned int)J1939_ID_SA(frame.can_id), SA_TX);
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
+	uint8_t tx_buf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+	uint8_t rx_buf[8];
+
+	/* static receiver on SA_RX; the forged claim maps NAME_RX -> SA_RX */
+	self->rx = j1939_open_name(self->ifindex, J1939_NO_NAME, SA_RX, PGN_TEST);
+	ASSERT_GE(self->rx, 0);
+
+	self->raw = open_raw(self->ifindex);
+	ASSERT_GE(self->raw, 0);
+	ASSERT_EQ(forge_address_claim(self->raw, SA_RX, NAME_RX), 0)
+		TH_LOG("failed to inject address claim: %d", errno);
+
+	self->tx = j1939_open_name(self->ifindex, J1939_NO_NAME, SA_TX,
+			      J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+	ASSERT_EQ(j1939_connect_name(self->tx, self->ifindex, NAME_RX,
+				J1939_NO_ADDR, PGN_TEST), 0)
+		TH_LOG("connect to peer NAME failed: %d", errno);
+
+	ASSERT_EQ(send(self->tx, tx_buf, sizeof(tx_buf), 0),
+		  (int)sizeof(tx_buf))
+		TH_LOG("send to peer NAME failed: %d", errno);
+	ASSERT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_RECV_TIMEOUT_MS), (int)sizeof(tx_buf));
+	EXPECT_EQ(memcmp(tx_buf, rx_buf, sizeof(tx_buf)), 0);
+}
+
+/* many concurrent transport-protocol sessions run without corruption. */
+TEST_F(j1939_addr, stress_concurrent_sessions)
+{
+	pid_t pids[STRESS_N];
+	int i, failed = 0;
+
+	for (i = 0; i < STRESS_N; i++) {
+		pids[i] = fork();
+		ASSERT_GE(pids[i], 0);
+		if (pids[i] == 0)
+			_exit(stress_child(self->ifindex, 0x40 + i, 0x20 + i));
+	}
+
+	for (i = 0; i < STRESS_N; i++) {
+		int status;
+
+		if (waitpid(pids[i], &status, 0) < 0 ||
+		    !WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			failed++;
+	}
+
+	EXPECT_EQ(failed, 0)
+		TH_LOG("%d of %d concurrent sessions failed", failed, STRESS_N);
+}
+
+#define SA_CLAIM		0x50
+#define SA_DST			0x60
+#define NAME_CLAIM		0x00000000c0ffee10ULL
+#define NAME_LOWER		0x00000000c0ffee00ULL	/* higher priority */
+#define NAME_HIGHER		0x00000000c0ffee20ULL	/* lower priority */
+
+/*
+ * Claim an address the way j1939acd would: bind a NAME to an address and send
+ * an Address Claimed message, then wait for the claim to settle. Returns the
+ * (still open) socket on success.
+ */
+static int claim_addr(int ifindex, name_t name, uint8_t sa)
+{
+	uint8_t nb[8];
+	int s;
+
+	s = j1939_open_flags(ifindex, name, sa, J1939_NO_PGN, J1939_OPEN_BCAST);
+	if (s < 0)
+		return -1;
+
+	put_name(nb, name);
+	if (j1939_sendto(s, nb, 8, ifindex, J1939_NO_NAME, J1939_NO_ADDR,
+			 J1939_PGN_ADDRESS_CLAIMED) != 8) {
+		close(s);
+		return -1;
+	}
+
+	usleep(ACLAIM_SETTLE_US);	/* settling time */
+	return s;
+}
+
+/* Send a single data frame from a socket to (SA_DST, PGN_TEST). */
+static int send_data(int s, int ifindex)
+{
+	uint8_t data[8] = {};
+
+	return j1939_sendto(s, data, sizeof(data), ifindex, J1939_NO_NAME,
+			    SA_DST, PGN_TEST);
+}
+
+static bool match_addr_claimed(canid_t id, const void *ctx)
+{
+	(void)ctx;
+	return J1939_ID_PF(id) == J1939_PF(J1939_PGN_ADDRESS_CLAIMED) &&
+	       J1939_ID_SA(id) == SA_CLAIM;
+}
+
+/* sending an Address Claimed message puts it on the wire and claims. */
+TEST_F(j1939_addr, address_claim_send)
+{
+	struct can_frame frame;
+
+	self->raw = open_raw(self->ifindex);
+	ASSERT_GE(self->raw, 0);
+
+	self->tx = claim_addr(self->ifindex, NAME_CLAIM, SA_CLAIM);
+	ASSERT_GE(self->tx, 0)
+		TH_LOG("address claim failed: %d", errno);
+
+	/* the Address Claimed frame must have appeared on the wire */
+	EXPECT_EQ(recv_match(self->raw, ACLAIM_SETTLE_US / 1000, &frame,
+			     match_addr_claimed, NULL), 0)
+		TH_LOG("no Address Claimed frame seen on the wire");
+
+	/* with the address claimed, the socket can transmit */
+	EXPECT_EQ(send_data(self->tx, self->ifindex), 8)
+		TH_LOG("transmit from claimed address failed: %d", errno);
+}
+
+/*
+ * Shared address-claim arbitration setup for the win/lose conflict tests.
+ * Claim SA_CLAIM with NAME_CLAIM, confirm we own it, then let a contender with
+ * @contender claim the same SA. On success stores the result of transmitting
+ * after the contention in *tx_ret (errno is left as that send set it) and
+ * returns 0; returns -1 if any setup step failed. Each caller asserts its own
+ * win/lose outcome on *tx_ret.
+ */
+static int ac_conflict_probe(FIXTURE_DATA(j1939_addr) *self, name_t contender,
+			     int *tx_ret)
+{
+	self->raw = open_raw(self->ifindex);
+	if (self->raw < 0)
+		return -1;
+	self->tx = claim_addr(self->ifindex, NAME_CLAIM, SA_CLAIM);
+	if (self->tx < 0)
+		return -1;
+
+	/* baseline: we own the address and can transmit */
+	if (send_data(self->tx, self->ifindex) != 8)
+		return -1;
+
+	/* let the contender claim our SA */
+	if (forge_address_claim(self->raw, SA_CLAIM, contender))
+		return -1;
+
+	*tx_ret = send_data(self->tx, self->ifindex);
+	return 0;
+}
+
+/* a higher-priority competing claim takes the address away from us. */
+TEST_F(j1939_addr, ac_conflict_lose)
+{
+	int tx_ret;
+
+	/* a contender with a lower NAME (higher priority) claims our SA */
+	ASSERT_EQ(ac_conflict_probe(self, NAME_LOWER, &tx_ret), 0);
+
+	/* we must have lost the address */
+	EXPECT_LT(tx_ret, 0)
+		TH_LOG("transmit still succeeded after losing the address");
+	EXPECT_EQ(errno, EADDRNOTAVAIL);
+}
+
+/* a lower-priority competing claim does not take our address. */
+TEST_F(j1939_addr, ac_conflict_defend)
+{
+	int tx_ret;
+
+	/* a contender with a higher NAME (lower priority) must not win */
+	ASSERT_EQ(ac_conflict_probe(self, NAME_HIGHER, &tx_ret), 0);
+
+	EXPECT_EQ(tx_ret, 8)
+		TH_LOG("lost the address to a lower-priority claim");
+}
+
+J1939_TEST_MAIN();
diff --git a/tools/testing/selftests/net/can/test_j1939_addr.sh b/tools/testing/selftests/net/can/test_j1939_addr.sh
new file mode 100755
index 000000000000..e611fe211c6d
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_j1939_addr.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+J1939_TEST_PROG=test_j1939_addr
+source "$(dirname "$0")/j1939_lib.sh"
-- 
2.47.3

