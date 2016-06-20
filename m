From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bug? -- NEVER getting controller-problem{back-to-error-active}
Date: Mon, 20 Jun 2016 12:33:01 +0200
Message-ID: <5767C65D.2010303@grandegger.com>
References: <loom.20160620T110554-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:52972 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcFTKdG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2016 06:33:06 -0400
In-Reply-To: <loom.20160620T110554-742@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>, linux-can@vger.kernel.org

Hello,

Am 20.06.2016 um 11:12 schrieb ajneu:
> Hi,
> 
> I'm using a PEAK USB Adapter (PCAN-USB FD) for normal CAN Frames (standard
> format), and lsmod shows peak_usb as it should.
> 
> When running on a can bus and continually send out messages (one frame each
> second).
> But there is no other participant, so I will get NO ACK.
> 
> 
> So berr-counter-tx counts up until it reaches
> 96:
> -> enter state ERROR-WARNING.
> 
>     I then get a frame:
>     Error:
> 	Id  : 0x20000004
> 	Data: 0x0 0x8 0x0 0x0 0x0 0x0 0x0 0x0
> 	controller-problem{tx-error-warning}
> 
> 
> Then berr-counter-tx continues to count up to
> 128:
> -> enter state ERROR-PASSIVE.
> 
>     I then get a frame:
>     Error:
> 	Id  : 0x20000004
> 	Data: 0x0 0x20 0x0 0x0 0x0 0x0 0x0 0x0
> 	controller-problem{tx-error-passive}
> 
> 
> Then if I connect another participant, berr-counter-tx counter will start
> decrementing (bec. of successfull ACK)
> When berr-counter-tx is
> 127:
> -> enter state ERROR_WARNING.
> 
>     I then get a frame:
>     Error:
> 	Id  : 0x20000004
> 	Data: 0x0 0x8 0x0 0x0 0x0 0x0 0x0 0x0
> 	controller-problem{tx-error-warning}
> 
> 
> When berr-counter-tx reaches
> 95:
> -> enter state ERROR_ACTIVE
> 
> BUT I NEVER GET the frame
> 	Id  : 0x20000004
> 	Data: 0x0 0x40 0x0 0x0 0x0 0x0 0x0 0x0
> 	controller-problem{back-to-error-active}
> WHY?
> WHY DO I NOT GET THAT FRAME?
> IS THIS A BUG???
> 
> 
> The command
>     ip -details link show can0
> shows...
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
> DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 94 rx 80) restart-ms 0
>            bitrate 250000 sample-point 0.875
>            tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
>            pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
>            pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
> dbrp-inc 1
>            clock 80000000
> 
> ...so I'm definately in error-active.
> (But I never received back-to-error-active. Why? Is this a bug?)
> 
> Thanks.
> ajneu
> 
> 
> 
> PS:
> ------------------------------------
> When berr-counter-tx switches from 96 to
> 95:
> and I then do command
>     ip -details link show can0
> it shows...
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
> DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>            bitrate 250000 sample-point 0.875
>            tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
>            pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
>            pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
> dbrp-inc 1
>            clock 80000000
> 
> 
> That ALSO SEEMS TO BE A BUG. I expect berr-counter-tx to be 95 and not 0 as
> shown.
> But when berr-counter-tx decrements one more, I get
> 
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
> DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state ERROR-ACTIVE (berr-counter tx 94 rx 80) restart-ms 0
>            bitrate 250000 sample-point 0.875
>            tq 62 prop-seg 27 phase-seg1 28 phase-seg2 8 sjw 1
>            pcan_usb_fd: tseg1 1..64 tseg2 1..16 sjw 1..16 brp 1..1024 brp-inc 1
>            pcan_usb_fd: dtseg1 1..16 dtseg2 1..8 dsjw 1..4 dbrp 1..1024
> dbrp-inc 1
>            clock 80000000
> 

Does the following patch fix both issues?

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index ce44a03..ca17ac2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -529,7 +529,7 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
        struct peak_usb_device *dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
        struct pcan_usb_fd_device *pdev =
                        container_of(dev, struct pcan_usb_fd_device, dev);
-       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
+       enum can_state new_state;
        enum can_state rx_state, tx_state;
        struct net_device *netdev = dev->netdev;
        struct can_frame *cf;
@@ -547,10 +547,7 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
                new_state = CAN_STATE_ERROR_WARNING;
        } else {
                /* no error bit (so, no error skb, back to active state) */
-               dev->can.state = CAN_STATE_ERROR_ACTIVE;
-               pdev->bec.txerr = 0;
-               pdev->bec.rxerr = 0;
-               return 0;
+               new_state = CAN_STATE_ERROR_ACTIVE;
        }
 
        /* state hasn't changed */


Wolfgang.
