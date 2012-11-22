From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH v7] can: kvaser_usb: Add support for Kvaser CAN/USB
 devices
Date: Thu, 22 Nov 2012 12:46:39 +0100
Message-ID: <20121122114639.GA21258@hposo>
References: <1353582257-25870-1-git-send-email-mkl@pengutronix.de>
 <50AE06FF.1070403@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62960 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab2KVTNH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:13:07 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so3051747eek.19
        for <linux-can@vger.kernel.org>; Thu, 22 Nov 2012 11:13:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50AE06FF.1070403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Daniel Berglund <db@kvaser.com>

On Thu, Nov 22, 2012 at 12:05:35PM +0100, Marc Kleine-Budde wrote:
> On 11/22/2012 12:04 PM, Marc Kleine-Budde wrote:
> > From: Olivier Sobrie <olivier@sobrie.be>
> > 
> > This driver provides support for several Kvaser CAN/USB devices.
> > Such kind of devices supports up to three CAN network interfaces.
> > 
> > It has been tested with a Kvaser USB Leaf Light (one network interface)
> > connected to a pch_can interface.
> > The firmware version of the Kvaser device was 2.5.205.
> > 
> > List of Kvaser devices supported by the driver:
> >   - Kvaser Leaf Light
> >   - Kvaser Leaf Professional HS
> >   - Kvaser Leaf SemiPro HS
> >   - Kvaser Leaf Professional LS
> >   - Kvaser Leaf Professional SWC
> >   - Kvaser Leaf Professional LIN
> >   - Kvaser Leaf SemiPro LS
> >   - Kvaser Leaf SemiPro SWC
> >   - Kvaser Memorator II HS/HS
> >   - Kvaser USBcan Professional HS/HS
> >   - Kvaser Leaf Light GI
> >   - Kvaser Leaf Professional HS (OBD-II connector)
> >   - Kvaser Memorator Professional HS/LS
> >   - Kvaser Leaf Light "China"
> >   - Kvaser BlackBird SemiPro
> >   - Kvaser USBcan R
> > 
> > Signed-off-by: Daniel Berglund <db@kvaser.com>
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Changes since v6:
> > - added 'const' to kvaser_usb_table and kvaser_usb_bittiming_const
> 
> Olivier, I'm applying this patch to linux-can/next, if you don't have
> any objections.

I don't see any problem :-)
Thanks a lot for the support!

Olivier

> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



