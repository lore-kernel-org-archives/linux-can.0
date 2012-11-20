From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Tue, 20 Nov 2012 19:12:26 +0000 (UTC)
Message-ID: <loom.20121120T192159-770@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44788 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab2KTTMk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Nov 2012 14:12:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TatFY-0002A4-Fb
	for linux-can@vger.kernel.org; Tue, 20 Nov 2012 20:12:48 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Nov 2012 20:12:48 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Nov 2012 20:12:48 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> > 
> > However, everything isn't fixed yet.  After sending a handful of messages, 
the 
> > CAN interface hits the same problem that started this thread.  My 
application 
> > prints the error "No buffer space available" and the only way to recover is 
an 
> > interface reset via "ifconfig can0 down" followed by "ifconfig can0 up".
> 
> Could you please send the output of "candump any,0:0,#FFFFFFFF" while
> sending the messages. Do they go out to the bus? Also "ip -d -s link
> show can0" would be useful.

candump produced no output while my application was running and trying to send
messages.  Furthermore, the lack of output from candump suggests that messages
aren't being received as well.  There is another CAN device on the bus and I can
confirm, using a CAN monitor tool on another PC, that it is actively sending
messages.

Upon starting my application, 16 messages are transmitted on the bus (confirmed
via the external CAN monitor tool) which candump does not report.  Then
transmission stops.  This lines up with the output of "ip -d -s link show can0",
shown below:

At startup:

4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

After transmission stops:

4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

After transmission stops & interface is reset:

4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 250000 sample-point 0.875
    tq 500 prop-seg 3 phase-seg1 3 phase-seg2 1 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    0          0        0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       16      0       0

The best I can tell, the 16 messages which are successfully transmitted on the
bus are considered dropped by the driver.

- Mike


