From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] ip: link add vxcan support
Date: Tue, 25 Apr 2017 10:59:50 +0200
Message-ID: <20170425085950.3252-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:8607 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1177033AbdDYJAD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 05:00:03 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Support the configuration of the Virtual CAN Tunnel (vxcan).
The code is derived from link_veth.c which implements a similar netlink
interface for the configuration of netdevice pairs.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

Hello Marc,

I created this patch to test the vxcan driver. As include/linux/can/vxcan.h
will be part of the standard update of iproute2, I will send the patch to
netdev-ML when this is done.

IIRC the latest extensions to support the termination API and the fixed
bitrate support is still not implemented in iproute2. Would you like to do
this? I'm currently more addicted to the namespace stuff.

Regards,
Oliver

 include/linux/can/vxcan.h | 12 +++++++
 ip/Makefile               |  2 +-
 ip/iplink_vxcan.c         | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/can/vxcan.h
 create mode 100644 ip/iplink_vxcan.c

diff --git a/include/linux/can/vxcan.h b/include/linux/can/vxcan.h
new file mode 100644
index 00000000..ffb0b715
--- /dev/null
+++ b/include/linux/can/vxcan.h
@@ -0,0 +1,12 @@
+#ifndef _UAPI_CAN_VXCAN_H
+#define _UAPI_CAN_VXCAN_H
+
+enum {
+	VXCAN_INFO_UNSPEC,
+	VXCAN_INFO_PEER,
+
+	__VXCAN_INFO_MAX
+#define VXCAN_INFO_MAX	(__VXCAN_INFO_MAX - 1)
+};
+
+#endif
diff --git a/ip/Makefile b/ip/Makefile
index 035d42c7..d5c6473a 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -2,7 +2,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     rtm_map.o iptunnel.o ip6tunnel.o tunnel.o ipneigh.o ipntable.o iplink.o \
     ipmaddr.o ipmonitor.o ipmroute.o ipprefix.o iptuntap.o iptoken.o \
     ipxfrm.o xfrm_state.o xfrm_policy.o xfrm_monitor.o iplink_dummy.o \
-    iplink_ifb.o iplink_nlmon.o iplink_team.o iplink_vcan.o \
+    iplink_ifb.o iplink_nlmon.o iplink_team.o iplink_vcan.o iplink_vxcan.o \
     iplink_vlan.o link_veth.o link_gre.o iplink_can.o iplink_xdp.o \
     iplink_macvlan.o ipl2tp.o link_vti.o link_vti6.o \
     iplink_vxlan.o tcp_metrics.o iplink_ipoib.o ipnetconf.o link_ip6tnl.o \
diff --git a/ip/iplink_vxcan.c b/ip/iplink_vxcan.c
new file mode 100644
index 00000000..0074ae38
--- /dev/null
+++ b/ip/iplink_vxcan.c
@@ -0,0 +1,87 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <net/if.h>
+#include <linux/can/vxcan.h>
+
+#include "utils.h"
+#include "ip_common.h"
+
+static void print_usage(FILE *f)
+{
+	printf("Usage: ip link <options> type vxcan [peer <options>]\n"
+	       "To get <options> type 'ip link add help'\n");
+}
+
+static void usage(void)
+{
+	print_usage(stderr);
+}
+
+static int vxcan_parse_opt(struct link_util *lu, int argc, char **argv,
+			  struct nlmsghdr *hdr)
+{
+	char *dev = NULL;
+	char *name = NULL;
+	char *link = NULL;
+	char *type = NULL;
+	int index = 0;
+	int err, len;
+	struct rtattr *data;
+	int group;
+	struct ifinfomsg *ifm, *peer_ifm;
+	unsigned int ifi_flags, ifi_change;
+
+	if (strcmp(argv[0], "peer") != 0) {
+		usage();
+		return -1;
+	}
+
+	ifm = NLMSG_DATA(hdr);
+	ifi_flags = ifm->ifi_flags;
+	ifi_change = ifm->ifi_change;
+	ifm->ifi_flags = 0;
+	ifm->ifi_change = 0;
+
+	data = NLMSG_TAIL(hdr);
+	addattr_l(hdr, 1024, VXCAN_INFO_PEER, NULL, 0);
+
+	hdr->nlmsg_len += sizeof(struct ifinfomsg);
+
+	err = iplink_parse(argc - 1, argv + 1, (struct iplink_req *)hdr,
+			   &name, &type, &link, &dev, &group, &index);
+	if (err < 0)
+		return err;
+
+	if (name) {
+		len = strlen(name) + 1;
+		if (len > IFNAMSIZ)
+			invarg("\"name\" too long\n", *argv);
+		addattr_l(hdr, 1024, IFLA_IFNAME, name, len);
+	}
+
+	peer_ifm = RTA_DATA(data);
+	peer_ifm->ifi_index = index;
+	peer_ifm->ifi_flags = ifm->ifi_flags;
+	peer_ifm->ifi_change = ifm->ifi_change;
+	ifm->ifi_flags = ifi_flags;
+	ifm->ifi_change = ifi_change;
+
+	if (group != -1)
+		addattr32(hdr, 1024, IFLA_GROUP, group);
+
+	data->rta_len = (void *)NLMSG_TAIL(hdr) - (void *)data;
+	return argc - 1 - err;
+}
+
+static void vxcan_print_help(struct link_util *lu, int argc, char **argv,
+	FILE *f)
+{
+	print_usage(f);
+}
+
+struct link_util vxcan_link_util = {
+	.id = "vxcan",
+	.parse_opt = vxcan_parse_opt,
+	.print_help = vxcan_print_help,
+};
-- 
2.11.0

