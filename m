From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [can-utils] J1939 v6 (#7)
Date: Thu, 1 Oct 2015 01:38:27 +0200
Message-ID: <20150930233827.GA31862@airbook.vandijck-laurijssen.be>
References: <linux-can/can-utils/pull/7@github.com>
 <5608E3EB.5090308@pengutronix.de>
 <20150929121530.GB14618@airbook.vandijck-laurijssen.be>
 <loom.20150930T171203-985@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:61243 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbbI3Xie (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2015 19:38:34 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150930T171203-985@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Aaron Clarke <ac@aaronclarke.com>
Cc: linux-can@vger.kernel.org


--- Original message ---
> Date:	Wed, 30 Sep 2015 15:26:40 +0000 (UTC)
> From: Aaron Clarke <ac@aaronclarke.com>
> To: linux-can@vger.kernel.org
> Subject: Re: [can-utils] J1939 v6 (#7)
> User-Agent: Loom/3.14 (http://gmane.org/)
> 
> Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> 
> 
> > The lack of extensive userbase made all arguments void.
> > In between, the userbase may have grown?
> > Given that the pull request is coming from Mikey, the need is growing
> > and this may be a proper time to decide on this 
> 
> I am working on a j1939 project that could use this and appreciate any
> development.  We need a stable solution as soon as possible.
> 
> > Any decision implies that some porting to 4.2 kernel needs to be done
> > anyway. The latest patches I have for 3.15 are not stable yet. j1939 is
> > stable up to 3.12 only.
> 
> I ported the 3.15 branch to a 4.1 kernel (patched for beaglebone black) but
> it crashes on multi-packet sends.  Is this a know issue with the 3.15
> branch?  In any case, I will try the 3.12 kernel branch instead if that is
> more stable.

The 3.12 branch is stable.

Kind regards,
Kurt
