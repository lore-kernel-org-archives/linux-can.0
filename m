From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 0/3] can: janz-ican3: fix support for
 CAN_RAW_RECV_OWN_MSGS
Date: Mon, 9 Jul 2012 14:29:51 -0700
Message-ID: <20120709212951.GC20561@ovro.caltech.edu>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
 <4FFB479D.7070000@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:53958 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab2GIV3y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 17:29:54 -0400
Content-Disposition: inline
In-Reply-To: <4FFB479D.7070000@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, Jul 09, 2012 at 11:05:33PM +0200, Oliver Hartkopp wrote:
> Hello Ira,
> 
> looks good to me in general ...
> 
> Let's wait for other comments though.
> 
> Does it work without problems?
> 

There are no problems that I could find. Hooking two cards together and
running cangen on both simultaneously at the maximum packet generation
rate worked fine. It worked in both loopback (no option specified) and
non-loopback (-x) mode.

The previous patch which used can_cmp_echo_skb() did not handle
non-loopback mode correctly.

This version seems to receive more ENOBUFS errors back to cangen than
the "ALTERNATE VERSION" which removed the netif_stop_queue() and
netif_wake_queue() functions. I don't know if that is a problem or not.

Overall, it looks good to me.

Thanks for the comments on the other patches,
Ira

> On 09.07.2012 21:56, Ira W. Snyder wrote:
> 
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > This is another different approach to fixing the Janz ICAN3 support for
> > CAN_RAW_RECV_OWN_MSGS.
> > 
> > The can_put_echo_skb() function is changed to always keep all packets
> > until can_get_echo_skb() is called. Previously, it would drop packets if
> > they were not needed to be looped back. This makes it possible for the
> > new function can_cmp_echo_skb() to work with hardware-assisted loopback
> > support on the Janz ICAN3, which does not have TX-complete interrupts of
> > any kind.
> > 
> > Since we are now storing packets even in the non-loopback case, there is
> > some extra memory overhead, to store the extra packets between the calls
> > to can_put_echo_skb() and can_get_echo_skb().
> > 
> > After this patch series is applied, the SocketCAN tst-rcv-own-msgs test
> > passes.
> > 
> > Performance is rougly 15% less than using the previously posted patch:
> > [PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
> > 
> > This performance drop is due to the extra overhead of receiving the echo
> > packets from the card itself. This involves one extra interrupt for each
> > packet sent, and the associated overhead of running ican3_napi() for
> > each packet sent.
> > 
> 
> 
> If it works without problems you might try to use 2 or 3 echo_skbs for testing
> to ensure the Janz card gets lined with outgoing traffic without waiting for
> each single sent frame.
> 
> I assume this would make the implementation slightly complexer but may solve
> the performance drop on the wire.
> 
> > Ira W. Snyder (3):
> >   can: make the echo stack keep packet information longer
> >   can: add can_cmp_echo_skb() for echo skb comparison
> >   can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
> > 
> >  drivers/net/can/dev.c        |   75 ++++++++++++++++++++++++++++++-----------
> >  drivers/net/can/janz-ican3.c |   56 +++++++++++++++++--------------
> >  include/linux/can/dev.h      |    2 +
> >  3 files changed, 87 insertions(+), 46 deletions(-)
> > 
> 
> 
