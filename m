From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] [PATCH v3] can: fix handling of unmodifiable configuration options
Date: Mon, 14 Mar 2016 20:08:10 +0100
Message-ID: <1457982490-27520-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:16793 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbcCNTI2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Mar 2016 15:08:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: ramesh.shanmugasundaram@bp.renesas.com, Oliver Hartkopp <socketcan@hartkopp.net>

As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
(6cfda7fbebe) it is possible to define fixed configuration options by
setting the according bit in 'ctrlmode' and clear it in 'ctrlmode_supported'.
This leads to the incovenience that the fixed configuration can not be passed
by netlink (ip tool) even when it has the correct value (e.g. non-ISO, FD).

This patch fixes that issue and allows fixed set bit values to be set again
which does not change the unmodifiable content. For this reason a new helper
can_set_static_ctrlmode() has been introduced to provide a proper interface to
handle static enabled CAN controller options.

Additionally it fixes the inconsitency that was prohibiting the support of
'CANFD-only' controller drivers.

Reported-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c         | 18 +++++++++++++++---
 drivers/net/can/m_can/m_can.c |  2 +-
 include/linux/can/dev.h       | 22 ++++++++++++++++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 141c2a4..da1578d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -696,11 +696,17 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 	/* allow change of MTU according to the CANFD ability of the device */
 	switch (new_mtu) {
 	case CAN_MTU:
+		/* 'CANFD-only' controllers can not switch to CAN_MTU */
+		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
+			return -EINVAL;
+
 		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
 		break;
 
 	case CANFD_MTU:
-		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
+		/* check for potential CANFD ability */
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
+		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
 			return -EINVAL;
 
 		priv->ctrlmode |= CAN_CTRLMODE_FD;
@@ -819,8 +825,14 @@ static int can_changelink(struct net_device *dev,
 			return -EBUSY;
 		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		/* check whether changed bits are allowed to be modified */
-		if (cm->mask & ~priv->ctrlmode_supported)
+		/* check whether provided bits are allowed to be passed */
+		if (cm->mask &
+		    ~(priv->ctrlmode_supported | priv->ctrlmode_static))
+			return -EOPNOTSUPP;
+
+		/* make sure static options are not accidently cleared */
+		if ((cm->mask & priv->ctrlmode_static & cm->flags) !=
+		    (cm->mask & priv->ctrlmode_static))
 			return -EOPNOTSUPP;
 
 		/* clear bits to be modified and copy the flag values */
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 39cf911..195f15e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -955,7 +955,7 @@ static struct net_device *alloc_m_can_dev(void)
 	priv->can.do_get_berr_counter = m_can_get_berr_counter;
 
 	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
-	priv->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
+	can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
 
 	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 735f9f8..098243b 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -40,8 +40,11 @@ struct can_priv {
 	struct can_clock clock;
 
 	enum can_state state;
-	u32 ctrlmode;
-	u32 ctrlmode_supported;
+
+	/* CAN controller features - see include/uapi/linux/can/netlink.h */
+	u32 ctrlmode;		/* current options setting */
+	u32 ctrlmode_supported;	/* options that can be modified by netlink */
+	u32 ctrlmode_static;	/* static enabled options for driver/hardware */
 
 	int restart_ms;
 	struct timer_list restart_timer;
@@ -108,6 +111,21 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 	return skb->len == CANFD_MTU;
 }
 
+/* helper to define static CAN controller features at device creation time */
+static inline void can_set_static_ctrlmode(struct net_device *dev,
+					   const u32 static_mode)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* alloc_candev() succeeded => netdev_priv() is valid at this point */
+	priv->ctrlmode = static_mode;
+	priv->ctrlmode_static = static_mode;
+
+	/* override MTU which was set by default in can_setup()? */
+	if (static_mode & CAN_CTRLMODE_FD)
+		dev->mtu = CANFD_MTU;
+}
+
 /* get data length from can_dlc with sanitized can_dlc */
 u8 can_dlc2len(u8 can_dlc);
 
-- 
2.7.0

