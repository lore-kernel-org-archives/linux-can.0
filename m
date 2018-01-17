From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] j1939: remove priv->ifindex
Date: Wed, 17 Jan 2018 12:37:49 +0100
Message-ID: <20180117113749.2466-1-o.rempel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42049 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeAQLhw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 06:37:52 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>

ifindex is used only in one place for debugging.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/bus.c        | 5 +----
 net/can/j1939/j1939-priv.h | 1 -
 net/can/j1939/main.c       | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index fb6b701562c8..9ba6da216c1b 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -22,10 +22,7 @@
 #include "j1939-priv.h"
 
 #define ecu_dbg(ecu, fmt, ...) \
-	pr_debug("j1939-%i,%016llx,%02x: " fmt, (ecu)->priv->ifindex, \
-		(ecu)->name, (ecu)->sa, ##__VA_ARGS__)
-#define ecu_alert(ecu, fmt, ...) \
-	pr_alert("j1939-%i,%016llx,%02x: " fmt, (ecu)->priv->ifindex, \
+	pr_debug("j1939-%i,%016llx,%02x: " fmt, (ecu)->priv->netdev->ifindex, \
 		(ecu)->name, (ecu)->sa, ##__VA_ARGS__)
 
 /* ECU device interface */
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index da37056ba5e5..3c4fb88f7816 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -72,7 +72,6 @@ struct j1939_priv {
 	/* segments need a lock to protect the above list */
 	rwlock_t lock;
 
-	int ifindex;			/* TODO: redundant with netdev? */
 	struct net_device *netdev;
 
 	/* list of 256 ecu ptrs, that cache the claimed addresses.
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 86cdcc18338a..36ceedb2e403 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -220,7 +220,6 @@ int j1939_netdev_start(struct net_device *netdev)
 	rwlock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->ecus);
 	priv->netdev = netdev;
-	priv->ifindex = netdev->ifindex;
 	kref_init(&priv->kref);
 	dev_hold(netdev);
 
-- 
2.11.0

