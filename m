From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: [INFO] BCM and ISOTP crashes Linux 3.11 - 3.13 when running on REAL
 HW CAN interfaces
Date: Sat, 01 Feb 2014 19:14:43 +0100
Message-ID: <52ED3993.2080404@hartkopp.net>
References: <20140130.162723.1124545320708055175.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <opensuse-kernel+bounces-5461-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
In-Reply-To: <20140130.162723.1124545320708055175.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
To: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris Baskevitch <boris.baskevitch-8eWYsXVvN4PZIJhgGyx37A@public.gmane.org>, Daniele Venzano <linux-aa24p/qCTT1g9hUCZPvPmw@public.gmane.org>, Josselin Costanzi <josselin.costanzi-Tny/h2m1dROW3RwJEphJ61AUjnlXr6A1@public.gmane.org>, Nathan Conrad <nconrad.mlock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dirk Rohleder <dirk-pmyc6AMmRiliEfu1fGPkyA@public.gmane.org>, Luis Henriques <luis.henriques-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, kernel-team-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hello all,

at 2013-08-01 Eric Dumazet created this patch to make sure some
networking rules are enforced in the Linux Kernel in Linux 3.11:
http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=376c7311bdb6efea3322310333576a04d73fbe4c

This affects CAN BCM and CAN ISOTP and leads to a KERNEL CRASH
when you are *sending* with the BCM or ISOTP on REAL(!) CAN interfaces.

AFAIK there are not so many use cases. That's why it lasted 6 months to detect it :-(
Virtual CAN and SLCAN interfaces do not have this problem (no echo skbs).

Do I have to care about this issue?

Usually the embedded systems do not have such a recent kernel.
Regarding desktop distributions Redhat 7 runs a 3.10 kernel which is safe.

But e.g. OpenSuse 13.1 and Ubuntu 13.10 / Linux Mint Petra are based on
Linux 3.11 and Debian Jessie (current Debian testing) is on Linux 3.12.

The latter have the described problem with BCM / ISOTP until this patch 

http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=0ae89beb283a0db5980d1d4781c7d7be2f2810d6

is applied by the stable kernel maintainers and distribution maintainers.
The patch is already upstream for Linux 3.14 but it will take some time
until it gets into the stable kernels 3.11 - 3.13 and the distributions.

As Linux 3.11 is already end-of-life [EOL] I'll address the Ubuntu and
OpenSuse maintainers directly so that this patch for 3.11 does not get lost.
David Miller already queued this patch up for -stable
Original post: http://marc.info/?l=linux-netdev&m=139107310226665&w=2

Take care,
Oliver


-------- Original Message --------
Subject: Re: [PATCH stable 3.9+] can: add destructor for self generated skbs
Date: Thu, 30 Jan 2014 16:27:23 -0800 (PST)
From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
To: socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org
CC: eric.dumazet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nautsch2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
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
> Signed-off-by: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
> Tested-by: Andre Naujoks <nautsch2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied and queued up for -stable, thanks.
