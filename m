From: Daniel Steer <daniel.steer@mclaren.com>
Subject: Re: skbuff panic
Date: Thu, 19 Feb 2015 11:48:09 +0000 (UTC)
Message-ID: <loom.20150219T121134-213@post.gmane.org>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com> <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com> <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com> <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net> <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com> <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com> <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com> <53BFE637.2030905@hartkopp.net> <CANGgnMYJ+eLGeMiLuTXQONpC6B1GSW6gPkk-u=ATcVNijLN5rA@mail.gmail.com> <53C0237E.7010504@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55648 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565AbbBTRkJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 20 Feb 2015 12:40:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YOrYa-0001SS-OR
	for linux-can@vger.kernel.org; Fri, 20 Feb 2015 18:40:05 +0100
Received: from proxy30.messagelabs.net ([193.109.254.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 20 Feb 2015 18:40:04 +0100
Received: from daniel.steer by proxy30.messagelabs.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 20 Feb 2015 18:40:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> On 07/11/2014 04:58 PM, Austin Schuh wrote:
> > On Fri, Jul 11, 2014 at 6:27 AM, Oliver Hartkopp <socketcan <at> 
hartkopp.net> wrote:
> >> Thanks for testing, Austin!
> >>
> >> I'll cook a patch for stable to add these settings.
> >> Even if we do not know why someone requests obviously all netdev 
skbs and
> >> treats them to be Ethernet/IP packets we should fix it in our code.
> >>
> >> If we fix it somewhere else it will last one year until some of the
> >> is-there-anything-else-than-ethernet-networking guys will break it 
again.
> >> 
> > 
> > Is it worth debugging why as well?  Defense in layers?
> 
> Anything new about the kernel-dhcp?
> 
> Marc
> 

Hi,

I have been investigating a similar issue on our system when running 
dhclient on a wireless network interface whilst sending and receiving on 
CAN via the BCM. I have applied your suggested patch, but also needed to 
reset the mac header pointer in alloc_can_skb() as looped back transmit 
packets will also cause an sk_buff under panic in af_packet.c. Ours is 
an older kernel and not the latest CAN code, but I can't see any changes 
in the latest code that would address this.

diff --git a/net/can/af_can.c b/net/can/af_can.c
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -318,6 +318,8 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,22)
     skb_reset_network_header(skb);
     skb_reset_transport_header(skb);
+    /* dhclient interacting badly with CAN. */
+    skb_reset_mac_header(skb);
 #else
     skb->nh.raw = skb->data;
     skb->h.raw  = skb->data;

Thank you,

Daniel



