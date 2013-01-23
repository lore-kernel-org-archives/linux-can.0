From: kbuild test robot <fengguang.wu@intel.com>
Subject: [can:for-davem 18/19] net/can/gw.c:370:13: sparse: restricted
 __wsum degrades to integer
Date: Wed, 23 Jan 2013 09:26:57 +0800
Message-ID: <50ff3c61.yH1i+RBrM59x8gEs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab3AWB2X (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 22 Jan 2013 20:28:23 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

tree:   git://gitorious.org/linux-can/linux-can-next for-davem
head:   565836761aa8096f568c021f709a84076f35976a
commit: 0bb45781da3270edfaf854b0dd9a40aca49c15dc [18/19] can: gw: add a variable limit for CAN frame routings


sparse warnings: (new ones prefixed by >>)

>> net/can/gw.c:370:13: sparse: restricted __wsum degrades to integer
   net/can/gw.c:402:26: sparse: restricted __wsum degrades to integer
>> net/can/gw.c:402:24: sparse: incorrect type in assignment (different base types)
   net/can/gw.c:402:24:    expected restricted __wsum [usertype] csum
   net/can/gw.c:402:24:    got unsigned int

vim +370 net/can/gw.c

   364		 */
   365	
   366	#define cgw_hops(skb) ((skb)->csum)
   367	
   368		BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
   369	
 > 370		if (cgw_hops(skb) >= max_hops)
   371			return;
   372	
   373		if (!(gwj->dst.dev->flags & IFF_UP)) {
   374			gwj->dropped_frames++;
   375			return;
   376		}
   377	
   378		/* is sending the skb back to the incoming interface not allowed? */
   379		if (!(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK) &&
   380		    skb_headroom(skb) == sizeof(struct can_skb_priv) &&
   381		    (((struct can_skb_priv *)(skb->head))->ifindex ==
   382		     gwj->dst.dev->ifindex))
   383			return;
   384	
   385		/*
   386		 * clone the given skb, which has not been done in can_rcv()
   387		 *
   388		 * When there is at least one modification function activated,
   389		 * we need to copy the skb as we want to modify skb->data.
   390		 */
   391		if (gwj->mod.modfunc[0])
   392			nskb = skb_copy(skb, GFP_ATOMIC);
   393		else
   394			nskb = skb_clone(skb, GFP_ATOMIC);
   395	
   396		if (!nskb) {
   397			gwj->dropped_frames++;
   398			return;
   399		}
   400	
   401		/* put the incremented hop counter in the cloned skb */
   402		cgw_hops(nskb) = cgw_hops(skb) + 1;
   403		nskb->dev = gwj->dst.dev;
   404	
   405		/* pointer to modifiable CAN frame */

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
