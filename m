From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN-BCM periodic send signaling
Date: Mon, 06 Jan 2014 19:08:43 +0100
Message-ID: <52CAF12B.1000006@hartkopp.net>
References: <003601cf0b02$53c58f10$fb50ad30$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:31717 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbaAFSIp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jan 2014 13:08:45 -0500
In-Reply-To: <003601cf0b02$53c58f10$fb50ad30$@annecy-elec.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Boris Baskevitch <boris.baskevitch@annecy-elec.fr>
Cc: linux-can@vger.kernel.org

Hey Boris,

On 06.01.2014 18:11, Boris Baskevitch wrote:

> I'm using the CAN-BCM to send periodic CAN messages on the bus.
> In one of those messages, I need to send a counter value which is incremented each time the message is sent.
> How can I do that ?

E.g. if you have a 4 bit counter, you just send 16 "struct can_frames" at
TX_SETUP time - also set nframes to 16 then.

When nframes > 1 a sequence of CAN frames is sent automatically.
You may alter these CAN frames at runtime.
If you do so, the tx index may be set to "0" (start) with TX_RESET_MULTI_IDX.

See tst-bcm-cycle.c from the git://gitorious.org/linux-can/can-tests.git

Here's the patch to demonstrate it based on can-tests repository with nframes=4:

diff --git a/tst-bcm-cycle.c b/tst-bcm-cycle.c
index b85ceed..adb2fd6 100644
--- a/tst-bcm-cycle.c
+++ b/tst-bcm-cycle.c
@@ -89,16 +89,29 @@ int main(int argc, char **argv)

 	msg.msg_head.opcode  = TX_SETUP;
 	msg.msg_head.can_id  = 0x42;
-	msg.msg_head.flags   = SETTIMER|STARTTIMER;
-	msg.msg_head.nframes = 1;
-	msg.msg_head.count = 10;
-	msg.msg_head.ival1.tv_sec = 1;
+	msg.msg_head.flags   = SETTIMER|STARTTIMER|TX_CP_CAN_ID;
+	msg.msg_head.nframes = 4;
+	msg.msg_head.count = 0;
+	msg.msg_head.ival1.tv_sec = 0;
 	msg.msg_head.ival1.tv_usec = 0;
 	msg.msg_head.ival2.tv_sec = 0;
-	msg.msg_head.ival2.tv_usec = 0;
-	msg.frame[0].can_id    = 0x42;
+	msg.msg_head.ival2.tv_usec = 200000;
+
+	//msg.frame[0].can_id    = 0x42; /* obsolete due to TX_CP_CAN_ID */
 	msg.frame[0].can_dlc   = 8;
-	U64_DATA(&msg.frame[0]) = (__u64) 0xdeadbeefdeadbeefULL;
+	U64_DATA(&msg.frame[0]) = (__u64) 0x01000000deadbeefULL;
+
+	//msg.frame[1].can_id    = 0x42; /* obsolete due to TX_CP_CAN_ID */
+	msg.frame[1].can_dlc   = 8;
+	U64_DATA(&msg.frame[1]) = (__u64) 0x02000000deadbeefULL;
+
+	//msg.frame[2].can_id    = 0x42; /* obsolete due to TX_CP_CAN_ID */
+	msg.frame[2].can_dlc   = 8;
+	U64_DATA(&msg.frame[2]) = (__u64) 0x03000000deadbeefULL;
+
+	//msg.frame[3].can_id    = 0x42; /* obsolete due to TX_CP_CAN_ID */
+	msg.frame[3].can_dlc   = 8;
+	U64_DATA(&msg.frame[3]) = (__u64) 0x04000000deadbeefULL;

 	if (write(s, &msg, sizeof(msg)) < 0)
 		perror("write");

Does this fit your needs?

Regards,
Oliver

