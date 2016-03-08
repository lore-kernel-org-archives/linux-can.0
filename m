From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] [PATCH] can: fix handling of unmodifiable configuration options
Date: Tue,  8 Mar 2016 18:13:41 +0100
Message-ID: <1457457221-25068-1-git-send-email-socketcan@hartkopp.net>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: ramesh.shanmugasundaram@bp.renesas.com, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-stable 3 . 16+" <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
(6cfda7fbebe) it is possible to define fixed configuration options by
setting the according bit in 'ctrlmode' and clear it in 'ctrlmode_supported'.
This leads to the incovenience that the fixed configuration can not be passed
by netlink (ip tool) even when it has the correct value (e.g. non-ISO, FD).

This patch fixes that issue and allows fixed set bit values to be set again
which does not change the unmodifiable content.

Additionally it fixes the inconsitency that was prohibiting the support of
'CANFD-only' controller drivers.

Reported-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org> 3.16+
---
 drivers/net/can/dev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 141c2a4..b084cfd 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -696,11 +696,18 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 	/* allow change of MTU according to the CANFD ability of the device */
 	switch (new_mtu) {
 	case CAN_MTU:
+		/* take care of 'CANFD-only' controllers */
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
+		    (priv->ctrlmode & CAN_CTRLMODE_FD))
+			return -EINVAL;
+
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
 		break;
 
 	case CANFD_MTU:
-		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
+		/* check for CANFD capability */
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
+		    !(priv->ctrlmode & CAN_CTRLMODE_FD))
 			return -EINVAL;
 
 		priv->ctrlmode |= CAN_CTRLMODE_FD;
@@ -819,10 +826,13 @@ static int can_changelink(struct net_device *dev,
 			return -EBUSY;
 		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		/* check whether changed bits are allowed to be modified */
-		if (cm->mask & ~priv->ctrlmode_supported)
+		/* check whether provided bits are allowed to be passed */
+		if (cm->mask & ~(priv->ctrlmode_supported | priv->ctrlmode))
 			return -EOPNOTSUPP;
 
+		/* reduce to bits that are allowed to be modified */
+		cm->mask &= priv->ctrlmode_supported;
+
 		/* clear bits to be modified and copy the flag values */
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= (cm->flags & cm->mask);
-- 
2.7.0
