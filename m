From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Subject: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Date: Fri, 8 Feb 2019 13:17:46 +0000
Message-ID: <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>
References: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Patrick Zysset <Patrick.Zysset@netmodule.com>
List-Id: linux-can.vger.kernel.org

D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
However, some CPUs with D_CAN controller have their own limits:
TI AM335x Sitara CPU, for example, supports max of 64 message objects.

This patch extends max D_CAN message objects up to 64.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
---
 drivers/net/can/c_can/Kconfig | 12 ++++++++++++
 drivers/net/can/c_can/c_can.c | 42 ++++++++++++++++++++++-----------------=
---
 drivers/net/can/c_can/c_can.h | 20 ++++++++++++++++----
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 61ffc12d8fd8..6c1ada7291df 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -20,4 +20,16 @@ config CAN_C_CAN_PCI
 	---help---
 	  This driver adds support for the C_CAN/D_CAN chips connected
 	  to the PCI bus.
+
+config CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	bool "Use 64 message objects for D_CAN"
+	default n
+	---help---
+	  D_CAN supports up to 128 message objects, comparing to 32 on
+	  C_CAN. However, some CPUs with D_CAN controller have their
+	  own limits: TI AM335x Sitara CPU, for example, supports max
+	  of 64 message objects.
+	  Enabling this option extends max D_CAN message objects up to
+	  64.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8ffe13..5d695b89b459 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -352,15 +352,6 @@ static void c_can_setup_tx_object(struct net_device *d=
ev, int iface,
 	}
 }
=20
-static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *=
dev,
-						       int iface)
-{
-	int i;
-
-	for (i =3D C_CAN_MSG_OBJ_RX_FIRST; i <=3D C_CAN_MSG_RX_LOW_LAST; i++)
-		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
-}
-
 static int c_can_handle_lost_msg_obj(struct net_device *dev,
 				     int iface, int objno, u32 ctrl)
 {
@@ -706,7 +697,16 @@ static void c_can_do_tx(struct net_device *dev)
 	struct net_device_stats *stats =3D &dev->stats;
 	u32 idx, obj, pkts =3D 0, bytes =3D 0, pend, clr;
=20
-	clr =3D pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	if (priv->type =3D=3D BOSCH_D_CAN) {
+		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
+	} else {
+#endif
+		pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	}
+#endif
+	clr =3D pend;
=20
 	while ((idx =3D ffs(pend))) {
 		idx--;
@@ -817,7 +817,17 @@ static int c_can_read_objects(struct net_device *dev, =
struct c_can_priv *priv,
=20
 static inline u32 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+	u32 pend;
+
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	if (priv->type =3D=3D BOSCH_D_CAN) {
+		pend =3D priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+	} else {
+#endif
+		pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	}
+#endif
=20
 	return pend;
 }
@@ -828,8 +838,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *=
priv)
  * c_can core saves a received CAN message into the first free message
  * object it finds free (starting with the lowest). Bits NEWDAT and
  * INTPND are set for this message object indicating that a new message
- * has arrived. To work-around this issue, we keep two groups of message
- * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
+ * has arrived.
  *
  * We clear the newdat bit right away.
  *
@@ -840,13 +849,6 @@ static int c_can_do_rx_poll(struct net_device *dev, in=
t quota)
 	struct c_can_priv *priv =3D netdev_priv(dev);
 	u32 pkts =3D 0, pend =3D 0, toread, n;
=20
-	/*
-	 * It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
-			"Implementation does not support more message objects than 16");
-
 	while (quota > 0) {
 		if (!pend) {
 			pend =3D c_can_get_pending(priv);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8acdc7fa4792..e44b686a70a2 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -23,9 +23,15 @@
 #define C_CAN_H
=20
 /* message object split */
+
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define C_CAN_NO_OF_OBJECTS	64
+#else
 #define C_CAN_NO_OF_OBJECTS	32
-#define C_CAN_MSG_OBJ_RX_NUM	16
-#define C_CAN_MSG_OBJ_TX_NUM	16
+#endif
+
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
+#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
=20
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -35,9 +41,11 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
=20
-#define C_CAN_MSG_OBJ_RX_SPLIT	9
-#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define RECEIVE_OBJECT_BITS	0xffffffff
+#else
 #define RECEIVE_OBJECT_BITS	0x0000ffff
+#endif
=20
 enum reg {
 	C_CAN_CTRL_REG =3D 0,
@@ -76,6 +84,8 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
+	C_CAN_INTPND4_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -137,6 +147,8 @@ static const u16 reg_map_d_can[] =3D {
 	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
 	[C_CAN_INTPND1_REG]	=3D 0xB0,
 	[C_CAN_INTPND2_REG]	=3D 0xB2,
+	[C_CAN_INTPND3_REG]	=3D 0xB4,
+	[C_CAN_INTPND4_REG]	=3D 0xB6,
 	[C_CAN_MSGVAL1_REG]	=3D 0xC4,
 	[C_CAN_MSGVAL2_REG]	=3D 0xC6,
 	[C_CAN_IF1_COMREQ_REG]	=3D 0x100,
--=20
2.11.0
