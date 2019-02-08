From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>
Subject: [PATCH 2/2] can: c_can: configurable amount of D_CAN RX objects
Date: Fri, 8 Feb 2019 13:17:50 +0000
Message-ID: <20190208131738.27668-3-andrejs.cainikovs@netmodule.com>
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

Make number of D_CAN RX message objects configurable. This will allow
having bigger (or smaller) RX buffer instead of 50/50 split for RX/TX.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
---
 drivers/net/can/c_can/Kconfig |  8 ++++++
 drivers/net/can/c_can/c_can.c | 64 +++++++++++++++++++++++++++++----------=
----
 drivers/net/can/c_can/c_can.h | 16 +++++------
 3 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 6c1ada7291df..949d2d12d71e 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -32,4 +32,12 @@ config CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	  Enabling this option extends max D_CAN message objects up to
 	  64.
=20
+config CAN_C_CAN_DCAN_RX_MSG_OBJECTS
+	int "Specify amount of D_CAN RX message objects"
+	depends on CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	default 32
+	---help---
+	  Use specific number of message objects for RX, instead of
+	  50/50 split between RX/TX.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5d695b89b459..675bc223e222 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -208,6 +208,26 @@ static const struct can_bittiming_const c_can_bittimin=
g_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static inline u64 c_can_get_mask(int bits)
+{
+	return ((u64)1 << bits) - 1;
+}
+
+static inline int c_can_ffs64(u64 x)
+{
+	int b;
+
+	b =3D ffs(x);
+
+	if (!b) {
+		b =3D ffs(x >> 32);
+		if (b)
+			b +=3D 32;
+	}
+
+	return b;
+}
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -695,24 +715,23 @@ static void c_can_do_tx(struct net_device *dev)
 {
 	struct c_can_priv *priv =3D netdev_priv(dev);
 	struct net_device_stats *stats =3D &dev->stats;
-	u32 idx, obj, pkts =3D 0, bytes =3D 0, pend, clr;
+	u32 idx, obj, pkts =3D 0, bytes =3D 0;
+	u64 pend, clr;
=20
+	/* Mask interrupt pending bits */
+	pend =3D priv->read_reg32(priv, C_CAN_INTPND1_REG);
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type =3D=3D BOSCH_D_CAN) {
-		pend =3D priv->read_reg32(priv, C_CAN_INTPND3_REG);
-	} else {
-#endif
-		pend =3D priv->read_reg(priv, C_CAN_INTPND2_REG);
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+		pend |=3D (u64)priv->read_reg32(priv, C_CAN_INTPND3_REG) << 32;
 	}
 #endif
-	clr =3D pend;
+	pend &=3D ~c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
+	clr =3D pend >> C_CAN_MSG_OBJ_RX_NUM;
=20
-	while ((idx =3D ffs(pend))) {
-		idx--;
-		pend &=3D ~(1 << idx);
-		obj =3D idx + C_CAN_MSG_OBJ_TX_FIRST;
+	while ((obj =3D c_can_ffs64(pend))) {
+		pend &=3D ~((u64)1 << (obj - 1));
 		c_can_inval_tx_object(dev, IF_RX, obj);
+		idx =3D obj - C_CAN_MSG_OBJ_TX_FIRST;
 		can_get_echo_skb(dev, idx);
 		bytes +=3D priv->dlc[idx];
 		pkts++;
@@ -736,19 +755,19 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(u32 pend)
+static u64 c_can_adjust_pending(u64 pend)
 {
-	u32 weight, lasts;
+	u64 weight, lasts;
=20
-	if (pend =3D=3D RECEIVE_OBJECT_BITS)
+	if (pend =3D=3D c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM))
 		return pend;
=20
 	/*
 	 * If the last set bit is larger than the number of pending
 	 * bits we have a gap.
 	 */
-	weight =3D hweight32(pend);
-	lasts =3D fls(pend);
+	weight =3D hweight64(pend);
+	lasts =3D fls64(pend);
=20
 	/* If the bits are linear, nothing to do */
 	if (lasts =3D=3D weight)
@@ -777,11 +796,11 @@ static inline void c_can_rx_finalize(struct net_devic=
e *dev,
 }
=20
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *p=
riv,
-			      u32 pend, int quota)
+			      u64 pend, int quota)
 {
 	u32 pkts =3D 0, ctrl, obj;
=20
-	while ((obj =3D ffs(pend)) && quota > 0) {
+	while ((obj =3D c_can_ffs64(pend)) && quota > 0) {
 		pend &=3D ~BIT(obj - 1);
=20
 		c_can_rx_object_get(dev, priv, obj);
@@ -815,13 +834,15 @@ static int c_can_read_objects(struct net_device *dev,=
 struct c_can_priv *priv,
 	return pkts;
 }
=20
-static inline u32 c_can_get_pending(struct c_can_priv *priv)
+static inline u64 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend;
+	u64 pend;
=20
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type =3D=3D BOSCH_D_CAN) {
 		pend =3D priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+		pend |=3D (u64)priv->read_reg32(priv, C_CAN_NEWDAT3_REG) << 32;
+		pend &=3D c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
 	} else {
 #endif
 		pend =3D priv->read_reg(priv, C_CAN_NEWDAT1_REG);
@@ -847,7 +868,8 @@ static inline u32 c_can_get_pending(struct c_can_priv *=
priv)
 static int c_can_do_rx_poll(struct net_device *dev, int quota)
 {
 	struct c_can_priv *priv =3D netdev_priv(dev);
-	u32 pkts =3D 0, pend =3D 0, toread, n;
+	u32 pkts =3D 0, n;
+	u64 pend =3D 0, toread;
=20
 	while (quota > 0) {
 		if (!pend) {
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index e44b686a70a2..4a0759ee249d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -26,12 +26,12 @@
=20
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 #define C_CAN_NO_OF_OBJECTS	64
+#define C_CAN_MSG_OBJ_RX_NUM	CONFIG_CAN_C_CAN_DCAN_RX_MSG_OBJECTS
 #else
 #define C_CAN_NO_OF_OBJECTS	32
+#define C_CAN_MSG_OBJ_RX_NUM	16
 #endif
-
-#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
-#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_RX_NUM)
=20
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -41,12 +41,6 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
=20
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
-#define RECEIVE_OBJECT_BITS	0xffffffff
-#else
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-#endif
-
 enum reg {
 	C_CAN_CTRL_REG =3D 0,
 	C_CAN_CTRL_EX_REG,
@@ -82,6 +76,8 @@ enum reg {
 	C_CAN_TXRQST2_REG,
 	C_CAN_NEWDAT1_REG,
 	C_CAN_NEWDAT2_REG,
+	C_CAN_NEWDAT3_REG,
+	C_CAN_NEWDAT4_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
 	C_CAN_INTPND3_REG,
@@ -145,6 +141,8 @@ static const u16 reg_map_d_can[] =3D {
 	[C_CAN_TXRQST2_REG]	=3D 0x8A,
 	[C_CAN_NEWDAT1_REG]	=3D 0x9C,
 	[C_CAN_NEWDAT2_REG]	=3D 0x9E,
+	[C_CAN_NEWDAT3_REG]	=3D 0xA0,
+	[C_CAN_NEWDAT4_REG]	=3D 0xA2,
 	[C_CAN_INTPND1_REG]	=3D 0xB0,
 	[C_CAN_INTPND2_REG]	=3D 0xB2,
 	[C_CAN_INTPND3_REG]	=3D 0xB4,
--=20
2.11.0
