From: Pavel Machek <pavel@denx.de>
Subject: [PATCH 2/2] Add 32-bit accesses
Date: Mon, 5 May 2014 14:08:01 +0200
Message-ID: <20140505120801.GA16461@amd.pavel.ucw.cz>
References: <20140426203131.GA21832@amd.pavel.ucw.cz>
 <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
 <20140427122510.GB12901@amd.pavel.ucw.cz>
 <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59979 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbaEEMID (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 May 2014 08:08:03 -0400
Content-Disposition: inline
In-Reply-To: <20140502084851.GA5730@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thor Thayer <tthayer.linux@gmail.com>
Cc: Thor Thayer <tthayer@altera.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com


Add helpers for 32-bit accesses and replace open-coded 32-bit access
with calls to helpers.

Tested-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Thor Thayer <tthayer@altera.com>
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index c56f1b1..10c3fd2 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -188,6 +190,8 @@ struct c_can_priv {
 	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
+	u32 (*read_reg32) (struct c_can_priv *priv, enum reg index);
+	void (*write_reg32) (struct c_can_priv *priv, enum reg index, u32 val);
 };
 
 struct net_device *alloc_c_can_dev(void);

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a2ca820..824ec21 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -252,8 +261,7 @@ static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj
 	struct c_can_priv *priv = netdev_priv(dev);
 	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
 
-	priv->write_reg(priv, reg + 1, cmd);
-	priv->write_reg(priv, reg, obj);
+	priv->write_reg32(priv, reg, (cmd << 16) | obj);
 
 	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
 		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
@@ -328,8 +336,7 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 		change_bit(idx, &priv->tx_dir);
 	}
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 
@@ -391,8 +398,7 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 
 	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
 
-	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
-	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
+	arb = priv->read_reg32(priv, C_CAN_IFACE(ARB1_REG, iface));
 
 	if (arb & IF_ARB_MSGXTD)
 		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -424,12 +430,10 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	mask |= BIT(29);
-	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
-	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface), mask >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
 
 	id |= IF_ARB_MSGVAL;
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), id);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), id >> 16);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), id);
 
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), mcont);
 	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
