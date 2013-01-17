From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/4] can-gw: make routing to the incoming CAN interface configurable
Date: Thu, 17 Jan 2013 18:43:41 +0100
Message-ID: <50F8384D.3050601@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:15105 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab3AQRnn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 12:43:43 -0500
Received: from [192.168.178.31] (p5B0B0333.dip0.t-ipconnect.de [91.11.3.51])
	by smtp.strato.de (jorabe mo19) (RZmta 31.13 DYNA|AUTH)
	with ESMTPA id C058b1p0HH6Ao4 for <linux-can@vger.kernel.org>;
	Thu, 17 Jan 2013 18:43:41 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From f811108301b262334810f90e6f732c142b302414 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 17 Jan 2013 07:10:50 +0100
Subject: [PATCH 2/4] can-gw: make routing to the incoming CAN interface configurable

Introduce new configuration flag CGW_FLAGS_CAN_IIF_TX_OK to configure if a
CAN sk_buff that has been routed with can-gw is allowed to be send back to
the originating CAN interface.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/gw.h |    1 +
 net/can/gw.c                |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index 8e1db18..0505c7f 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -51,6 +51,7 @@ enum {
 
 #define CGW_FLAGS_CAN_ECHO 0x01
 #define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
+#define CGW_FLAGS_CAN_IIF_TX_OK 0x04
 
 #define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
 
diff --git a/net/can/gw.c b/net/can/gw.c
index 574dda78e..37a3efb 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -52,6 +52,7 @@
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
+#include <linux/can/skb.h>
 #include <linux/can/gw.h>
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
@@ -347,6 +348,13 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
+	/* is sending the skb back to the incoming interface not allowed? */
+	if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
+	    skb_headroom(skb) == sizeof(struct can_skb_priv) &&
+	    (((struct can_skb_priv *)(skb->head))->ifindex ==
+	     gwj->dst.dev->ifindex))
+		return;
+
 	/*
 	 * clone the given skb, which has not been done in can_rcv()
 	 *
-- 
1.7.10.4

