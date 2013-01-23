From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [can:for-davem 18/19] net/can/gw.c:370:13: sparse: restricted
 __wsum degrades to integer
Date: Wed, 23 Jan 2013 10:06:33 +0100
Message-ID: <50FFA819.8060708@hartkopp.net>
References: <50ff3c61.yH1i+RBrM59x8gEs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:39670 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3AWJGk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Jan 2013 04:06:40 -0500
In-Reply-To: <50ff3c61.yH1i+RBrM59x8gEs%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

it was hard to make sparse to give this warning on my machine ...

For the records:

	make C=1 CF="-D__CHECK_ENDIAN__"

made it :-)


I pushed a new commit to the cangw branch of ollis-can-next:

https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commits/cangw

The commit is 

https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commit/4068160ad6f42436a40edf4b04ec47e86399b544

Please pull.

Thanks!

From 4068160ad6f42436a40edf4b04ec47e86399b544 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 23 Jan 2013 09:45:39 +0100
Subject: [PATCH] can-gw: fix sparse warning

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/gw.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index e12666e..acdd465 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -359,12 +359,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 *
 	 * The Controller Area Network controllers only accept CAN frames with
 	 * correct CRCs - which are not visible in the controller registers.
-	 * According to skbuff.h documentation the csum element for IP checksums
-	 * is undefined/unsued when ip_summed == CHECKSUM_UNNECESSARY. Only
-	 * CAN skbs can be processed here which already have this property.
+	 * According to skbuff.h documentation the csum_start element for IP
+	 * checksums is undefined/unsued when ip_summed == CHECKSUM_UNNECESSARY.
+	 * Only CAN skbs can be processed here which already have this property.
 	 */
 
-#define cgw_hops(skb) ((skb)->csum)
+#define cgw_hops(skb) ((skb)->csum_start)
 
 	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
 
-- 
1.7.1



On 23.01.2013 02:26, kbuild test robot wrote:

> tree:   git://gitorious.org/linux-can/linux-can-next for-davem
> head:   565836761aa8096f568c021f709a84076f35976a
> commit: 0bb45781da3270edfaf854b0dd9a40aca49c15dc [18/19] can: gw: add a variable limit for CAN frame routings
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> net/can/gw.c:370:13: sparse: restricted __wsum degrades to integer
>    net/can/gw.c:402:26: sparse: restricted __wsum degrades to integer
>>> net/can/gw.c:402:24: sparse: incorrect type in assignment (different base types)
>    net/can/gw.c:402:24:    expected restricted __wsum [usertype] csum
>    net/can/gw.c:402:24:    got unsigned int
> 


