From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH V3 1/3] can: add can_is_canfd_skb() API
Date: Thu, 6 Nov 2014 09:52:28 +0800
Message-ID: <20141106015226.GA7642@shlinux1.ap.freescale.net>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com>
 <1415204533.13896.7.camel@edumazet-glaptop2.roam.corp.google.com>
 <545A5F55.7050307@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0112.outbound.protection.outlook.com ([157.56.110.112]:23360
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750974AbaKFCWg (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Nov 2014 21:22:36 -0500
Content-Disposition: inline
In-Reply-To: <545A5F55.7050307@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, varkabhadram@gmail.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 05, 2014 at 06:33:09PM +0100, Oliver Hartkopp wrote:
> On 05.11.2014 17:22, Eric Dumazet wrote:
> >On Wed, 2014-11-05 at 21:16 +0800, Dong Aisheng wrote:
> 
> >
> >This looks a bit strange to assume that skb->len == magical_value is CAN
> >FD. A comment would be nice.
> >
> 
> Yes. Due to exactly two types of struct can(fd)_frame which can be
> contained in a skb the skbs are distinguished by the length which
> can be either CAN_MTU or CANFD_MTU.
> 
> >>+static inline int can_is_canfd_skb(struct sk_buff *skb)
> >
> >static inline bool can_is_canfd_skb(const struct sk_buff *skb)
> >
> 
> ok.
> 

Got it.

> >>+{
> 
> What about:
> 
> 	/* the CAN specific type of skb is identified by its data length */
> 

Looks good to me.
I will send a updated version with these changes.

> >>+	return skb->len == CANFD_MTU;
> >>+}
> >>+
> >>  /* get data length from can_dlc with sanitized can_dlc */
> >>  u8 can_dlc2len(u8 can_dlc);
> 
> Regards,
> Oliver
>

Regards
Dong Aisheng
