From: Holger Bechtold <Holger.Bechtold@gmx.net>
Subject: [PATCH] for C_CAN driver.
Date: Mon, 25 Nov 2013 15:48:19 +0100
Message-ID: <20131125144819.GA5129@pc1xp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:62666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230Ab3KYOsc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 25 Nov 2013 09:48:32 -0500
Received: from pc1xp ([212.255.254.112]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MYwyp-1W62hh3qFP-00VkOA for
 <linux-can@vger.kernel.org>; Mon, 25 Nov 2013 15:48:31 +0100
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

Hello all

As suggested by Marc Kleine-Budde I re-submit a modified version of the
patch for the transmitted bytes counter.

---------- patch description -----------------------------------------------

The number of bytes transmitted was not updated correctly, if several
CAN messages (with different length) were transmitted in one 'bunch'.
Thus programs like 'ifconfig' showed wrong transmit byte counts.
Reason was, that the message object whose DLC is to be read was not
necessarily the active one at the time when
   priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, 0)) & IF_MCONT_DLC_MASK;
was executed.

---------- patch -----------------------------------------------------------

--- linux-3.8.13/drivers/net/can/c_can/c_can.c.Orig	2013-05-11 22:57:46.000000000 +0200
+++ linux-3.8.13/drivers/net/can/c_can/c_can.c	2013-11-25 15:21:29.000763007 +0100
@@ -751,6 +751,7 @@ static void c_can_do_tx(struct net_devic
 		if (!(val & (1 << (msg_obj_no - 1)))) {
 			can_get_echo_skb(dev,
 					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
+			c_can_object_get(dev, 0, msg_obj_no, IF_COMM_ALL);
 			stats->tx_bytes += priv->read_reg(priv,
 					C_CAN_IFACE(MSGCTRL_REG, 0))
 					& IF_MCONT_DLC_MASK;

------------------------------------------------------------------------------

Signed-off-by: Holger Bechtold <Holger.Bechtold@gmx.net>

