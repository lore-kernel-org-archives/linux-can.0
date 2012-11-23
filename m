From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Fri, 23 Nov 2012 14:27:04 +0000 (UTC)
Message-ID: <loom.20121123T150627-133@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p
   ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305@grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-106@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49550 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab2KWO1W (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Nov 2012 09:27:22 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbuE4-0006rh-5s
	for linux-can@vger.kernel.org; Fri, 23 Nov 2012 15:27:28 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 15:27:28 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 15:27:28 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Pellegrini <mikep86 <at> gmail.com> writes:

> My application has been running strong for about 45 minutes and counting with
> this driver.  I will leave the system running over Thanksgiving as a long-term
> test.

The driver has unfortunately failed the long-term test.  When I checked the
PCH-System this morning, it had hit the transmission problem again.  Dmesg 
output is:

[234700.232657] c_can_isr: irqstatus=0x6
[234700.232712] c_can_isr: irqstatus=0x6
[234700.232765] c_can_isr: irqstatus=0x6
[234700.232818] c_can_isr: irqstatus=0x6
[234700.232873] c_can_isr: irqstatus=0x6
[234700.232928] c_can_isr: irqstatus=0x6
[234700.232985] c_can_isr: irqstatus=0x6
[234700.233041] c_can_isr: irqstatus=0x6
[234700.233096] c_can_isr: irqstatus=0x6
[234700.233151] c_can_isr: irqstatus=0x6
[234700.233203] c_can_isr: irqstatus=0x6
[234700.233257] c_can_isr: irqstatus=0x6
[234700.233312] c_can_isr: irqstatus=0x6
[234700.233369] c_can_isr: irqstatus=0x6
[234700.233424] c_can_isr: irqstatus=0x6
[234700.233478] c_can_isr: irqstatus=0x6

"ip -d -s link show can0" output is:

8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    102603     43967    0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    4487315    1082899  0       0       0       0

I tried sending a message with "cansend can0 123#abcdef" and got the error 
message "write: No buffer space available".

Additionally, data reception is broken.  I can confirm via the CAN Monitor
system that the External Node system is sending messages which the PCH-System
should be receiving.  However, the RX count is not increasing and 
"candump any,0:0,#FFFFFFFF" does not show any messages being transmitted or
received on the interface.

Resetting the interface fixes data transmission and reception.  After the reset,
"ip -d -s link show can0" output is:

8: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    103148     44200    0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    4487318    1082900  0       13      0       0

After the reset, dmesg output is:

[235689.911732] c_can_isr: irqstatus=0x7
[235690.358052] c_can_isr: irqstatus=0x8000
[235690.358111] c_can_isr: irqstatus=0x8
[235690.358282] c_can_isr: irqstatus=0x9
[235690.975410] c_can_isr: irqstatus=0x8000
[235690.975466] c_can_isr: irqstatus=0x1
[235691.420692] c_can_isr: irqstatus=0x8000
[235691.420749] c_can_isr: irqstatus=0x2
[235691.420899] c_can_isr: irqstatus=0x8000
[235691.420937] c_can_isr: irqstatus=0x3
[235692.038095] c_can_isr: irqstatus=0x8000
[235692.038151] c_can_isr: irqstatus=0x4
[235692.483325] c_can_isr: irqstatus=0x8000
[235692.483381] c_can_isr: irqstatus=0x5
[235692.483548] c_can_isr: irqstatus=0x8000
[235692.483587] c_can_isr: irqstatus=0x6
[235693.100729] c_can_isr: irqstatus=0x8000
[235693.100785] c_can_isr: irqstatus=0x7
[235693.545970] c_can_isr: irqstatus=0x8000
[235693.546027] c_can_isr: irqstatus=0x8
[235693.546195] c_can_isr: irqstatus=0x9

- Mike

