From: Reuben Dowle <Reuben.Dowle@navico.com>
Subject: [libsocketcan] Add can_get_link_stats()
Date: Mon, 5 Mar 2012 23:00:02 +0000
Message-ID: <6686CF564BC462488080D46D3C933CA4089576@EXCH02-AKLNZ.MARINE.NET.INT>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vw-hfger.navico.com ([81.89.228.210]:4876 "EHLO
	VW-HFGER.navico.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407Ab2CEXKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Mar 2012 18:10:34 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Add can_get_link_stats()

This function gets link_stats64 information for the can interface.
This structure can be for any interface (not just can), but it
seems logical to keep functions for getting any statistics relevant
to CAN in this library.

Signed-off-by: Reuben Dowle <reuben.dowle@navico.com>

diff --git a/include/libsocketcan.h b/include/libsocketcan.h
index dc52053..06b37d6 100644
--- a/include/libsocketcan.h
+++ b/include/libsocketcan.h
@@ -50,6 +50,7 @@ int can_get_clock(const char *name, struct can_clock *clock);
 int can_get_bittiming_const(const char *name, struct can_bittiming_const *btc);
 int can_get_berr_counter(const char *name, struct can_berr_counter *bc);
 int can_get_device_stats(const char *name, struct can_device_stats *cds);
+int can_get_link_stats(const char *name, struct rtnl_link_stats64 *ls);
 
 #ifdef __cplusplus
 }
diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 26da338..ed33332 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -54,6 +54,7 @@
 #define GET_BITTIMING_CONST 6
 #define GET_BERR_COUNTER 7
 #define GET_XSTATS 8
+#define GET_LINK_STATS64 9
 
 struct get_req {
 	struct nlmsghdr n;
@@ -380,6 +381,19 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 		    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
 		     sizeof(name)) != 0)
 			continue;
+		
+		if (acquire == GET_LINK_STATS64) {
+			if (!tb[IFLA_STATS64]) {
+				fprintf(stderr, "no link_stats64 data found\n");
+			}
+			else {
+				memcpy(res,
+				       RTA_DATA(tb[IFLA_STATS64]),
+				       sizeof(struct rtnl_link_stats64));
+				ret = 0;
+			}
+			continue;
+		}
 
 		if (tb[IFLA_LINKINFO])
 			parse_rtattr_nested(linkinfo,
@@ -1154,3 +1168,24 @@ int can_get_device_stats(const char *name, struct can_device_stats *cds)
 {
 	return get_link(name, GET_XSTATS, cds);
 }
+
+/**
+ * @ingroup extern
+ * can_get_link_stats - get the rtnl_link_stats64.
+ *
+ * @param name name of the can device. This is the netdev name, as ifconfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the can
+ * line. e.g. "can0"
+ * @param bc pointer to the error counter struct..
+ *
+ * This one gets the current rtnl_link_stats64.
+ *
+ * Please see struct rtnl_link_stats64 for more information.
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+int can_get_link_stats(const char *name, struct rtnl_link_stats64 *ls)
+{
+	return get_link(name, GET_LINK_STATS64, ls);
+}


