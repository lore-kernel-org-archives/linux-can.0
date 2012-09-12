From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH v3] can: rename LED trigger name on netdev renames
Date: Wed, 12 Sep 2012 09:22:19 +0200
Message-ID: <20120912072219.GA518@vandijck-laurijssen.be>
References: <20120907071934.GB37685@macbook.local>
 <1347207464-2002-1-git-send-email-fabio.baltieri@gmail.com>
 <20120910142827.GB11000@vandijck-laurijssen.be>
 <504E30AE.50201@hartkopp.net>
 <20120910184049.GD2006@gmail.com>
 <504E3901.10901@hartkopp.net>
 <20120910200844.GC546@vandijck-laurijssen.be>
 <504ECF3B.1090709@hartkopp.net>
 <20120911071314.GA4766@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx01.eia.be ([195.130.156.18]:17222 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2ILHWX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 12 Sep 2012 03:22:23 -0400
Content-Disposition: inline
In-Reply-To: <20120911071314.GA4766@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org

On Tue, Sep 11, 2012 at 09:13:14AM +0200, Fabio Baltieri wrote:
> Hi Oliver,
> 
> On Tue, Sep 11, 2012 at 07:42:19AM +0200, Oliver Hartkopp wrote:
> > On 10.09.2012 22:08, Kurt Van Dijck wrote:
> > > But the initial name must have been set properly already in that case...
> > 
> > Yes it is.
> > 
> > See register_netdevice()
> > 
> > http://lxr.linux.no/#linux+v3.5.3/net/core/dev.c#L5453
> > 
> > 
> > at the end NETDEV_REGISTER is notified:
> > 
> > http://lxr.linux.no/#linux+v3.5.3/net/core/dev.c#L5552
> > 
> > So it would be pretty elegant to create the LED trigger name in the notifier.
> > This would allow to remove that code at the current init function too.
> 
> That would indeed be elegant, but in the current implementation
> triggers only works for supported drivers, while putting registration in
> the notifier would imply to use it also in unsupported ones, where you
> would get a trigger which never triggers.

I note here another problem: any candev rename causes the notifier to
rename its led triggers, but some have it never registered.

Oliver, your approach is the better. It took a bit for me to see ...
but this requires a bit of reverting in the drivers.

Kind regards,
Kurt
