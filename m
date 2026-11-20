Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167973;
	b=viGUb3vz/TrqQ/8PgM8YlueWycScmbIdjg+r5PVSVPDjiVUubuD4sPZF4fj8eYjVcAuO
	 wNXHflCpip/5p4LTN8qy4Muma5E9EYsTQc5cFOcQrSaKdn5KFoAseyyGQYcpdJo8E/FEp
	 EeTYtNerQm++erZDR3bDjNW1y5sFsAL5x5tTyR64ivxwNtXSIaAdcilxFIv5rySnnQLvq
	 M3e5ONC1/+pbO2SElq8gTyb37ya5kiy8LYXUkX1yxLch5h32AS99UF9Z5f99NhvAx6V0W
	 NXoSPh04V2CFUDlaqWzxzVfkLTZpZkPvaTducxI2CzcWqJHnKCJVpCwv9tGONWJ8yCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=oxiu5l03TjeNQRcDr/PNCNqvR4y0kcYMeE3Rc/pWmXU=;
	b=BL99ZI+sdF4fTuz7AXZ/I+GdGwUnptC8DabUsnD48pvHlY028kdZDNYO8pAqWXQi1z1c
	 Dw3Jxcqq4NMnrQrUGW/81VkJXUmznYwoSj5h1nyKCnUHioJDHbyMBipU7iOVF/Q5a906r
	 lzJUj+BmqsUqX5NoG55UVhtoox8mv5ud6lX1eiJDib8Q0YTxA2Tvn6TkC59WMkf10QAG6
	 9tYjfWOYohUTvZ5heeRCnSFTv33Hq61wGDhKSXgKl0AELykI/+xVIbCFCfiLXTAMO1BHd
	 JaH00iQ18GLBkU8MGWTMav5XNYPitBEJ5XKo9oOHRl/QVgFjQSI8ISxgL0AWi07hAVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="JM/UhAbG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511760A2623;
	Fri, 20 Nov 2026 09:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9511760A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JM/UhAbG
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8B181205B46;
	Fri, 20 Nov 2026 10:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxiu5l03TjeNQRcDr/PNCNqvR4y0kcYMeE3Rc/pWmXU=;
	b=JM/UhAbGYfvtDhNBLHX5M2Dc+ajPGn6AsWNs4Bvl4Qj6SEhZTyJ7LgxdWJ67qM+lNr00ae
	bqHIXNHlpEIMqVusTaqcYLF7AZ9i5V4BK8NTvsGCHRhAk0A+rNe2n71IH213kf5lcaYJ1h
	Ed0/GNi4c0Txm9i/HtJJie1NkJNyfGxHq6fk/Hv7whq8QctTLc57/GTQUKgWac+nz3w5Zq
	yoCgHJZS0IS/07YPajLl2eY8gloPDeCJaVbz1jvns4GIglIkwyuNEfqwmlp2EhP/FLBWT8
	RNaZOy7omGqdxWRZHs9DS0k9HeKIPqNQoVKEs1c4bN2fvzY4yj0cQB38h9oxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795167962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxiu5l03TjeNQRcDr/PNCNqvR4y0kcYMeE3Rc/pWmXU=;
	b=fLvsoTrTt51o9sIJsv/8VkfvKM9ZYrgI3ifkcrWKULm1AiSzlHaK9Q24b5LeGrRfJqU5MC
	Gu2YRWlGkjZb+hWo8TUfc8n8E8PiuLABirBPH/KNLxG/Ndcvl88sn5YYU2kjjiNLOZibeu
	SMDk4FwwYtR1WiI3xEOMaY/2v24lBr+KkDWnFSAByWOl3AVR9fCJjZNcXbYg5NJor/kaeW
	FU2HDxxFI82G1GPID7PRYSlUM1bIXauUCqniIUdpr5lMmhXIzWVgC1mkOJ8dw9Wg+HOFD6
	tAETfumsIvbJvfjp/4xk1OYqi+RBd1HbMDtD80PFKhgk3LoN7QrxIG5fz3YMrg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795167962; a=rsa-sha256;
	cv=none;
	b=ShPESUCCV/9njJ8IAhr7YlutHQ4nz6dCTBrNimGW96G3f76hi++wHrWHF9Juc6TwQVOE6G
	liOyi+9c1dkQLUpQ5d394qV5erGwgLQkM5mSdDAGcF36UDJ7fDDu6iNkKEE23sffy13NxR
	Kha1QmZldIRnXDLWrAYjYAuND7W6obNGI8x9cpuP/k7CZLKRFqjFz6cZB0WOxCZ5H2vFcl
	Xx/vRc8vW/EInfQ1sijXzVwBdaaT5qB+Io7Pa9VD1ekPhZHJlKLUED7pbG8kA3KSzfnhtb
	WgAGllhiYs2y15Jd5lSoytCVeN+8xkutrBuxP1JwcD7qxe1ht7GPA1bYoq9GdA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 551D4381BC0; Fri, 20 Nov 2026 10:46:02 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Fri, 20 Nov 2026 10:46:04 +0100
