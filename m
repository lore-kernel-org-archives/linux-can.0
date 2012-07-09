From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Mon, 09 Jul 2012 23:05:33 +0200
Message-ID: <4FFB479D.7070000@hartkopp.net>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:18141 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab2GIVF0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 17:05:26 -0400
In-Reply-To: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

Hello Ira,

looks good to me in general ...

Let's wait for other comments though.

Does it work without problems?

On 09.07.2012 21:56, Ira W. Snyder wrote:

> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> 
> This is another different approach to fixing the Janz ICAN3 support for
> CAN_RAW_RECV_OWN_MSGS.
> 
> The can_put_echo_skb() function is changed to always keep all packets
> until can_get_echo_skb() is called. Previously, it would drop packets if
> they were not needed to be looped back. This makes it possible for the
> new function can_cmp_echo_skb() to work with hardware-assisted loopback
> support on the Janz ICAN3, which does not have TX-complete interrupts of
> any kind.
> 
> Since we are now storing packets even in the non-loopback case, there is
> some extra memory overhead, to store the extra packets between the calls
> to can_put_echo_skb() and can_get_echo_skb().
> 
> After this patch series is applied, the SocketCAN tst-rcv-own-msgs test
> passes.
> 
> Performance is rougly 15% less than using the previously posted patch:
> [PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
> 
> This performance drop is due to the extra overhead of receiving the echo
> packets from the card itself. This involves one extra interrupt for each
> packet sent, and the associated overhead of running ican3_napi() for
> each packet sent.
> 


If it works without problems you might try to use 2 or 3 echo_skbs for testing
to ensure the Janz card gets lined with outgoing traffic without waiting for
each single sent frame.

I assume this would make the implementation slightly complexer but may solve
the performance drop on the wire.

> Ira W. Snyder (3):
>   can: make the echo stack keep packet information longer
>   can: add can_cmp_echo_skb() for echo skb comparison
>   can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
> 
>  drivers/net/can/dev.c        |   75 ++++++++++++++++++++++++++++++-----------
>  drivers/net/can/janz-ican3.c |   56 +++++++++++++++++--------------
>  include/linux/can/dev.h      |    2 +
>  3 files changed, 87 insertions(+), 46 deletions(-)
> 


