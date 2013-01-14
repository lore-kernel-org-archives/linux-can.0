From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can-next rebase?
Date: Mon, 14 Jan 2013 19:49:28 +0100
Message-ID: <50F45338.9060301@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:41487 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab3ANStc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Jan 2013 13:49:32 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Marc,

it looks like that my request to Dave to revert a patch failed:

http://marc.info/?t=135799864800001&r=1&w=2

To prevent the routing of CAN frames back to the originating device i wanted
to use skb->skb_iif (incoming interface index).

But skb->skb_iif is now *always* set in netif_receive_skb(), so it get's
destroyed when going down to the CAN netdev and up again :-(

As we can not used the control buffer cb[] too (net/sched qdiscs are using
the cb[] in the tx path), i was thinking about putting this information into
the skb payload (into skb headroom).

This looks like this then:

 
+struct can_skb_priv {
+	int rx_ifindex;
+	struct can_frame cf[0];
+};
+


diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8233e5e..8233944 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -500,14 +500,21 @@ static void can_setup(struct net_device *dev)
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
+	struct can_skb_priv *cskbp;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct can_frame));
 	if (unlikely(!skb))
 		return NULL;
 
 	skb->protocol = htons(ETH_P_CAN);
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+	cskbp = (struct can_skb_priv *)skb->head;
+	cskbp->rx_ifindex = dev->ifindex;
+
 	*cf = (struct can_frame *)skb_put(skb, sizeof(struct can_frame));
 	memset(*cf, 0, sizeof(struct can_frame));
 

(..)
 
+	/* is sending the skb back to the incoming interface allowed? */
+	if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
+	    skb_headroom(skb) == sizeof(struct can_skb_priv)) {
+		struct can_skb_priv *cskbp = (struct can_skb_priv *)skb->head;
+
+		if (cskbp->rx_ifindex == gwj->dst.dev->ifindex)
+			return;
+	}
+


All the other handling with skb->data and skb->len remains stable with this
approach.

But coming back to the mail topic:

I think i would need at least three patches for this change.

When trying to rebase linux-can-next the automatic merge fails ...

$ git rebase        
First, rewinding head to replay your work on top of it...
Applying: can: add tx/rx LED trigger support
Applying: can: flexcan: add LED trigger support
Applying: can: add tx/rx LED trigger support
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: can: flexcan: add LED trigger support
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
No changes -- Patch already applied.
Applying: can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/can/c_can/c_can_platform.c
CONFLICT (content): Merge conflict in drivers/net/can/c_can/c_can_platform.c
Auto-merging Documentation/devicetree/bindings/net/can/c_can.txt
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/net/can/c_can.txt
Failed to merge in the changes.
Patch failed at 0005 can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To check out the original branch and stop rebasing run "git rebase --abort".


Any idea?
 
Regards,
Oliver

