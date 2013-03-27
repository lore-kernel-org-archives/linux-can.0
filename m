From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Parsing j1939 from raw candump
Date: Wed, 27 Mar 2013 13:04:38 +0100
Message-ID: <20130327120438.GD449@vandijck-laurijssen.be>
References: <loom.20130325T214842-307@post.gmane.org>
 <20130326191831.GA22696@vandijck-laurijssen.be>
 <loom.20130326T221001-133@post.gmane.org>
 <20130327080926.GA449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from Mailrelay020.isp.belgacom.be ([195.238.6.95]:1869 "EHLO
	mailrelay020.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab3C0MEn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Mar 2013 08:04:43 -0400
Content-Disposition: inline
In-Reply-To: <20130327080926.GA449@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Giox79 <giovanniparodi79@gmail.com>, linux-can@vger.kernel.org

> > 
> > > 
> > > > Please note that I have the whole j1939 standard and that 
> > > > at present time I can't integrate the j1939 canutils in linux 
> > > > kernel because I should use for other kind of constraints 
> > > > a 2.6 linux kernel.
> > > 
> > > which specific 2.6 one did it start from (like 2.6.28 or 2.6.35 or ...)
> > 
> > The version is 2.6.35.3
> I'll take a look if backporting linux-j1939 to 2.6.35 is feasible.
> Btw, I still run a platform with 2.6.25 _and_ a backported j1939.
> But 2.6.25 lacks some infrastructure, and I had to come up with less
> elegant procfs tunables to replace iproute2 commands.
> The rest of the API (i.e. socket interface) is equal.
> 
> I'll take a look...

Giovanni,

I've put a branch j1939-v2.6.35 on
http://gitorious.org/~kurt-vd/linux-can/linux-can-j1939

I cherry-picked some commits between v2.6.35 & v2.6.38 in order
to enable the necessary rtnetlink infrastructure.
It is compile-tested, but I'm unable to test it on hardware easily.
I'm booting via EFI now and that support is very recent...

You may want to give it a try.
The iproute2 package does not need backporting AFAIK, i.e. you can use
the one you like (with j1939 support).

If this works, it enables you to play with the j1939 stack on your PC also.

Kind regards,
Kurt
