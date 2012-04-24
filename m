From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 21:02:26 +0200
Message-ID: <20120424190226.GA1589@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
 <4F964C45.8010804@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63673 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972Ab2DXTAj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 15:00:39 -0400
Received: by wibhr17 with SMTP id hr17so3770617wib.1
        for <linux-can@vger.kernel.org>; Tue, 24 Apr 2012 12:00:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F964C45.8010804@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

Hi Wolfgang,

On Tue, Apr 24, 2012 at 08:46:29AM +0200, Wolfgang Grandegger wrote:
> I still think that the blinking support should go to the timer class to
> avoid duplicated code. Any good reason against? Apart from that the
> patches look good.
> 
> Wolfgang.

I can see you point and I considered your note about adding the
one-shot-blink function to the led-class framework (sorry for not
mentioning it in my first post).  Still, I ended up with this code for
a couple of reasons:

- I think that the led_blink_set function is primarily used to configure
  leds with hardware blinking (like i2c led drivers).  While it would be
  possible to extend the function to get one-shot behavior and always
  fallback on software blink, I think that that's out of the purpose of
  the led-class, which should just translate on-off requests to
  underlaying hardware.

- I think that different drivers may want to obtain different on-off
  behavior depending on the application.  For example in the ide-disk
  case the user expects to see a steady-on LED on constant activity,
  and that's how it's implemented, while in this case the on-if-up
  keep-blinking-on-activity off-if-down makes much more sense. So I think
  that even if a generic blink function were available, people would
  still be using custom functions because they want to fine tune the
  behavior for the application.  Also, maybe a function too generic may
  impact on performance in critical paths.

- in this case, it looks to me like the implementation is as optimized
  as it can be, in the sense that the hot-path does really only some
  essential check and engage the timer and the timer function itself is
  really short.  Also the final blinking effect is nice IMO :-)

Regards,
Fabio
