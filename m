From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH v3] can: kvaser_usb: handle rx msg correctly
Date: Wed, 15 May 2013 13:50:25 +0200
Message-ID: <20130515114907.GA17776@hposo>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <20130430214044.GA22921@thinkoso.home>
 <51824189.8090402@pengutronix.de>
 <20130502180610.GA14242@thinkoso.home>
 <20130502185710.GA1041@thinkoso.home>
 <518388AD.3050902@pengutronix.de>
 <20130507200523.GA2514@thinkoso.home>
 <51935DEB.8080805@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:45943 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3EOLue (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 07:50:34 -0400
Received: by mail-ea0-f169.google.com with SMTP id m14so1012554eaj.28
        for <linux-can@vger.kernel.org>; Wed, 15 May 2013 04:50:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51935DEB.8080805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

Hi Marc,

On Wed, May 15, 2013 at 12:05:31PM +0200, Marc Kleine-Budde wrote:
> On 05/07/2013 10:05 PM, Olivier Sobrie wrote:
> > From: Jonas Peterson <jonas.peterson@gmail.com>
> > 
> > Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBcan
> > Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
> > patch adds support for it.
> > 
> > Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> > ---
> > v3:
> >  - add KVASER_EXTENDED_FRAME define
> >  - call kvaser_usb_rx_error() in kvaser_usb_rx_can_msg when the frame is
> >    a CMD_LOG_MESSAGE and flag MSG_FLAG_ERROR_FRAME is set.
> > 
> > By reading the patch again I saw that I mixed up kvaser_usb_rx_can_msg and
>                                                                      ^^^
> 
> Do you want to merge kvaser_usb_rx_can_msg() or kvaser_usb_rx_can_err()?

No, grrr I mixed up kvaser_usb_rx_can_msg and kvaser_usb_rx_can_err in my
comment. I meant kvaser_usb_rx_can_err() and kvaser_usb_rx_error().

> 
> > kvaser_usb_rx_error when I cleaned the patch... If fixed that in this
> > version.
> > I should maybe merge these two functions to avoid confusion...
> 
> If you want to merge kvaser_usb_rx_can_err() and kvaser_usb_rx_error()
> it would make sense, to have the error handling functionality in one
> function. I haven't looked at the code, though.

Yes that's what I'll maybe do, merging the two error functions in one.
I'll look at this more deeply when I've a more time.

> 
> However, this would be a separate patch. I'm applying this patch as it
> is to can/master with linux-stable on Cc.

Ok fine for me.

Thanks,

-- 
Olivier
