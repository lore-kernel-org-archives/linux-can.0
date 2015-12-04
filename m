From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Fri, 4 Dec 2015 15:04:14 +0100
Message-ID: <20151204140414.GA24723@airbook.eia.lan>
References: <loom.20151120T162359-379@post.gmane.org>
 <20151123200923.GA4556@airbook.vandijck-laurijssen.be>
 <CAA7hF3zr0jcJNRn6EYVuFfhg-xCab5MR=B4budC1Pzce0xL7zg@mail.gmail.com>
 <20151125132633.GE764@airbook.vandijck-laurijssen.be>
 <CAA7hF3zSyPFDEzuPWmwwBhTf3005U_g8fEV3ses5_i+Gi=_ecw@mail.gmail.com>
 <5655CCDE.2090701@pengutronix.de>
 <CAA7hF3xDeRRg3LXyfzWtY_DxmMUM8bL=sxvRcAEwHr_G4GsZ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:57653 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbbLDOFC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Dec 2015 09:05:02 -0500
Content-Disposition: inline
In-Reply-To: <CAA7hF3xDeRRg3LXyfzWtY_DxmMUM8bL=sxvRcAEwHr_G4GsZ=A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

> On Wed, Nov 25, 2015 at 3:59 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 11/25/2015 02:39 PM, laurent vaudoit wrote:
> >>>> i have found a workaround, working with rtpatch, but not sure if this
> >>>> can be considered as a bug fix or not.
> >>>> in function j1939tp_rxtask, there is a call to j1939session_cancel,
> >>>> who call put_session
> >>>> and at the end of j1939tp_rxtask, we call put_session.
> >>>> if i comment this "second call" to put_session, the problem disappear.
> >>>
> >>> It seems that you added a memory leak because put_session if a ref
> >>> counter. You keep the session installed ... forever, or until a next
> >>> similar session is about to be created.
> >>>
> >>> I'm not sure either that this is the correct way to proceed.
> >>
> >> i'm not sure i understand well.
> >> this seems weird for me to have one get_session and 2 put_session
> >> should'nt we have one get_session and one put_session only? (this is
> >> what i tried)?

When you come to the point where you want to get rid of the session,
you need decrement the refcounter to become zero.
This extra put_session compensates the initial 1 in the refcounter.

I still don't see where it goes wrong. Can you experiment with disabling
individual lines in j1939session_destroy()? Since problems occur only
later, I suspect that the call to skb_free is causing the issue, but I'm
not sure.

Kurt

