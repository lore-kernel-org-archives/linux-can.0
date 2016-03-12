From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration options
Date: Sat, 12 Mar 2016 19:31:27 +0100
Message-ID: <1457807487-14691-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:37469 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcCLScA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 12 Mar 2016 13:32:00 -0500
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
 include/linux/can/dev.h       | 14 ++++++++++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 141c2a4..88599f4 100644
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
+		/* check for CANFD capability */
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
index 39cf911..6952321 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -955,7 +955,7 @@ static struct net_device *alloc_m_can_dev(void)
 	priv->can.do_get_berr_counter = m_can_get_berr_counter;
 
 	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
-	priv->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
+	can_set_static_ctrlmode(&priv->can, CAN_CTRLMODE_FD_NON_ISO);
 
 	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1 */
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 735f9f8..afd23c2 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -40,8 +40,11 @@ struct can_priv {
 	struct can_clock clock;
 
 	enum can_state state;
-	u32 ctrlmode;
-	u32 ctrlmode_supported;
+
+	/* CAN controller feature bitfield see include/uapi/linux/can/netlink.h */
+	u32 ctrlmode;		/* current setting */
+	u32 ctrlmode_static;	/* fixed enabled options required by driver/hardware */
+	u32 ctrlmode_supported;	/* options that can be modified by netlink command */
 
 	int restart_ms;
 	struct timer_list restart_timer;
@@ -108,6 +111,13 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 	return skb->len == CANFD_MTU;
 }
 
+static inline void can_set_static_ctrlmode(struct can_priv *priv,
+					   const u32 static_mode)
+{
+	priv->ctrlmode = static_mode;
+	priv->ctrlmode_static = static_mode;
+}
+
 /* get data length from can_dlc with sanitized can_dlc */
 u8 can_dlc2len(u8 can_dlc);
 
-- 
2.7.0

