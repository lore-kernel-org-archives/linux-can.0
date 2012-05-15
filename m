From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 15:37:10 +0200
Message-ID: <20120515133710.GA1414@vandijck-laurijssen.be>
References: <4FAD5A04.2030108@hartkopp.net>
 <20120514093630.GA600@vandijck-laurijssen.be>
 <4FB16213.2000007@hartkopp.net>
 <20120515083454.GA504@vandijck-laurijssen.be>
 <4FB21FA5.8080807@hartkopp.net>
 <20120515100318.GG504@vandijck-laurijssen.be>
 <4FB253A8.3090500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:45159 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611Ab2EONhP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 May 2012 09:37:15 -0400
Content-Disposition: inline
In-Reply-To: <4FB253A8.3090500@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, May 15, 2012 at 03:01:28PM +0200, Oliver Hartkopp wrote:
> On 15.05.2012 12:03, Kurt Van Dijck wrote:
> 
> > On Tue, May 15, 2012 at 11:19:33AM +0200, Oliver Hartkopp wrote:
> 
> >>>> 2. in any case legacy applications must not get CAN frames with a DLC > 8
> >>> Or cut the DLC to 8, and drop the remainder of the message? This changes
> >>> the actual can(fd)_frame. That is acceptable since you're running legacy apps
> >>> on CANFD bus.
> >>>
[...]
> >>
> >> I have a patch for that later in this mail.
> > waaw. You're running _with_ HDR bit on :-) ?
> 
I meant you have a "High data rate" yourself. It was meant as some form
of humor to indicate my supprise of you generating a new patch very quick ...

[...]
> >> 1. CANFD aware apps may get CAN_MTU and CANFD_MTU frames on rx
> >> 2. CANFD aware apps may send CAN_MTU and CANFD_MTU frames on tx
> >> 3. legacy apps can receive CAN_MTU and CANFD_MTU frames if the DLC <= 8
> >>    (the possible CANFD_MTU is cut down to CAN_MTU to preserve the ABI)
> >>
> >> Effects to the CAN netdev driver:
> >>
> >> Legacy operation (CAN_MTU)
> >> - send and receive struct can_frames
> >>
> >> CANFD operation (CANFD_MTU and CAN_MTU)
> >> - you can send CANFD_MTU and CAN_MTU frames
> >>   (a default setting (EDL, HDR) for CAN_MTU frames needs to be specified)
> >> - the driver generates always canfd_frames on reception
> > Interesting.
> > How does a driver makes the difference between received
> > CAN2.0B frames & CANFD frames?
> 
> 
> As you always generate canfd_frames in this operating mode you can express
> this information within canfd_frame.flags.
> 
> > I think it makes sense, equally to the send() path, to allow the driver
> > to generate can_frame _or_ canfd_frame on reception, depending on the
> > bitstream (if possible).
> 
> 
> As written above this can be done with a singe canfd_frame.
> 
> A legacy app would get the can_frame as-is when DLC <= 8
> A CANFD frame can evaluate the bits if they are at least interesting for the
> app. For a detailed 'candump' output this could be interesting ;-)
> 
> > 
> > A CANFD application will then be able to distinguish between them based
> > on the return value of recv_msg (CAN_MTU or CANFD_MTU, even with payload <= 8).
> 
> 
> There's no reason to provide a CAN_MTU frame to a CANFD application once the
> driver is switched to CANFD-mode.
I think there is a reason. If a CAN2.0B frame was on the wire, generating
a can_frame rather than a canfd_frame better reflects what was on the wire.

I still think a can_frame & canfd_frame with same data differ on the wire.

If a CANFD chip (in a specific mode) is unable to distinguish this, then
that's a driver issue. But I propose not to put such sideeffect into the
generic parts.
> 
> The CANFD app only gets the old-style CAN_MTU frames when the CAN interface is
> not in CANFD mode.
> 
> > 
> > Did I mention I very much like this additional patch?
> > Well done.
> 
> 
> Thanks to you! I was not really happy with the hard exclusive-or switch and
> your remarks made me thinking about the simultaneous access with new and
> legacy apps again.
You're not tired of me then :-)
> I think cutting the canfd_frames down to can_frames when
> the content is generally usable for the legacy app makes the migration pretty
> handy :-)
My first suggestion was to also cut longer CANFD frames down to 8 bytes
(thereby loosing data!).
Remember it's still a compatibility mode. I think that would be acceptable.
> 
> Will send a v4 patch for the ongoing discussion.
I didn't wait on them ..., but now I will
> 
> Regards,
> Oliver
Kind regards,
Kurt
