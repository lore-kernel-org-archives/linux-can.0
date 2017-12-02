From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] vxcan: improve handling of missing peer name attribute
Date: Sat,  2 Dec 2017 18:48:52 +0100
Message-ID: <20171202174852.9618-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:14930 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdLBRtD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 2 Dec 2017 12:49:03 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Serhey Popovych <serhe.popovych@gmail.com>

Picking up the patch from Serhey Popovych (commit 191cdb3822e5df6b3c8,
"veth: Be more robust on network device creation when no attributes").

When the peer name attribute is not provided the former implementation tries
to register the given device name twice ... which leads to -EEXIST.
If only one device name is given apply an automatic generated and valid name
for the peer.

CC: Serhey Popovych <serhe.popovych@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/vxcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 8404e8852a0f..b4c4a2c76437 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -194,7 +194,7 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 		tbp = peer_tb;
 	}
 
-	if (tbp[IFLA_IFNAME]) {
+	if (ifmp && tbp[IFLA_IFNAME]) {
 		nla_strlcpy(ifname, tbp[IFLA_IFNAME], IFNAMSIZ);
 		name_assign_type = NET_NAME_USER;
 	} else {
-- 
2.15.0

