From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 10:34:54 +0200
Message-ID: <20120515083454.GA504@vandijck-laurijssen.be>
References: <4FAD5A04.2030108@hartkopp.net>
 <20120514093630.GA600@vandijck-laurijssen.be>
 <4FB16213.2000007@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:34449 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758054Ab2EOIe6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 May 2012 04:34:58 -0400
Content-Disposition: inline
In-Reply-To: <4FB16213.2000007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Oliver,

On Mon, May 14, 2012 at 09:50:43PM +0200, Oliver Hartkopp wrote:
> Hello Kurt,
> 
> thanks for your feedback.
> 
> Indeed i'm not totally happy with the current hard switch too! Let's see if we
> can develop something less intrusive but still clean in design.
> 
> The question is how to cope with this scenario:
> 
> A legacy application wants to communicate via can0 not knowing anything about
> CAN FD. This legacy app can only read and write struct can_frames and does not
> know about different data rates in the data field.
> 
> 1. For this scenario we need to define (globally!?) if legacy apps generated
> (short) CAN frames use the slow or high data rate in the data field when
> transmitted via that specific CAN FD interface.
IMHO, slow datarate matches the most closely to regular CAN2.0B.
> 
> 2. in any case legacy applications must not get CAN frames with a DLC > 8
Or cut the DLC to 8, and drop the remainder of the message? This changes
the actual can(fd)_frame. That is acceptable since you're running legacy apps
on CANFD bus.

An alternative could be to drop CANFD frames in can_recv() itself.
This may sound inefficient, but remind you're running legacy apps on CANFD busses
_WITH_ CANFD frames on it.

I'd rather choose a suboptimal compatibility mode than adding code to explicitely
tweak the subsystem.
> 
> 3. legacy applications assume struct can_frames on read and write. There
> should no MSG_TRUNC been set in msg flags when receiving a can_frame.
see 2. MSG_TRUNC would be set only with sizes != CAN_MTU & != CANFD_MTU.

This level of compatibility involves modifying the actual received CAN frame
when CANFD frames are received on a socket using CAN_MTU. I accept this
compatibility for sake of preserving the API that DLC <= 8 for such frames.

> 
> OTOH we will have new applications that are aware of CAN FD. These new
> applications may also be able to deal with two different sizes of structs for
> read and write operations (can_frame and canfd_frame) - if we specify it so.
they (ideally) always do:
	ret = recv(cansock, &canfd_frame, CANFD_MTU);
and recv() returns CANFD_MTU _or_ CAN_MTU.
That sounds acceptible.
> 
> Therefore we would need at least some flag if the application is CAN FD aware
> or not. Btw. i'll think about a better simultaneous access of legacy and new
> apps to the CAN interfaces.

Well, I think I just solved this in 2.
> 
> Some more comments inline:

For the remainder, a few topics remain, so I cut a bit:

> If you want to exchange canfd_frames you can add a new sockopt or you
> introduce a new protocol (e.g. CAN_RAWFD). The latter has no additional
> property/method - besides the different protocol number ... %-)
> 
> Would you prefer that solution?

No, IMHO that's even worse :-)
* more code would be duplicated
* no interleaved CAN & CANFD frames on 1 socket.

> > I understood that mixing CAN & CANFD on 1 bus is possible on CANFD chip level,
> > and we do want to support those features by using 2 structs
> > that in fact determine the CAN type. If an application want to mix
> > CAN & CANFD, it is currently not possible without opening another
> > socket, thereby loosing the proper sequence of events.
> 
> 
> Beware of providing a needless flexibility here.
> Once the CAN driver is switched to the CAN FD mode you can send and receive
> all types of frames. You can send normal CAN frames inside struct canfd_frame
> too! So when you open a socket - and you are a CAN FD aware app - you switch
> to CAN_RAW_FD_FRAMES and you are free to send/recv whatever you like.
Now this is interesting. I really tought that a struct can_frame and a
struct canfd_frame with similar content still produce a (slight) different
bitstream on the wire, i.e. a struct can_frame would produce a CAN2.0b bitstream
that is different than the CANFD bitstream.

I did think that this difference in bitstream/protocol would map
on a different struct.
Where am I wrong here?

Even if I'm not convinced, I now better understand your exclusive-or ...
This definitely needs clarification.

> 
> NB: You can only switch the CAN interface MTU when the interface is down.
very good!
No discussion there.
> 
> > 
> > IMHO, the CAN_RAW_FD_FRAMES is not justifyable towards userspace
> > applications.
> > 
> > I put my view in the code down below, besides the elimination of the 'fd_frames'
> > member in struct raw_sock, and the corresponding CAN_RAW_FD_FRAMES sockopt.
> > 
> > IMO, the old behaviour (that is written in stone) is still preserved for
> > 99.999%, _and_ no difficult sockopts are needed.
> > Difficult means in this case: it became not straightforward to predict
> > which frames got received.
> 
> 
> Indeed :-)
> 
> And that's not acceptable for legacy apps.

Even that I avoided this 0.001% difference above in (2.), I'll still
make a nasty comparison here.

If an ABI was 100% the same, I argue that if a legacy app does
	int value = 1;
	setsockopt(cansock, 5, &value, sizeof(value));
Then you also are changing the behaviour of the legacy application now.
No problem, let's create CANFD_RAW. But even that is not 100% compatible.

Ok, this is unlikely to be a problem, but 'unlikely' > 0%.
You see my point? A legacy app doing
	recv(cansock, &can_frame, <CANFD_MTU hardcoded>);
may break legacy apps, but this is considered unlikely, and
such crap should not prevent development of good stuff.

Just think about it.

Anyway, I still think I solved this problem in (2.) by modifying
the received content.

Kind regards,
Kurt
