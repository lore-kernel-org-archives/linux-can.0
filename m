From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/8] can: flexcan: allocate skb in flexcan_mailbox_read
Date: Fri, 12 Jul 2019 08:02:38 +0000
Message-ID: <20190712075926.7357-2-qiangqing.zhang@nxp.com>
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

We need to use alloc_canfd_skb() for CAN FD frames and alloc_can_skb()
for CAN classic frames. So we have to alloc skb in flexcan_mailbox_read().

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c      | 38 ++++++++++++++++++++--------------
 drivers/net/can/rx-offload.c   | 29 +++++++-------------------
 include/linux/can/rx-offload.h |  5 +++--
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e35083ff31ee..7e12f3db0915 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -789,14 +789,15 @@ static inline struct flexcan_priv *rx_offload_to_priv=
(struct can_rx_offload *off
 	return container_of(offload, struct flexcan_priv, offload);
 }
=20
-static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
-					 struct can_frame *cf,
-					 u32 *timestamp, unsigned int n)
+static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload, b=
ool drop,
+					 struct sk_buff **skb, u32 *timestamp,
+					 unsigned int n)
 {
 	struct flexcan_priv *priv =3D rx_offload_to_priv(offload);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	struct flexcan_mb __iomem *mb;
 	u32 reg_ctrl, reg_id, reg_iflag1;
+	struct can_frame *cf =3D NULL;
 	int i;
=20
 	mb =3D flexcan_get_mb(priv, n);
@@ -827,22 +828,27 @@ static unsigned int flexcan_mailbox_read(struct can_r=
x_offload *offload,
 		reg_ctrl =3D priv->read(&mb->can_ctrl);
 	}
=20
-	/* increase timstamp to full 32 bit */
-	*timestamp =3D reg_ctrl << 16;
+	if (!drop)
+		*skb =3D alloc_can_skb(offload->dev, &cf);
=20
-	reg_id =3D priv->read(&mb->can_id);
-	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
-		cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
-	else
-		cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
+	if (*skb && cf) {
+		/* increase timstamp to full 32 bit */
+		*timestamp =3D reg_ctrl << 16;
=20
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |=3D CAN_RTR_FLAG;
-	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+		reg_id =3D priv->read(&mb->can_id);
+		if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
+			cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+		else
+			cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
-		__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
-		*(__be32 *)(cf->data + i) =3D data;
+		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+			cf->can_id |=3D CAN_RTR_FLAG;
+		cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+
+		for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+			__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
+			*(__be32 *)(cf->data + i) =3D data;
+		}
 	}
=20
 	/* mark as read */
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 2ce4fa8698c7..632919484ff7 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -121,32 +121,19 @@ static int can_rx_offload_compare(struct sk_buff *a, =
struct sk_buff *b)
 static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *o=
ffload, unsigned int n)
 {
 	struct sk_buff *skb =3D NULL;
-	struct can_rx_offload_cb *cb;
-	struct can_frame *cf;
-	int ret;
+	u32 timestamp;
=20
 	/* If queue is full or skb not available, read to discard mailbox */
-	if (likely(skb_queue_len(&offload->skb_queue) <=3D
-		   offload->skb_queue_len_max))
-		skb =3D alloc_can_skb(offload->dev, &cf);
+	bool drop =3D unlikely(skb_queue_len(&offload->skb_queue) >
+			     offload->skb_queue_len_max);
=20
-	if (!skb) {
-		struct can_frame cf_overflow;
-		u32 timestamp;
+	if (offload->mailbox_read(offload, drop, &skb, &timestamp, n) && !skb)
+		offload->dev->stats.rx_dropped++;
=20
-		ret =3D offload->mailbox_read(offload, &cf_overflow,
-					    &timestamp, n);
-		if (ret)
-			offload->dev->stats.rx_dropped++;
+	if (skb) {
+		struct can_rx_offload_cb *cb =3D can_rx_offload_get_cb(skb);
=20
-		return NULL;
-	}
-
-	cb =3D can_rx_offload_get_cb(skb);
-	ret =3D offload->mailbox_read(offload, cf, &cb->timestamp, n);
-	if (!ret) {
-		kfree_skb(skb);
-		return NULL;
+		cb->timestamp =3D timestamp;
 	}
=20
 	return skb;
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.=
h
index 8268811a697e..c54d80ef4314 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,8 +23,9 @@
 struct can_rx_offload {
 	struct net_device *dev;
=20
-	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_f=
rame *cf,
-				     u32 *timestamp, unsigned int mb);
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, bool drop,
+				     struct sk_buff **skb, u32 *timestamp,
+				     unsigned int mb);
=20
 	struct sk_buff_head skb_queue;
 	u32 skb_queue_len_max;
--=20
2.17.1
