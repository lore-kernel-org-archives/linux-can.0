From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Raw CAN socket support in LXC?
Date: Mon, 11 May 2015 13:45:51 +0200
Message-ID: <201505111345.51998.pisa@cmp.felk.cvut.cz>
References: <554C6FDE.6080706@actia.se> <554C79D4.8000901@pengutronix.de> <554C9B67.1030201@actia.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:63319 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbbEKMVC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 May 2015 08:21:02 -0400
In-Reply-To: <554C9B67.1030201@actia.se>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Adam =?utf-8?q?Engstr=C3=B6m?= <adam.engstrom@actia.se>

Hello John,

On Friday 08 of May 2015 13:17:52 John Ernberg wrote:
> Hi
>
> With the experimenting I have been able to do on an Ubuntu 14.04 LTS
> computer, I cannot find any CAN or virtual CAN interfaces inside the
> container.
> When I change the config to specifically forward CAN interfaces, like this:
> lxc.network.type = can
> lxc.network.link = lxcbr0
> lxc.network.flags = up
> lxc.network.hwaddr = 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> I get a series of parsing errors from LXC and the container cannot be
> created.
>
> Creating a privileged container did not change anything.
>
> We will also take the systemd alternative into consideration, but the
> current state is that we'd like to run with LXC, as they provide us with
> more options for future changes to our use-cases.

you cannot use Ethernet bridging. This cannot work.
But you should be able to forward whole interface
to the container

lxc.network.type = phys

I have not tried this for CAN, but it works with Ethernet
and I expect that in this case there is no significant difference
to CAN. But you lose (at least for Ethernet) access to the interface
from the outer system.

If you want to filter frames then you should be able to setup
virtual CAN interface in the outer/host system, then setup CANGW
to route messages in the interrest and the start container
which hides virtual can interface from the outer system
but CANGW setup should continue to work after this move of
interface to other namespace.

I am out of time with teaching now so I do not expect to find
time to test that soon but I hope that hint is in the right
direction. If there is some need to do code adaptations somebody
of my colleagues could have interrest to look at it if we
are sucesfull with gaining one of our partially related grant
or we find other funding.

Best wishes,

               Pavel
