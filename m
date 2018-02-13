From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Framework for hardware filter support?
Date: Tue, 13 Feb 2018 20:42:03 +0100
Message-ID: <20180213194203.GA15640@airbook.vandijck-laurijssen.be>
References: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
 <eabc4877-8f50-7246-32da-1f5bbb2e507e@hartkopp.net>
 <6c112388-5dcb-2dca-06c6-eac56d470fbb@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:56732 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965313AbeBMToC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Feb 2018 14:44:02 -0500
Content-Disposition: inline
In-Reply-To: <6c112388-5dcb-2dca-06c6-eac56d470fbb@pobox.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Santos <daniel.santos@pobox.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can <linux-can@vger.kernel.org>

On zo, 11 feb 2018 16:33:43 -0600, Daniel Santos wrote:
> > where the CAN_RAW filter design would easily fit.
> 
> This is what I mean by a framework.  So the driver should inform the
> core CAN driver what it's filtering capabilities are -- again, I would
> have to study a number of devices to design this sanely.  It would seem
> that iproute2 would be the best userland mechanism to specify them, and
> it could pass an array of struct can_filter objects.  Then based upon
> the hardware, it can apply or reject them.  It would also be nice for
> iproute2 to query the driver and be able to report those capabilities.

I remember this discussion has passed a few times already.
The end result has always been to:
1. give the kernel/driver a list of id/masks.
2. The driver does no aggregation, the root operator should know
   what to do.

Maybe some day this will become limited for hardware that can do special
tricks, like having a random list of identifiers.
This can most probable be addressed in some clever way that is specific
for the driver (like adding a list of id/masks where mask is always
0x7ff for a random canid list).
Due to the driver doing smart things, the driver may not be capable of
informing filtering capabilities in a static way. I would start without
it.

The support of hardware filters is hardware specific anyway, and
intersects the multi-user principle. The only justification is ....
that the root operator knows the hardware and the application.

What matters for a generic implementation is that the API is simple,
clear and usable. That is where the id/mask list pops in.
Operators that don't understand the id/mask list will probably fail
anyway to use hardware filters on CAN. No framework can prevent that.

Kurt
