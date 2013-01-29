From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: ATTENTION: Out-of-tree CAN driver maintainers!
Date: Tue, 29 Jan 2013 21:56:52 +0100
Message-ID: <51083794.4080803@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:54755 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3A2U4z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Jan 2013 15:56:55 -0500
Received: from [192.168.178.33] (p5B0B05C1.dip0.t-ipconnect.de [91.11.5.193])
	by smtp.strato.de (jored mo27) (RZmta 31.14 DYNA|AUTH)
	with ESMTPA id k02bb9p0TKuqQB for <linux-can@vger.kernel.org>;
	Tue, 29 Jan 2013 21:56:52 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

in Linux 3.9 the layout of CAN frame in the socket buffer (struct sk_buff) is
extended by a struct can_skb_priv.

This structure is placed 'before' the CAN frame data, which is done by
skb_reserve(). All other things like skb->data and skb->len handling is not
changed.

When you are already using the GPL exported alloc_can_skb() function
 -> Good! can_alloc_skb() has been adapted -> no action needed for you.

When you are NOT using can_alloc_skb() and you still do not want to use it
(hint, hint) you need to

1. include the new include file include/linux/can/skb.h
2. add the sizeof(struct can_skb_priv) to the allocated skb size
3. call can_skb_reserve(skb) after successfully allocating the skb
4. assign the device interface index in the struct can_skb_priv

N.B. The can_skb_reserve() action needs to be done before adding any data to
the skb with skb_put().

The changes that have been done in slcan.c can be taken as an example:

--- linux/drivers/net/can/slcan.c	2013-01-19 15:03:33.175529949 +0100
+++ net-next/drivers/net/can/slcan.c	2013-01-29 07:05:09.612534272 +0100
@@ -52,12 +52,13 @@
 #include <linux/if_ether.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/can.h>
+#include <linux/can/skb.h>

 static __initconst const char banner[] =
 	KERN_INFO "slcan: serial line CAN interface driver\n";

 MODULE_ALIAS_LDISC(N_SLCAN);
 MODULE_DESCRIPTION("serial line CAN interface");
@@ -181,20 +182,25 @@
 		tmp = hex_to_bin(sl->rbuff[dlc_pos++]);
 		if (tmp < 0)
 			return;
 		cf.data[i] |= tmp;
 	}

-	skb = dev_alloc_skb(sizeof(struct can_frame));
+	skb = dev_alloc_skb(sizeof(struct can_frame) +
+			    sizeof(struct can_skb_priv));
 	if (!skb)
 		return;

 	skb->dev = sl->dev;
 	skb->protocol = htons(ETH_P_CAN);
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
+
 	memcpy(skb_put(skb, sizeof(struct can_frame)),
 	       &cf, sizeof(struct can_frame));
 	netif_rx_ni(skb);

 	sl->dev->stats.rx_packets++;
 	sl->dev->stats.rx_bytes += cf.can_dlc;


For out-of-tree drivers you probably need to put some

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+#include <linux/can/skb.h>
+#endif

arround it.

Any questions? No questions? Good :-)

Regards,
Oliver
