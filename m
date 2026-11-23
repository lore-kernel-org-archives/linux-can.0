Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795392566;
	b=tGXNabLgru/zoxuSa49IW1kwNtIZMZk8ye4YMnphj/wXdBsVFJxuXWa4bzO5cj18vB9T
	 3LdaiLS5BvTPYX7UjzYk/V7/AP6PGgHu9k/WlqrlhvUVekE/t3VVYDQFbUw0ub/JGRf3x
	 gcZMewE+uJXokaZ3mwqOsXwm3zcUVXJnoMNbdTN9rlvZ3eyUz8ma8XdcmFLq0T5GNxH/5
	 8RYRAiIQsjGCKRPDixyZMucuQiXbCUxbg1BzqvgKSK+nEbQOBs4dcmFKyVRlPuWlW9wD7
	 QF4ov/f0p3b2G1C0+Xy9wkuOCeJO3Z0zklonr5Ci82U06eKawJp3670uohDPQGCvizA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795392566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
	b=bBUREPQKkn5BFPp9AIqS4YvIVTkR8Ghkz6UyxxH+l/3Gwj0Tq9PLCV4GNQcZ8tMSFBL1
	 MRFnmP/7yN2KWvPayL3WhrrotHWp43kPfsslgAPRIYRxLrj8SlZVC/7n9VhbF+l3yGVp8
	 n7V3ADAk7Oca2Ygt39bdLLQUNii5BEMMrUktppYIBHsufscHYmnf3HPZ82YGzqqQPtL2k
	 OE3y0TNoYEBuGq62HKKB6C9H6Xuou7WnxqUShLo/zEquBFNd/xnlbpCpj4h0unxU+O4aG
	 fjdAFRYfcn7/UooKsabiKhweh+qK2Y8IWaTQ3/qa65J/oHEvRMJnqByk3fAOyXoPhSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bO3Xvg/G";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3F606A31E
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 00:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bO3Xvg/G
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b413997581so2279315a91.2
        for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795392565; x=1795997365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
        b=bO3Xvg/GvXSBMOwAZWCHZ1tEYldoTL/n5xhnbPHDS3uQE7Sv8OQh4LJ6JYItRZAiXq
         XvMWlzkSxtPGXkZ9l71qN1dHqUb3fc+VqST8GHnFtZZqiOCeFNhbyoKkCxAJnNE67ZYL
         yCTXW4qcyGBGrntGyiasEEr077JUQQZnBLh9AE/QBfYhitZGWz2MHpNL4CQALeWsvyJE
         fZK2dxbkB8oPVUn7tbLVgYB+dkQ5E5AIFcS1pMibV5hpo5QyjEQtqL2bh/UYXkzA1wU2
         5HZvTnuuMHEnb9rsuwBO6rT0+e/EuKC2+iRhfKdWpSMXnCl/zBSp5z+vWqW91x44iKNP
         SKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795392565; x=1795997365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5oZfxZDZESOt7JOg36JOb5NoJDTCRqffJz0J5sNJMMI=;
        b=GMgI1THfhyZpxOt1cQfY6tW89SLFCqpyY6OX2H9MWi+SPvso0JyGXfi2ISzHmPCa3u
         9oPoFri+wh1GU07VbYpNh1Y4SnL7vgFH3FB87YVKJ55ip3oXnF///ObmJdLUSOXna80t
         Dq37lZCateujBGARASUccYMK6rq+1apg1UnckfCMxRr+V8u4JXriM/aQhs6YfjszJfx1
         VITgFvb7iafAB5XGA0k/evBci2rra3D6DdKDzfAWhdbOpdF4Eyx9CsT649gdxusX33a3
         y3BPbOaTvRVjJ1e0CehQYhtfRE92B6d5ltmtVeVz+l6JtzMmwebmpzdbgZ59r3wBE1z/
         e5vQ==
X-Forwarded-Encrypted: i=1; AL+hErEw1CwiRm2acEGmF1XV2Vi7SThAmePE7yJWKj3660IU8LI10d3r/tbsU78rOb5XCAQq4AgJKbAIlCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NW+f3CK8acQ7jb8c/7uPucrXqE0tpEQ6nfqPAZRtJ46V0tBRN
	Js+uZoJPrO6yH+gfoyzh5mITo2ig6oh+Bx4Appsdz3tptSOhkQiytN+Zrr8lwdUx
