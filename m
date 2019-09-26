From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 1/2] can: D_CAN: perform a sofware reset on open
Date: Thu, 26 Sep 2019 08:50:44 +0000
Message-ID: <20190926085005.24805-2-jhofstee@victronenergy.com>
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926085005.24805-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

When the C_CAN interface is closed it is put in power down mode, but
does not reset the error counters / state. So reset the D_CAN on open,
so the reported state and the actual state match.

According to [1], the C_CAN module doesn't have the software reset.

[1] http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/us=
ers_manual_c_can_fd8_r210_1.pdf

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/c_can/c_can.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 606b7d8ffe13..502a181d02e7 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -52,6 +52,7 @@
 #define CONTROL_EX_PDR		BIT(8)
=20
 /* control register */
+#define CONTROL_SWR		BIT(15)
 #define CONTROL_TEST		BIT(7)
 #define CONTROL_CCE		BIT(6)
 #define CONTROL_DISABLE_AR	BIT(5)
@@ -569,6 +570,26 @@ static void c_can_configure_msg_objects(struct net_dev=
ice *dev)
 				   IF_MCONT_RCV_EOB);
 }
=20
+static int software_reset(struct net_device *dev)
+{
+	struct c_can_priv *priv =3D netdev_priv(dev);
+	int retry =3D 0;
+
+	if (priv->type !=3D BOSCH_D_CAN)
+		return 0;
+
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_SWR | CONTROL_INIT);
+	while (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_SWR) {
+		msleep(20);
+		if (retry++ > 100) {
+			netdev_err(dev, "CCTRL: software reset failed\n");
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Configure C_CAN chip:
  * - enable/disable auto-retransmission
@@ -578,6 +599,11 @@ static void c_can_configure_msg_objects(struct net_dev=
ice *dev)
 static int c_can_chip_config(struct net_device *dev)
 {
 	struct c_can_priv *priv =3D netdev_priv(dev);
+	int err;
+
+	err =3D software_reset(dev);
+	if (err)
+		return err;
=20
 	/* enable automatic retransmission */
 	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
--=20
2.17.1
