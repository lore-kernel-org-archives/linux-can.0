From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 16:36:55 +0200
Message-ID: <20120515143655.GC1414@vandijck-laurijssen.be>
References: <4FAD5A04.2030108@hartkopp.net>
 <20120514093630.GA600@vandijck-laurijssen.be>
 <4FB16213.2000007@hartkopp.net>
 <20120515083454.GA504@vandijck-laurijssen.be>
 <4FB21FA5.8080807@hartkopp.net>
 <20120515100318.GG504@vandijck-laurijssen.be>
 <4FB253A8.3090500@hartkopp.net>
 <20120515133710.GA1414@vandijck-laurijssen.be>
 <4FB26543.5070002@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:45534 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964815Ab2EOOg6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 May 2012 10:36:58 -0400
Content-Disposition: inline
In-Reply-To: <4FB26543.5070002@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> 
> >> There's no reason to provide a CAN_MTU frame to a CANFD application once the
> >> driver is switched to CANFD-mode.
> > I think there is a reason. If a CAN2.0B frame was on the wire, generating
> > a can_frame rather than a canfd_frame better reflects what was on the wire.
> > 
> > I still think a can_frame & canfd_frame with same data differ on the wire.
> 
> 
> Yes. But you can express this difference with the CANFD_NOEDL bit in
> canfd_frame.flags:
> 
> CANFD_NOEDL == 1 => standard CAN 2.0B frame
> CANFD_NOEDL == 0 => CAN FD frame (whatever DLC 0-F is used)
I see now.
Some more pieces fall into place.
I still haven't memorised the complete docs.
> 

> 
> >> I think cutting the canfd_frames down to can_frames when
> >> the content is generally usable for the legacy app makes the migration pretty
> >> handy :-)
> > My first suggestion was to also cut longer CANFD frames down to 8 bytes
> > (thereby loosing data!).
> > Remember it's still a compatibility mode. I think that would be acceptable.
> 
> 
> At the point where CAN FD frames with a DLC > 8 become relevant for
> applications a new CANFD aware application *should* come into service.
> 
> Silently cutting payload data is a bad idea.

I'm mostly not in favor of modifying/cutting the payload,
but I consider it here.
Since you introduce a sockopt to switch to CANFD mode, I foresee following
scenario:

People write a brand new CANFD aware application, at least, they apply canfd_frame.
They send frames, up to the 64 bytes, but do not see anything coming, because ....
they forgot to do setsockopt(...).

If they only would see their frames cut to 8 bytes, one can notice
there might be some compatibility mode in place.
If they don't see anything, yeah, the problem could be anywhere.

So a question comes in: I do this & that, and others say:
is your CAN bus ok, is this, is that?
until finally, as that is the way it goes, the code comes along,
and someone says: of course, ...

So I think it's worth considering ... due to the socket option.
Especially since I think the impact is minimal.

Kurt
