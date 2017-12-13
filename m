From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH iproute2] ip: add vxcan to help text
Date: Wed, 13 Dec 2017 21:21:28 +0100
Message-ID: <20171213202128.4424-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:21221 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdLMUWN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Dec 2017 15:22:13 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Add missing tag 'vxcan' inside the help text which was missing in commit
efe459c76d35f ('ip: link add vxcan support').

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 ip/ipaddress.c | 2 +-
 ip/iplink.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 8057011e..f150d919 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -74,7 +74,7 @@ static void usage(void)
 	fprintf(stderr, "CONFFLAG  := [ home | nodad | mngtmpaddr | noprefixroute | autojoin ]\n");
 	fprintf(stderr, "LIFETIME := [ valid_lft LFT ] [ preferred_lft LFT ]\n");
 	fprintf(stderr, "LFT := forever | SECONDS\n");
-	fprintf(stderr, "TYPE := { vlan | veth | vcan | dummy | ifb | macvlan | macvtap |\n");
+	fprintf(stderr, "TYPE := { vlan | veth | vcan | vxcan | dummy | ifb | macvlan | macvtap |\n");
 	fprintf(stderr, "          bridge | bond | ipoib | ip6tnl | ipip | sit | vxlan | lowpan |\n");
 	fprintf(stderr, "          gre | gretap | erspan | ip6gre | ip6gretap | ip6erspan | vti |\n");
 	fprintf(stderr, "          nlmon | can | bond_slave | ipvlan | geneve | bridge_slave |\n");
diff --git a/ip/iplink.c b/ip/iplink.c
index 0a8eb56f..e83f1477 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -109,7 +109,7 @@ void iplink_usage(void)
 			"\n"
 			"       ip link help [ TYPE ]\n"
 			"\n"
-			"TYPE := { vlan | veth | vcan | dummy | ifb | macvlan | macvtap |\n"
+			"TYPE := { vlan | veth | vcan | vxcan | dummy | ifb | macvlan | macvtap |\n"
 			"          bridge | bond | team | ipoib | ip6tnl | ipip | sit | vxlan |\n"
 			"          gre | gretap | erspan | ip6gre | ip6gretap | ip6erspan |\n"
 			"          vti | nlmon | team_slave | bond_slave | ipvlan | geneve |\n"
-- 
2.15.1

