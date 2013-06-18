From: "Max S." <max@schneidersoft.net>
Subject: Re: PCAN drivers?
Date: Tue, 18 Jun 2013 04:42:57 +0000
Message-ID: <1371530577.24999.7.camel@blackbox>
References: <51BF1C74.5030506@mlbassoc.com>
	 <51BF1FDF.2060003@pengutronix.de> <51BF211D.7030404@mlbassoc.com>
	 <51BF21EB.9080402@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:47703 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3FREfu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 00:35:50 -0400
In-Reply-To: <51BF21EB.9080402@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Gary Thomas <gary@mlbassoc.com>, linux-can@vger.kernel.org

I use the PCAN usb device.

On old systems < 3.4 I compile the source from peak systems.

On newer systems it is plug and play. If you used peak 'years ago' you
probably used the chardev driver. You can still use this driver if you
have software that requires it, but you will need compile the source
with special -no-netdev switch, better to port your code and embrace the
upstream driver :). The buildfiles contain a nice list of switches you
can use.

Max Schnedier

On Mon, 2013-06-17 at 16:49 +0200, Marc Kleine-Budde wrote:
> On 06/17/2013 04:45 PM, Gary Thomas wrote:
> > On 2013-06-17 15:40, Marc Kleine-Budde wrote:
> >> On 06/17/2013 04:25 PM, Gary Thomas wrote:
> >>> What's the best driver for the Peak PCAN PCI board?
> >>>    PEAK-System Technik GmbH PCAN-PCI CAN-Bus controller
> >>> I'm interested in linux-3.5.2 on Fedora 17
> >>
> >> The PEAK PCI  should work out-of-the box with kernel version v3.2. The
> >> PCI Express Cards shoud work with v3.4.
> > 
> > Thanks.  What driver module do I need for this (none seem to come
> > packaged with the Fedora kernel)?
> 
> It should be loaded automatically, it's called peak_pci.ko
> 
> > What about the CAN utils (cansend, candump, etc)?
> > 
> > Sorry for the barrage of questions; I used this stuff years ago
> > and time seems to have marched on whilst I had to do other things...
> 
> compile yourself:
> 
>     https://gitorious.org/linux-can/can-utils
> 
> Marc
> 


