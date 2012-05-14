From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v3] CAN FD support
Date: Mon, 14 May 2012 21:50:43 +0200
Message-ID: <4FB16213.2000007@hartkopp.net>
References: <4FAD5A04.2030108@hartkopp.net> <20120514093630.GA600@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:9782 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803Ab2ENTun (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 May 2012 15:50:43 -0400
In-Reply-To: <20120514093630.GA600@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Kurt,

thanks for your feedback.

Indeed i'm not totally happy with the current hard switch too! Let's see if we
can develop something less intrusive but still clean in design.

The question is how to cope with this scenario:

A legacy application wants to communicate via can0 not knowing anything about
CAN FD. This legacy app can only read and write struct can_frames and does not
know about different data rates in the data field.

1. For this scenario we need to define (globally!?) if legacy apps generated
(short) CAN frames use the slow or high data rate in the data field when
transmitted via that specific CAN FD interface.

2. in any case legacy applications must not get CAN frames with a DLC > 8

3. legacy applications assume struct can_frames on read and write. There
should no MSG_TRUNC been set in msg flags when receiving a can_frame.

OTOH we will have new applications that are aware of CAN FD. These new
applications may also be able to deal with two different sizes of structs for
read and write operations (can_frame and canfd_frame) - if we specify it so.

Therefore we would need at least some flag if the application is CAN FD aware
or not. Btw. i'll think about a better simultaneous access of legacy and new
apps to the CAN interfaces.

Some more comments inline:

On 14.05.2012 11:36, Kurt Van Dijck wrote:

> I like the inversion of HDR & EDL bits. It make CAN & CANFD
> even more compatible.
> 
> I still don't see the contribution of ETH_P_CANFD.


I'll think about it again.

> Another issue I'm still struggling with: can_raw is differentiating
> between CAN & CANFD with CAN_RAW_FD_FRAMES sockopt.


As written above it is needed to indicate a CAN FD aware app.

I just wonder if CAN FD apps should deal with both MTUs at a time.

> IMO, at most 1 property/method shall exist to differentiate CAN from CANFD.
> (Preferrably, no method should have been necessary).


The protocol CAN_RAW stands for struct can_frame. This is fixed.

If you want to exchange canfd_frames you can add a new sockopt or you
introduce a new protocol (e.g. CAN_RAWFD). The latter has no additional
property/method - besides the different protocol number ... %-)

Would you prefer that solution?

> I see that 2 struct are in place now, with sizes CAN_MTU & CANFD_MTU.
> This alone is IMO enough to differentiate.


See above. Yes, but you need to protect legacy apps of getting FD frames.

> Next to this property, an _extra_ sockopt is introduced.
> This sockopt actually implements a filter, at can_raw level, *and*
> is a second way of telling you want to use CANFD.


The exclusive-OR switch can probably be alleviated.

> 
> I understood that mixing CAN & CANFD on 1 bus is possible on CANFD chip level,
> and we do want to support those features by using 2 structs
> that in fact determine the CAN type. If an application want to mix
> CAN & CANFD, it is currently not possible without opening another
> socket, thereby loosing the proper sequence of events.


Beware of providing a needless flexibility here.
Once the CAN driver is switched to the CAN FD mode you can send and receive
all types of frames. You can send normal CAN frames inside struct canfd_frame
too! So when you open a socket - and you are a CAN FD aware app - you switch
to CAN_RAW_FD_FRAMES and you are free to send/recv whatever you like.

NB: You can only switch the CAN interface MTU when the interface is down.

> 
> IMHO, the CAN_RAW_FD_FRAMES is not justifyable towards userspace
> applications.
> 
> I put my view in the code down below, besides the elimination of the 'fd_frames'
> member in struct raw_sock, and the corresponding CAN_RAW_FD_FRAMES sockopt.
> 
> IMO, the old behaviour (that is written in stone) is still preserved for
> 99.999%, _and_ no difficult sockopts are needed.
> Difficult means in this case: it became not straightforward to predict
> which frames got received.


Indeed :-)

And that's not acceptable for legacy apps.

Thanks,
Oliver
