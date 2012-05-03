From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] CAN FD support part 2 - ideas and commented source
Date: Thu, 3 May 2012 14:37:55 +0200
Message-ID: <20120503123755.GD416@vandijck-laurijssen.be>
References: <4FA242D0.2070604@hartkopp.net>
 <4FA268B2.8030109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:16042 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616Ab2ECMiD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 May 2012 08:38:03 -0400
Content-Disposition: inline
In-Reply-To: <4FA268B2.8030109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Oliver,

Your proposal looks more elaborate than my first one :-)

In this email, I'll restrict myself to discussing ETH_P_CANFD.

On Thu, May 03, 2012 at 01:14:58PM +0200, Oliver Hartkopp wrote:
> Hi all,
> 
> in this mail i would like to document the ideas for CAN FD support pointing
> directly to the changes inside the source.
> 

[........]
> 
> That's it.

using dev's MTU is a very good idea!

Restricting the API to use one of 2 MTU's makes life easier.

> 
> Any objections / better ideas?
I don't see benefit in introducing ETH_P_CANFD.
Using the skb's payload length differentiates enough between CAN_MTU & CANFD_MTU.
Why not using that info. IMHO, ETH_P_CANFD duplicates the info.

This part proves my point:
@@ -69,13 +73,23 @@ static inline int can_dropped_invalid_skb(struct net_device *dev,
 {
 	const struct can_frame *cf = (struct can_frame *)skb->data;
 
-	if (unlikely(skb->len != sizeof(*cf) || cf->can_dlc > 8)) {
This check should have become:
+	if (unlikely(skb->len != dev->mut) || (cf->can_dlc > mtu_to_max_can_dlc(dev->mtu))

Instead of all the if then else flows here.
A lookup table to use by mtu_to_max_can_dlc is quite straight-forward:
static const int mtu_to_max_can_dlc_table[] = {
	[sizeof(struct can_frame) = CAN_MAX_DLC,
	[sizeof(struct canfd_frame) = CANFD_MAX_DLC,
};

The remainder of the function needs no change, so all this patching
was not necessary.

-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return 1;
-	}
+	if (skb->protocol == htons(ETH_P_CAN)) {
+		if (skb->len != sizeof(struct can_frame) ||
+		    cf->can_dlc > CAN_MAX_DLC)
+			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANFD)) {
+		if (skb->len != sizeof(struct canfd_frame) ||
+		    cf->can_dlc > CANFD_MAX_DLC)
+			goto inval_skb;
+	} else
+		goto inval_skb;
	}
 
 	return 0;

Similarly, can_rcv() & can_send() can access the device's mtu

Do you still think introducing ETH_P_CANFD is necessary?


Kurt
