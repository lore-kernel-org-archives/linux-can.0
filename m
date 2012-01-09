From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Changing addr with bind()
Date: Mon, 9 Jan 2012 11:23:08 +0100
Message-ID: <20120109102308.GD386@e-circ.dyndns.org>
References: <20120104094715.GB320@e-circ.dyndns.org>
 <loom.20120104T160223-182@post.gmane.org>
 <20120104204151.GA306@e-circ.dyndns.org>
 <loom.20120105T113439-912@post.gmane.org>
 <20120105120930.GA372@e-circ.dyndns.org>
 <loom.20120105T215714-788@post.gmane.org>
 <20120106122550.GA17043@e-circ.dyndns.org>
 <loom.20120106T190304-160@post.gmane.org>
 <20120109093318.GB386@e-circ.dyndns.org>
 <20120109100210.GC386@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:29629 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab2AIKXN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jan 2012 05:23:13 -0500
Content-Disposition: inline
In-Reply-To: <20120109100210.GC386@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>, linux-can@vger.kernel.org

On Mon, Jan 09, 2012 at 11:02:10AM +0100, Kurt Van Dijck wrote:
> On Mon, Jan 09, 2012 at 10:33:18AM +0100, Kurt Van Dijck wrote:
> > On Fri, Jan 06, 2012 at 06:25:59PM +0000, Wolfgang wrote:
> > > 
> > > Now I have a different question, is it possible to bind different sockets with
> > > different src.addr to one interface.
> > of course, yes.
> > > Because it is saying 'bind failed: Device 
> > > or resource busy' if I want to do this ('$ip addr add j1939 0x01 dev can0' is 
> > > working, of course)
> > It should work. Since '$ ip addr add ...' worked, there must be something in the code.
> > I look in the code for this. Did I understand well that only the first bind() succeeds?
> 
> Stop searching. It's explicitely disabled in can-j1939 kernel code, and I remember
> it was not easy to fix in the first versions, but things have changed since.
> I'll try to make a fix...
I pushed 2 commits to can-j1939-modules repository. You may want to upgrade your sources.
Please note I had no time to test these.

Kurt
