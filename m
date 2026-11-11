Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393473;
	b=g2Bs/x2AI3bofdP3/EGxhp9siQpv1wqOVza4ZUv/Hd6hq7a/2Rmnp6ADsQGVmS2wCbFO
	 iGw1zf3v6ad0psBbRfHLpm+l2OAPL6BVTQ+tc+8ZrvlBBFrv6wvduiQu4CHKC2C6RKtIY
	 dpQxV2clxoKMQyNUszLhcN+x+wglfbAypkOlci3g2fE4t2bztHngaIQgtpDbYPjiJpvYD
	 NSM5axE2/HnQKvb7du+WhG8q6LXUBvHyM+KZaDcofeETOWkUzZlZV37ELSL9oaOgIaLgJ
	 FEom2kCFgncKBGu+52uRs4ol8jZOpc7thctJj0P32jHipoacSbp4o2L887mx1zzsShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393473;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=6Ho2M0VUW7VCGgUrpM5ofB3aUX9egvXjmTtH+qZ/dEo=;
	b=bi5nVoqhz10CPvfV8ZG0lijfTcgDB201rwSw+iq79xptupunNWgfgw45vtnFRpBpbXIQ
	 BvnVX4rwhtH+mU1XvvD+2+6hJIsoPeIZ4V5gd1s9wsOqgwU5keKX6kNgFwnesbc3otM1D
	 2h9p+h4m79YCSO168BHwJ4c1EsSYrxvHySaBUIcxy3zDlV9PrIc+3EOQN6BP4tOvQVSd0
	 u/8g4a8dcQoWqtK3DAhI+/QVottKFkJrJxaenWHPqQEl0EsiR3/PP1zE3IldNcbG/YI/W
	 SDGWOrppUO7OH3ddEWZtdVVulpgsQOwTNCNVMitZ5xBPyXPyaBZ7z5GAz1hpsjeMdlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XDWKkjbP;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BA606A887;
	Wed, 11 Nov 2026 10:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687BA606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XDWKkjbP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=6Ho2M0VUW7VCGgUrpM5ofB3aUX9egvXjmTtH+qZ/dEo=;
	b=XDWKkjbPTPxXderyAtatzGncYj2SKg43LlCq5joI0NbiS4GaDYhUnNQcRJ0mBO
	hEA3fMCLygHey27qdF+BjU4C89jvzx3SNZdSkyTxq54ZmEw3CFanGSRccAX/1EF7
	c8f5BjvE5p/XXVZWW5sczt9VgeIC8TfAHFb2Np8yfAoHw=
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Date: Wed, 11 Nov 2026 18:31:24 +0800
Subject: [PATCH net v9 3/4] can: j1939: drop the message when the
 reassembled skb is gone
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
Message-Id: <20261111-j1939-edpo-v9-v9-3-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
In-Reply-To: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-CM-TRANSID:_____wDn38ZvRfRqIHegGQ--.49604S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw18Aw15Wr1ruw4fAr13urg_yoW8Xw4UpF
	y7KryUGr9rXF47ArsagrWDX345C3Zaqry8GFyUtwn3C3y5Cw45trs8Kryaqan8Aan5u3ya
	ga43X3W7Kay0937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcWrAUUUUU=
Sender: quchaosheng000406@163.com
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xBFumr0RXBf3QAA3l

From: Chaosheng Qu <quchaosheng000406@163.com>

Check the skb that j1939_session_completed() hands to j1939_sk_recv(),
which dereferences oskb->sk.  A NULL here is the last step of the EDPO
out-of-range sequence fixed by the previous patch; the bounds check makes
the lookup succeed, but the dereference should not depend on that.

Drop the message instead, which is what the other caller of
j1939_session_skb_get(), j1939_simple_txnext(), already does.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 258009182..fc2840f33 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1281,9 +1281,17 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+
+		/* Defense in depth: pkt.dpo is range checked when an EDPO is
+		 * received, so the lookup should always find the skb.  Drop
+		 * the message rather than hand a NULL skb to j1939_sk_recv()
+		 * if the offset arithmetic ever regresses.
+		 */
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);

-- 
2.43.0


