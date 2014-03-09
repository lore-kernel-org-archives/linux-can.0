From: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Sun, 09 Mar 2014 19:32:18 -0400
Message-ID: <1394407938.2880.4.camel@NREC-014563>
References: <1394294420.3356.15.camel@NREC-014563>
	 <531CBB6F.7090803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from rec.ri.cmu.edu ([128.2.197.155]:54595 "EHLO mail.rec.ri.cmu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbaCIXcU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 9 Mar 2014 19:32:20 -0400
Received: from [192.168.0.19] (c-67-165-49-6.hsd1.pa.comcast.net [67.165.49.6])
	(authenticated bits=0)
	by mail.rec.ri.cmu.edu (8.13.1/8.13.1) with ESMTP id s29NWSX2019259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Sun, 9 Mar 2014 19:32:28 -0400
In-Reply-To: <531CBB6F.7090803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Absolutely, and thanks for the link (without undue noob-roasting ;) )

Signed-off-by: Christopher R. Baker <cbaker@rec.ri.cmu.edu>

-Chris

On Sun, 2014-03-09 at 20:05 +0100, Marc Kleine-Budde wrote:
> On 03/08/2014 05:00 PM, Christopher R. Baker wrote:
> > I'm new to the list, and have poked around on gmane enough to convince
> > myself that this hasn't been covered before, but if I've missed
> > something in this vein, apologies in advance.
> 
> You are the first one to address this issue. \o/
> 
> > My objective is to be able to totally discriminate CAN ports on
> > multi-port cards via udev so as to rename them to semantically
> > interesting/unique names for my system (e.g., "ecuCAN" and "auxCAN"
> > instead of "can0" and "can1").
> >
> > udevadm info gives me the KERNELS=... incantation to match the pci bus
> > address, but there are no other differences in the udev listing for my
> > various CAN ports (at least for my peak_pci device)
> > 
> > Digging into the semantics of ATTRS{...}, "dev_id" stood out as having
> > the intention of discriminating between physical ports that "share the
> > same link layer" (from netdev.h) or "share the same MAC address" (from
> > various other mailing lists).
> > 
> > The following patch assigns the dev_id field to match the channel number
> > on all multi-channel cards I could identify in a fresh git pull under
> > drivers/net/can.  I can only test my two-port Peak PCI card, but it
> > works as expected: ATTRS{dev_id} now expresses the port number and my
> > udev rules now unambiguously pick out and rename my individual CAN
> > ports.
> > 
> > The drivers for other cards I have touched at least compile, but should
> > certainly be tested before deploying this patch.
> 
> Thanks for the patch, looks good. Can I add your Signed-off-by[1]?
> 
> Marc
> 
> [1]
> http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L307