Subject: [PATCH can-next v5 9/9] selftests: can: check SO_J1939_PROMISC
 receive effect
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
Message-Id: <20261120-j1939-selftests-v5-9-fdf4c242a37e@pengutronix.de>
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

Add a test that SO_J1939_PROMISC changes what the RX path delivers. The
existing coverage only round-trips the flag through set/getsockopt, so a
kernel that stores the flag but never acts on it still passes.

The test uses one probe per filter. One probe goes to a different
address from the bound one. The other has a different PGN. The test
sends the probes three times: before the flag is set, while the flag is
set, and after the flag is cleared. The probes must arrive only while
the flag is set. After the flag is cleared, the test also sends a frame
for the bound address and PGN. That frame must arrive.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Q: why does j1939_set_flag_ok() accept a return value of 1 from
setsockopt(SO_J1939_PROMISC)?
A: See patch 4: the return value is a stack bug, and this series changes
no kernel code.

Changes in v5:
- No changes.

Changes in v4:
- give the matching frame sent after SO_J1939_PROMISC is cleared its own
  payload, so a late probe is not mistaken for it
- name the probe address and PGN once, as PROMISC_OTHER_DA and
  PROMISC_OTHER_PGN, and assert that they are unicast and PDU1
- use recv_none_ok() for the negative receive check

Changes in v3:
- check the PGN of each probe received after SO_J1939_PROMISC is set;
  both carry the same payload (sashiko)
- set the flag with j1939_set_flag_ok(), and check that the probes are
  filtered again after SO_J1939_PROMISC is cleared
- check that a matching frame still arrives after SO_J1939_PROMISC is
  cleared, and stop at once if it does not
- name each probe after what differs from the binding
- define the bound address and PGN once and derive the probes from them
- assert that SA_OTHER is a third unicast address

Changes in v2:
- drop the Assisted-by trailer; the cover letter says how an LLM was used
- wrap at 80 columns and fix the checkpatch warnings (Marc)
- name all constants and avoid casts
- check the address and the PGN filter each on its own
---
 tools/testing/selftests/net/can/test_j1939_opts.c | 137 +++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
index 36734df3420eaced3735f4f1438bca5e7abd65c2..25158623ee6eb47543831771ee79d4c5cb7fe2a9 100644
--- a/tools/testing/selftests/net/can/test_j1939_opts.c
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -6,8 +6,9 @@
  * and addressing: the SO_J1939_FILTER PGN whitelist, the SO_J1939_SEND_PRIO
  * send priority seen in the CAN id (via a CAN_RAW peer, including the kernel's
  * default), unconnected sendto(2), a wrong-family bind rejection,
- * SO_J1939_ERRQUEUE TX-completion notifications, and set/getsockopt
- * round-trips of SO_J1939_SEND_PRIO, SO_J1939_PROMISC and SO_J1939_ERRQUEUE.
+ * SO_J1939_ERRQUEUE TX-completion notifications, the SO_J1939_PROMISC receive
+ * effect, and set/getsockopt round-trips of SO_J1939_SEND_PRIO,
+ * SO_J1939_PROMISC and SO_J1939_ERRQUEUE.
  *
  * Run by test_j1939_opts.sh, see j1939_tests.h.
  */
@@ -19,6 +20,10 @@
 /* arbitrary addresses */
 #define SA_TX			0x80
 #define SA_RX			0x90
+#define SA_OTHER		0x50	/* neither SA_TX nor SA_RX */
+_Static_assert(SA_OTHER != SA_TX && SA_OTHER != SA_RX &&
+	       SA_OTHER <= J1939_MAX_UNICAST_ADDR,
+	       "SA_OTHER must be a third unicast address");
 
 /* two different destination-specific PGNs, otherwise arbitrary */
 #define PGN_A			0x0ab00
@@ -171,6 +176,134 @@ TEST_F(j1939_opts, filter_pgn)
 		TH_LOG("rx got another frame or an error after PGN_A");
 }
 
