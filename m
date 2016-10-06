From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 13:32:44 +0200
Message-ID: <20161006113244.GD26915@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
 <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
 <9472847f-aa01-f4b0-f2cc-968a04c6ce06@pengutronix.de>
 <20161006102643.GB26915@airbook.vandijck-laurijssen.be>
 <7a910650-0d91-e98c-8694-2d8b32ae68a7@pengutronix.de>
 <20161006111347.GC26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:44188 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbcJFLdp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 07:33:45 -0400
Content-Disposition: inline
In-Reply-To: <20161006111347.GC26915@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

> > >>>
> > >>> 1) I'll try to move module parameters to /proc/sys/net/can-j1939/ items.
> > > 
> > > I'm done.
> > > I fixed the Makefile so it can compile can-j1939 as module again :-)
> > > I changed the defaults to strict j1939 compliant (way-to-large max
> > > 	packet size, padding).
> > > And I migrated the module parameters to /proc/sys/net/can-j1939.
> > > I loaded the module, and verified /proc, without any real wire tests.
> > > 
> > > So you need to cherry-pick another 3 commits.
> > 
> > Tnx. Does it compile with disabled PROC support?
> 
> Yes, it just compiled (the module), not sure how it reacts when actually
> used like that.
> I just think I forgot to add descriptions in Documentation/sysctl.

I added yet another commit, that add documentation of the new sysctl's.

Kurt

