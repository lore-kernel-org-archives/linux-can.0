From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Mon, 10 Mar 2014 13:52:06 +0100
Message-ID: <20140310125206.GC456@vandijck-laurijssen.be>
References: <1394294420.3356.15.camel@NREC-014563>
 <531CBB6F.7090803@pengutronix.de>
 <531D6D3B.9020900@hartkopp.net>
 <20140310104650.GA456@vandijck-laurijssen.be>
 <531DACC5.8090804@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:24310 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbaCJMwL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 08:52:11 -0400
Content-Disposition: inline
In-Reply-To: <531DACC5.8090804@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

On Mon, Mar 10, 2014 at 01:15:01PM +0100, Oliver Hartkopp wrote:
> Hey Kurt!
> 
> On 10.03.2014 11:46, Kurt Van Dijck wrote:
> 
> >> Do you have an idea how to proceed with USB or other devices that bring their
> >> own identification (like a serial number / device id) ??
> >>
> >> E.g. the Softing Card provides some serial number through sysfs:
> >>
> >> http://lxr.free-electrons.com/source/drivers/net/can/softing/softing_main.c#L719
> > 
> > I still think this is the correct way.
> 
> Yes. You are right.
> 
> > udev identifies the device based on anyting device related (serial number, driver, ...)
> > and identifies the channel of the device based on the netdev (now through dev_id).
> > The netdev links to the device, so there is be no problem with identification.
> 
> Looking into your code IMO a similar thing has to be done for the other CAN
> interfaces providing HW/SW versions and unique IDs like e.g. a serial number.

Yes, I think too.
Now that (later this week) the netdev attrs have been integrated in a regular way,
the sysfs code will be much more readable and easier to follow than today.
I had to use special handlings for the 'channel', now dev_id.

> 
> E.g. the PEAK USB adapters or the USB8DEV adapter, etc.
> 
> It already looks pretty good for a general usage.
> 
> Do you know what your attributes "frequency" and "tx_pending" have been used
> for in the softing driver? Are they still needed?

tx_pending can go. I'll address that too later this week.
Frequency is an indication of the embedded cpu's frequency.
It's exported, but with no immediate user.

Kurt

