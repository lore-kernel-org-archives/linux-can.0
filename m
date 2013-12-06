From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Fri, 6 Dec 2013 09:27:27 +0000 (UTC)
Message-ID: <loom.20131206T100036-664@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56622 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757314Ab3LFJ1w (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Dec 2013 04:27:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VorhN-0003eY-Sx
	for linux-can@vger.kernel.org; Fri, 06 Dec 2013 10:27:49 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 10:27:49 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 10:27:49 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> What do you mean? CAN belongs to the network world. What does the
> following command report:
> 
>  # ip -d -s link show can0

I have now already modified driver, but before it shown the overrun &
arbitration lost errors. Perfect command:)
> 
> > Then each event "arbitration lost" generates an IRQ.
> 
> From a CAN device?

Yes you can see it in a code of driver/net/can/sja1000/sja1000.c,
function:

static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
{ 
   ...
   if (isrc & IRQ_ALI) {
      /* arbitration lost interrupt */
      netdev_dbg(dev, "arbitration lost interrupt\n");
      alc = priv->read_reg(priv, SJA1000_ALC);
      priv->can.can_stats.arbitration_lost++;
      stats->tx_errors++;
      cf->can_id |= CAN_ERR_LOSTARB;
      cf->data[0] = alc & 0x1f;
   }
   ...
}


I've just studied sja1000.c I do not know yet, if it is healthy.
May be something in upper levels will be not anymore well handled. 
I've changed a code in a function (see IRQ_ALI part):

static void set_normal_mode(struct net_device *dev)
{
  ...
               if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
                    priv->write_reg(priv, SJA1000_IER, IRQ_ALL & ~IRQ_ALI);
               else
                    priv->write_reg(priv, SJA1000_IER,
                                    IRQ_ALL & ~(IRQ_BEI | IRQ_ALI));
  ...
}

But I prefare to make some kind of "ioctl" support for that. There are
applications, where it shall not happend. Concurrently I've played with
taskset and priorities. 

$ ps -e -o pid,rtprio,comm | grep "irq/19"
   56     89 irq/19-uhci_hcd
 1877     88 irq/19-can0
 1922     88 irq/19-can1

I do not still understand, what does it mean "irq/19-uhci_hcd". Which is
also active, even I do not have any USB device. Mouse and keyboard are
connected through PS2.

$ lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Now I have NO FAILURE. To make 100% confirmation, I have to improve  tests.
Until now:

$ ip -d -s link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    1874449440 234306180 0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    771292494  107205646 0       0       0       0

$ ip -d -s link show can1
4: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
DEFAULT qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 1000000 sample-point 0.750
    tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    384541802  59160277 0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    77591108   9843156  0       0       0       0


Please keep in mind arbit-lost is now zero forever.

> 
> > Is it OK to disable it, just now for tests. With that I want to reduce an
> > amount of IRQs. Is it possible to disable it without a new compilation of a
> > kernel?
> 
> "ifconfig <device> down" should do the job. You may get in trouble if
> it's your ethernet device, though.
> 

I do not want to disable a can, just an interrupt "arbitration lost" for TX.

> > We are running quite fast, in few ms. So we test your driver quite well:)
> 
> With "-rt" or with vanilla Linux?

3.12.1-custom6-rt4

> Wolfgang.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

What do you think about support for enabling/disabling selected IRQs? Is it
already done?

By

Richard



