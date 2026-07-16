Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCDD3F9A05;
	Thu, 16 Jul 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217406; cv=none; b=rZhbXEUhf4N7PZj3vO50W3psIh0JyEFsMBQmtjToEjU1Vh2sVYr0vWmKdfDWZZiN+f68+d7nc0mz1YqRAjo5636jIo8nRSbzipZha7DdQ6kVHDYpfiZYExjSIwY45T16oy9Dtg7tX54V8JAyqRizf8b5eI/I8OoiBIAgbcoHzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217406; c=relaxed/simple;
	bh=Kg2KZmHxnn/+rUzlmB7HnjsT5mNZ/CfG/M24/lqwbDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHvwTcVFzpyzBoFOWnc82W5jJBZs4jnkA9obX9jkVS/5EsZ9r+cPLiZ2mKqlxuC5F5YmgJuBJhk7fyDqv/wN6p82WHlQoW7cJz2ncMW15uqyl0grpq26nHuDTDpHVD76yIVMCUUIex/cpqaIe5J+kDheZcO5Fnq1MXXgl1niQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5649820227F;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORj-0027ol-3D;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 688F556C3D7;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Shuhao Fu <sfual@cse.ust.hk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 04/19] can: j1939: fix lockless local-destination check
Date: Thu, 16 Jul 2026 17:47:29 +0200
Message-ID: <20260716155528.809908-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuhao Fu <sfual@cse.ust.hk>

j1939_priv.ents[].nusers is documented as protected by priv->lock, and
its updates already happen under that lock. j1939_can_recv() also reads
it under read_lock_bh(). However, j1939_session_skb_queue() and
j1939_tp_send() still read priv->ents[da].nusers without taking the
lock.

Those transport-side checks decide whether to set J1939_ECU_LOCAL_DST, so
they can race with j1939_local_ecu_get() and j1939_local_ecu_put() while
userspace is binding or releasing sockets concurrently with TP traffic.
This can misclassify TP/ETP sessions as local or remote and take the wrong
transport path.

Fix both transport paths by routing the destination-locality check through
a helper that reads ents[].nusers under read_lock_bh(&priv->lock).

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260419140614.GA4041240@chcpu16
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..8a31cb23bc76 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -351,6 +351,18 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	}
 }
 
+static bool j1939_address_is_local(struct j1939_priv *priv, u8 addr)
+{
+	bool local = false;
+
+	read_lock_bh(&priv->lock);
+	if (j1939_address_is_unicast(addr) && priv->ents[addr].nusers)
+		local = true;
+	read_unlock_bh(&priv->lock);
+
+	return local;
+}
+
 void j1939_session_skb_queue(struct j1939_session *session,
 			     struct sk_buff *skb)
 {
@@ -359,8 +371,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 
 	j1939_ac_fixup(priv, skb);
 
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
@@ -2038,8 +2049,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
 		return ERR_PTR(ret);
 
 	/* fix DST flags, it may be used there soon */
-	if (j1939_address_is_unicast(skcb->addr.da) &&
-	    priv->ents[skcb->addr.da].nusers)
+	if (j1939_address_is_local(priv, skcb->addr.da))
 		skcb->flags |= J1939_ECU_LOCAL_DST;
 
 	/* src is always local, I'm sending ... */
-- 
2.53.0

