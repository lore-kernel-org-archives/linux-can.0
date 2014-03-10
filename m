From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Mon, 10 Mar 2014 11:46:50 +0100
Message-ID: <20140310104650.GA456@vandijck-laurijssen.be>
References: <1394294420.3356.15.camel@NREC-014563>
 <531CBB6F.7090803@pengutronix.de>
 <531D6D3B.9020900@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:43349 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983AbaCJKq4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Mar 2014 06:46:56 -0400
Content-Disposition: inline
In-Reply-To: <531D6D3B.9020900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

Hey Christopher & Oliver,

On Mon, Mar 10, 2014 at 08:43:55AM +0100, Oliver Hartkopp wrote:
> Hello Christopher,
> 
> On 09.03.2014 20:05, Marc Kleine-Budde wrote:
> > On 03/08/2014 05:00 PM, Christopher R. Baker wrote:
> 
> > You are the first one to address this issue. \o/
> 
> I remember we discussed this issue years ago - but it was not really brought
> to an end. So I really appreciate Christophers attempt :-)
> 
> >> udevadm info gives me the KERNELS=... incantation to match the pci bus
> >> address, but there are no other differences in the udev listing for my
> >> various CAN ports (at least for my peak_pci device)
> >>
> >> Digging into the semantics of ATTRS{...}, "dev_id" stood out as having
> >> the intention of discriminating between physical ports

I find this attempt attractive, because it moves multichannel device identification
to generic netdev infrastructure.

The patch obsoletes the 'channel' sysfs property of the softing device driver.
That property did exactly what can now be done with 'dev_id'.
I'll prepare a patch when this gets accepted.
That patch would not only remove 1 property.
The 'channel' property required the attr_group to be present at device creation.
Whithout 'channel', I could use the regular sysfs_create_group which makes
the code even simpler.

[...]
> 
> Ok. That looks reasonable (and therefore the patch fits excellent).
> 
> As you stated above you can identify the card via the PCI bus address too.

I contest this. If 2 CAN ports appear in 1 single PCI device probe,
then they share all PCI attributes, via their 'device' link.
> 
> Do you have an idea how to proceed with USB or other devices that bring their
> own identification (like a serial number / device id) ??
> 
> E.g. the Softing Card provides some serial number through sysfs:
> 
> http://lxr.free-electrons.com/source/drivers/net/can/softing/softing_main.c#L719

I still think this is the correct way.
udev identifies the device based on anyting device related (serial number, driver, ...)
and identifies the channel of the device based on the netdev (now through dev_id).
The netdev links to the device, so there is be no problem with identification.

> 
> and e.g. the PEAK USB have a so called "device number" that is currently just
> printed in kernel log:
> 
> http://lxr.free-electrons.com/source/drivers/net/can/usb/peak_usb/pcan_usb_core.c#L799
> 
> Especially to assign USB devices that can be attached in a wild manner each
> time a good idea would be needed for udev to identify the adapter.
> 
> Do you also have an idea for that? E.g. use the HW MAC address field (we do
> not need for CAN) for this kind of "serial number / device id" ??

Putting somehing else into the MAC address field is not right.
What problem do you try to solve here?

Kind regards,
Kurt Van Dijck
