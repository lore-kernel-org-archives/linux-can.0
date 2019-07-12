From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/8] can: flexcan: use struct canfd_frame for CAN classic
 frame
Date: Fri, 12 Jul 2019 08:02:41 +0000
Message-ID: <20190712075926.7357-3-qiangqing.zhang@nxp.com>
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

This patch prepares for CAN FD mode, using struct canfd_frame can both
for classic format frame and fd format frame.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c    | 34 +++++++++++++++++-----------------
 drivers/net/can/rx-offload.c |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7e12f3db0915..5b0a159daa38 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -609,10 +609,10 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
-	struct can_frame *cf =3D (struct can_frame *)skb->data;
+	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
 	u32 can_id;
 	u32 data;
-	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
+	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | (cfd->len << 16);
 	int i;
=20
 	if (can_dropped_invalid_skb(dev, skb))
@@ -620,18 +620,18 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff =
*skb, struct net_device *de
=20
 	netif_stop_queue(dev);
=20
-	if (cf->can_id & CAN_EFF_FLAG) {
-		can_id =3D cf->can_id & CAN_EFF_MASK;
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		can_id =3D cfd->can_id & CAN_EFF_MASK;
 		ctrl |=3D FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
 	} else {
-		can_id =3D (cf->can_id & CAN_SFF_MASK) << 18;
+		can_id =3D (cfd->can_id & CAN_SFF_MASK) << 18;
 	}
=20
-	if (cf->can_id & CAN_RTR_FLAG)
+	if (cfd->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
-		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
+	for (i =3D 0; i < cfd->len; i +=3D sizeof(u32)) {
+		data =3D be32_to_cpup((__be32 *)&cfd->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
=20
@@ -797,7 +797,7 @@ static unsigned int flexcan_mailbox_read(struct can_rx_=
offload *offload, bool dr
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	struct flexcan_mb __iomem *mb;
 	u32 reg_ctrl, reg_id, reg_iflag1;
-	struct can_frame *cf =3D NULL;
+	struct canfd_frame *cfd =3D NULL;
 	int i;
=20
 	mb =3D flexcan_get_mb(priv, n);
@@ -829,25 +829,25 @@ static unsigned int flexcan_mailbox_read(struct can_r=
x_offload *offload, bool dr
 	}
=20
 	if (!drop)
-		*skb =3D alloc_can_skb(offload->dev, &cf);
+		*skb =3D alloc_can_skb(offload->dev, (struct can_frame **)&cfd);
=20
-	if (*skb && cf) {
+	if (*skb && cfd) {
 		/* increase timstamp to full 32 bit */
 		*timestamp =3D reg_ctrl << 16;
=20
 		reg_id =3D priv->read(&mb->can_id);
 		if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
-			cf->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+			cfd->can_id =3D ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 		else
-			cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
+			cfd->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
=20
 		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-			cf->can_id |=3D CAN_RTR_FLAG;
-		cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+			cfd->can_id |=3D CAN_RTR_FLAG;
+		cfd->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
=20
-		for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+		for (i =3D 0; i < cfd->len; i +=3D sizeof(u32)) {
 			__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
-			*(__be32 *)(cf->data + i) =3D data;
+			*(__be32 *)(cfd->data + i) =3D data;
 		}
 	}
=20
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 632919484ff7..9f8c8410e19e 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -55,11 +55,11 @@ static int can_rx_offload_napi_poll(struct napi_struct =
*napi, int quota)
=20
 	while ((work_done < quota) &&
 	       (skb =3D skb_dequeue(&offload->skb_queue))) {
-		struct can_frame *cf =3D (struct can_frame *)skb->data;
+		struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
=20
 		work_done++;
 		stats->rx_packets++;
-		stats->rx_bytes +=3D cf->can_dlc;
+		stats->rx_bytes +=3D cfd->len;
 		netif_receive_skb(skb);
 	}
=20
--=20
2.17.1
