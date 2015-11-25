From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Wed, 25 Nov 2015 14:26:33 +0100
Message-ID: <20151125132633.GE764@airbook.vandijck-laurijssen.be>
References: <loom.20151120T162359-379@post.gmane.org>
 <20151123200923.GA4556@airbook.vandijck-laurijssen.be>
 <CAA7hF3zr0jcJNRn6EYVuFfhg-xCab5MR=B4budC1Pzce0xL7zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.edpnet.be ([212.71.1.221]:33780 "EHLO relay.edpnet.be"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751832AbbKYN1b (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Nov 2015 08:27:31 -0500
Content-Disposition: inline
In-Reply-To: <CAA7hF3zr0jcJNRn6EYVuFfhg-xCab5MR=B4budC1Pzce0xL7zg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org


--- Original message ---
> Date: Wed, 25 Nov 2015 11:28:30 +0100
> From: laurent vaudoit <laurent.vaudoit@gmail.com>
> To: linux-can@vger.kernel.org, Kurt Van Dijck
>  <dev.kurt@vandijck-laurijssen.be>
> Subject: Re: J1939 crash after receiving BAM frame and no DT frame
> 
> Hi Kurt
> 
> On Mon, Nov 23, 2015 at 9:09 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> >> Hi all,
> >> i'm facing some issue on my imx6 board, with j1939 patch.
> >>
> >> i setup my can interface with ip link command
> >> and then i setup this interface in j1939
> >>
> >> ip link set can0 up type can bitrate 250000
> >> ip link set can0 j1939 on
> >>
> >> and after i launch a candump on can0
> >>
> >> On can0, i play an can bus trace (logged from a vehicule).
> >> at the end of the trace, i have a bam frame without the DT frame associated
> >>
> >> on the console, i see the log
> >> 1939tprx_task timeout on 2 (it seems normal)
> >> and after, i have a rando crash of my system (not in can stuffs, sometimes
> >> a reset, sometimes nand driver...)
> >>
> >> if i remove the BAM frame, problem does not appear.
> >> if i do not set can0 j1939 on, problem does not appear
> >> so it seems the problem is related to j1939 timeout
> >
> > I was not in a position to reproduce your scenario.
> >
> > I suspect a locking mistake of mine.
> > Can you try this patch?
> >
> > diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> > index 5c0bdc5..0bc1edb 100644
> > --- a/net/can/j1939/transport.c
> > +++ b/net/can/j1939/transport.c
> > @@ -166,9 +166,9 @@ static void put_session(struct session *session)
> >         tasklet_disable_nosync(&session->txtask);
> >
> >         if (in_interrupt()) {
> > -               spin_lock_bh(&s.del.lock);
> > +               spin_lock(&s.del.lock);
> >                 list_add_tail(&session->list, &s.del.sessionq);
> > -               spin_unlock_bh(&s.del.lock);
> > +               spin_unlock(&s.del.lock);
> >                 schedule_work(&s.del.work);
> >         } else {
> >                 /* destroy session right here */
> >
> > --
> >
> > You may also enable CONFIG_DEBUG_SPINLOCK
> 
> i've tried the patch, but in fact in_interrupt() return 0 so
> i do no enter in this code
> after more debug, the problem is in
> 1939session_destroy, during the first call to tasklet_disable()
> 
> 
> by the way problem occurs with rtpatch applied, and does not without.

Well, that explains me not having seen this.

> 
> i have found a workaround, working with rtpatch, but not sure if this
> can be considered as a bug fix or not.
> in function j1939tp_rxtask, there is a call to j1939session_cancel,
> who call put_session
> and at the end of j1939tp_rxtask, we call put_session.
> if i comment this "second call" to put_session, the problem disappear.

It seems that you added a memory leak because put_session if a ref
counter. You keep the session installed ... forever, or until a next
similar session is about to be created.

I'm not sure either that this is the correct way to proceed.

> 
> rt_patch makes lots of improvment in tasklet management.
> please let me know if this part of code is usefull (2 call to
> put_session instead of 1)
> 
> Regards
> Laurent
> >
> >>
> >> Is someone yet encountered this problem?
> >>
> >> my kernel is a 3.10 kernel, with j1939 patch
> >>
> >> Thanks in advance
> >> Best regards
> >>
> >> Laurent
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
