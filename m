From: Holger Bechtold <Holger.Bechtold@gmx.net>
Subject: [PATCH] to C_CAN driver in linux kernel
Date: Sun, 24 Nov 2013 13:15:47 +0100
Message-ID: <20131124121547.GB4010@pc1xp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab3KXMPv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 24 Nov 2013 07:15:51 -0500
Received: from pc1xp ([212.255.43.128]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTjqS-1WAqsX39t2-00QQhv for
 <linux-can@vger.kernel.org>; Sun, 24 Nov 2013 13:15:50 +0100
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

Hello all

I would like to sumbit 2 patches to the C_CAN driver module file c_can.c.
Both bugs were noticed, fixed and tested on platform
   BeagleBoneBlack with AM335x Texas Instruments ARM Microprocessors
using these 2 kernel versions:

--- Angstroem -----------------------------
# uname -a
Linux beaglebone 3.8.13 #1 SMP Thu Sep 12 10:27:06 CEST 2013 armv7l GNU/Linux

# cat /etc/issue
Angstrom v2012.12 - Kernel
-------------------------------------------

and

--- Ubuntu --------------------------------
# uname -a
Linux ubuntu-armhf 3.8.13-bone20 #1 SMP Wed May 29 10:49:26 UTC 2013 ...
   armv7l GNU/Linux

# cat /etc/issue
Ubuntu 12.04.3 LTS
-------------------------------------------

I could not yet test the patches with the newest kernel sources
   linux-3.12.1
but the differences in file c_can.c are quite small and pertain only to
the control of a CAN-BUS activity LED.

If you will accept patches only for the newest kernel sources, please
drop me a line and I will try to test with newest sources.

Best Regards
Holger Bechtold

---------- patch 1 description -----------------------------------------------

The for-loop cycling through the message objects forming the reception FIFO
was left prematurely when it reached the last object (marked IF_MCONT_EOB).
If a received message was stored in this object, it was not handled
properly, leaving the IF_MCONT_INTPND condition pending. This led to a
processor deadlock and a kernel panic.

---------- patch 1 -----------------------------------------------------------

--- drivers/net/can/c_can/c_can.c.orig	2013-11-20 16:57:44.655806758 +0100
+++ drivers/net/can/c_can/c_can.c	2013-11-20 17:06:31.915937041 +0100
@@ -810,9 +807,6 @@ static int c_can_do_rx_poll(struct net_d
 			msg_ctrl_save = priv->read_reg(priv,
 					C_CAN_IFACE(MSGCTRL_REG, 0));
 
-			if (msg_ctrl_save & IF_MCONT_EOB)
-				return num_rx_pkts;
-
 			if (msg_ctrl_save & IF_MCONT_MSGLST) {
 				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
 				num_rx_pkts++;

---------- patch 2 description -----------------------------------------------

The number of bytes transmitted was not updated correctly. Thus programs
like 'ifconfig' showed wrong transmit byte counts.

---------- patch 2 -----------------------------------------------------------

--- drivers/net/can/c_can/c_can.c.orig	2013-11-20 16:57:44.655806758 +0100
+++ drivers/net/can/c_can/c_can.c	2013-11-20 17:06:31.915937041 +0100
@@ -749,11 +749,8 @@ static void c_can_do_tx(struct net_devic
 		msg_obj_no = get_tx_echo_msg_obj(priv);
 		val = c_can_read_reg32(priv, C_CAN_TXRQST1_REG);
 		if (!(val & (1 << (msg_obj_no - 1)))) {
-			can_get_echo_skb(dev,
-					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
-			stats->tx_bytes += priv->read_reg(priv,
-					C_CAN_IFACE(MSGCTRL_REG, 0))
-					& IF_MCONT_DLC_MASK;
+			stats->tx_bytes += can_get_echo_skb(dev, msg_obj_no -
+				C_CAN_MSG_OBJ_TX_FIRST);
 			stats->tx_packets++;
 			c_can_inval_msg_object(dev, 0, msg_obj_no);
 		} else {

------------------------------------------------------------------------------

Signed-off-by: Holger Bechtold <Holger.Bechtold@gmx.net>
