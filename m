From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [iproute2 1/2] Update CAN netlink header
Date: Tue, 22 Jul 2014 18:09:44 +0400
Message-ID: <1406038184.9500.2.camel@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
	 <1405935800-26622-2-git-send-email-nebaruzdin@gmail.com>
	 <53CD532F.90905@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:44007 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaGVOJu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 10:09:50 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so5586356lab.1
        for <linux-can@vger.kernel.org>; Tue, 22 Jul 2014 07:09:48 -0700 (PDT)
In-Reply-To: <53CD532F.90905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Mon, 2014-07-21 at 19:51 +0200, Oliver Hartkopp wrote:
> Hello Nikita,
> 
> On 21.07.2014 11:43, Nikita Edward Baruzdin wrote:
> > Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
> > ---
> >  include/linux/can/netlink.h | 12 ++++++++----
> 
> 
> >   * CAN device statistics
> > @@ -122,9 +124,11 @@ enum {
> >  	IFLA_CAN_RESTART_MS,
> >  	IFLA_CAN_RESTART,
> >  	IFLA_CAN_BERR_COUNTER,
> > +	IFLA_CAN_DATA_BITTIMING,
> > +	IFLA_CAN_DATA_BITTIMING_CONST,
> >  	__IFLA_CAN_MAX
> >  };
> 
> This change has already been applied to the iproute2 git repository from
> Stephen Hemminger:
> 
> http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/
> 
> See:
> 
> http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/diff/include/linux/can/netlink.h?id=e4d5edba68970124c5ce245a11a5c5cd4dde9ae1
> 
> The best is, to wait until Stephen has pulled the Linux headers into his tree.
> This will usually happen when the merge window for the Kernel 3.17(!) is
> closed - e.g. in 4-6 weeks from now.
> 
> After the kernel header update in the iproute2 git repository it makes sense
> to post your patch 2/2 as
> 
> 	iproute2: add support for CAN presume-ack feature
> 
> and send this simultaneously on linux-can and linux-netdev ML.
> 
> So let's wait for Stephen updating his iproute2 tree ...
> 
> Thanks,
> Oliver
> 

Got it, I was looking at linux-can/iproute2 tree.

And what about libsocketcan patches?

