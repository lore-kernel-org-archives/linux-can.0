From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2] can: dev: call netif_carrier_off() in register_candev()
Date: Mon, 22 Jul 2019 14:04:50 +0000
Message-ID: <20190722140429.19782-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, Willem de Bruijn <willemb@google.com>
List-Id: linux-can.vger.kernel.org

CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
trigger as suggested, there's a small inconsistency with the link
property: The LED is on initially, stays on when the device is brought
up, and then turns off (as expected) when the device is brought down.

Make sure the LED always reflects the state of the CAN device.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Acked-by: Willem de Bruijn <willemb@google.com>
---
v2: resending with proper subject (no net-next) and Willem's ack.

 drivers/net/can/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c05e4d50d43d..fad27ace6248 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1260,6 +1260,7 @@ int register_candev(struct net_device *dev)
 		return -EINVAL;
=20
 	dev->rtnl_link_ops =3D &can_link_ops;
+	netif_carrier_off(dev);
 	return register_netdev(dev);
 }
 EXPORT_SYMBOL_GPL(register_candev);
--=20
2.20.1
