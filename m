From: Jason White <white_jason_r1@cat.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Mon, 27 Jan 2014 20:47:18 +0000 (UTC)
Message-ID: <loom.20140127T210023-257@post.gmane.org>
References: <1838723.N2loBrR0E2@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52255 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbaA0Urn (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 27 Jan 2014 15:47:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1W7t5p-0005GA-Jk
	for linux-can@vger.kernel.org; Mon, 27 Jan 2014 21:47:41 +0100
Received: from 192.189.128.15 ([192.189.128.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 27 Jan 2014 21:47:41 +0100
Received: from white_jason_r1 by 192.189.128.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 27 Jan 2014 21:47:41 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Alexander Stein <alexander.stein <at> systec-electronic.com> writes:

> 
> Sorry for "new" thread, I don't have the old messages for reply
> 
> Jason White wrote:
> > Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:
> > > > Officially the TX-timeout has been removed as the controller just 
sends
> > > > out
> > > > the CAN frames, when it comes back to life ...
> > > > 
> > > > The question is, if the controller gets into the BUS_OFF state and 
if
> > > > the
> > > > restart-ms option (see ip tool) would help here.
> > > 
> > > FYI:
> > > A CAN chip that sits alone on a proper bus, trying to transmit a 
frame,
> > > will never go into BUS_OFF. It can only go in BUS_OFF when a bad 
network
> > > is encountered, i.e. the chip does not see it's TX activity on its RX.
> > > 
> > > I think this scenario (chip alone, going in BUS_OFF) is no different
> > > than regular BUS_OFF, and should be treated likewise.
> > 
> > This sounds like something I would be interested in.  Just a couple of
> > questions.  What do you mean TX-timeout has been removed?  Also does
> > it work in error passive state (scenario where the ECU is alone on
> > the bus - no ack from another ECU).  Does it just reset the CAN
> > hardware or does the queues get flushed as well?
> 
> Is there any progress on this topic? I would be particilar interested in 
clearing the socket queue,
> especially in case a BUS-OFF happens or when no device is on the bus (no 
ACK).
> 
> Best regards,
> Alexander
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

I never saw a response to Alexandar's question and got side tracked myself, 
so assume there has not been any further development when the device goes 
error-passive.  I believe there is a command to reset the device when it 
goes to bus-off (IFLA_CAN_RESTART manually and can_bus_off()).

The general consensus I've seen is to bring the device interface down and 
then up to flush the tx queue.  We have been doing that, but this has 
recently come up again because of the overhead of making system calls from a 
C application especially when the timeout to flush is relatively fast.

Looking more at the logic within IFLA_CAN_RESTART and the can_bus_off() 
function, I don't see why this couldn't be extended to error-passive state.  
I'm not totally certain what netif_carrier_off() does (hoping it would flush 
tx queues), but its for when a link state goes down, which is what happens 
with error-passive (missing ack frames with no other nodes on the CAN bus).  
Could a can_error_passive() function be created that acted similar to 
can_bus_off() and called from each specific driver when that state is 
encountered?  The other option is to extend IFLA_CAN_RESTART so that it 
allowed to be called in the error-passive state (or whenever) instead of 
just bus-off.

Thoughts?

Thanks,
Jason




