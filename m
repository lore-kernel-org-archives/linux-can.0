From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH stable 3.9+] can: add destructor for self generated skbs
Date: Thu, 30 Jan 2014 15:10:03 -0800
Message-ID: <1391123403.28432.81.camel@edumazet-glaptop2.roam.corp.google.com>
References: <52EA1740.2010108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <52EA1740.2010108@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: David Miller <davem@davemloft.net>, Andre Naujoks <nautsch2@gmail.com>, Linux Netdev List <netdev@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Thu, 2014-01-30 at 10:11 +0100, Oliver Hartkopp wrote:
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
> 
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
