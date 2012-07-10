From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Tue, 10 Jul 2012 08:09:53 +0200
Message-ID: <4FFBC731.60408@grandegger.com>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36897 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GJGJ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 02:09:59 -0400
In-Reply-To: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

Hi Ira,

On 07/09/2012 09:56 PM, Ira W. Snyder wrote:
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

Well, I don't like such device specific quirk going into the common
interface.

> After this patch series is applied, the SocketCAN tst-rcv-own-msgs test
> passes.
> 
> Performance is rougly 15% less than using the previously posted patch:
> [PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS

Oops, that's a lot and a clear contra.

> This performance drop is due to the extra overhead of receiving the echo
> packets from the card itself. This involves one extra interrupt for each
> packet sent, and the associated overhead of running ican3_napi() for
> each packet sent.

Do we really want that. I agree that CAN_RAW_RECV_OWN_MSGS should work
as expected but we should not try hard to partially fix the timing
issue. Why do we not just use the default protocol callback (flags &=
!IFF_ECHO) if the hardware cannot do it better.

Wolfgang.
