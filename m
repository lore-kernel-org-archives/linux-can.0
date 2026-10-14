Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46856560ADE;
	Wed, 14 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992687; cv=pass; b=V4u60AooTVuvvZMmAvW1F2jCzlUsiIhq1n7yH5axivWw2u8M5C8k/NvRmln1+4kC3MxvOKKwSIsGzJHSfv2lLOw5FQ571gOQ6OmGfdlMACdg7Uxq2xdYUbrsog/950l1cvxWZWn+r9yqyC1KBdiMSTPcnGl9zWlVkPZw3U33Dlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992687; c=relaxed/simple;
	bh=1w6VnA93kmZ4XZ7LNht9nWmp/y/4b4G8FYh8vZuRD3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz2jewg8wJqkzbYoSzHTFn0D54VKI2TWMm+NU3zrqKUbgiISwETgxNTRoi3qg3r90etCzbLXkoj4PrEdZqoyvAnrmK2Ki4Ln4AvCY893rBNlRhM3pOMeexOk9ZNty2z9HRnJz5Y9jXqhYzkauYlwBVOI0VAJ6ke604GkVwwJkro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gPdQzSIe; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gPdQzSIe"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 44A262027D4;
	Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5AnQXGsoqTI6+R2LvsudVA4c8wt6zip2KzS2kCMT7A=;
	b=gPdQzSIeQBpH1wMW/Ax2z0QmQfwJJENAlDSjE3HlHWG4AnWjjZS5ou78Xk7k50y13J5WrK
	hdjd1WjqnODPNFltM+Dm/gg3AAT7ImuD0s6P/9FBXD1vRRxevoy+2NTVEhR2bAOKlB8QAr
	0m1UcHo3Cc+ZcAE5kGOaP7J0+5PeRpfXYcX4ykriK5Te3PZxSBsniQW7fZEJa4BsySiRMG
	Ea+3XFdtTrN6lYv3tPCWo3XayDyF2H8fhdd2UAT+lYnNYz8yR0tSlFDO3i8NmTNpKJSEWh
	1KbN8r6lPF36UWaGtpk+Ovg4gO4RFFtz2bogfI/bbBIytVrbK1biv6E54PH9gQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791992677; a=rsa-sha256;
	cv=none;
	b=XT1RvVhmLmX9E3Zyg9fcKjCbyojXPDrTPUMqrc3iTp/TDQVkzw/OTc1BqN74IbBa4FDQTE
	5SJJn6eLCvbNCRtTfXn5kT4d5Iy8udm0Q8r4ry2npL1IQt5LLKcEZDikUEX9os21z6CK/L
	twmE3WaDkcnJ1rS0v1GvZwD53BCkBSV4yF0+G+MMyh/BEMw6M3kqg2brk5THrLtLzJT3F2
	wIsy8e92ovRjA+YAoScH1jvKnwgR0XmM6wOJaFTDZoPbsJ78M43u+8+aXZVEwrb2m0AYwc
	GKYtim6PD5hAPsjldtJeXgps8FWIYrKUAsH0Ijw7y0grKijGmX/cJNcuTZgpGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5AnQXGsoqTI6+R2LvsudVA4c8wt6zip2KzS2kCMT7A=;
	b=BevjoHmCCYesrK/2vTRxiZoArAAGgpBAOnH2K0kMlG9FImdM3hZshY7Xa/GRSOCBWZ8BQn
	imBbhYO+EVUu5WsT1ThCJaMCvwds5UAc1pJZaSjBnORLELoyAyBPLOiMH3vNGBFJ60B+dO
	n7CsNKEc5xpmv66nPoCnnCybeOE2DKtWabUHsopzRxRODLtCxWHi4K182VExp3Ve2gIkZt
	EHd0sQer8n10iQRi9FJ82WebrlqS0b3MJ7upkq5OosqliLlPBHPZ8ru+WOknky5tDuJMVP
	s+xJYGGjMyqQB6yHrfFRWgz5b//u4Ei6T/bvd/rdDjSP0G/LTP6qz3SgJhvNsg==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 2A40E389273; Wed, 14 Oct 2026 17:44:37 +0200 (CEST)
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
Subject: [PATCH can-next v1 8/8] selftests: can: check SO_J1939_PROMISC receive effect
Date: Wed, 14 Oct 2026 17:44:34 +0200
Message-ID: <20261014154435.3577983-9-o.rempel@pengutronix.de>
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

