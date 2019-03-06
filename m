From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH RESEND 1/5] can: rx-offload: add CANFD support based on
 offload
Date: Wed, 6 Mar 2019 10:00:53 +0000
Message-ID: <20190306095833.20922-2-qiangqing.zhang@nxp.com>
References: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306095833.20922-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Using struct canfd_frame instead of can_frame to add support for CAN FD
mode in offload. FlexCAN controller will set the is_canfd variable when
it supports CAN FD mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/rx-offload.c   | 16 ++++++++++------
 include/linux/can/rx-offload.h |  4 +++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 2ce4fa8698c7..131fe600deb3 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -55,11 +55,11 @@ static int can_rx_offload_napi_poll(struct napi_struct =
*napi, int quota)
=20
 	while ((work_done < quota) &&
 	       (skb =3D skb_dequeue(&offload->skb_queue))) {
-		struct can_frame *cf =3D (struct can_frame *)skb->data;
+		struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
=20
 		work_done++;
 		stats->rx_packets++;
-		stats->rx_bytes +=3D cf->can_dlc;
+		stats->rx_bytes +=3D cf->len;
 		netif_receive_skb(skb);
 	}
=20
@@ -122,16 +122,20 @@ static struct sk_buff *can_rx_offload_offload_one(str=
uct can_rx_offload *offload
 {
 	struct sk_buff *skb =3D NULL;
 	struct can_rx_offload_cb *cb;
-	struct can_frame *cf;
+	struct canfd_frame *cf;
 	int ret;
=20
 	/* If queue is full or skb not available, read to discard mailbox */
 	if (likely(skb_queue_len(&offload->skb_queue) <=3D
-		   offload->skb_queue_len_max))
-		skb =3D alloc_can_skb(offload->dev, &cf);
+		   offload->skb_queue_len_max)) {
+		if (offload->is_canfd)
+			skb =3D alloc_canfd_skb(offload->dev, &cf);
+		else
+			skb =3D alloc_can_skb(offload->dev, (struct can_frame **)&cf);
+	}
=20
 	if (!skb) {
-		struct can_frame cf_overflow;
+		struct canfd_frame cf_overflow;
 		u32 timestamp;
=20
 		ret =3D offload->mailbox_read(offload, &cf_overflow,
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.=
h
index 8268811a697e..6448e7dfc170 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,7 +23,7 @@
 struct can_rx_offload {
 	struct net_device *dev;
=20
-	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_f=
rame *cf,
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct canfd=
_frame *cf,
 				     u32 *timestamp, unsigned int mb);
=20
 	struct sk_buff_head skb_queue;
@@ -35,6 +35,8 @@ struct can_rx_offload {
 	struct napi_struct napi;
=20
 	bool inc;
+
+	bool is_canfd;
 };
=20
 int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_off=
load *offload);
--=20
2.17.1
