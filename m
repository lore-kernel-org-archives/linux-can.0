From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [jtkirshe-net-next:core-queue 1002/1025]
 drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false
 due to limited range of data type
Date: Sun, 1 Feb 2015 08:00:25 -0500
Message-ID: <20150201130025.GC27932@linux>
References: <20150130112625.25243.36818@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:39628 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbbBANA3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Feb 2015 08:00:29 -0500
Received: by mail-wg0-f50.google.com with SMTP id b13so34171566wgh.9
        for <linux-can@vger.kernel.org>; Sun, 01 Feb 2015 05:00:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150130112625.25243.36818@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi!

Andri wrote:
> >    drivers/net/can/usb/kvaser_usb.c: In function 'kvaser_usb_rx_error_update_can_state':
> > >> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> > >> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> > 
> > vim +639 drivers/net/can/usb/kvaser_usb.c
> > 
> >    623    const struct kvaser_usb_error_summary *es,
> >    624    struct can_frame *cf)
> >    625    {
> >    626        struct net_device_stats *stats;
> >    627        enum can_state cur_state, new_state, tx_state, rx_state;
> >    628    
> >    629        netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);
> >    630    
> >    631        stats = &priv->netdev->stats;
> >    632        new_state = cur_state = priv->can.state;
> >    633    
> >    634        if (es->status & (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET))
> >    635            new_state = CAN_STATE_BUS_OFF;
> >    636        else if (es->status & M16C_STATE_BUS_PASSIVE)
> >    637            new_state = CAN_STATE_ERROR_PASSIVE;
> >    638        else if (es->status & M16C_STATE_BUS_ERROR) {
> >  > 639            if ((es->txerr >= 256) || (es->rxerr >= 256))
> >    640                new_state = CAN_STATE_BUS_OFF;
> >    641            else if ((es->txerr >= 128) || (es->rxerr >= 128))
> >    642                new_state = CAN_STATE_ERROR_PASSIVE;
> >    643            else if ((es->txerr >= 96) || (es->rxerr >= 96))
> >    644                new_state = CAN_STATE_ERROR_WARNING;
> >    645            else if (cur_state > CAN_STATE_ERROR_ACTIVE)
> >    646                new_state = CAN_STATE_ERROR_ACTIVE;
> >    647        }
> > 
>
> Isn't this redundant anyway? This is always handled by a different
> interrupt, right?
> 

The BUS_ERROR check might have been a bit pedantic indeed, but
I've faced a number of cases where the firmware reported error
counters > 128 without having any M16C_STATE_BUS_PASSIVE flags
checked either in the status flag of the current message or any
previous messages.

That's why I've added such elaborate checks.

But since on bus error, good state was always reported and the
driver did indeed transition to bus error state as expected,
and since also the checks the compiler warns about doesn't work
anyway, I'll just remove the two lines:

 639            if ((es->txerr >= 256) || (es->rxerr >= 256))
 640                new_state = CAN_STATE_BUS_OFF;

And test the state changes again.

> In case it isn't you could probably do something like this:
> if ((es->txerr >= 128) || (es->rxerr >= 128)) {
>         if(cur_state == CAN_STATE_ERROR_PASSIVE)
>                 new_state = CAN_STATE_BUS_OFF;
>         else
>                 new_state = CAN_STATE_ERROR_PASSIVE;

That unfortunately won't work. As can be seen by candump traces
I've sent on submission v6 here:

	http://article.gmane.org/gmane.linux.can/7485

The firmware can report error counters, in an increasing fashion
but in the same state range several times. So unless I'm missing
something, I'll just remove the useless checks and see what
happens.

> } else if ((es->txerr >= 96) || (es->rxerr >= 96)) {
>         new_state = CAN_STATE_ERROR_WARNING;
> } else if (cur_state > CAN_STATE_ERROR_ACTIVE) {
>         new_state = CAN_STATE_ERROR_ACTIVE;
> }
> 

Thanks,
Darwish
