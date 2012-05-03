From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Thu, 3 May 2012 23:49:40 +0200
Message-ID: <20120503214940.GA1826@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <4F964C45.8010804@grandegger.com>
 <20120424190226.GA1589@gmail.com>
 <4F97A735.5080708@grandegger.com>
 <4F97AA91.1020007@pengutronix.de>
 <4F97CC48.5000809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34164 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab2ECVrN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 17:47:13 -0400
Received: by were53 with SMTP id e53so1395286wer.19
        for <linux-can@vger.kernel.org>; Thu, 03 May 2012 14:47:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F97CC48.5000809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello everyone,

I'm back on the activity-trigger subject.

On Wed, Apr 25, 2012 at 12:04:56PM +0200, Wolfgang Grandegger wrote:
> >>> On Tue, Apr 24, 2012 at 08:46:29AM +0200, Wolfgang Grandegger wrote:
> >>>> I still think that the blinking support should go to the timer class to
> >>>> avoid duplicated code. Any good reason against? Apart from that the
> >>>> patches look good.
> >>>>
> >> For me it still does make sense to provide a generic
> >> led_trigger_blink_once support. But well, go ahead if I'm the only one
> >> with that opinion.
> > 
> > +1
> > At least start a discussion on the LED list (I don't know which list
> > that is).
> 
> The MAINAINERS file does not list a mailing list, therefore the LKML
> should be used, with a CC to Richard Purdie, I think. While checking if
> LED support is discussed, I found related mails. One shot timer LED
> support seems to be a frequently discussed issue:
> 
>   http://marc.info/?t=133489487700001&r=1&w=2
>   http://marc.info/?l=linux-kernel&m=133331013422467&w=4
> 
> As usual, it's better to send a patch than to ask a (general) questions.
> I think we would get rather quick response.

I spent last couple of days trying to come up with a generic one-shot
blink patch clean enough to get some chance of integration, but what I
ended up with was these considerations in favor of framework-specific
code:

The only clean way I see to do that is to implement the function as an
extension of the actual soft-blink code.

That functions are used as fallback if no hw-blink is available and are
just blindly toggling values on-off, so they have to be modified quite
heavily to add necessary state information to support the behaviour of
the actual code (like when a trigger is added for an already up
interface) and the feature required by other usage cases (like the
trigger currently discussed in the list - which is going in the way of a
trigger-specific implemetation anyway).  This would involve adding flags
and cases in both trigger and timer code.

So, I'm taking a break on this and trying to feed this argument: why the
socketcan code would benefit from a specific implementation rather than
a generic one?

Because overall code is *much* more simple and clean!

- the timer function body is just 12 lines of code, whithout special
  cases, that's faster to execute and easy to understand (and debug).

- the event function for TX and RX paths is just some checks and a
  mod_timer, without list iterations or locking, and as it's going to be
  called in hard-irq context, I think this is a *strong* plus for the
  implementation (the most important thing here is to get out of the way
  as fast as possible, right? A generic implementation would only make
  latencies worse here).

So, my point, do you still think that this feature would benefit of a
generic triggering implementation?

(of course, I'm posting a v3 with just Oliver's Kconfig notes if you
agree with my point :-) )

Regards,
Fabio
