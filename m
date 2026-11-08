Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378615;
	b=ZEv6hAvJs8byWV4sDreB5yzxjkbKNssVKMFwQYWS82duVu/SYN7Lvpn2QKxW8UvX5HkT
	 urHjy62GYJdQb2Sdbr31Dy7miy9GQR9Q9W8R2veO+arxt/Bhn272watv755OT3WcU7bOJ
	 AIIQalcnR4dHQPwc0oKP9/71HsNkg9b/IJnItJICAE2CU0T7VoXFN+AvyMvWYYXXQC1Ok
	 VM3O6+7+zeY0hAneCO7JmshvMDY2EmqQhpX9bu0J0f19qXgcfKyNxuNswBjy4V/O+U6BL
	 9V3L3x6+WyzQl9ecZoKp6StBsyJsl17zfX36eaDeyXhoNIsZDW2mCbwayJLLP83mLIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378615;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=a1FqF8Br2zg85qjr6YI+b6O9gQbxnYbLnUsbz4vQtuU=;
	b=z4VQrS8xOAlMEoSO8uG84peJJUiqbB57bnG82FSM0k04n6HFKYm49Sn65M7DORJQ44Y0
	 1UuwCWw8ERe4e61lkJUXpXc2zuUzJWTjr+Jgk5//gKv/twQAOc4wjZme4R+MNHYaatKAY
	 jU6bPtrsoQIkAXMP7r1EUdNE8YK/H381q8GoBi0WCb5v7aYVgTm34M+SWbLeVMSmIPq85
	 jws1LgpQDi/krpzN03EsyOQ8U5k4bCTGXtFg562c/SsAuuIUg8B7SsR+k4GsutjD5j0Sp
	 Ro6CTFO9LmorhaD40piUyxMjXljpEjxFuYKBLENF0pjQ0bn8XEtkpIxVW/mxctUYftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=P0tVSCNP;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342E606A334;
	Wed, 11 Nov 2026 06:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B342E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=P0tVSCNP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=a1FqF8Br2zg85qjr6YI+b6O9gQbxnYbLnUsbz4vQtuU=;
	b=P0tVSCNPGicpsOAnF06gRjHzAabjZyHjJwos/lVnwn4V8frTzrCyl9ZIzemQbU
	HZu42ENT4b9wIAwUmHZuTfWxLe4Tbpb/p/Ku3g9mdgTNSsH29X6htoPuygCP+vMB
	zKm2Taslr4Vv8opxfmd0gFzPXYly798KTdwtmdjoqfejg=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v7 3/4] can: j1939: drop the message when the reassembled skb is gone
Date: Sun, 08 Nov 2026 09:34:23 +0800
Message-ID: <179410166346.60581.12668181404057434786@163.com>
In-Reply-To: <179410166344.60581.3898011861151549156@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HwNgC_RqGrLqGQ--.51764S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4xtr4kXw17JF1DJryxZrb_yoW8ZF4rpF
	98KFy5Gr9rZr17Ars3K3yUX34Yy3Zaqr1rXFy0k3s3A345Cr4rJF4DK34aqa98Jan5u3y3
	W3sxX3W7Kay0g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOHUDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAGyKGr0C2Fw2wAA3E

From ba4643113b5f6ad2b53b98dae1c25d5465d4d0c0 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <quchaosheng000406@163.com>
Date: Sun, 8 Nov 2026 09:22:29 +0800
Subject: [PATCH net v7 3/4] can: j1939: drop the message when the reassembled
 skb is gone

j1939_session_completed() takes the skb for the completed message and hands
it to j1939_sk_recv() without checking the result.  j1939_session_skb_get()
returns NULL when the offset it computes lands past the end of the queue.

The offset is "pkt.dpo * 7", and pkt.dpo is bounded when an EDPO is
received,
so this should not happen.  Guard it anyway: a NULL dereference in the
receive path is a kernel panic, while a dropped message is a lost datagram.
j1939_simple_txnext(), the only other caller of j1939_session_skb_get(),
already checks for NULL.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index b0e62822b56e..5f05c15114ce 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1269,9 +1269,19 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+
+		/* Defense in depth: pkt.dpo is range checked when an EDPO is
+		 * received, so the lookup should always find the skb.  Drop the
+		 * message rather than hand a NULL skb to j1939_sk_recv() if the
+		 * offset arithmetic ever regresses.  The only other caller of
+		 * j1939_session_skb_get(), j1939_simple_txnext(), already does
+		 * this.
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


