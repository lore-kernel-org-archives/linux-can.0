From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Wed, 5 Oct 2016 20:02:05 +0200
Message-ID: <20161005180205.GE25008@airbook.vandijck-laurijssen.be>
References: <CANGgnMaxNRBDG9WWAanHEem-wDJ1ujxYdqgko7nAx3iJNcPUGA@mail.gmail.com>
 <20160920091525.2ff22d58@erd980>
 <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
 <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:50111 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbcJESDD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2016 14:03:03 -0400
Content-Disposition: inline
In-Reply-To: <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>


> On 10/04/2016 08:40 PM, Kurt Van Dijck wrote:
> >>> I think we agree on what must be possible, we may just differ on the
> >>> defaults and how to set things.
> >>
> >> It seems, or rather what I'd like to see is that we want most things to
> >> be per socket option. All module parameters should go away. The default
> >> for transport_max_size might be a system wide value, similar to
> >> /proc/sys/net/core/rmem_max.
> > 
> > do you propose to add /proc files?

In that case, I didn't understand your point :-(

> 
> No - However I'm not sure yet, though.
> 
> > I'm willing to replace module parameters with /proc files, but I don't
> > see the real advantage yet. And module parameters were quicker :-)
> 
> When trying to bring new code into the kernel, this is probably not the
> best argument :)

Well, in my experience, the infrastructures are built so that
easy-to-read code do the right thing in the right way.
In that regard, I suspect module parameters may be the preferred way?

Kurt
