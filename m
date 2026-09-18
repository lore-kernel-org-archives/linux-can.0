Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E928DB54;
	Fri, 18 Sep 2026 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700227; cv=none; b=Riy/fASR3iB+U2HOEZbgP7D90tOc1QAQF8Zs3sp0KPsVlZaMVxDol5ER+b6wUQw1JIoB6i9SweV5InhjoONSfKFXaHdTlES4XDTi/5m5fvvCCijHhUmfGKfz7Rju44wH9Dhi25w36G6HSSRWztX3y4oJF6r5ASeHHAtTCWJpm5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700227; c=relaxed/simple;
	bh=BU6Gow1GkXgMlkSVzOBNAwJivG+3VA2dm+yN6Q06WzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IopbCpYHqbLntFayC7dpPUcqJG1yCbJDaVU/LjuYXhJqcVhknkUKUJ3gra11vyuZ4riTJaGjaX+Mg121dnvZhzeNrPCIH9jlOyGYhmI3nB6SyaqZkF5t7qaiuwDOJazpq4VLKEu7bryhVlaE7gcIbKniaonlu9CbmWHBOF73iiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AbDpmFXD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AbDpmFXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=09
	lAaBv/6Y9GQDR0tK0e/kF1ZYd5mbxpJg3UKvI5uZM=; b=AbDpmFXDe+qnmbN0HQ
	yJYHLNr1MEdnkDjO8IkwUQznO7jIcKYZHNf/VBZ906p8ZzB4y+jnflUeINKbYukz
	MXnfDYMxihZwaX9Yoi0pkKiYbdypw1pABoGP5YLAbDyR6pjx8Sb7ft1qdnvtWuge
	nejFQJrHGmOJY6ltG8zNTExfk=
Received: from vd-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X+FaqKxqMQl+BQ--.61271S3;
	Fri, 18 Sep 2026 10:56:32 +0800 (CST)
From: Xue Boyang <m18335910246@163.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	kernel@pengutronix.de
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m18335910246@163.com
Subject: [PATCH net 1/2] can: j1939: fix null-ptr-deref in j1939_session_completed()
Date: Thu, 17 Sep 2026 21:56:14 -0500
Message-ID: <20260918025622.192582-2-m18335910246@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918025622.192582-1-m18335910246@163.com>
References: <20260918025622.192582-1-m18335910246@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X+FaqKxqMQl+BQ--.61271S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr43Ar1kKw4kAF1kGF17Wrg_yoW5AF13pF
	y3CryUGrZ7Zr1UAr48trWDXryFvanakFyrGw1Fg3sxA3sxCa15tF4UtFyS9a98Gan5ua43
	uasrXw1DKw40g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pioa0PUUUUU=
X-CM-SenderInfo: zpryjjavzrijiuw6il2tof0z/xtbC8QAItmqsqGAd0AAA3M

j1939_session_completed() distributes the reassembled message to all
matching receivers via j1939_sk_recv().  The skb is obtained from
j1939_session_skb_get(), which looks up the receive queue starting at
session->pkt.dpo * 7 and returns NULL if no queued skb covers that
offset.

The DPO (Data Packet Offset) command is accepted without validation in
j1939_xtp_rx_dpo_one(), so a peer can move pkt.dpo to a packet number
beyond the end of the reassembled buffer.  The TP.DT placement uses
"dat[0] - 1 + session->pkt.dpo" arithmetic, so with pkt.dpo ==
pkt.total a final DT frame with dat[0] == 0 is still accepted as the
last in-order packet (packet == rx) and the transfer completes
normally.  j1939_session_completed() then looks up the offset
pkt.total * 7, which is outside the receive buffer, so
j1939_session_skb_get() returns NULL and it is passed to
j1939_sk_recv(), which dereferences it via j1939_skb_to_cb().

This is reachable by an unprivileged user through a virtual CAN
interface (all required capabilities are obtainable in a user
namespace) with the frame sequence:

    ETP.CM_RTS (size 1786)  -> total = 256 packets
    ETP.CM_DPO (packet 0)
    ETP.DT x255             -> packets 0..254, rx = 255
    ETP.CM_DPO (packet 256) -> dpo = 256, unvalidated
    ETP.DT (dat[0] = 0)     -> packet 255 == rx, completes transfer

resulting in:

    KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
    RIP: 0010:j1939_sk_recv+0xd8/0x4b0
    Call Trace:
     <IRQ>
     ? j1939_session_skb_get_by_offset+0x14f/0x2a0
     j1939_xtp_rx_eoma+0x43d/0x500
     j1939_tp_recv+0x930/0xca0
     j1939_can_recv+0x696/0x900
     can_rcv_filter+0x223/0x760
     can_receive+0x222/0x310
     can_rcv+0x204/0x370

(j1939_session_completed() is inlined into j1939_xtp_rx_eoma() in
this build; trace taken from v7.3.0-rc3-00313-gdaf677c2c644 + KASAN.)

The only other caller of j1939_session_skb_get(),
j1939_simple_txnext(), already checks for NULL; do the same here and
skip the distribution while still running
j1939_session_deactivate_activate_next() so the session is not left
stuck.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Xue Boyang <m18335910246@163.com>
---
 net/can/j1939/transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..ecf7f245f837 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,10 @@ static void j1939_session_completed(struct j1939_session *session)
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
-- 
2.53.0

