From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 12:03:18 +0200
Message-ID: <20120515100318.GG504@vandijck-laurijssen.be>
References: <4FAD5A04.2030108@hartkopp.net>
 <20120514093630.GA600@vandijck-laurijssen.be>
 <4FB16213.2000007@hartkopp.net>
 <20120515083454.GA504@vandijck-laurijssen.be>
 <4FB21FA5.8080807@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:6706 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102Ab2EOKDX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 May 2012 06:03:23 -0400
Content-Disposition: inline
In-Reply-To: <4FB21FA5.8080807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, May 15, 2012 at 11:19:33AM +0200, Oliver Hartkopp wrote:
> On 15.05.2012 10:34, Kurt Van Dijck wrote:
> 
> > On Mon, May 14, 2012 at 09:50:43PM +0200, Oliver Hartkopp wrote:
> 
> >> A legacy application wants to communicate via can0 not knowing anything about
> >> CAN FD. This legacy app can only read and write struct can_frames and does not
> >> know about different data rates in the data field.
> >>
> >> 1. For this scenario we need to define (globally!?) if legacy apps generated
> >> (short) CAN frames use the slow or high data rate in the data field when
> >> transmitted via that specific CAN FD interface.
> > IMHO, slow datarate matches the most closely to regular CAN2.0B.
> 
> 
> You can not rely on this.
> 
> The most probable migration scenario is to increase the payload data rate
> without changing any application.
This view makes also sense. This is not a breaking issue for me :-)
> 
> >>
> >> 2. in any case legacy applications must not get CAN frames with a DLC > 8
> > Or cut the DLC to 8, and drop the remainder of the message? This changes
> > the actual can(fd)_frame. That is acceptable since you're running legacy apps
> > on CANFD bus.
> > 
> > An alternative could be to drop CANFD frames in can_recv() itself.
> > This may sound inefficient, but remind you're running legacy apps on CANFD busses
> > _WITH_ CANFD frames on it.
> 
> 
> I have a patch for that later in this mail.
waaw. You're running _with_ HDR bit on :-) ?
> 
> > 
> > I'd rather choose a suboptimal compatibility mode than adding code to explicitely
> > tweak the subsystem.
> 
> 
> CAN_RAW_FD_FRAMES *is* this compatibility switch :-)
see below. I see improvement, but I meant something different.
> 
> >>
> >> 3. legacy applications assume struct can_frames on read and write. There
> >> should no MSG_TRUNC been set in msg flags when receiving a can_frame.
> > see 2. MSG_TRUNC would be set only with sizes != CAN_MTU & != CANFD_MTU.
> > 
> > This level of compatibility involves modifying the actual received CAN frame
> > when CANFD frames are received on a socket using CAN_MTU. I accept this
> > compatibility for sake of preserving the API that DLC <= 8 for such frames.
> 
> 
> Yes. I did exactly this in my patch this morning.
Yes. I like it.
> 
> If you get a CANFD frame to be passed to a legacy socket
> 
> 1. check id DLC <= 8 (in raw_rcv())
> 2. cut the length from CANFD_MTU to CAN_MTU (in raw_recvmsg())
> 
> > 
> >>

[...]
> 
> Yes. Especially we need to specify how the CAN controller should send
> can_frames passed to its CAN driver. Should it been send with or without
> EDL bit, and should it been send with high data rate or not.
> 
> This is what i wanted to suggest with the global CANFD driver settings.

netlink-wise, I would have considered this a device setting.

[...]
> > 
> > Ok, this is unlikely to be a problem, but 'unlikely' > 0%.
> > You see my point? A legacy app doing
> > 	recv(cansock, &can_frame, <CANFD_MTU hardcoded>);
> > may break legacy apps, but this is considered unlikely, and
> > such crap should not prevent development of good stuff.
> > 
> > Just think about it.
> 
> 
> Done :-)
> 
> Legacy crap that was technically possible to do just has to be supported.

I still don't get the real difference, I probably never will :-(
> 
> Here's my patch:

> 
> Changes to the previous version:
> 
> CANFD aware apps set CAN_RAW_FD_FRAMES to enable longer MTUs (not new).
> 
> 1. CANFD aware apps may get CAN_MTU and CANFD_MTU frames on rx
> 2. CANFD aware apps may send CAN_MTU and CANFD_MTU frames on tx
> 3. legacy apps can receive CAN_MTU and CANFD_MTU frames if the DLC <= 8
>    (the possible CANFD_MTU is cut down to CAN_MTU to preserve the ABI)
> 
> Effects to the CAN netdev driver:
> 
> Legacy operation (CAN_MTU)
> - send and receive struct can_frames
> 
> CANFD operation (CANFD_MTU and CAN_MTU)
> - you can send CANFD_MTU and CAN_MTU frames
>   (a default setting (EDL, HDR) for CAN_MTU frames needs to be specified)
> - the driver generates always canfd_frames on reception
Interesting.
How does a driver makes the difference between received
CAN2.0B frames & CANFD frames?
I think it makes sense, equally to the send() path, to allow the driver
to generate can_frame _or_ canfd_frame on reception, depending on the
bitstream (if possible).

A CANFD application will then be able to distinguish between them based
on the return value of recv_msg (CAN_MTU or CANFD_MTU, even with payload <= 8).

Did I mention I very much like this additional patch?
Well done.

Regards,
Kurt
