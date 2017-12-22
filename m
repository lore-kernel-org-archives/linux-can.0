From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 1/6] can: dev: Add support for limiting configured bitrate
Date: Fri, 22 Dec 2017 19:01:23 +0530
Message-ID: <1513949488-13026-2-git-send-email-faiz_abbas@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, faiz_abbas-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-can.vger.kernel.org

From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>

Various CAN or CAN-FD IP may be able to run at a faster rate than
what the transceiver the CAN node is connected to. This can lead to
unexpected errors. However, CAN transceivers typically have fixed
limitations and provide no means to discover these limitations at
runtime. Therefore, add support for a can-transceiver node that
can be reused by other CAN peripheral drivers to determine for both
CAN and CAN-FD what the max bitrate that can be used. If the user
tries to configure CAN to pass these maximum bitrates it will throw
an error.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
[nsekhar-l0cyMroinI0@public.gmane.org: fix build error with !CONFIG_OF]
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
---
v6 changes:
fix build error with !CONFIG_OF

 drivers/net/can/dev.c   | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 365a8cc..007cfc0 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -27,6 +27,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/netlink.h>
 #include <linux/can/led.h>
+#include <linux/of.h>
 #include <net/rtnetlink.h>
 
 #define MOD_DESC "CAN device driver interface"
@@ -814,6 +815,30 @@ int open_candev(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(open_candev);
 
+#ifdef CONFIG_OF
+/*
+ * Common function that can be used to understand the limitation of
+ * a transceiver when it provides no means to determine these limitations
+ * at runtime.
+ */
+void of_can_transceiver(struct net_device *dev)
+{
+	struct device_node *dn;
+	struct can_priv *priv = netdev_priv(dev);
+	struct device_node *np = dev->dev.parent->of_node;
+	int ret;
+
+	dn = of_get_child_by_name(np, "can-transceiver");
+	if (!dn)
+		return;
+
+	ret = of_property_read_u32(dn, "max-bitrate", &priv->max_bitrate);
+	if ((ret && ret != -EINVAL) || (!ret && !priv->max_bitrate))
+		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
+}
+EXPORT_SYMBOL_GPL(of_can_transceiver);
+#endif
+
 /*
  * Common close function for cleanup before the device gets closed.
  *
@@ -913,6 +938,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 					priv->bitrate_const_cnt);
 		if (err)
 			return err;
+
+		if (priv->max_bitrate && bt.bitrate > priv->max_bitrate) {
+			netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
+				   priv->max_bitrate);
+			return -EINVAL;
+		}
+
 		memcpy(&priv->bittiming, &bt, sizeof(bt));
 
 		if (priv->do_set_bittiming) {
@@ -997,6 +1029,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 					priv->data_bitrate_const_cnt);
 		if (err)
 			return err;
+
+		if (priv->max_bitrate && dbt.bitrate > priv->max_bitrate) {
+			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
+				   priv->max_bitrate);
+			return -EINVAL;
+		}
+
 		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
 
 		if (priv->do_set_data_bittiming) {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 61f1cf2..fbb7810 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -48,6 +48,8 @@ struct can_priv {
 	unsigned int data_bitrate_const_cnt;
 	struct can_clock clock;
 
+	unsigned int max_bitrate;
+
 	enum can_state state;
 
 	/* CAN controller features - see include/uapi/linux/can/netlink.h */
@@ -166,6 +168,12 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
+#ifdef CONFIG_OF
+void of_can_transceiver(struct net_device *dev);
+#else
+static inline void of_can_transceiver(struct net_device *dev) { }
+#endif
+
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
 struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
