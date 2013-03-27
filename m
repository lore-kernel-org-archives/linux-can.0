From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: Parsing j1939 from raw candump
Date: Wed, 27 Mar 2013 12:36:31 +0000 (UTC)
Message-ID: <loom.20130327T132424-152@post.gmane.org>
References: <loom.20130325T214842-307@post.gmane.org> <20130326191831.GA22696@vandijck-laurijssen.be> <loom.20130326T221001-133@post.gmane.org> <20130327080926.GA449@vandijck-laurijssen.be> <20130327120438.GD449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42382 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214Ab3C0Mgv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 27 Mar 2013 08:36:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UKpbN-0006h1-3R
	for linux-can@vger.kernel.org; Wed, 27 Mar 2013 13:37:13 +0100
Received: from elgafwout2.elsag.it ([151.89.15.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 13:37:13 +0100
Received: from giovanniparodi79 by elgafwout2.elsag.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 27 Mar 2013 13:37:13 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> > > 
> > > > 
> > > > > Please note that I have the whole j1939 standard and that 
> > > > > at present time I can't integrate the j1939 canutils in linux 
> > > > > kernel because I should use for other kind of constraints 
> > > > > a 2.6 linux kernel.
> > > > 
> > > > which specific 2.6 one did it start from (like 2.6.28 or 2.6.35 or ...)
> > > 
> > > The version is 2.6.35.3
> > I'll take a look if backporting linux-j1939 to 2.6.35 is feasible.
> > Btw, I still run a platform with 2.6.25 _and_ a backported j1939.
> > But 2.6.25 lacks some infrastructure, and I had to come up with less
> > elegant procfs tunables to replace iproute2 commands.
> > The rest of the API (i.e. socket interface) is equal.
> > 
> > I'll take a look...
> 
> Giovanni,
> 
> I've put a branch j1939-v2.6.35 on
> http://gitorious.org/~kurt-vd/linux-can/linux-can-j1939
> 
> You may want to give it a try.
> The iproute2 package does not need backporting AFAIK, i.e. you can use
> the one you like (with j1939 support).
> 
> If this works, it enables you to play with the j1939 stack on your PC also.
>

Thank you for your help.
I will give it a try during the weekend.
I don't know how to thank you. I will try using it and I will let you know.
I hope that Monday I will be able to provide some good news.
Have a nice day and a happy Easter
Giovanni

