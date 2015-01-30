From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [jtkirshe-net-next:core-queue 1002/1025]
 drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false
 due to limited range of data type
Date: Fri, 30 Jan 2015 11:26:25 +0000
Message-ID: <20150130112625.25243.36818@shannon>
References: <201501301018.HN7rQ3rB%fengguang.wu@intel.com>
 <54CB3B1F.6010406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0056.outbound.protection.outlook.com ([157.55.234.56]:30720
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761241AbbA3L0g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Jan 2015 06:26:36 -0500
In-Reply-To: <54CB3B1F.6010406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kbuild-all@01.org, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Quoting Marc Kleine-Budde (2015-01-30 08:04:47)
> Ahmed S. Darwish Cc'ed
> 
> On 01/30/2015 03:53 AM, kbuild test robot wrote:
> > tree:   jtkirshe-net-next/core-queue
> > head:   c265eda3429432b5e9e53c8082861ffbd2ffd2c2
> > commit: 96d7f10634e66b27e23854c774fbcc0a2a654e82 [1002/1025] can: kvaser_usb: Consolidate and unify state change handling
> > config: avr32-allyesconfig (attached as .config)
> > reproduce:
> >   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >   chmod +x ~/bin/make.cross
> >   git checkout 96d7f10634e66b27e23854c774fbcc0a2a654e82
> >   # save the attached .config to linux build tree
> >   make.cross ARCH=avr32 
> > 
> > All warnings:
> > 
> >    drivers/net/can/usb/kvaser_usb.c: In function 'kvaser_usb_rx_error_update_can_state':
> >>> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> >>> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always false due to limited range of data type
> > 
> > vim +639 drivers/net/can/usb/kvaser_usb.c
> > 
> >    623                                                         const struct kvaser_usb_error_summary *es,
> >    624                                                         struct can_frame *cf)
> >    625        {
> >    626                struct net_device_stats *stats;
> >    627                enum can_state cur_state, new_state, tx_state, rx_state;
> >    628        
> >    629                netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);
> >    630        
> >    631                stats = &priv->netdev->stats;
> >    632                new_state = cur_state = priv->can.state;
> >    633        
> >    634                if (es->status & (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET))
> >    635                        new_state = CAN_STATE_BUS_OFF;
> >    636                else if (es->status & M16C_STATE_BUS_PASSIVE)
> >    637                        new_state = CAN_STATE_ERROR_PASSIVE;
> >    638                else if (es->status & M16C_STATE_BUS_ERROR) {
> >  > 639                        if ((es->txerr >= 256) || (es->rxerr >= 256))
> >    640                                new_state = CAN_STATE_BUS_OFF;
> >    641                        else if ((es->txerr >= 128) || (es->rxerr >= 128))
> >    642                                new_state = CAN_STATE_ERROR_PASSIVE;
> >    643                        else if ((es->txerr >= 96) || (es->rxerr >= 96))
> >    644                                new_state = CAN_STATE_ERROR_WARNING;
> >    645                        else if (cur_state > CAN_STATE_ERROR_ACTIVE)
> >    646                                new_state = CAN_STATE_ERROR_ACTIVE;
> >    647                }
> > 
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology Center
> > http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> > 
> 

Isn't this redundant anyway? This is always handled by a different interrupt,
right?

In case it isn't you could probably do something like this:
if ((es->txerr >= 128) || (es->rxerr >= 128)) {
        if(cur_state == CAN_STATE_ERROR_PASSIVE)
                new_state = CAN_STATE_BUS_OFF;
        else
                new_state = CAN_STATE_ERROR_PASSIVE;
} else if ((es->txerr >= 96) || (es->rxerr >= 96)) {
        new_state = CAN_STATE_ERROR_WARNING;
} else if (cur_state > CAN_STATE_ERROR_ACTIVE) {
        new_state = CAN_STATE_ERROR_ACTIVE;
}

--
Andri
