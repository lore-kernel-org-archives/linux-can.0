From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 4/8] can: flexcan: add CANFD BRS support
Date: Fri, 12 Jul 2019 08:02:47 +0000
Message-ID: <20190712075926.7357-5-qiangqing.zhang@nxp.com>
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

This patch intends to add CAN FD BitRate Switch(BRS) support in driver.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 23e9407e33ff..4956ef64944a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -684,9 +684,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cfd->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	if (can_is_canfd_skb(skb))
+	if (can_is_canfd_skb(skb)) {
 		ctrl |=3D FLEXCAN_MB_CNT_EDL;
=20
+		if (cfd->flags & CANFD_BRS)
+			ctrl |=3D FLEXCAN_MB_CNT_BRS;
+	}
+
 	for (i =3D 0; i < cfd->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cfd->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
@@ -907,6 +911,9 @@ static unsigned int flexcan_mailbox_read(struct can_rx_=
offload *offload, bool dr
=20
 		if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
 			cfd->len =3D can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0x0F));
+
+			if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
+				cfd->flags |=3D CANFD_BRS;
 		} else {
 			cfd->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
=20
--=20
2.17.1
