From: aj neu <ajneu1@gmail.com>
Subject: libsocketcan proposal for upstream (get typekind vcan or can, etc.)
Date: Fri, 23 Sep 2016 08:16:53 +0200
Message-ID: <CAPgtGZNhuinRb-gpj9QkTVnhfY8PE03JKoqhKm8Lw3g2s1+rzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32973 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757392AbcIWGQy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 23 Sep 2016 02:16:54 -0400
Received: by mail-it0-f65.google.com with SMTP id x192so431839itb.0
        for <linux-can@vger.kernel.org>; Thu, 22 Sep 2016 23:16:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

below, please find a patch which adds the following functions to libsocketcan

    device_exists, device_is_up, can_get_typekind

    int device_exists(const char *name);
     // determine if device is libsocketcan-compatible and exists

    int device_is_up(const char *name);
     // determine if device is up (also usable for vcan)

    int can_get_typekind(const char *name, char *buf, size_t buflen);
     // determine if typekind is "can" or "vcan"


The patch can be applied to
https://git.platon.pengutronix.de/cgit/tools/libsocketcan
as follows:
   git apply diff.patch


Can this be applied to upstream?

Thanks.
ajneu


diff --git a/include/libsocketcan.h b/include/libsocketcan.h
index dc52053..16fd60a 100644
--- a/include/libsocketcan.h
+++ b/include/libsocketcan.h
@@ -27,11 +27,15 @@
  */

 #include <can_netlink.h>
+#include <stddef.h>

 #ifdef __cplusplus
 extern "C" {
 #endif

+int device_exists(const char *name);
+int device_is_up(const char *name);
+
 int can_do_restart(const char *name);
 int can_do_stop(const char *name);
 int can_do_start(const char *name);
@@ -46,6 +50,7 @@ int can_get_restart_ms(const char *name, __u32 *restart_ms);
 int can_get_bittiming(const char *name, struct can_bittiming *bt);
 int can_get_ctrlmode(const char *name, struct can_ctrlmode *cm);
 int can_get_state(const char *name, int *state);
+int can_get_typekind(const char *name, char *buf, size_t buflen);
 int can_get_clock(const char *name, struct can_clock *clock);
 int can_get_bittiming_const(const char *name, struct can_bittiming_const *btc);
 int can_get_berr_counter(const char *name, struct can_berr_counter *bc);
diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index c97a28c..7c7f9bb 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -46,6 +46,10 @@
 #define IF_UP 1
 #define IF_DOWN 2

+#ifndef IFF_UP
+#define IFF_UP IF_UP
+#endif
+
 #define GET_STATE 1
 #define GET_RESTART_MS 2
 #define GET_BITTIMING 3
@@ -54,6 +58,9 @@
 #define GET_BITTIMING_CONST 6
 #define GET_BERR_COUNTER 7
 #define GET_XSTATS 8
+#define GET_TYPEKIND 9
+#define GET_DEVICEEXISTS 10
+#define GET_DEVICE_UP 11

 struct get_req {
     struct nlmsghdr n;
@@ -74,6 +81,11 @@ struct req_info {
     struct can_bittiming *bittiming;
 };

+struct str_buf {
+    char * buf;
+    const size_t capacity; // storage capacity of buf: number of bytes
+};
+
 static void
 parse_rtattr(struct rtattr **tb, int max, struct rtattr *rta, int len)
 {
@@ -389,7 +401,8 @@ static int do_get_nl_link(int fd, __u8 acquire,
const char *name, void *res)
             else
                 continue;

-            if (acquire == GET_XSTATS) {
+            switch (acquire) {
+            case GET_XSTATS:
                 if (!linkinfo[IFLA_INFO_XSTATS])
                     fprintf(stderr, "no can statistics found\n");
                 else {
@@ -398,6 +411,30 @@ static int do_get_nl_link(int fd, __u8 acquire,
const char *name, void *res)
                     ret = 0;
                 }
                 continue;
+
+            case GET_TYPEKIND:
+                if (!linkinfo[IFLA_INFO_KIND])
+                    fprintf(stderr, "no type-kind found\n");
+                else {
+                    const size_t buflen = ((struct str_buf *)res)->capacity;
+                    if (buflen) {
+                        char * const buf = ((struct str_buf *)res)->buf;
+                        *buf = '\0';
+                        strncat(buf,
RTA_DATA(linkinfo[IFLA_INFO_KIND]), buflen-1);
+                    }
+                    ret = 0;
+                }
+                continue;
+
+            case GET_DEVICEEXISTS:
+                ret = 0;
+                continue;
+
+            case GET_DEVICE_UP:
+                if ((ifi->ifi_flags & IFF_UP) == IFF_UP) {
+                    ret = 0;
+                }
+                continue;
             }

             if (!linkinfo[IFLA_INFO_DATA]) {
@@ -652,6 +689,38 @@ static int set_link(const char *name, __u8
if_state, struct req_info *req_info)

 /**
  * @ingroup extern
+ * device_exists - return non-zero if the device exists
+ *
+ * @param name name of the device. This is the netdev name, as
ifconfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the can
+ * line. e.g. "can0"
+ *
+ * @return 1 if device exists
+ * @return 0 if device does not exist
+ */
+int device_exists(const char *name)
+{
+    return !get_link(name, GET_DEVICEEXISTS, NULL);
+}
+
+/**
+ * @ingroup extern
+ * device_is_up - return non-zero if the device is up
+ *
+ * @param name name of the device. This is the netdev name, as
ifconfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the can
+ * line. e.g. "can0"
+ *
+ * @return 1 if device is up
+ * @return 0 if device is not up
+ */
+int device_is_up(const char *name)
+{
+    return !get_link(name, GET_DEVICE_UP, NULL);
+}
+
+/**
+ * @ingroup extern
  * can_do_start - start the can interface
  * @param name name of the can device. This is the netdev name, as
ifconfig -a shows
  * in your system. usually it contains prefix "can" and the numer of the can
@@ -961,6 +1030,25 @@ int can_get_state(const char *name, int *state)

 /**
  * @ingroup extern
+ * can_get_typekind - get the type (kind) of the netlink, i.e. can or vcan
+ *
+ * @param name name of the can device. This is the netdev name, as
ifconfig -a shows
+ * in your system. usually it contains prefix "can" and the numer of the can
+ * line. e.g. "can0"
+ * @param buf pointer to the first element of a string buffer, to
store the kind
+ * @param buflen length of the string buffer (at most buflen-1 chars
will be written)
+ *
+ * @return 0 if success
+ * @return -1 if failed
+ */
+int can_get_typekind(const char *name, char *buf, size_t buflen)
+{
+    struct str_buf sbuf = { buf, buflen };
+    return get_link(name, GET_TYPEKIND, &sbuf);
+}
+
+/**
+ * @ingroup extern
  * can_get_restart_ms - get the current interval of auto restarting.
  *
  * @param name name of the can device. This is the netdev name, as
ifconfig -a shows