Add a test that exercises the SO_J1939_PROMISC receive effect. The
existing coverage only round-trips the flag through set/getsockopt, so a
kernel that stores it but never acts on it in the RX path stays green.

The test binds an rx socket to a specific (address, PGN), checks that a
frame to a different destination address and PGN is not delivered, then
enables SO_J1939_PROMISC and checks the same otherwise-unmatched frame is
now delivered unchanged.

Assisted-by: LLM
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../selftests/net/can/test_j1939_opts.c       | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_j1939_opts.c b/tools/testing/selftests/net/can/test_j1939_opts.c
index f761a42db213..3afda9b4e4a8 100644
--- a/tools/testing/selftests/net/can/test_j1939_opts.c
+++ b/tools/testing/selftests/net/can/test_j1939_opts.c
@@ -5,8 +5,8 @@
  * On top of the basic transport, cover the user-visible J1939 socket options and
  * addressing: the SO_J1939_FILTER PGN whitelist, the SO_J1939_SEND_PRIO send
  * priority seen in the CAN id (via a CAN_RAW peer, including the default of 6),
- * unconnected sendto(2), a wrong-family bind rejection, and SO_J1939_ERRQUEUE
- * TX-completion notifications.
+ * unconnected sendto(2), a wrong-family bind rejection, SO_J1939_ERRQUEUE
+ * TX-completion notifications, and the SO_J1939_PROMISC receive effect.
  *
  * The vcan interface is set up by the caller (see test_j1939_opts.sh); its name
  * is passed via the CANIF environment variable.
@@ -22,6 +22,7 @@
 
 #define SA_TX			0x80
 #define SA_RX			0x90
+#define SA_OTHER		0x50
 #define PGN_A			0x0ab00
 #define PGN_B			0x0cd00
 #define PRIO_SET		3
@@ -123,6 +124,47 @@ TEST_F(j1939_opts, filter_pgn)
 		TH_LOG("PGN_B was received but should have been filtered out");
 }
 
+/* SO_J1939_PROMISC delivers a frame that does not match the bound (addr,pgn). */
+TEST_F(j1939_opts, promisc_receive)
+{
+	uint8_t tx_buf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+	uint8_t rx_buf[8];
+	int enable = 1;
+	int ret;
+
+	self->rx = j1939_open(self->ifindex, SA_RX, PGN_A);
+	ASSERT_GE(self->rx, 0);
+	self->tx = j1939_open(self->ifindex, SA_TX, J1939_NO_PGN);
+	ASSERT_GE(self->tx, 0);
+
+	/*
+	 * This frame uses a different address and PGN than rx is bound to.
+	 * Without promisc, rx must not receive it.
+	 */
+	ret = j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			   J1939_NO_NAME, SA_OTHER, PGN_B);
+	ASSERT_EQ(ret, (int)sizeof(tx_buf))
+		TH_LOG("sendto unmatched frame failed: %d", errno);
+	EXPECT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_NEG_RECV_TIMEOUT_MS), -1)
+		TH_LOG("unmatched frame was received without promisc");
+
+	/* SO_J1939_PROMISC returns the flag value (1), not 0, on success. */
+	ASSERT_GE(setsockopt(self->rx, SOL_CAN_J1939, SO_J1939_PROMISC,
+			     &enable, sizeof(enable)), 0)
+		TH_LOG("SO_J1939_PROMISC failed: %d", errno);
+
+	/* The same otherwise-unmatched frame must now be delivered. */
+	ret = j1939_sendto(self->tx, tx_buf, sizeof(tx_buf), self->ifindex,
+			   J1939_NO_NAME, SA_OTHER, PGN_B);
+	ASSERT_EQ(ret, (int)sizeof(tx_buf))
+		TH_LOG("sendto unmatched frame failed: %d", errno);
+	ASSERT_EQ(recv_timeout(self->rx, rx_buf, sizeof(rx_buf),
+			       J1939_RECV_TIMEOUT_MS), (int)sizeof(tx_buf))
+		TH_LOG("unmatched frame not received despite promisc");
+	EXPECT_EQ(memcmp(tx_buf, rx_buf, sizeof(tx_buf)), 0);
+}
+
 /* without SO_J1939_SEND_PRIO the J1939 default priority (6) is used. */
 TEST_F(j1939_opts, send_prio_default)
 {
-- 
2.47.3