+/*
+ * rx binds to (PROMISC_BOUND_DA, PROMISC_BOUND_PGN). Without SO_J1939_PROMISC
+ * it must not get the probes below. Each probe differs from the binding only
+ * in the address or only in the PGN, so each filter is tested on its own.
+ */
+#define PROMISC_BOUND_DA	SA_RX
+#define PROMISC_BOUND_PGN	PGN_A
+#define PROMISC_OTHER_DA	SA_OTHER
+#define PROMISC_OTHER_PGN	PGN_B
+_Static_assert(PROMISC_OTHER_DA != PROMISC_BOUND_DA &&
+	       PROMISC_OTHER_PGN != PROMISC_BOUND_PGN,
+	       "each probe must differ from the binding");
+_Static_assert(J1939_IS_PDU1(PROMISC_BOUND_PGN) &&
+	       PROMISC_BOUND_DA <= J1939_MAX_UNICAST_ADDR,
+	       "the binding must be a unicast address and a PDU1 PGN");
+_Static_assert(J1939_IS_PDU1(PROMISC_OTHER_PGN) &&
+	       PROMISC_OTHER_DA <= J1939_MAX_UNICAST_ADDR,
+	       "the probes must use a unicast address and a PDU1 PGN");
+
+enum { PROBE_OTHER_PGN, PROBE_OTHER_DA, PROBE_NUM };
+
+static const struct {
+	uint8_t da;
+	pgn_t pgn;
+} promisc_probes[] = {
+	[PROBE_OTHER_PGN] = { PROMISC_BOUND_DA, PROMISC_OTHER_PGN },
+	[PROBE_OTHER_DA] = { PROMISC_OTHER_DA, PROMISC_BOUND_PGN },
+};
+
+_Static_assert(ARRAY_SIZE(promisc_probes) == PROBE_NUM,
+	       "promisc_probes needs one row per probe");
+
+/*
+ * Send every probe from tx and check that rx gets none of them. Keep
+ * sending after a probe arrives, so each filter is checked on its own.
+ * Return false if rx gets a probe or reports an error. Also return false
+ * at once if a probe cannot be sent.
+ */
+static bool no_probe_received_ok(FIXTURE_DATA(j1939_opts) *self,
+				 const uint8_t *buf, size_t len)
+{
+	bool ok = true;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
+		if (!j1939_sendto_ok(self->tx, buf, len, self->ifindex,
+				     J1939_NO_NAME, promisc_probes[i].da,
+				     promisc_probes[i].pgn)) {
+			fprintf(stderr, "# sendto probe %zu failed: %d\n", i,
+				errno);
+			return false;
+		}
+		if (!recv_none_ok(self->rx)) {
+			fprintf(stderr, "# rx got probe %zu or an error\n", i);
+			ok = false;
+		}
+	}
+	return ok;
+}
+
+/* SO_J1939_PROMISC delivers frames that do not match the bound (addr, pgn). */
+TEST_F(j1939_opts, promisc_receive)
+{
+	struct sockaddr_can match_src = {};
+	const pgn_t bound_pgn = PROMISC_BOUND_PGN;
+	uint8_t match_buf[CAN_MAX_DLEN];
+	uint8_t tx_buf[CAN_MAX_DLEN];
+	size_t i;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
+	memcpy(match_buf, tx_buf, sizeof(match_buf));
+	match_buf[0] ^= UINT8_MAX;
+
+	self->rx = j1939_open(self->ifindex, PROMISC_BOUND_DA,
+			      PROMISC_BOUND_PGN);
+	ASSERT_GE(self->rx, 0);
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	EXPECT_TRUE(no_probe_received_ok(self, tx_buf, sizeof(tx_buf)))
+		TH_LOG("probe check without promisc failed");
+
+	ASSERT_TRUE(j1939_set_flag_ok(self->rx, SO_J1939_PROMISC, 1))
+		TH_LOG("setting SO_J1939_PROMISC failed: %d", errno);
+
+	for (i = 0; i < ARRAY_SIZE(promisc_probes); i++) {
+		struct sockaddr_can src = {};
+		bool got;
+
+		ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+					    self->ifindex, J1939_NO_NAME,
+					    promisc_probes[i].da,
+					    promisc_probes[i].pgn))
+			TH_LOG("sendto probe %zu failed: %d", i, errno);
+		got = recvfrom_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+					 J1939_RECV_TIMEOUT_MS, &src);
+		EXPECT_TRUE(got)
+			TH_LOG("probe %zu not received despite promisc", i);
+		if (!got)
+			continue;
+		/* the probes carry the same payload, so check which one came */
+		EXPECT_EQ(src.can_addr.j1939.pgn, promisc_probes[i].pgn)
+			TH_LOG("probe %zu came with PGN 0x%05x", i,
+			       src.can_addr.j1939.pgn);
+	}
+
+	/* with promisc cleared, the bound (addr, pgn) filters again */
+	ASSERT_TRUE(j1939_set_flag_ok(self->rx, SO_J1939_PROMISC, 0))
+		TH_LOG("clearing SO_J1939_PROMISC failed: %d", errno);
+	EXPECT_TRUE(no_probe_received_ok(self, tx_buf, sizeof(tx_buf)))
+		TH_LOG("probe check after clearing promisc failed");
+
+	/*
+	 * Send a frame for the bound address and PGN. It must still
+	 * arrive. A socket that receives nothing would pass the probe
+	 * check after clearing, too. The frame has its own payload, so a
+	 * late probe cannot be mistaken for it.
+	 */
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, match_buf, sizeof(match_buf),
+				    self->ifindex, J1939_NO_NAME,
+				    PROMISC_BOUND_DA, PROMISC_BOUND_PGN))
+		TH_LOG("sendto of the matching frame failed: %d", errno);
+	ASSERT_TRUE(recvfrom_verify_ok(self->rx, match_buf, sizeof(match_buf),
+				       J1939_RECV_TIMEOUT_MS, &match_src))
+		TH_LOG("no matching frame after promisc was cleared");
+	EXPECT_EQ(match_src.can_addr.j1939.pgn, bound_pgn);
+}
+
 /* Without SO_J1939_SEND_PRIO the kernel's default priority is used. */
 TEST_F(j1939_opts, send_prio_default)
 {

-- 
2.47.3

