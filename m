From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939: put_session BUG_ON
Date: Fri, 27 Jan 2017 16:21:42 +0100
Message-ID: <20170127152142.GA29115@airbook.vandijck-laurijssen.be>
References: <CAA7hF3yAMSbd1HM79N12vfw0VKa96nCJsMLgcOA-=Oomqv-Qpg@mail.gmail.com>
 <20170127113043.GD29959@airbook.vandijck-laurijssen.be>
 <CAA7hF3y_epAa3ky+vds9QDjbEWzAcBfk_Ab6Yuk5vz-fTDoQ2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:51221 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbdA0PVt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Jan 2017 10:21:49 -0500
Content-Disposition: inline
In-Reply-To: <CAA7hF3y_epAa3ky+vds9QDjbEWzAcBfk_Ab6Yuk5vz-fTDoQ2g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can <linux-can@vger.kernel.org>


> Hi Kurt,
> On Fri, Jan 27, 2017 at 12:30 PM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> > Hey,
> >
> >> Hi,
> >>
> >> i'm using old j1939 way on a project (with modified iproute2)
> >> and my client detect some problem when making some robustness test (weird
> >> test and not
> >> available test in my mind).
> >>
> >> on the board, we have two can interface, with j1939 on, and source adress
> >> 0x4a on each.
> >
> > OK
> >
> >> the 2 can interace are plugged together (this is the weird stuff for me)
> >
> > Well, that's illegal in j1939. You cannot have 2 cannodes on the bus
> > sharing the same source address.
> >
> > You can debate if the kernel should support this properly or not.
> 
> I agree with you this is illegal, the problem is that our client does
> not want to "hear" this explanation

I assume your client adheres the "linux should support this properly"
side then.

> >
> >>
> >> from an external canalyzer, we send a pgn request
> >> 18ea4a01x 0xcd 0xfe 0x00
> >>
> >> on this, the client application wants to answer a segmented frame on both
> >> interfaces
> >> so on each interface we send a rts message (pgn 0xEC00) with the same SA.
> >>
> >> nobody answer with the CTS message, and so my interface wants to send abort
> >> message.
> >
> > both interfaces send the abort, if I'm not mistaken.
> 
> yes i think so, but i go into the BUG_ON function during the first abort.
> >
> >>
> >> and at this step i have a kernel BUG in transport/put_session function
> >> BUG_ON(!list_empty(&session->list));
> >>
> >> Would you have an idea of what could lead to this behaviour?
> >> What is the goal of this line code?
> >
> > I checked j1939-v3.8 branch (my local one, since you didn't really specify).
> > But my conclusion is similar to my latest j1939d-v4.x branch.
> 
> i use the 3.10 kernel (i've check on different version, and there is
> no big difference i think)

I agree, there's no real difference

> >
> > The immediate goal is to prevent to remove the session while it has not
> > been removed from a list (so it is still possible to match against the
> > session).
> >
> > I think that you triggered a condition where you received an abort
> > message around the time that the timeout is expiring.
> > So you will end up destroying the session from both (a) abort reception
> > and (b) session expiry.
> > This condition is hard to simulate, I'm sure that aborts did not crash
> > all the time, it did work.
> 
> you're right, abort works well on a standard configuration (if i do
> not plug can0/1 together)

Can you attache the output of BUG_ON(),
i'm curious to see the stack trace?

I'm trying to understand how it can fail, but I fail to see it.

> 
> > Can this be related to the rtpatch, where both events run from a thread
> > rather than a softirq, which may schedule at some critical point in my
> > code?
> >
> >>
> >> I've tested with and without rtpatch with the same behaviour.

Ok, then I can think "regular" back again.

Multicore or singlecore?

> >
> > That means you're pretty successfull already with running can-j1939 with
> > rtpatch? nice to hear.
> >
> yes it runs pretty well even with rtpatch except i had to comment a
> put_session call in rx_task (i think we allready discuss that), and
> may be the point can be related.
> >>
> >> Another question, on my board we have rtpatch, and so the in(interrupt
> >> function allways return 0 (as with rtpatch interrupt are kernel threads).
> >> Is this point can lead to some problem?
> >
> > The in_interrupt() is used to avoid killing tasklets from interrupt
> > context. I'm not that experienced with rtpatch, but I assume that
> > this would pose no problem and tasklets get cancelled right away.
> > But I'm not sure :-)
> 
> i've tried to allways use the code with the queue or allways use the
> call to destroy, and i get the problem in both case, so i assume the
> "problem" is not coming from this.
> >
> >>
> >> Thanks in advance for your help
> >> Best regards
> >> Laurent
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
