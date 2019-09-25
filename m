From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH] can: peakcan: report bus recovery as well
Date: Wed, 25 Sep 2019 08:58:45 +0000
Message-ID: <20190925085824.4708-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Stephane Grosjean <s.grosjean@peak-system.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

While the state changes are reported when the error counters increase
and decrease, there is no event when the bus recovers and the error
counters decrease again. So add those as well.

Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/=
peak_usb/pcan_usb.c
index 617da295b6c1..dd2a7f529012 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -436,8 +436,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_co=
ntext *mc, u8 n,
 		}
 		if ((n & PCAN_USB_ERROR_BUS_LIGHT) =3D=3D 0) {
 			/* no error (back to active state) */
-			mc->pdev->dev.can.state =3D CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			new_state =3D CAN_STATE_ERROR_ACTIVE;
+			break;
 		}
 		break;
=20
@@ -460,9 +460,9 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_co=
ntext *mc, u8 n,
 		}
=20
 		if ((n & PCAN_USB_ERROR_BUS_HEAVY) =3D=3D 0) {
-			/* no error (back to active state) */
-			mc->pdev->dev.can.state =3D CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			/* no error (back to warning state) */
+			new_state =3D CAN_STATE_ERROR_WARNING;
+			break;
 		}
 		break;
=20
@@ -501,6 +501,11 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_c=
ontext *mc, u8 n,
 		mc->pdev->dev.can.can_stats.error_warning++;
 		break;
=20
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->can_id |=3D CAN_ERR_CRTL;
+		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
+		break;
+
 	default:
 		/* CAN_STATE_MAX (trick to handle other errors) */
 		cf->can_id |=3D CAN_ERR_CRTL;
--=20
2.17.1
