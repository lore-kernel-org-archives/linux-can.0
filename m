From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH v2 2/2] can: C_CAN: add bus recovery events
Date: Tue, 1 Oct 2019 21:01:24 +0000
Message-ID: <20191001210054.14588-3-jhofstee@victronenergy.com>
References: <20191001210054.14588-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191001210054.14588-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

While the state is updated when the error counters increase and decrease,
there is no event when the bus recovers and the error counters decrease
again. So add that event as well.

Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 2332687fa6dc..e1e9b87dd4d2 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -912,6 +912,9 @@ static int c_can_handle_state_change(struct net_device =
*dev,
 	struct can_berr_counter bec;
=20
 	switch (error_type) {
+	case C_CAN_NO_ERROR:
+		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+		break;
 	case C_CAN_ERROR_WARNING:
 		/* error warning state */
 		priv->can.can_stats.error_warning++;
@@ -942,6 +945,13 @@ static int c_can_handle_state_change(struct net_device=
 *dev,
 				ERR_CNT_RP_SHIFT;
=20
 	switch (error_type) {
+	case C_CAN_NO_ERROR:
+		/* error warning state */
+		cf->can_id |=3D CAN_ERR_CRTL;
+		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
+		cf->data[6] =3D bec.txerr;
+		cf->data[7] =3D bec.rxerr;
+		break;
 	case C_CAN_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |=3D CAN_ERR_CRTL;
@@ -1080,11 +1090,17 @@ static int c_can_poll(struct napi_struct *napi, int=
 quota)
 	/* handle bus recovery events */
 	if ((!(curr & STATUS_BOFF)) && (last & STATUS_BOFF)) {
 		netdev_dbg(dev, "left bus off state\n");
-		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+		work_done +=3D c_can_handle_state_change(dev, C_CAN_ERROR_PASSIVE);
 	}
+
 	if ((!(curr & STATUS_EPASS)) && (last & STATUS_EPASS)) {
 		netdev_dbg(dev, "left error passive state\n");
-		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+		work_done +=3D c_can_handle_state_change(dev, C_CAN_ERROR_WARNING);
+	}
+
+	if ((!(curr & STATUS_EWARN)) && (last & STATUS_EWARN)) {
+		netdev_dbg(dev, "left error warning state\n");
+		work_done +=3D c_can_handle_state_change(dev, C_CAN_NO_ERROR);
 	}
=20
 	/* handle lec errors on the bus */
--=20
2.17.1
