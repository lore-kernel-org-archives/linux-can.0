From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] Read all data from socket in do_get_nl_link
Date: Wed,  1 Aug 2012 14:57:02 +0200
Message-ID: <1343825822-19607-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33854 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752612Ab2HAM5J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 08:57:09 -0400
Received: from comm.systec-electronic.de (95-91-85-164-dynip.superkabel.de [95.91.85.164])
	by webbox1416.server-home.net (Postfix) with ESMTPA id C025B27A569
	for <linux-can@vger.kernel.org>; Wed,  1 Aug 2012 15:07:34 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

recvmsg might not return all interface data at once. Use a non-blocking
socket and read several times until there is no more data.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Without that patch I only get the data for lo, eth0 and eth2 (I printed
RTA_DATA(tb[IFLA_IFNAME]))), even eth1 is missing here.
With that patch I get the data for all my 10 interfaces I currently have.

 src/libsocketcan.c |  231 +++++++++++++++++++++++++++-------------------------
 1 files changed, 119 insertions(+), 112 deletions(-)

diff --git a/src/libsocketcan.c b/src/libsocketcan.c
index 26da338..b3815c1 100644
--- a/src/libsocketcan.c
+++ b/src/libsocketcan.c
@@ -258,6 +258,7 @@ static int open_nl_sock()
 	int fd;
 	int sndbuf = 32768;
 	int rcvbuf = 32768;
+	int flags;
 	unsigned int addr_len;
 	struct sockaddr_nl local;
 
@@ -271,6 +272,10 @@ static int open_nl_sock()
 
 	setsockopt(fd, SOL_SOCKET, SO_RCVBUF, (void *)&rcvbuf, sizeof(rcvbuf));
 
+	if (-1 == (flags = fcntl(fd, F_GETFL, 0)))
+		flags = 0;
+	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+
 	memset(&local, 0, sizeof(local));
 	local.nl_family = AF_NETLINK;
 	local.nl_groups = 0;
@@ -349,43 +354,40 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 		return ret;
 	}
 
-	if ((msglen = recvmsg(fd, &msg, 0)) <= 0) {
-		perror("Receive error");
-		return ret;
-	}
-	size_t u_msglen = (size_t) msglen;
-	/* Check to see if the buffers in msg get truncated */
-	if (msg.msg_namelen != sizeof(peer) ||
-	    (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
-		fprintf(stderr, "Uhoh... truncated message.\n");
-		return ret;
-	}
+	while ((msglen = recvmsg(fd, &msg, 0)) > 0) {
+		size_t u_msglen = (size_t) msglen;
+		/* Check to see if the buffers in msg get truncated */
+		if (msg.msg_namelen != sizeof(peer) ||
+		    (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC))) {
+			fprintf(stderr, "Uhoh... truncated message.\n");
+			return ret;
+		}
 
-	for (nl_msg = (struct nlmsghdr *)nlbuf;
-	     NLMSG_OK(nl_msg, u_msglen);
-	     nl_msg = NLMSG_NEXT(nl_msg, u_msglen)) {
-		int type = nl_msg->nlmsg_type;
-		int len;
-		if (type != RTM_NEWLINK)
-			continue;
+		for (nl_msg = (struct nlmsghdr *)nlbuf;
+		    NLMSG_OK(nl_msg, u_msglen);
+		    nl_msg = NLMSG_NEXT(nl_msg, u_msglen)) {
+			int type = nl_msg->nlmsg_type;
+			int len;
+			if (type != RTM_NEWLINK)
+				continue;
 
-		struct ifinfomsg *ifi = NLMSG_DATA(nl_msg);
-		struct rtattr *tb[IFLA_MAX + 1];
+			struct ifinfomsg *ifi = NLMSG_DATA(nl_msg);
+			struct rtattr *tb[IFLA_MAX + 1];
 
-		len =
-		    nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
-		parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
+			len =
+			    nl_msg->nlmsg_len - NLMSG_LENGTH(sizeof(struct ifaddrmsg));
+			parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), len);
 
-		if (strncmp
-		    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
-		     sizeof(name)) != 0)
-			continue;
+			if (strncmp
+			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
+			    sizeof(name)) != 0)
+				continue;
 
