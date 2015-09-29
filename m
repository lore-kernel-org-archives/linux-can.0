From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [can-utils] J1939 v6 (#7)
Date: Tue, 29 Sep 2015 14:15:30 +0200
Message-ID: <20150929121530.GB14618@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7@github.com>
 <5608E3EB.5090308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:22116 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbI2MPn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 08:15:43 -0400
Content-Disposition: inline
In-Reply-To: <5608E3EB.5090308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: reply+001c342fd7b1455c991eb49342cd421d7317d7ea6ef9754c92cf00000001121c121c92a169ce0672fa57@reply.github.com, linux-can <linux-can@vger.kernel.org>

> Hello Mikey and Kurt,
> 
> On 09/24/2015 09:33 PM, mikey32905 wrote:
> >         You can view, comment on, or merge this pull request online at:
> > 
> >   https://github.com/linux-can/can-utils/pull/7
> > 
> > 
> >         Commit Summary
> > 
> >   * can-j1939: add libj1939.a
> >   * can-j1939: add jspy 'sniffer' program
> >   * can-j1939: add jsr program
> >   * can-j1939: update headers with j1939
> >   * can-j1939: add jacd address claim daemon
> 
> Kurt, I got this pull request of the j1939 tools from Mikey. What's the
> status of the j1939, can we add it to the can-utils? Is the userspace
> API stable?

Cool!

The userspace API/ABI is IMO stable. I had a lot of feedback from Oliver
on this, and I stripped everything I could.
The semantics underneath (in kernel space) are almost stable.

The biggest thing is that the struct sockaddr_can is enlarged by j1939,
and this got never accepted.
The current kernel patches do change the other CAN sockets' behaviour to
test not on exact size of the 'struct sockaddr', but to test a 'minimal
required size'.

The lack of extensive userbase made all arguments void.
In between, the userbase may have grown?
Given that the pull request is coming from Mikey, the need is growing
and this may be a proper time to decide on this :-)

Any decision implies that some porting to 4.2 kernel needs to be done
anyway. The latest patches I have for 3.15 are not stable yet. j1939 is
stable up to 3.12 only.

Kurt

> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


