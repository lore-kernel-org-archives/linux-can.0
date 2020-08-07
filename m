From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v1 5/5] can: j1939: transport: j1939_xtp_rx_dat_one(): compare own packets to detect corruptions
Date: Fri,  7 Aug 2020 12:52:00 +0200
Message-ID: <20200807105200.26441-6-o.rempel@pengutronix.de>
References: <20200807105200.26441-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgHGLAK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Aug 2020 07:00:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625E7C061575
        for <linux-can@vger.kernel.org>; Fri,  7 Aug 2020 03:52:08 -0700 (PDT)
In-Reply-To: <20200807105200.26441-1-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org, David Jander <david@protonic.nl>

Since the stack relays on receiving own packets, it was overwriting own
transmit buffer from received packets.

At least theoretically, the received echo buffer can be corrupt or
changed and the session partner can request to resend previous data. In
this case we will re-send bad data.

With this patch we will stop to overwrite own TX buffer and use it for
sanity checking.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 90a2baac8a4a..5cf107cb447c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1792,7 +1792,20 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	}
 
 	tpdat = se_skb->data;
-	memcpy(&tpdat[offset], &dat[1], nbytes);
+	if (!session->transmission) {
+		memcpy(&tpdat[offset], &dat[1], nbytes);
+	} else {
+		int err;
+
+		err = memcmp(&tpdat[offset], &dat[1], nbytes);
+		if (err)
+			netdev_err_once(priv->ndev,
+					"%s: 0x%p: Data of RX-looped back packet (%*ph) doesn't match TX data (%*ph)!\n",
+					__func__, session,
+					nbytes, &dat[1],
+					nbytes, &tpdat[offset]);
+	}
+
 	if (packet == session->pkt.rx)
 		session->pkt.rx++;
 
-- 
2.28.0
