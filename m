From: John Whitmore <arigead@gmail.com>
Subject: RFC mcp251x Auto baud rate detection
Date: Tue, 11 Feb 2014 16:21:02 +0000
Message-ID: <20140211162100.GA3742@griso.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:54484 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaBKQU3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 11:20:29 -0500
Received: by mail-ea0-f173.google.com with SMTP id d10so3740633eaj.18
        for <linux-can@vger.kernel.org>; Tue, 11 Feb 2014 08:20:28 -0800 (PST)
Received: from griso.site ([109.79.119.187])
        by mx.google.com with ESMTPSA id j42sm69801559eep.21.2014.02.11.08.20.25
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Feb 2014 08:20:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been on before about this. Basically I control my own CAN Bus Network
which has a configurable baud rate. So devices which connect occasionally
(test equipement) have to listen for the target baud rate and then connect. To
facilitate this all the permanent/fixed nodes on the network, on power up,
pick a random time between say 1 and 2 Seconds. Every node's code forces a
"Ping" Message onto the network if they haven't heard any traffic in that
random time. This means that only node with the smallest random number will
ping the network if there's no activity.

Basically a node connecting listens to a few, (I'd have to check but think I
use 8), "standard" baud rates in turn and counts errors. My code does it down
in the MCP2515 driver. So the driver listens at 10K. If after a timeout of say
5 seconds there are no MERRE errors raised and 1 or more valid CAN Frames have
been received then that's our baud rate and the driver connects. If there are
MERRE errors then connect in listen mode at the next defined baud rate
25K. Keep going through the standard baud rates until you find your target.

I have attached a patch file with a small change to the mcp251x
 driver. Basically it just checks for the MERRE Error Interrupt flag and when
 it's raised it dumps the Receive buffers, and increments RX Error count. At
 present I'm not specifically enabling the MERRE Interrupt and I'm not
 checking that the device is in "Listen" mode. I didnt' like to do that as
 it's in a ISR and might be considered a waste of time. Maybe it would be
 better to only check that Error flag if in Listen Mode, but regardless of
 mode it's  still an Error. 

At present I just dump RX Buffers but the MERRE flag can be either on the RX
side or the TX side, the MCP2515 don't distinguish. I assume I'm in listen
mode so can ignore TX. The Microchip datasheet suggests that the MERRE
interrupt is used in Listen mode for automatic baud rate detection but I'm not
sure that flag is only raised in "Listen" Mode. It's not clear in the data sheet.

So given the patch file which increments RX Error counts on MERRE, when I
listen at 5K to the network, which is communicating at 10K, after a time checking
 errors ($ip -s -d link show can0) gives me:

3: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT qlen 10
    link/can 
    can <LISTEN-ONLY> state STOPPED restart-ms 0 
    bitrate 5000 sample-point 0.680 
    tq 8000 prop-seg 8 phase-seg1 8 phase-seg2 8 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0         
    RX: bytes  packets  errors  dropped overrun mcast   
    0          0        10      0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      


Obviously 10 errors that's not the correct baud rate so when I listen at the
correct baud rate of 10K. After a period of time my output is:


3: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT qlen 10
    link/can 
    can <LISTEN-ONLY> state STOPPED restart-ms 0 
    bitrate 10000 sample-point 0.875 
    tq 6250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0         
    RX: bytes  packets  errors  dropped overrun mcast   
    0          7        10      0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    0          0        0       0       0       0      

I've got 7 good CAN Frame and no increase in RX Errors so that's the target baudrate.

I'm new here so there are many things I don't know, and many questions I could
ask. Like the above output from the "ip" command. Should there be a specific
column for "merre" errors as there are for "dropped" and "overrun"? That would
mean obviously changing the mcp251x driver. I think that would be better as if
you listen to a 5K Network at 25K each frame is far longer then the expected
frame. So you'd get both an MERRE error and probably an overrun, as well as
possibly a valid frame as you clear the MERRE flag and the RX flag and the
MCP2515 working frame buffer gets dumped into the RX Buffer. That might get
confusing if you just count errors but if you specifically count "MERRE"
errors then even if you mistakenly think you got a valid frame in the
listening period you have an MERRE so it's not the target baud rate.

Additionally I've only ever used the microchip CAN engine in the MCP2515 and
various Microcontrollers so I've no idea if this would have any crossover with
other CAN Drivers?

When I mentioned this before on this list I asked wheather it should be in
Kernel or user space. Having given it some thought I think it should be in
User space as my network has a list of valid baud rates say (10k, 25k, 50k,
100k, 250k ,500k, 800k and 1M). That's not information that the driver should
ever know anything about. And another network would probalby use totally
different baud rates.

I'd like to hear any thoughts about this people have. Obviously I'm just
manually looking at the output from the "ip" command at present but would have
to do some research to find out how to pull those error and RX counts into a
piece of system software. Then the same piece of code would have to be able to
execute the ip command to set the listen mode. Robert Love's "Linux System
Programming" book don't deal with much of that specifically, so I have some
stuff to learn.


--J/dobhs11T7y2rNN
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-Added-MERRF-Processing-to-mcp251x_can_ist.patch"

From 70d5c740c07281040e8e05623bba2728f749b564 Mon Sep 17 00:00:00 2001
From: John Whitmore <johnfwhitmore@gmail.com>
Date: Tue, 11 Feb 2014 09:39:27 +0000
Subject: [PATCH] Added MERRF Processing to mcp251x_can_ist()

In listen mode the MCP2515 fires this error flag to signal an error received
on the CAN Bus. This can be used to auto detect baud rate.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/net/can/mcp251x.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 8cda23b..1810187 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -808,6 +808,19 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 
 		mcp251x_read_2regs(spi, CANINTF, &intf, &eflag);
 
+		/* receive buffer 0 */
+		if (intf & CANINTF_MERRF) {
+			printk(KERN_ALERT "JFW mcp251x MERRE\n");
+			mcp251x_write_bits(spi, CANINTF, CANINTF_MERRF, 0x00);
+			net->stats.rx_errors++;
+
+			/*
+			 * We've got an error condition so dump all received messages
+			 */
+			mcp251x_write_bits(spi, CANINTF, CANINTF_RX, 0x00);
+			intf &= ~CANINTF_RX;
+		}
+
 		/* mask out flags we don't care about */
 		intf &= CANINTF_RX | CANINTF_TX | CANINTF_ERR;
 
-- 
1.7.10.4


--J/dobhs11T7y2rNN--
