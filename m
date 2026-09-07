Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F733479872;
	Mon,  7 Sep 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793028; cv=none; b=ModtLNDAL0149lrYtdqqaG3uWDr0ooHNbt8UJf03+qwN55VRg/Q7/NJhgtiTy08qBkb56EK/J6Jmw2/yq3O/NwK8OFAVE6RME+FVC/0JU8pqYYnuFvlg4E/jg6p4275s/7RHkQYKQAW7ie3mI8g1o+IEPYlYEiQLV7losVN2qSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793028; c=relaxed/simple;
	bh=00BhCRwbFPUhGYktYr+ZVqT6zRXJCkDRmRD3zstNDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuiM/i34eKboSjTL2u9nicn8IBedrHAxVC3EAzaEq2wlbd6Bcfq+BeVdLHHn60H3bOI7YJLlxeb1C+lbxq2pw3eVaG0v5s8Xh5oSFYJD0NDg1ItkTiAoGp98x0+w3RJnSqvjLLru4S5BQrL+dbhrIA0yHI86x4rTin6GwYysQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=HZ7DIVbE; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="HZ7DIVbE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788793015; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UKwL+/zSgDWDaUoYaGsf9dFyzi5V46qJNcHjj+DZd60=;
	b=HZ7DIVbEYQ9XsjLVRRe1zpynnWdYnK+XMp8H1rqlv3RwIryP6vEJiPRwzDGsh68KvjHzP3+zAWsfKuxRhmtVHKkTJdSdjJhfPri9X550y7FQn9GqBEOgjH3eOZzhq2lOSEWu25o+ee7aXJqcaFA7HcznPMBmVyrK0FT+tHwxoHU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07679742|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00628589-0.000516362-0.993198;FP=9819626307066575985|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j7vgRsC_1788793005;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j7vgRsC_1788793005 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 22:56:54 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH 1/2] can: j1939: reject TP RTS with wrong packet count
Date: Mon,  7 Sep 2026 22:56:38 +0800
Message-ID: <20260907145640.1106170-2-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260907145640.1106170-1-liuc63@xiaopeng.com>
References: <20260907145640.1106170-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_rts_session_new() computes the expected packet count as
(len + 6) / 7, then unconditionally overwrites it with dat[3] from
the incoming RTS, even when the two disagree.  When dat[3] is smaller,
the session completes after fewer packets than the buffer was sized
for, delivering a short (zero-padded) message to userspace.  When
dat[3] is zero, every incoming data packet looks out of range and the
session hangs until the rx timeout fires.

Abort the session when dat[3] doesn't match or is zero, similar to
how a4fbe70c5cb7 ("can: j1939: j1939_xtp_rx_rts_session_new(): abort
TP less than 9 bytes") rejects out-of-range message sizes.

An alternative would be to silently keep the computed value and ignore
dat[3], but that doesn't actually work: the sender only transmits
dat[3] packets, so the receiver would never collect enough to complete
and would hang until the rx timeout fires -- a worse failure mode than
a clean abort with a clear log message.

  # RTS: len=100 (dat[1..2]=0x0064) but dat[3]=1 (should be 15)
  cansend vcan0 18EC8090#1064000103002301

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/can/j1939/transport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5..8fdce5792 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1672,11 +1672,16 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
 	if (skcb.addr.type != J1939_ETP) {
-		if (dat[3] != session->pkt.total)
-			netdev_alert(priv->ndev, "%s: 0x%p: strange total, %u != %u\n",
-				     __func__, session, session->pkt.total,
-				     dat[3]);
-		session->pkt.total = dat[3];
+		if (dat[3] != session->pkt.total || dat[3] == 0) {
+			netdev_warn(priv->ndev,
+				    "%s: 0x%p: packet count mismatch, calc %u != RTS %u, abort\n",
+				    __func__, session,
+				    session->pkt.total, dat[3]);
+			j1939_xtp_tx_abort(priv, &skcb, true,
+					   J1939_XTP_ABORT_FAULT, pgn);
+			j1939_session_put(session);
+			return NULL;
+		}
 		session->pkt.block = min(dat[3], dat[4]);
 	}
 
-- 
2.50.1

