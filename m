Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410783;
	b=GE21+SqUGE51jql62tmwsvh56Xs5jbrxlg//MPxDbls5HW9w0jwUpENaPwM0z5YOz4jR
	 4cEArkAwUMWFap/l35MGsoKFp5T4M7MXibT7BGzOCqCZ+t5aPQbq1wsgn4GJ5SPMcwgEK
	 m7UgyPavjY37C6kL6GP9Jd83PGkVasyAf8ECn5qp9eMlD5WMI0lQEzMl8lkgve3emNQ9X
	 Jr4hfURy/oLryc1qhbou2Tc3aKBTFern6vCjSX/c7RzDnhZlFgaH9Sc8RvZ8crqN/Eyeo
	 tri+op0MvPb0i7L1IXKe9Lry2t3sHbHx4jCUEqaqXI/61FSQlSOQ7kwb9YQ3NG7vdKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410783;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=6wmlD7jtirBkDzpzQmnWDtjg7VyKMwqIZMobKF2/Aac=;
	b=KjGkrH62MC9LLqIzRmJoEeK/63rNVeNQpmV1g83TXE5/mg3cFN1cCUYLkIldJQZe7RMC
	 rqOEAWgsAuOgX8erq8NcqmCBeNPVnZZW33uNAQgMBp3U7GSn2h89aiTIpzbSD2THrtuzH
	 2mtv+acFvj0wBfyUtN1kGiEqoSXeFr4AA3afPkEUHAV9JO95ELceB+yOlRfDk0GhEIsqY
	 6ohwmwyR5uNZJssDxFF/mKDtoliWUJcio6a0HNIEkK8pmxXBcJvgSqiig0CBC0L+dEgLe
	 esM0+FIdoqEVmu7KjlMCKCH7O2AnG144OXCR6a+p2e9DOz7a8yD+zn12Nnb6ZrNlICw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MPspumvp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC629606A88C;
	Wed, 11 Nov 2026 15:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC629606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MPspumvp
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 17B39202C9B;
	Wed, 11 Nov 2026 16:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wmlD7jtirBkDzpzQmnWDtjg7VyKMwqIZMobKF2/Aac=;
	b=MPspumvp9rE19KxVRZgKG69iQ8ia1bQxFZ4S2V4yOSPEu23YjG075f9rL5NperW0Ubvp+s
	aR9VcfQMyZX6k34twB8FYRQRAgxprv0WWAnnnIw/V9fXcZ4P/ZDNXATxljgUicTFjzry76
	HX+VOQCaygJ4zVxFxlPiSSVoyLUf9rzEBd1WMXqSnfuXj5rwi/8Y7uwBVA7jGFmACBm2WF
	r52ue1aoKQ/NIljW2Sa7WgP5huwmJ4GdtEZawpKCuA/J4C3cpWs9sr2th3TWY/roqIO6q5
	imvkNyD9x5Tl9Uwci8+5+mXiLqoqA4qUyyF0Gm8Ix4IgUjg0fbswd+eU+uflzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794410776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wmlD7jtirBkDzpzQmnWDtjg7VyKMwqIZMobKF2/Aac=;
	b=ChQmwy0jnqffyVzjpNFXuk6/ZYm07Yn7xhAW4VfnLBjF5ibjFlUvnl84deyv9qylpKby+d
	1AxjbNjFEwON5asJA1R+8H9SaRRqC9Ux0+ThC4Yov4KMzo1u7kjArMKcs/FKCoEetg1Qm/
	6LHqkwQgR/FbvEkBQil1R7P2dUaY+/utQe5RTaEP36/n0CulpHGIOneLrd+gi+nzrEr4Mo
	R0OajHZnu0Ju+mkPeeoPnWmhqSc/Ns6oMSH5dOCaaqXP2fYpXAEPMG1k1OxqG+IbA7jZBL
	GToLBsARqVRH4lI9PSMqAY5Wypg3QibjRgQ3TJ5ciosr8OCR9zPW+0yYXnYNfw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794410776; a=rsa-sha256;
	cv=none;
	b=fxLCx0s16mUK45h4ufgzRgkhZA5mVuV89Mhar85jQp+kxOvL9vdHgUehOQZ1ZeJWlvOX6X
	HHpuqZGAi+qXxWEH+/+pZO8z6gEbCGPWl8SoqgO/4P+KvCBdlnUy2L3Yz721gUUNEmdTSP
	o4hEp25kMNMIwJ/pmXK5aO7cDOoUXHNLC9sYMJco64u/7UIyv5p9IF2cNPFVmMOu8X+d+D
	SHgfy+4IkSRm8xQ8m7AeYsZSX4La24oz44rQI2BDhJfFL7YGKrU3I6s7a9KxD45LUbu0VN
	VfQNxwLGXS44jo4N4F2IdehDxfQlqA07hjstAQIOO716xJ6gOqr17PFS4w8ObA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id BCC8A3818BA; Wed, 11 Nov 2026 16:26:11 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Wed, 11 Nov 2026 16:25:58 +0100
