From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 16:12:30 +0000 (UTC)
Message-ID: <loom.20121115T165949-68@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46432 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768347Ab2KOQMt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Nov 2012 11:12:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZ23i-0000iL-J5
	for linux-can@vger.kernel.org; Thu, 15 Nov 2012 17:12:54 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 17:12:54 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 17:12:54 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

> 
> On 14.11.2012 16:39, Michael Pellegrini wrote:
> 
> > I am trying to use the pch_can driver to interface with a CANopen system.
> > I am encountering a serious issue where, at random intervals, the CAN 
interface
> > will lock up and stop transmitting data.  Data reception continues normally.
> > The only way I've found to resolve the issue so far is to issue an
> > "ifconfig canx down" command followed by an "ifconfig canx up" command.
> > After the interface is reset through these commands, the TX packet dropped 
count
> > and the TX packet carrier count increment by 1.
> > 
> > I am running Ubuntu 12.04 with kernel version 3.2.0-23.
> > 
> > Has anyone else seen this problem or have a fix for it?
> 
> Hello Mike,
> 
> i put the relevant people into CC that probably know better than me.
> 
> Btw. using the pch_can driver:
> 
> 1. Can you please provide the output of 
> 
> 	ip -details link show can0
> 
> (if can0 is your device with the problem)
> at start time and when the problem happened?

At Start Time:

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000

After Problem Happens:

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000

I then reset the interface via "ifconfig can0 down" and "ifconfig can0 up".

Output is:

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    pch_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000

Output of "ifconfig can0" is:

can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-
00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:1085 errors:0 dropped:769 overruns:0 frame:0
          TX packets:2039 errors:0 dropped:1 overruns:0 carrier:1
          collisions:0 txqueuelen:10
          RX bytes:1085 (1.0 KB)  TX bytes:10467 (10.4 KB)
          Interrupt:18

Notice that the "dropped" and "carrier" count incremented by 1.

> 
> 2. Can you send the output of
> 
> 	candump can0,0~0,#FFFFFFFF -e
> 
> from start time until the problem happens?

candump produces no output with the options provided.  As a sanity check, I ran 
candump with the options "can0,0:0,#FFFFFFFF -e" and got all data frames, as
expected.

> 
> 3. It turned out that the pch_can controller is created upon the C_CAN
> CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
> pch_can driver with a PCI-attached C_CAN driver:
> 
> http://thread.gmane.org/gmane.linux.can/815
> 
> I don't know the current state of the tests/replacement.
> 
> But a general C_CAN PCI driver has been contributed by Frederico Vaga which
> became a mainline driver in June
> 
> http://git.kernel.org/?
p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5b92da0443c2585e31b64e86c2e
1b8e22845d4bb
> 
> Don't know if this driver can be used out of the box, when the PCI IDs of the
> PCH_CAN board are added ...
> 
> But maybe the guys in CC know 
> 
> Regards,
> Oliver
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



