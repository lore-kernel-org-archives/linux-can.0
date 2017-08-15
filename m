From: David Jander <david@protonic.nl>
Subject: Re: j1939: bind() and connect()
Date: Tue, 15 Aug 2017 11:01:16 +0200
Message-ID: <20170815110116.4d12f4f3@erd980>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
        <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:24388 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdHOJ3Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Aug 2017 05:29:16 -0400
In-Reply-To: <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can <linux-can@vger.kernel.org>

On Tue, 15 Aug 2017 10:14:18 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 08/14/2017 07:37 PM, Marc Kleine-Budde wrote:
> > - Should a second bind() be allowed on a previously bind() socket?
> > 
> > As far as I understand the code, there's some support, but when the
> > interface is switched, j1939_ifindex_stop() is not called.  
> 
> Ah, there's a check, that you cannot re-bind() to another interface:
> 
> > 		if (bound_dev_if != addr->can_ifindex)  

This makes sense. re-bind() to another interface only would make sense if
bind() to any interface is also permitted, but that would imply separate
address-claims on all different interfaces with potentially different
source-address being claimed on each one.... don't think the stack should take
care of such complex scenarios, at least not at first IMHO.

Best regards,

-- 
David Jander
Protonic Holland.
