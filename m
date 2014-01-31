From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH stable 3.9+] can: add destructor for self generated skbs
Date: Thu, 30 Jan 2014 16:27:23 -0800 (PST)
Message-ID: <20140130.162723.1124545320708055175.davem@davemloft.net>
References: <52EA1740.2010108@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:32803 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbaAaA1Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2014 19:27:24 -0500
In-Reply-To: <52EA1740.2010108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: socketcan@hartkopp.net
Cc: eric.dumazet@gmail.com, nautsch2@gmail.com, netdev@vger.kernel.org, linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 30 Jan 2014 10:11:28 +0100

> Self generated skbuffs in net/can/bcm.c are setting a skb->sk reference but
> no explicit destructor which is enforced since Linux 3.11 with commit
> 376c7311bdb6 (net: add a temporary sanity check in skb_orphan()).
> 
> This patch adds some helper functions to make sure that a destructor is
> properly defined when a sock reference is assigned to a CAN related skb.
> To create an unshared skb owned by the original sock a common helper function
> has been introduced to replace open coded functions to create CAN echo skbs.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Tested-by: Andre Naujoks <nautsch2@gmail.com>

Applied and queued up for -stable, thanks.
