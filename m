From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [jtkirshe-net-next:core-queue 1002/1025]
 drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false
 due to limited range of data type
Date: Sun, 1 Feb 2015 07:04:56 -0500
Message-ID: <20150201120456.GB27932@linux>
References: <54CB3B1F.6010406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:43733 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbBAMFA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Feb 2015 07:05:00 -0500
Received: by mail-we0-f170.google.com with SMTP id w55so28979875wes.1
        for <linux-can@vger.kernel.org>; Sun, 01 Feb 2015 04:04:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54CB3B1F.6010406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi!

Quoting buildbot:

> tree:   jtkirshe-net-next/core-queue
> head:   c265eda3429432b5e9e53c8082861ffbd2ffd2c2
> commit: 96d7f10634e66b27e23854c774fbcc0a2a654e82 [1002/1025] can: kvaser_usb: Consolidate and unify state change handling
> config: avr32-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 96d7f10634e66b27e23854c774fbcc0a2a654e82
>   # save the attached .config to linux build tree
>   make.cross ARCH=avr32 
> 
> All warnings:
> 
>    drivers/net/can/usb/kvaser_usb.c: In function 'kvaser_usb_rx_error_update_can_state':
> >> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> >> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> 

Oh, my apologies. I wonder why such warning did not appear on my
end even though I've compiled and tested the driver tens of times.

$ gcc --version
  gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2

Either because I was using 'make M=drivers/net/can/usb/' all the time
or there's some compiler flag config I've unchecked...

> vim +639 drivers/net/can/usb/kvaser_usb.c
> 
>    623    const struct kvaser_usb_error_summary *es,
>    624    struct can_frame *cf)
>    625    {
>    626        struct net_device_stats *stats;
>    627        enum can_state cur_state, new_state, tx_state, rx_state;
>    628    
>    629        netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);
>    630    
>    631        stats = &priv->netdev->stats;
>    632        new_state = cur_state = priv->can.state;
>    633    
>    634        if (es->status & (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET))
>    635            new_state = CAN_STATE_BUS_OFF;
>    636        else if (es->status & M16C_STATE_BUS_PASSIVE)
>    637            new_state = CAN_STATE_ERROR_PASSIVE;
>    638        else if (es->status & M16C_STATE_BUS_ERROR) {
>  > 639            if ((es->txerr >= 256) || (es->rxerr >= 256))
>    640                new_state = CAN_STATE_BUS_OFF;

I'll submit a fix shortly, and see how to cleanly handle the same
issue in the patches merged in -next

>    641            else if ((es->txerr >= 128) || (es->rxerr >= 128))
>    642                new_state = CAN_STATE_ERROR_PASSIVE;
>    643            else if ((es->txerr >= 96) || (es->rxerr >= 96))
>    644                new_state = CAN_STATE_ERROR_WARNING;
>    645            else if (cur_state > CAN_STATE_ERROR_ACTIVE)
>    646                new_state = CAN_STATE_ERROR_ACTIVE;
>    647        }

Thanks,
Darwish
