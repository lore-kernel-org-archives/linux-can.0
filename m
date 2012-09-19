From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [Socketcan-users] What are you doing if the TX buffer
 overflows?
Date: Wed, 19 Sep 2012 12:26:40 +0200
Message-ID: <20120919102640.GB1612@vandijck-laurijssen.be>
References: <2478881.znSzbTXnK5@uschi>
 <50586DE4.9020707@grandegger.com>
 <50587058.7090703@pengutronix.de>
 <34567791.oZ5dyCnTQA@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:58552 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756136Ab2ISK0r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 06:26:47 -0400
Content-Disposition: inline
In-Reply-To: <34567791.oZ5dyCnTQA@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org, socketcan-users@lists.berlios.de

On Wed, Sep 19, 2012 at 12:02:37PM +0200, Steffen Rose wrote:
> Hallo,

Please use linux-can@vger.kernel.org mailing list :-)

> 
> more a question to this discussion then a meaning:
(small english vocabulary fix: s/meaning/opinion/)
> 
> > >> a) clear the TX-queue in Linux
> [...]
> > Yes, if it's a hardware limitation so be it. But if we design an
> > interface it should support "clear everything" (a+b+c), but also just
> > only c.
> > 
> 
> Example:
>  I use more than one program, e.g.3 to communicate over one interface, 
> e.g.can0.
> 
> Question:
> The TX Queue is interface related, not program related, right?
> 
> This would mean, if my program (one of the 3) clear the TX queue as part of an 
> internal communication reset it would also destroy the messages of the other 
> programs.
> 
> Is this idea right?

Yes, you're right.
That's an aspect of 'multi-user' environment,
with a flexible 'user' interpretation.

Kind regards,
Kurt
