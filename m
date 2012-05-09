From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] can: trx support
Date: Wed, 9 May 2012 16:53:11 +0200
Message-ID: <20120509145311.GA7194@vandijck-laurijssen.be>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com>
 <4FA9394A.90303@pengutronix.de>
 <20120508173001.31ce8f0c@eb-e6520>
 <4FA93FC1.7030808@pengutronix.de>
 <20120508191459.703c4369@eb-e6520>
 <4FA95A17.8090406@hartkopp.net>
 <4FA96750.6020206@pengutronix.de>
 <20120509081650.GA426@vandijck-laurijssen.be>
 <4FAA809D.8070502@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:50919 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758059Ab2EIOxP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 9 May 2012 10:53:15 -0400
Content-Disposition: inline
In-Reply-To: <4FAA809D.8070502@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>

On Wed, May 09, 2012 at 04:35:09PM +0200, Oliver Hartkopp wrote:
> On 09.05.2012 10:16, Kurt Van Dijck wrote:
> 

> >> In the current implementation you can register a callback via
> >> platform_data to enable/disable the transceiver. It's up to the board to
> >> do something useful with it.
> > Like in: The driver must call the callback, and the board can act upon this.
> >>
> >> I think for now I'll take Eric's patch as it is, until we've implemented
> >> something more complicated to support automotive style transceivers :)
> > 
> > To implement something more complicated:
> > http://www.mail-archive.com/socketcan-core@lists.berlios.de/msg00269.html
> > 
> 
> 
> Wow - indeed i was not remembering your effort for these CAN transceiver class
> support.
> 
> It looks interesting. Btw. i would name all the transceiver stuff with 'trx'
> instead of 'tr' (see http://www.acronymfinder.com/TRX.html)

How come that I never know such sites :-) ?
I can live with 'trx'.

> and i think there
> are some more modes than
> 
> +
> +/*
> + * CAN transceiver modes
> + */
> +#define CANTR_MODE_OFF 0
> +#define CANTR_MODE_ON  1
> +
> 
> especially for automotive power switching.
Yeah, I started with 2.
Does the framework allows enough expansion?
> 
> Additionally a netlink config interface is preferred these days too.
I think the netlink config may be routed via the netdev?
> 
> Btw. do you plan to pick the trx support up sometime?
That depends. Does it fulfill the needs, without too much overhead?

I've boards running with this, with older kernel, because I'm too lazy
to replace it with something else (simpler).

Kurt
