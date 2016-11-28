From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Mon, 28 Nov 2016 10:01:24 +0100
Message-ID: <3312577.WzoMqUrz0A@ws-stein>
References: <1864402.pXgGBBp51L@ws-stein> <153c7653-ab74-fd0c-c605-7bafe5e44297@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33366 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754552AbcK1JBe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2016 04:01:34 -0500
In-Reply-To: <153c7653-ab74-fd0c-c605-7bafe5e44297@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

On Friday 25 November 2016 12:46:08, Oliver Hartkopp wrote:
> Hello Alexander,
> 
> On 11/24/2016 04:49 PM, Alexander Stein wrote:
> > Back to my CAN problem: Only a single core handles USB IRQs and there is
> > apparently no softnet_data race.
> > The test about wrong CAN frame ordering was done on kernel 4.8.9-gentoo
> > but I was also able to reproduce this problem on 3.14.58-gentoo-r1.
> > 3.12.52-gentoo- r1 apparently does not suffer from that problem, at least
> > 3 tries were without errors. In buggy kernels this problems occured next
> > to every time.
> > 
> > Any idea what got wrong in the network code about gathering the SKBs
> > which might result in wrong order?
> 
> I detected a similar issue in some 3.1x kernel and asked this question:
> 
> http://marc.info/?l=linux-can&m=143637774606287&w=2
> 
> When you follow the entire discussion at
> 
> http://marc.info/?t=143637789700002&r=1&w=2
> 
> you will see that they pushed me to implement NAPI on all CAN interfaces
> which neither makes no sense for CAN controllers that do not have a RX
> FIFO (e.g. sja1000) nor fixes the issue at it's root cause.
> 
> Your findings bring up the problem again - good :-)

Too bad I didn't know of that post earlier, well never searched for it :-/

> When you look at the networking guys that like to speed up TCP traffic
> and also put skbs into percpu queues that are related to the receiving
> socket(!!!) instance then it should be possible to put CAN skbs related
> to their CAN interfaces into a percpu queue (to suppress out-of-order
> reception).

But wouldn't using queues related to sockets result in different orderings in 
different sockets? I've yet to find an erroneous rest run with a non-
conforming candump.
Anyway I don't yet fully understand the complete code and/or data flow up to 
the socket once netif_rx() is called.

> IMO the difference is not to queue the skbs for a specific socket but
> for a specific interface.
> The 'endpoint' of CAN frames where they have to be in order is can_rcv()
> in af_can.c and not any TCP instance that needs to reassemble the TCP
> traffic for a specific socket.

Sure, TCP can handle OOO pretty fine. Even for UDP this is not a problem at 
all. But isn't using raw sockets on ethernet in promiscuous mode a somewhat 
similar scenario? Or to put it in another way: Wouldn't tcpdump or wireshark 
suffer from the same problem?

> Can you check whether my suggestion with skb_set_hash() in
> alloc_can_skb() works for you?

For ease of use I didn't change alloc_can_skb() but rather used the patched 
inlined below. Using this change and (!)
> echo f >  /sys/class/net/can0/queues/rx-0/rps_cpus

3 test runs didn't raise any OOO errors.

But shouldn't the hash type be rather PKT_HASH_TYPE_L4? Otherwise 
skb_get_hash() doesn't use skb->hash directly (or at all?). I am aware that L4 
is semantically wrong though.

> In any way I think we should start a new attempt to make clear that the
> skbs have to be in order for a specific interface at can_rcv().
> And we need some solution that is enabled by default and fits to the
> netdev guys mindset.

It should not only be enabled by default but rather the only solution with no 
way to be disabled/wrong.

Best regards,
Alexander

diff --git a/systec_can.c b/systec_can.c
index b6d9b74..51b2bf6 100644
--- a/systec_can.c
+++ b/systec_can.c
@@ -978,6 +978,8 @@ static void systec_can_rx_can_msg(struct systec_can_chan 
*chan, u8 *msg_buf)
                 return;
         }
 
+        skb_set_hash(skb, chan->netdev->ifindex, PKT_HASH_TYPE_L2);
+
         /* get size of data part of CAN message */
         cf->can_dlc = get_can_dlc(msg->format & USBCAN_DATAFF_DLC);
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

