From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [jtkirshe-net-next:core-queue 1002/1025]
 drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false
 due to limited range of data type
Date: Wed, 4 Feb 2015 14:48:57 +0200
Message-ID: <20150204124857.GA2968@Darwish.PC>
References: <54CB3B1F.6010406@pengutronix.de>
 <20150201120456.GB27932@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:65388 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbbBDMtD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Feb 2015 07:49:03 -0500
Received: by mail-wi0-f171.google.com with SMTP id l15so31459863wiw.4
        for <linux-can@vger.kernel.org>; Wed, 04 Feb 2015 04:49:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150201120456.GB27932@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andri Yngvason <andri.yngvason@marel.com>

On Sun, Feb 01, 2015 at 07:04:56AM -0500, Ahmed S. Darwish wrote:
> Hi!
> 
> Quoting buildbot:
> 
...
> > >> drivers/net/can/usb/kvaser_usb.c:639: warning:
> > >>         comparison is always false due to limited range of data type
> > >> drivers/net/can/usb/kvaser_usb.c:639: warning:
> > >>         comparison is always false due to limited range of data type
> > 
> 
> Oh, my apologies. I wonder why such warning did not appear on my
> end even though I've compiled and tested the driver tens of times.
> 
> $ gcc --version
>   gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2
> 
> Either because I was using 'make M=drivers/net/can/usb/' all the time
> or there's some compiler flag config I've unchecked...
> 
> > vim +639 drivers/net/can/usb/kvaser_usb.c
> > 
> >  623  const struct kvaser_usb_error_summary *es,
> >  624  struct can_frame *cf)
> >  625  {
> >  626      struct net_device_stats *stats;
> >  627      enum can_state cur_state, new_state, tx_state, rx_state;
> >  628  
> >  629      netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);
> >  630  
> >  631      stats = &priv->netdev->stats;
> >  632      new_state = cur_state = priv->can.state;
> >  633  
> >  634      if (es->status & (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET))
> >  635          new_state = CAN_STATE_BUS_OFF;
> >  636      else if (es->status & M16C_STATE_BUS_PASSIVE)
> >  637          new_state = CAN_STATE_ERROR_PASSIVE;
> >  638      else if (es->status & M16C_STATE_BUS_ERROR) {
> > >639          if ((es->txerr >= 256) || (es->rxerr >= 256))
> >  640              new_state = CAN_STATE_BUS_OFF;
> 
> I'll submit a fix shortly, and see how to cleanly handle the same
> issue in the patches merged in -next
> 

A patch that implicitly fixes this warning, along with other
things, has now been posted to linux-can:

        can: kvaser_usb: Ignore spurious error events after a busoff
	http://article.gmane.org/gmane.linux.can/7587

> >  641          else if ((es->txerr >= 128) || (es->rxerr >= 128))
> >  642              new_state = CAN_STATE_ERROR_PASSIVE;
> >  643          else if ((es->txerr >= 96) || (es->rxerr >= 96))
> >  644              new_state = CAN_STATE_ERROR_WARNING;
> >  645          else if (cur_state > CAN_STATE_ERROR_ACTIVE)
> >  646              new_state = CAN_STATE_ERROR_ACTIVE;
> >  647      }
> 

Regards,
Darwish
