From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: can sja1000: remove unused member from private data
Date: Fri, 23 May 2014 13:33:21 +0200
Message-ID: <20140523113321.GM23173@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:60122 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbaEWLda (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 May 2014 07:33:30 -0400
Received: from vandijck-laurijssen.be (unknown [192.168.0.70])
	by cylon.vandijck-laurijssen.be (Postfix) with ESMTPSA id DE7A64CD4B
	for <linux-can@vger.kernel.org>; Fri, 23 May 2014 13:33:19 +0200 (CEST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Skb caching for echo has been addressed on can_dev level.
The echo_skb member inside sja1000_priv is not used.

Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
--
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index afa9984..5722251 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -152,7 +152,6 @@
  */
 struct sja1000_priv {
 	struct can_priv can;	/* must be the first member */
-	struct sk_buff *echo_skb;
 
 	/* the lower-layer is responsible for appropriate locking */
 	u8 (*read_reg) (const struct sja1000_priv *priv, int reg);
