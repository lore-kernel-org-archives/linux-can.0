From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] c_can: remove obsolete STRICT_FRAME_ORDERING Kconfig option
Date: Tue, 06 May 2014 19:45:38 +0200
Message-ID: <53691FC2.3080200@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:64474 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaEFRpl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 May 2014 13:45:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

In 2b9aecdce2 ("can: c_can: Disable rx split as workaround") a new Kcon=
fig
option was introduced as a workaround. The tests performed by Alexander=
 Stein
confirmed this option to be obsolete with all the other cleanups and fi=
xes
that had been discussed that time:
http://marc.info/?l=3Dlinux-can&m=3D139746476821294&w=3D2

Both (author and tester) agreed to remove this Kconfig option again:
http://marc.info/?l=3Dlinux-can&m=3D139883820714229&w=3D2

As some more cleanups took place since then a simple revert is not poss=
ible.
This patch removes the entire option as it would behave when disabled.
=46urther beautification=92s can be done later.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

---

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kcon=
fig
index 8ab7103..61ffc12 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -14,13 +14,6 @@ config CAN_C_CAN_PLATFORM
 	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
 	  boards like am335x, dm814x, dm813x and dm811x.
=20
-config CAN_C_CAN_STRICT_FRAME_ORDERING
-	bool "Force a strict RX CAN frame order (may cause frame loss)"
-	---help---
-	  The RX split buffer prevents packet reordering but can cause packet
-	  loss. Only enable this option when you accept to lose CAN frames
-	  in favour of getting the received CAN frames in the correct order.
-
 config CAN_C_CAN_PCI
 	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
 	depends on PCI
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c
index a2ca820..95e04e2 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -732,26 +732,12 @@ static u32 c_can_adjust_pending(u32 pend)
 static inline void c_can_rx_object_get(struct net_device *dev,
 				       struct c_can_priv *priv, u32 obj)
 {
-#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
-	if (obj < C_CAN_MSG_RX_LOW_LAST)
-		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_LOW);
-	else
-#endif
 		c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
 }
=20
 static inline void c_can_rx_finalize(struct net_device *dev,
 				     struct c_can_priv *priv, u32 obj)
 {
-#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
-	if (obj < C_CAN_MSG_RX_LOW_LAST)
-		priv->rxmasked |=3D BIT(obj - 1);
-	else if (obj =3D=3D C_CAN_MSG_RX_LOW_LAST) {
-		priv->rxmasked =3D 0;
-		/* activate all lower message objects */
-		c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
-	}
-#endif
 	if (priv->type !=3D BOSCH_D_CAN)
 		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
 }
@@ -799,9 +785,6 @@ static inline u32 c_can_get_pending(struct c_can_pr=
iv *priv)
 {
 	u32 pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
=20
-#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
-	pend &=3D ~priv->rxmasked;
-#endif
 	return pend;
 }
=20
@@ -814,25 +797,6 @@ static inline u32 c_can_get_pending(struct c_can_p=
riv *priv)
  * has arrived. To work-around this issue, we keep two groups of messa=
ge
  * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
  *
- * If CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING =3D y
- *
- * To ensure in-order frame reception we use the following
- * approach while re-activating a message object to receive further
- * frames:
- * - if the current message object number is lower than
- *   C_CAN_MSG_RX_LOW_LAST, do not clear the NEWDAT bit while clearing
- *   the INTPND bit.
- * - if the current message object number is equal to
- *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of all lower
- *   receive message objects.
- * - if the current message object number is greater than
- *   C_CAN_MSG_RX_LOW_LAST then clear the NEWDAT bit of
- *   only this message object.
- *
- * This can cause packet loss!
- *
- * If CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING =3D n
- *
  * We clear the newdat bit right away.
  *
  * This can result in packet reordering when the readout is slow.

