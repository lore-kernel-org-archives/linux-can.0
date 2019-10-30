From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [RFC PATCH] can: dev: Add check for the minimum value of a bit time
Date: Wed, 30 Oct 2019 06:45:54 +0000
Message-ID: <20191030064245.12923-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

As ISO 11898-1 said: The total number of time quanta in a nominal bit
time shall be programmable at least from 8 to 25 for implementation that
are not FD enabled. For implementations that are FD enabled, the total
number of time quanta in a data bit time shall be programmable at least
from 5 to 25 and in a nominal bit time at least from 8 to 80.

So the minimum value for nominal bit time is 8 and for data bit time is
5, had better ensure the minimum value of a bit time.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/dev.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index ac86be52b461..69e693c79579 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -115,7 +115,8 @@ can_update_sample_point(const struct can_bittiming_cons=
t *btc,
 	return best_sample_point;
 }
=20
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming=
 *bt,
+static int can_calc_bittiming(struct net_device *dev, bool is_data_bt,
+			      struct can_bittiming *bt,
 			      const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv =3D netdev_priv(dev);
@@ -147,6 +148,14 @@ static int can_calc_bittiming(struct net_device *dev, =
struct can_bittiming *bt,
 	     tseg >=3D (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
 		tsegall =3D CAN_CALC_SYNC_SEG + tseg / 2;
=20
+		/* the total number of time quanta in a data bit time
+		 * (SYNC_SEG + TSEG1 + TSEG2) shall be programmable at least 5.
+		 * the total number of time quanta in a nominal bit time
+		 * (SYNC_SEG + TSEG1 + TSEG2) shall be programmable at least 8.
+		 */
+		if ((is_data_bt && tsegall < 5) || (!is_data_bt && tsegall < 8))
+			continue;
+
 		/* Compute all possible tseg choices (tseg=3Dtseg1+tseg2) */
 		brp =3D priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
=20
@@ -228,7 +237,8 @@ static int can_calc_bittiming(struct net_device *dev, s=
truct can_bittiming *bt,
 	return 0;
 }
 #else /* !CONFIG_CAN_CALC_BITTIMING */
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming=
 *bt,
+static int can_calc_bittiming(struct net_device *dev, bool is_data_bt,
+			      struct can_bittiming *bt,
 			      const struct can_bittiming_const *btc)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
@@ -241,7 +251,8 @@ static int can_calc_bittiming(struct net_device *dev, s=
truct can_bittiming *bt,
  * prescaler value brp. You can find more information in the header
  * file linux/can/netlink.h.
  */
-static int can_fixup_bittiming(struct net_device *dev, struct can_bittimin=
g *bt,
+static int can_fixup_bittiming(struct net_device *dev, bool is_data_bt,
+			       struct can_bittiming *bt,
 			       const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv =3D netdev_priv(dev);
@@ -269,6 +280,15 @@ static int can_fixup_bittiming(struct net_device *dev,=
 struct can_bittiming *bt,
 		return -EINVAL;
=20
 	alltseg =3D bt->prop_seg + bt->phase_seg1 + bt->phase_seg2 + 1;
+
+	/* the total number of time quanta in a data bit time
+	 * (SYNC_SEG + TSEG1 + TSEG2) shall be programmable at least 5.
+	 * the total number of time quanta in a nominal bit time
+	 * (SYNC_SEG + TSEG1 + TSEG2) shall be programmable at least 8.
+	 */
+	if ((is_data_bt && alltseg < 5) || (!is_data_bt && alltseg < 8))
+		return -EINVAL;
+
 	bt->bitrate =3D priv->clock.freq / (bt->brp * alltseg);
 	bt->sample_point =3D ((tseg1 + 1) * 1000) / alltseg;
=20
@@ -295,7 +315,8 @@ can_validate_bitrate(struct net_device *dev, struct can=
_bittiming *bt,
 	return 0;
 }
=20
-static int can_get_bittiming(struct net_device *dev, struct can_bittiming =
*bt,
+static int can_get_bittiming(struct net_device *dev, bool is_data_bt,
+			     struct can_bittiming *bt,
 			     const struct can_bittiming_const *btc,
 			     const u32 *bitrate_const,
 			     const unsigned int bitrate_const_cnt)
@@ -308,9 +329,9 @@ static int can_get_bittiming(struct net_device *dev, st=
ruct can_bittiming *bt,
 	 * provided directly which are then checked and fixed up.
 	 */
 	if (!bt->tq && bt->bitrate && btc)
-		err =3D can_calc_bittiming(dev, bt, btc);
+		err =3D can_calc_bittiming(dev, is_data_bt, bt, btc);
 	else if (bt->tq && !bt->bitrate && btc)
-		err =3D can_fixup_bittiming(dev, bt, btc);
+		err =3D can_fixup_bittiming(dev, is_data_bt, bt, btc);
 	else if (!bt->tq && bt->bitrate && bitrate_const)
 		err =3D can_validate_bitrate(dev, bt, bitrate_const,
 					   bitrate_const_cnt);
@@ -944,7 +965,7 @@ static int can_changelink(struct net_device *dev, struc=
t nlattr *tb[],
 			return -EOPNOTSUPP;
=20
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err =3D can_get_bittiming(dev, &bt,
+		err =3D can_get_bittiming(dev, false, &bt,
 					priv->bittiming_const,
 					priv->bitrate_const,
 					priv->bitrate_const_cnt);
@@ -1035,7 +1056,7 @@ static int can_changelink(struct net_device *dev, str=
uct nlattr *tb[],
=20
 		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
 		       sizeof(dbt));
-		err =3D can_get_bittiming(dev, &dbt,
+		err =3D can_get_bittiming(dev, true, &dbt,
 					priv->data_bittiming_const,
 					priv->data_bitrate_const,
 					priv->data_bitrate_const_cnt);
--=20
2.17.1
