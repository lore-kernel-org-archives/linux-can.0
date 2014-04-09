From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Wed, 09 Apr 2014 09:40:11 +0200
Message-ID: <155230474.Qal719xsr7@ws-stein>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <8083460.0p0S3IB599@ws-stein> <alpine.DEB.2.02.1404090232400.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:48877 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750814AbaDIHly (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 03:41:54 -0400
In-Reply-To: <alpine.DEB.2.02.1404090232400.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Wednesday 09 April 2014 02:42:57, Thomas Gleixner wrote:
> I found the issue after a I got hold of a PCH afflicted system. It
> might not apply cleanly as I changed a few other things in my patch
> queue, but you get the idea. Too tired now to write changelogs, run
> tests ....
> 
> W/o that patch I observe the same problems as you. With that applied I
> did not observe any dropout with a 10 * 1e6 packet run.

Applying your patch I run my test with 5.000.000 CAN frames where none got lost and only a single one got switched.

Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Just for the reference I added my actually applied patch.

Thanks and best regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..b27b147 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -645,6 +645,10 @@ static int c_can_start(struct net_device *dev)
 	if (err)
 		return err;
 
+	/* Setup the command for new messages */
+	priv->comm_rcv_high = priv->type != BOSCH_D_CAN ?
+		IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* reset tx helper pointers and the rx mask */
@@ -789,14 +793,15 @@ static u32 c_can_adjust_pending(u32 pend)
 	return pend & ~((1 << lasts) - 1);
 }
 
-static inline void c_can_rx_object_get(struct net_device *dev, u32 obj)
+static inline void c_can_rx_object_get(struct net_device *dev,
+				       struct c_can_priv *priv, u32 obj)
 {
 #ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
 	if (obj < C_CAN_MSG_RX_LOW_LAST)
 		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_LOW);
 	else
 #endif
-		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_HIGH);
+		c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
 }
 
 static inline void c_can_rx_finalize(struct net_device *dev, struct c_can_priv *priv, u32 obj)
@@ -810,6 +815,8 @@ static inline void c_can_rx_finalize(struct net_device *dev, struct c_can_priv *
 		c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 	}
 #endif
+	if (priv->type != BOSCH_D_CAN)
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
@@ -820,7 +827,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
-		c_can_rx_object_get(dev, obj);
+		c_can_rx_object_get(dev, priv, obj);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
 
 		if (ctrl & IF_MCONT_MSGLST) {
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index cd91960..792944c 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -198,6 +198,7 @@ struct c_can_priv {
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