X-Gm-Gg: AZFdTZeROy3opFjV1vJTFqCOKS/T005thRw9XY88t11jrXX8Amdd5F8kT0NRwk808gb
	T6LVgj36sYDIF3z7A/gf5RPEguLh3Al4Bnv5LgWwlgXkRsj1sSw9+eAKj/Fh6GbQGAkI/qXy4y8
	z0lcQ2UHCirpi6rEae6Vk84Z12igA+5IUTqe2vNifz3dSDzalxwiW82gdQgOwoBMxcexjijX+y6
	K3/slgsm7F/miG6llt31Vx1MfYlbaiDc0r9p1u42H+3Lavwi64GJADEuuZ3VUOumQiRTpFA4Cq+
	AvnK8GSWEqlS/469bv29kuAx1WUYrMJQIhiHMTxqdQhOAn1ALoxomv4VcK8QYUqw0V5yu0w8K5V
	S6SP4ZdG/D7JFPMgi+HrkLxJwznY7YXnC5Z6FhHW/+pL4pbaIWXvTRPfEANPGPOA5x3Pnh2OoHS
	2Vp36vX0E/gy03hbyjLWcWzW980/lY4O2MOwgaC+uLN3SToitDR2AW9OWiqyt6OgVwFRoMISukH
	Wdp2GF5ANO9jqJb9nLsQhG98x/Pq/qfnRIheN6IWPjo5FqNVxTbWyfYoYwe7+wrN1ONRYAQ5qcJ
	Oe+zC3r0JFve8bxdVDVcq3dp/jd9EtHgx2KAEYxl3Yfz0thsHp1P2v0fCSj1vixu
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3b41c909001mr9327128a91.21.1795392564569;
        Sun, 22 Nov 2026 16:09:24 -0800 (PST)
Received: from gmail.com ([116.162.234.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm16532573a91.3.2026.11.22.16.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 16:09:24 -0800 (PST)
From: Xue Boyang <fuchen.dust@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] can: j1939: fix null-ptr-deref in j1939_session_completed()
Date: Sun, 22 Nov 2026 18:09:16 -0600
Message-ID: <20261123000916.181439-1-fuchen.dust@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_session_completed() distributes the reassembled message of a
receive session. It looks the message up at the offset named by the
last ETP.CM_DPO of the peer, session->pkt.dpo * 7, and passes the
result to j1939_sk_recv() without checking it.

j1939_xtp_rx_dpo_one() stores that DPO without any check. A receive
session keeps the whole message in a single skb, so a DPO with a
packet number >= session->pkt.total makes the lookup return NULL.
When the transfer then completes, j1939_sk_recv() dereferences the
NULL pointer and the kernel crashes in the receive path.

Any node on the CAN bus can send such a DPO, for example right before
the last data packet of an otherwise valid transfer, so this is
remotely triggerable. On a system with the vcan and J1939 modules
available, an unprivileged local user can reach it from inside a user
namespace as well.

Reject the DPO when it is received, and keep a backstop for the
lookup:

- Cancel a receive session with J1939_XTP_ABORT_BAD_EDPO_OFFSET when
  the DPO has a packet number >= session->pkt.total. That abort code
  existed but was never sent. Transmitter sessions are not affected,
  they only see the echo of their own DPO.
- Keep the NULL check in j1939_session_completed() and set
  session->err on that path, so that an unexpected lookup failure is
  reported as J1939_EE_INFO_RX_ABORT instead of ending as a success.

AI assistance was used to analyze the bug, and to prepare and test
this patch.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Xue Boyang <fuchen.dust@gmail.com>
---

Notes (j1939-v2-submit):
    Based on mainline commit 4843f6873f7c4835e62f2c73ba0fd538e57a2f22.
    
    Changes since v1, following the Sashiko review:
    v1: https://lore.kernel.org/linux-can/20261117103516.535910-1-fuchen.dust@gmail.com
    review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117103516.535910-1-fuchen.dust%40gmail.com
    
    - v1 only added the NULL check. v2 also rejects the DPO in
      j1939_xtp_rx_dpo_one() and reports a failed lookup via
      session->err.
    - The commit message now states the impact and the reachability.
    - This patch supersedes my 2-patch series from September, which had
      the same NULL check and a DPO check limited to dpo > pkt.total:
      https://lore.kernel.org/linux-can/20260918025622.192582-1-m18335910246@163.com
    
    Testing, on v7.4-rc3 based kernels with CONFIG_KASAN=y, with raw CAN
    frames injected on a vcan interface:
    
    - Unpatched: an ETP receive session given a DPO with packet number 256
      for a 256 packet transfer, followed by the last data packet, causes
      "KASAN: null-ptr-deref in range [0x18-0x1f]" in j1939_sk_recv() and
      a panic. The same happens when an unprivileged user triggers it from
      inside a user namespace, with the modules auto-loaded on demand.
    - Patched: the kernel answers with ETP.CM_ABORT (reason 12), the
      socket gets J1939_EE_INFO_RX_ABORT, nothing is delivered and the
      kernel keeps running. Same for packet numbers 257 and 65535.
    - A valid transfer whose last DPO has packet number 255 completes on
      both kernels, the 1786 byte message arrives intact.
    - net/can/j1939/ builds without warnings with W=1.
    
    The reproducer is not included. It is available on request.

 net/can/j1939/transport.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..d3644c8239a4b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,13 @@ static void j1939_session_completed(struct j1939_session *session)
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		} else {
+			/* should not happen, report it instead of a success */
+			session->err = EPROTO;
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1823,14 +1828,25 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(skb->data);
+	/* a receive session keeps the whole message in a single skb,
+	 * reject a DPO which does not point into it
+	 */
+	if (!session->transmission && dpo >= session->pkt.total) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 

base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
