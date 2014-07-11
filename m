From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: Re: [PATCH 3/4] can: netlink: Add CAN_CTRLMODE_PRESUME_ACK flag
Date: Fri, 11 Jul 2014 18:42:37 +0400
Message-ID: <1405089757.7790.1.camel@thinkpad>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
	 <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com>
	 <53BE9DF7.6020608@hartkopp.net> <53BE9F35.9060509@pengutronix.de>
	 <53BFE42D.20700@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47860 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaGKOmq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 10:42:46 -0400
Received: by mail-lb0-f173.google.com with SMTP id v6so709527lbi.4
        for <linux-can@vger.kernel.org>; Fri, 11 Jul 2014 07:42:44 -0700 (PDT)
In-Reply-To: <53BFE42D.20700@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, linux-can@vger.kernel.org

I actually think the word "PRESUME" is good enough. We could also use
"NOT_REQUIRE" instead: it's a bit more explicit, but a bit longer.
At least I couldn't think of anything better.

"NOT_WAIT" doesn't reflect the behaviour precisely in my view.
I also believe that the word "IGNORE" is better when it comes to some
"active" message (that supposes some reaction), like "IGNORE_ERRORS" or
"IGNORE_SERVICE_REQUEST". And ACK is more of a reply than a request for
action.

On Fri, 2014-07-11 at 09:18 -0400, Oliver Hartkopp wrote:
> I tried to find a short name for:
> 
> - do not wait for ack
> - ignore missing ack
> - broadcast that doesn't require an ack
> - ...
> 
> I'm really open for an alternative ;-)
> 
> On 10.07.2014 10:12, Marc Kleine-Budde wrote:
> > On 07/10/2014 04:06 PM, Oliver Hartkopp wrote:
> >> what do you think about this extension.
> >>
> >>  From my side the patchset makes sense.
> >>> +#define CAN_CTRLMODE_PRESUME_ACK    0x40    /* Ignore missing CAN
> >>> ACKs */
> >
> > Is this a good name? Does anyone come up with an alternative/better one?
> >
> > Marc
> >