-		if (tb[IFLA_LINKINFO])
-			parse_rtattr_nested(linkinfo,
-					    IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
-		else
-			continue;
+			if (tb[IFLA_LINKINFO])
+				parse_rtattr_nested(linkinfo,
+						    IFLA_INFO_MAX, tb[IFLA_LINKINFO]);
+			else
+				continue;
 
 		if (acquire == GET_XSTATS) {
 			if (!linkinfo[IFLA_INFO_XSTATS])
@@ -398,92 +400,97 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
 			continue;
 		}
 
-		if (!linkinfo[IFLA_INFO_DATA]) {
-			fprintf(stderr, "no link data found\n");
-			return ret;
-		}
-
-		parse_rtattr_nested(can_attr, IFLA_CAN_MAX,
-				    linkinfo[IFLA_INFO_DATA]);
-
-		switch (acquire) {
-		case GET_STATE:
-			if (can_attr[IFLA_CAN_STATE]) {
-				*((int *)res) = *((__u32 *)
-						  RTA_DATA(can_attr
-							   [IFLA_CAN_STATE]));
-				ret = 0;
-			} else {
-				fprintf(stderr, "no state data found\n");
+			if (!linkinfo[IFLA_INFO_DATA]) {
+				fprintf(stderr, "no link data found\n");
+				return ret;
 			}
 
-			break;
-		case GET_RESTART_MS:
-			if (can_attr[IFLA_CAN_RESTART_MS]) {
-				*((__u32 *) res) = *((__u32 *)
-						     RTA_DATA(can_attr
-							      [IFLA_CAN_RESTART_MS]));
-				ret = 0;
-			} else
-				fprintf(stderr, "no restart_ms data found\n");
-
-			break;
-		case GET_BITTIMING:
-			if (can_attr[IFLA_CAN_BITTIMING]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BITTIMING]),
-				       sizeof(struct can_bittiming));
-				ret = 0;
-			} else
-				fprintf(stderr, "no bittiming data found\n");
-
-			break;
-		case GET_CTRLMODE:
-			if (can_attr[IFLA_CAN_CTRLMODE]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_CTRLMODE]),
-				       sizeof(struct can_ctrlmode));
-				ret = 0;
-			} else
-				fprintf(stderr, "no ctrlmode data found\n");
+			parse_rtattr_nested(can_attr, IFLA_CAN_MAX,
+					    linkinfo[IFLA_INFO_DATA]);
 
-			break;
-		case GET_CLOCK:
-			if (can_attr[IFLA_CAN_CLOCK]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_CLOCK]),
-				       sizeof(struct can_clock));
-				ret = 0;
-			} else
-				fprintf(stderr,
-					"no clock parameter data found\n");
-
-			break;
-		case GET_BITTIMING_CONST:
-			if (can_attr[IFLA_CAN_BITTIMING_CONST]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BITTIMING_CONST]),
-				       sizeof(struct can_bittiming_const));
-				ret = 0;
-			} else
-				fprintf(stderr, "no bittiming_const data found\n");
-
-			break;
-		case GET_BERR_COUNTER:
-			if (can_attr[IFLA_CAN_BERR_COUNTER]) {
-				memcpy(res,
-				       RTA_DATA(can_attr[IFLA_CAN_BERR_COUNTER]),
-				       sizeof(struct can_berr_counter));
-				ret = 0;
-			} else
-				fprintf(stderr, "no berr_counter data found\n");
-
-			break;
+			switch (acquire) {
+			case GET_STATE:
+				if (can_attr[IFLA_CAN_STATE]) {
+					*((int *)res) = *((__u32 *)
+							  RTA_DATA(can_attr
+								  [IFLA_CAN_STATE]));
+					ret = 0;
+				} else {
+					fprintf(stderr, "no state data found\n");
+				}
 
-		default:
-			fprintf(stderr, "unknown acquire mode\n");
+				break;
+			case GET_RESTART_MS:
+				if (can_attr[IFLA_CAN_RESTART_MS]) {
+					*((__u32 *) res) = *((__u32 *)
+							    RTA_DATA(can_attr
+								      [IFLA_CAN_RESTART_MS]));
+					ret = 0;
+				} else
+					fprintf(stderr, "no restart_ms data found\n");
+
+				break;
+			case GET_BITTIMING:
+				if (can_attr[IFLA_CAN_BITTIMING]) {
+					memcpy(res,
+					      RTA_DATA(can_attr[IFLA_CAN_BITTIMING]),
+					      sizeof(struct can_bittiming));
+					ret = 0;
+				} else
+					fprintf(stderr, "no bittiming data found\n");
+
+				break;
+			case GET_CTRLMODE:
+				if (can_attr[IFLA_CAN_CTRLMODE]) {
+					memcpy(res,
+					      RTA_DATA(can_attr[IFLA_CAN_CTRLMODE]),
+					      sizeof(struct can_ctrlmode));
+					ret = 0;
+				} else
+					fprintf(stderr, "no ctrlmode data found\n");
+
+				break;
+			case GET_CLOCK:
+				if (can_attr[IFLA_CAN_CLOCK]) {
+					memcpy(res,
+					      RTA_DATA(can_attr[IFLA_CAN_CLOCK]),
+					      sizeof(struct can_clock));
+					ret = 0;
+				} else
+					fprintf(stderr,
+						"no clock parameter data found\n");
+
+				break;
+			case GET_BITTIMING_CONST:
+				if (can_attr[IFLA_CAN_BITTIMING_CONST]) {
+					memcpy(res,
+					      RTA_DATA(can_attr[IFLA_CAN_BITTIMING_CONST]),
+					      sizeof(struct can_bittiming_const));
+					ret = 0;
+				} else
+					fprintf(stderr, "no bittiming_const data found\n");
+
+				break;
+			case GET_BERR_COUNTER:
+				if (can_attr[IFLA_CAN_BERR_COUNTER]) {
+					memcpy(res,
+					      RTA_DATA(can_attr[IFLA_CAN_BERR_COUNTER]),
+					      sizeof(struct can_berr_counter));
+					ret = 0;
+				} else
+					fprintf(stderr, "no berr_counter data found\n");
+
+				break;
+
+			default:
+				fprintf(stderr, "unknown acquire mode\n");
+			}
 		}
 	}
+	if ((msglen <= 0) && (errno != EAGAIN)) {
+		perror("Receive error");
+	}
+
 	return ret;
 }
 
-- 
1.7.8.6

