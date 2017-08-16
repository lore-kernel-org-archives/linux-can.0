From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: bind() and connect()
Date: Wed, 16 Aug 2017 11:34:54 +0200
Message-ID: <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:54867 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdHPJgn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 05:36:43 -0400
Content-Disposition: inline
In-Reply-To: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

> Hello Kurt,
> 
> I've a few questions about the j1939 socket model:
> 
> - Should bind() be allowed to any interface, i.e. with can_ifindex == 0?
> 
> I don't think so, but it's never checked for this.

I'll explain a bit what I tried to accomplish:
* allow bind to any interface, for receive packets only (obviously)
* for rx/tx, only bind to 1 interface.

> 
> - Should a connect() without a previous bind() be allowed?
> 
> It's not checked for, but the error handling in sk_connect doesn't take
> that into account.

Like UDP will auto-bind to the first known local address ...
Then an application would not need to know the local address to use.

> 
> - Should a second bind() be allowed on a previously bind() socket?

Yes, definitely.
This is required to support dynamic addressing without possible losing
relevant messages.

> 
> As far as I understand the code, there's some support, but when the
> interface is switched, j1939_ifindex_stop() is not called.
> 
> - Should a second conect() be allowed on a previously connect() socket?

Never thought on that. This would equally be necessary when the remote
changes SA, but I consider this not a core requirement, since changing
SA implies possible glitches in the upper applications anyway.
closing socket and reopening a new one is allowed in that case.
> 
> Again some code, but AFAICS no real support.
> 
> regards,
> Marc

Kurt
