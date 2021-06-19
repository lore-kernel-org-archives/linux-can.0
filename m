Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72BAC2B9F4
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3156113C
	for <linux-can@archiver.kernel.org>; Sat, 19 Jun 2021 12:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhFSMOT (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 19 Jun 2021 08:14:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:33218 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhFSMOT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 08:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624104727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=etkyWav0iN0wA8IwSOpNSJnMEVsd4GpbY7I2Rd1SK10=;
    b=lM94ktLjbznPkEaZ9NN/XtiLRqEcNySi4CLMvtTCA9VQHdS/W1rwUkQBzU0ewypGcq
    SGO8ja3wsVKhKO7Qc53UVmXX5xJ4+ti9GlK7MD7i4Nm/YZZQtJ4biwfPyKpOY8+gaKnY
    l4ZxhETn5h2x0Geh/3cAASWtvC2oElnm1DJwlsYq5rcDei3gXJZsAyh2TZHiQXuE2nFh
    3OBa3vYqa9i8wrBGDNwSVlh+tbswTkYwCJSVu+iIXSDWfrJbof2R8ZiCX6GhUg+suyQh
    S6r/fKCCodVzRIRv84MYGHXe73nMli92Z4GExnJWC6AbRiOZwMwk5OG2j7BEiVlOrAWS
    bGKA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJywjsS7yVw=="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5JCC73bY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 19 Jun 2021 14:12:07 +0200 (CEST)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH] vxcan: remove sk reference in peer skb
Date:   Sat, 19 Jun 2021 14:11:59 +0200
Message-Id: <20210619121159.1805-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With can_create_echo_skb() the skb which is forwarded to the peer CAN
interface shares the sk pointer from the originating socket.
This makes the CAN frame show up in the peer namespace as a TX packet.

With the use of skb_clone() analogue to the handling in gw.c the peer
skb gets a new start in the peer namespace and correctly appears as
a RX packet.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vxcan.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index be5566168d0f..e5fd8b9bfca5 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -35,10 +35,11 @@ struct vxcan_priv {
 
 static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct vxcan_priv *priv = netdev_priv(dev);
 	struct net_device *peer;
+	struct sk_buff *nskb;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct net_device_stats *peerstats, *srcstats = &dev->stats;
 	u8 len;
 
 	if (can_dropped_invalid_skb(dev, skb))
@@ -50,22 +51,26 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *skb, struct net_device *dev)
 		kfree_skb(skb);
 		dev->stats.tx_dropped++;
 		goto out_unlock;
 	}
 
-	skb = can_create_echo_skb(skb);
-	if (!skb)
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (nskb)
+		consume_skb(skb);
+	else {
+		kfree_skb(skb);
 		goto out_unlock;
+	}
 
 	/* reset CAN GW hop counter */
-	skb->csum_start = 0;
-	skb->pkt_type   = PACKET_BROADCAST;
-	skb->dev        = peer;
-	skb->ip_summed  = CHECKSUM_UNNECESSARY;
+	nskb->csum_start = 0;
+	nskb->pkt_type   = PACKET_BROADCAST;
+	nskb->dev        = peer;
+	nskb->ip_summed  = CHECKSUM_UNNECESSARY;
 
 	len = cfd->len;
-	if (netif_rx_ni(skb) == NET_RX_SUCCESS) {
+	if (netif_rx_ni(nskb) == NET_RX_SUCCESS) {
 		srcstats->tx_packets++;
 		srcstats->tx_bytes += len;
 		peerstats = &peer->stats;
 		peerstats->rx_packets++;
 		peerstats->rx_bytes += len;
-- 
2.30.2

