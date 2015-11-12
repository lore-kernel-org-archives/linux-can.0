From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939: semantics question
Date: Thu, 12 Nov 2015 09:39:45 +0100
Message-ID: <20151112083945.GA30235@airbook.vandijck-laurijssen.be>
References: <20151111195255.GB23275@airbook.vandijck-laurijssen.be>
 <5643A9CA.8060509@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:17654 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbKLIke (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2015 03:40:34 -0500
Content-Disposition: inline
In-Reply-To: <5643A9CA.8060509@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>


> On 11.11.2015 20:52, Kurt Van Dijck wrote:
> 
> >I eventually got into investigating the necessary changes to drop
> >iproute2 from can-j1939.
> >We somewhat agreed that opening a can-j1939 socket and binding
> >to a CAN interface should activate can-j1939 processing for that
> >interface.
> >But how about deactivation?
> >Should the last can-j1939 socket on a CAN iface deactivate can-j1939 for
> >that iface when that socket closes?
> 
> At least this sounds like some kind of natural behaviour.
> 
> What would be the other option?

A special tool, intentionally not called 'ip' :-), that turns off
j1939 processing. Looks bad.

I'll stick to the 'natural behaviour'.

> 
> Would you still monitor address claiming inside the kernel without doing
> anything else?

no. And noone needs it anyway.

> 
> Or is the address claiming in user space the last application that closes
> the last socket anyway??

indeed, address claiming requires an open socket.

Thanks,
Kurt
