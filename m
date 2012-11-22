From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [can:for-davem 2/3] drivers/net/can/usb/kvaser_usb.c:431
 kvaser_usb_send_simple_msg() error: doing dma on the stack ((null))
Date: Fri, 23 Nov 2012 00:29:19 +0800
Message-ID: <20121122162919.GA13425@localhost>
References: <50ae18f9.g1Qzcmfv5xzx4tke%fengguang.wu@intel.com>
 <50AE231A.2040306@pengutronix.de>
 <20121122144648.GA11612@hposo>
 <50AE49D2.4080709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11406 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977Ab2KVSyS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Nov 2012 13:54:18 -0500
Content-Disposition: inline
In-Reply-To: <50AE49D2.4080709@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Olivier Sobrie <olivier@sobrie.be>, linux-can@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Nov 22, 2012 at 04:50:42PM +0100, Marc Kleine-Budde wrote:
> On 11/22/2012 03:46 PM, Olivier Sobrie wrote:
> > Hi Marc,
> > 
> > Argh.
> > 
> > On Thu, Nov 22, 2012 at 02:05:30PM +0100, Marc Kleine-Budde wrote:
> >> Hello Olivier,
> >>
> >> can you please ask on the usb mailinglist how to fix this problem (given
> >> this isn't a false positive)
> > 
> > Ok I'll ask. By googling I found this which looks to be a similar problem
> > fixed in another driver.
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=32ec4576c3fb37316b1d11a04b220527822f3f0d
> > 
> > I assume I've to kmalloc the kvaser_msg I send through
> > kvaser_usb_send_msg(). I'll ask to people of linux-usb to be sure.
> > 
> > By the way I installed smatch (which I never used) and ran the command
> >  make CHECK="~/bin/smatch -p=kernel" C=1"
> > in my kernel dir but I didn't get the error:
> >   CHECK   drivers/net/can/usb/kvaser_usb.c
> >   CC [M]  drivers/net/can/usb/kvaser_usb.o
> > 
> > Do I've to give a specific option to smatch to get this error?
> 
> I've not used smack either. Maybe Wu can give us some hints and/or links.

It should be due to the build system will rebuild smatch db before
running smatch, while you are running smatch with its default smatch
db which is not aware of (in smatch_data/kernel.dma_funcs) the newly
added kvaser_usb_send_msg().

Thanks,
Fengguang
