From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 7/7] can: ti_hecc: add missing state changes
Date: Tue, 24 Sep 2019 18:46:06 +0000
Message-ID: <20190924184437.10607-8-jhofstee@victronenergy.com>
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

While the ti_hecc has interrupts to report when the error counters increase
to a certain level and which change state it doesn't handle the case that
the error counters go down again, so the reported state can actually be
wrong. Since there is no interrupt for that, do update state based on the
error counters, when the state is not error active and goes down again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6098725bfdea..c7c866da9c6a 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -689,6 +689,23 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *de=
v_id)
 			can_bus_off(ndev);
 			change_state(priv, rx_state, tx_state);
 		}
+	} else if (unlikely(priv->can.state !=3D CAN_STATE_ERROR_ACTIVE)) {
+		enum can_state new_state, tx_state, rx_state;
+		u32 rec =3D hecc_read(priv, HECC_CANREC);
+		u32 tec =3D hecc_read(priv, HECC_CANTEC);
+
+		if (rec >=3D 128 || tec >=3D 128)
+			new_state =3D CAN_STATE_ERROR_PASSIVE;
+		else if (rec >=3D 96 || tec >=3D 96)
+			new_state =3D CAN_STATE_ERROR_WARNING;
+		else
+			new_state =3D CAN_STATE_ERROR_ACTIVE;
+
+		if (new_state < priv->can.state) {
+			rx_state =3D rec >=3D tec ? new_state : 0;
+			tx_state =3D rec <=3D tec ? new_state : 0;
+			change_state(priv, rx_state, tx_state);
+		}
 	}
=20
 	if (int_status & HECC_CANGIF_GMIF) {
--=20
2.17.1
