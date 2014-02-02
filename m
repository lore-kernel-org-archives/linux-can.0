From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [INFO] BCM and ISOTP crashes Linux 3.11 - 3.13 when running on
 REAL HW CAN interfaces
Date: Sun, 2 Feb 2014 18:00:18 +0000
Message-ID: <20140202180018.GB5717@hercules>
References: <20140130.162723.1124545320708055175.davem@davemloft.net>
 <52ED3993.2080404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37994 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaBBSAV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 2 Feb 2014 13:00:21 -0500
Content-Disposition: inline
In-Reply-To: <52ED3993.2080404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Boris Baskevitch <boris.baskevitch@annecy-elec.fr>, Daniele Venzano <linux@brownhat.org>, Josselin Costanzi <josselin.costanzi@mobile-devices.fr>, Nathan Conrad <nconrad.mlock@gmail.com>, Dirk Rohleder <dirk@rohleder-bo.de>, kernel-team@lists.ubuntu.com, opensuse-kernel@opensuse.org

On Sat, Feb 01, 2014 at 07:14:43PM +0100, Oliver Hartkopp wrote:
> Hello all,
> 
> at 2013-08-01 Eric Dumazet created this patch to make sure some
> networking rules are enforced in the Linux Kernel in Linux 3.11:
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=376c7311bdb6efea3322310333576a04d73fbe4c
> 
> This affects CAN BCM and CAN ISOTP and leads to a KERNEL CRASH
> when you are *sending* with the BCM or ISOTP on REAL(!) CAN interfaces.
> 
> AFAIK there are not so many use cases. That's why it lasted 6 months to detect it :-(
> Virtual CAN and SLCAN interfaces do not have this problem (no echo skbs).
> 
> Do I have to care about this issue?
> 
> Usually the embedded systems do not have such a recent kernel.
> Regarding desktop distributions Redhat 7 runs a 3.10 kernel which is safe.
> 
> But e.g. OpenSuse 13.1 and Ubuntu 13.10 / Linux Mint Petra are based on
> Linux 3.11 and Debian Jessie (current Debian testing) is on Linux 3.12.
> 
> The latter have the described problem with BCM / ISOTP until this patch 
> 
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=0ae89beb283a0db5980d1d4781c7d7be2f2810d6
> 
> is applied by the stable kernel maintainers and distribution maintainers.
> The patch is already upstream for Linux 3.14 but it will take some time
> until it gets into the stable kernels 3.11 - 3.13 and the distributions.
> 
> As Linux 3.11 is already end-of-life [EOL] I'll address the Ubuntu and
> OpenSuse maintainers directly so that this patch for 3.11 does not get lost.
> David Miller already queued this patch up for -stable
> Original post: http://marc.info/?l=linux-netdev&m=139107310226665&w=2
> 
> Take care,
> Oliver

Hi Oliver,

Thanks a lot for the heads-up on this issue.

I've just checked David Miller's net -stable queue[1] and it looks like he
has in fact already queued it.  We usually pick his stable patches when he
sends them to the stable mailing list, so I guess we'll just wait for this
to happen.

[1] http://patchwork.ozlabs.org/bundle/davem/stable/?state=*

Cheers,
--
Luis


> 
> 
> -------- Original Message --------
> Subject: Re: [PATCH stable 3.9+] can: add destructor for self generated skbs
> Date: Thu, 30 Jan 2014 16:27:23 -0800 (PST)
> From: David Miller <davem@davemloft.net>
> To: socketcan@hartkopp.net
> CC: eric.dumazet@gmail.com, nautsch2@gmail.com, netdev@vger.kernel.org, linux-can@vger.kernel.org
> 
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Thu, 30 Jan 2014 10:11:28 +0100
> 
> > Self generated skbuffs in net/can/bcm.c are setting a skb->sk reference but
> > no explicit destructor which is enforced since Linux 3.11 with commit
> > 376c7311bdb6 (net: add a temporary sanity check in skb_orphan()).
> > 
> > This patch adds some helper functions to make sure that a destructor is
> > properly defined when a sock reference is assigned to a CAN related skb.
> > To create an unshared skb owned by the original sock a common helper function
> > has been introduced to replace open coded functions to create CAN echo skbs.
> > 
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > Tested-by: Andre Naujoks <nautsch2@gmail.com>
> 
> Applied and queued up for -stable, thanks.
> 
> 
