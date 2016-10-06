From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 09:41:03 +0200
Message-ID: <20161006074103.GA11907@airbook.vandijck-laurijssen.be>
References: <20161004073703.GB13813@airbook.vandijck-laurijssen.be>
 <20161004145202.6c5238d9@erd980>
 <20161004135701.GA25008@airbook.vandijck-laurijssen.be>
 <20161004164725.08802a61@erd980>
 <20161004173129.GB25008@airbook.vandijck-laurijssen.be>
 <8f5ebcf8-8bb6-a9f0-33af-47d4a551e811@pengutronix.de>
 <20161004184036.GD25008@airbook.vandijck-laurijssen.be>
 <48bf45a3-b724-a546-62ee-31a27dc3db33@pengutronix.de>
 <20161005180205.GE25008@airbook.vandijck-laurijssen.be>
 <5fb6231c-4461-2be7-bd47-530aa62c121f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:44205 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbcJFHmE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 03:42:04 -0400
Content-Disposition: inline
In-Reply-To: <5fb6231c-4461-2be7-bd47-530aa62c121f@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>


--- Original message ---
> Date:   Thu, 6 Oct 2016 09:26:00 +0200
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: David Jander <david@protonic.nl>, Austin Schuh
>  <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
>  linux-can <linux-can@vger.kernel.org>
> Subject: Re: j1939
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
>  Icedove/45.2.0
> 
> On 10/05/2016 08:02 PM, Kurt Van Dijck wrote:
> >> On 10/04/2016 08:40 PM, Kurt Van Dijck wrote:
> >>>>> I think we agree on what must be possible, we may just differ on the
> >>>>> defaults and how to set things.
> >>>>
> >>>> It seems, or rather what I'd like to see is that we want most things to
> >>>> be per socket option. All module parameters should go away. The default
> >>>> for transport_max_size might be a system wide value, similar to
> >>>> /proc/sys/net/core/rmem_max.
> >>>
> >>> do you propose to add /proc files?
> > 
> >> No - However I'm not sure yet, though.
> > In that case, I didn't understand your point :-(
> 
> The rmem_max and rmem_default and their wmem friends define both a
> system wide default and a maximum for the read and write buffer of
> sockets. And there are two sockopts to change the default up to the
> maximum value that correspondes to the _max value. Where to put this
> value is another question. As it's a system wide setting /proc might be
> a sensible place.

I see.
Your example happened to live in proc, but that wasn't the point.
I agree with something like that, although I only envisioned xxx_default
and not xxx_max.
> 
> >>> I'm willing to replace module parameters with /proc files, but I don't
> >>> see the real advantage yet. And module parameters were quicker :-)
> >>
> >> When trying to bring new code into the kernel, this is probably not the
> >> best argument :)
> > 
> > Well, in my experience, the infrastructures are built so that
> > easy-to-read code do the right thing in the right way.
> > In that regard, I suspect module parameters may be the preferred way?
> 
> Some weeks ago Grek turned down a patch, as it introduced new module
> parameters and said quite clearly no new module parameters.
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



