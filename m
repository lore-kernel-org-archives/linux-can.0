From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 2/7] can: ti_hecc: release the mailbox a bit earlier
Date: Tue, 24 Sep 2019 18:45:49 +0000
Message-ID: <20190924184437.10607-3-jhofstee@victronenergy.com>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924184437.10607-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Release the mailbox after reading it, so it can be reused a bit earlier.
Since "can: rx-offload: continue on error" all pending message bits are
cleared directly, so remove clearing them in ti_hecc.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index f8b19eef5d26..461c28ab6d66 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -526,8 +526,9 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_=
offload *offload,
 					 u32 *timestamp, unsigned int mbxno)
 {
 	struct ti_hecc_priv *priv =3D rx_offload_to_priv(offload);
-	u32 data;
+	u32 data, mbx_mask;
=20
+	mbx_mask =3D BIT(mbxno);
 	data =3D hecc_read_mbx(priv, mbxno, HECC_CANMID);
 	if (data & HECC_CANMID_IDE)
 		cf->can_id =3D (data & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -547,6 +548,7 @@ static unsigned int ti_hecc_mailbox_read(struct can_rx_=
offload *offload,
 	}
=20
 	*timestamp =3D hecc_read_stamp(priv, mbxno);
+	hecc_write(priv, HECC_CANRMP, mbx_mask);
=20
 	return 1;
 }
@@ -695,7 +697,6 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev=
_id)
 		while ((rx_pending =3D hecc_read(priv, HECC_CANRMP))) {
 			can_rx_offload_irq_offload_timestamp(&priv->offload,
 							     rx_pending);
-			hecc_write(priv, HECC_CANRMP, rx_pending);
 		}
 	}
=20
--=20
2.17.1
