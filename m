From: ajneu <ajneu1@gmail.com>
Subject: Bug? -- NEVER getting =?utf-8?b?Y29udHJvbGxlci1wcm9ibGVte2JhY2stdG8tZXJyb3ItYWN0aXZlfQ==?=
Date: Mon, 20 Jun 2016 09:12:07 +0000 (UTC)
Message-ID: <loom.20160620T110554-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37330 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbcFTJMh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 Jun 2016 05:12:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bEvFk-00062G-AH
	for linux-can@vger.kernel.org; Mon, 20 Jun 2016 11:12:20 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 11:12:20 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 11:12:20 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I'm using a PEAK USB Adapter (PCAN-USB FD) for normal CAN Frames (standard
format), and lsmod shows peak_usb as it should.

When running on a can bus and continually send out messages (one frame each
second).
But there is no other participant, so I will get NO ACK.


So berr-counter-tx counts up until it reaches
96:
-> enter state ERROR-WARNING.

   I then get a frame:
   Error: 
	Id  : 0x20000004
	Data: 0x0 0x8 0x0 0x0 0x0 0x0 0x0 0x0 
	controller-problem{tx-error-warning}


Then berr-counter-tx continues to count up to 
128:
-> enter state ERROR-PASSIVE.

   I then get a frame:
   Error: 
	Id  : 0x20000004
	Data: 0x0 0x20 0x0 0x0 0x0 0x0 0x0 0x0 
	controller-problem{tx-error-passive}


Then if I connect another participant, berr-counter-tx counter will start
decrementing (bec. of successfull ACK)
When berr-counter-tx is 
127:
-> enter state ERROR_WARNING.

   I then get a frame:
   Error: 
	Id  : 0x20000004
	Data: 0x0 0x8 0x0 0x0 0x0 0x0 0x0 0x0 
	controller-problem{tx-error-warning}


When berr-counter-tx reaches 
95: 
-> enter state ERROR_ACTIVE

BUT I NEVER GET the frame
	Id  : 0x20000004
	Data: 0x0 0x40 0x0 0x0 0x0 0x0 0x0 0x0 
	controller-problem{back-to-error-active}
WHY?
WHY DO I NOT GET THAT FRAME?
IS THIS A BUG???


The command
   ip -details link show can0     
shows...

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 94 rx 80) restart-ms 0
          bitrate 250000 sample-point 0.875
          tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
          pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
          pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
dbrp-inc 1
          clock 80000000

...so I'm definately in error-active.
(But I never received back-to-error-active. Why? Is this a bug?)

Thanks.
ajneu



PS:
------------------------------------
When berr-counter-tx switches from 96 to
95:
and I then do command
   ip -details link show can0     
it shows...

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
          bitrate 250000 sample-point 0.875
          tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
          pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
          pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
dbrp-inc 1
          clock 80000000


That ALSO SEEMS TO BE A BUG. I expect berr-counter-tx to be 95 and not 0 as
shown.
But when berr-counter-tx decrements one more, I get 

3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
DEFAULT group default qlen 10
    link/can  promiscuity 0
    can state ERROR-ACTIVE (berr-counter tx 94 rx 80) restart-ms 0
          bitrate 250000 sample-point 0.875
          tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
          pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
          pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
dbrp-inc 1
          clock 80000000