Subject: [PATCH can-next v3 9/9] selftests: can: check SO_J1939_PROMISC
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
Message-Id: <20261111-j1939-selftests-v3-9-5a80277ab363@pengutronix.de>
References: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
In-Reply-To: <20261111-j1939-selftests-v3-0-5a80277ab363@pengutronix.de>
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
 tools/testing/selftests/net/can/test_j1939_opts.c | 129 +++++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
index a729e39c0be4fc8e77717c71000f205dd14f453b..4be2db1e2bb64b3aba534cb9405996f6b1d34edd 100644
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
@@ -173,6 +178,126 @@ TEST_F(j1939_opts, filter_pgn)
 	EXPECT_EQ(errno, EAGAIN);
 }
 
+/*
+ * rx binds to (PROMISC_BOUND_DA, PROMISC_BOUND_PGN). Without SO_J1939_PROMISC
+ * it must not get the probes below. Each probe differs from the binding only
+ * in the address or only in the PGN, so each filter is tested on its own.
+ */
+#define PROMISC_BOUND_DA	SA_RX
+#define PROMISC_BOUND_PGN	PGN_A
+_Static_assert(SA_OTHER != PROMISC_BOUND_DA && PGN_B != PROMISC_BOUND_PGN,
+	       "each probe must differ from the binding");
+_Static_assert(J1939_IS_PDU1(PROMISC_BOUND_PGN) &&
+	       PROMISC_BOUND_DA <= J1939_MAX_UNICAST_ADDR,
+	       "the binding must be a unicast address and a PDU1 PGN");
+
+enum { PROBE_OTHER_PGN, PROBE_OTHER_ADDR, PROBE_NUM };
+
+static const struct {
+	uint8_t da;
+	pgn_t pgn;
+} promisc_probes[] = {
+	[PROBE_OTHER_PGN] = { PROMISC_BOUND_DA, PGN_B },
+	[PROBE_OTHER_ADDR] = { SA_OTHER, PROMISC_BOUND_PGN },
+};
+
+_Static_assert(ARRAY_SIZE(promisc_probes) == PROBE_NUM,
+	       "promisc_probes needs one row per probe");
+
+/*
+ * Send every probe from tx and check that rx gets none of them. Keep
+ * sending after a probe arrives, so each filter is checked on its own.
+ * Return false if a probe arrives. Also return false at once if a probe
+ * cannot be sent.
+ */
+static bool no_probe_received_ok(FIXTURE_DATA(j1939_opts) *self,
+				 const uint8_t *buf, size_t len)
+{
+	uint8_t rx_buf[CAN_MAX_DLEN];
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
+		if (recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+				 J1939_NEG_RECV_TIMEOUT_MS) != -1) {
+			fprintf(stderr, "# probe %zu was received\n", i);
+			ok = false;
+		}
+	}
+	return ok;
+}
+
+/* SO_J1939_PROMISC delivers frames that do not match the bound (addr, pgn). */
+TEST_F(j1939_opts, promisc_receive)
+{
+	struct sockaddr_can bound_src = {};
+	const pgn_t bound_pgn = PROMISC_BOUND_PGN;
+	uint8_t tx_buf[CAN_MAX_DLEN];
+	size_t i;
+
+	fill_pattern(tx_buf, sizeof(tx_buf));
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
+	 * check after clearing, too.
+	 */
+	ASSERT_TRUE(j1939_sendto_ok(self->tx, tx_buf, sizeof(tx_buf),
+				    self->ifindex, J1939_NO_NAME,
+				    PROMISC_BOUND_DA, PROMISC_BOUND_PGN))
+		TH_LOG("sendto of the matching frame failed: %d", errno);
+	ASSERT_TRUE(recvfrom_verify_ok(self->rx, tx_buf, sizeof(tx_buf),
+				       J1939_RECV_TIMEOUT_MS, &bound_src))
+		TH_LOG("no matching frame after promisc was cleared");
+	EXPECT_EQ(bound_src.can_addr.j1939.pgn, bound_pgn);
+}
+
 /* Without SO_J1939_SEND_PRIO the kernel's default priority is used. */
 TEST_F(j1939_opts, send_prio_default)
 {

-- 
2.47.3

