From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] candump: support new raw socket option to join the given CAN filters
Date: Wed, 18 Mar 2015 08:25:26 +0100
Message-ID: <1426663526-10847-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:13424 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754959AbbCRHZg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Mar 2015 03:25:36 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The CAN_RAW socket can set multiple CAN identifier specific filters that lead
to multiple filters in the af_can.c filter processing. These filters are
indenpendent from each other which leads to logical OR'ed filters when applied.

This socket option joines the given CAN filters in the way that only CAN frames
are passed to user space that matched *all* given CAN filters. The semantic for
the applied filters is therefore changed to a logical AND.

This is useful especially when the filterset is a combination of filters where
the CAN_INV_FILTER flag is set in order to notch single CAN IDs or CAN ID
ranges from the incoming traffic.

Example:
	candump can0,100~7FF,200~7FF,400~7FF	(logical OR'ed filters)
	candump can0,100~7FF,200~7FF,400~7FF,J	(logical AND'ed filters)

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: print error message when kernel does not support CAN_RAW_JOIN_FILTERS

 candump.c               | 11 +++++++++++
 include/linux/can/raw.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/candump.c b/candump.c
index a1146f5..5daf622 100644
--- a/candump.c
+++ b/candump.c
@@ -131,6 +131,7 @@ void print_usage(char *prg)
 	fprintf(stderr, " <can_id>:<can_mask> (matches when <received_can_id> & mask == can_id & mask)\n");
 	fprintf(stderr, " <can_id>~<can_mask> (matches when <received_can_id> & mask != can_id & mask)\n");
 	fprintf(stderr, " #<error_mask>       (set error frame filter, see include/linux/can/error.h)\n");
+	fprintf(stderr, " [j|J]               (join the given CAN filters - logical AND semantic)\n");
 	fprintf(stderr, "\nCAN IDs, masks and data content are given and expected in hexadecimal values.\n");
 	fprintf(stderr, "When can_id and can_mask are both 8 digits, they are assumed to be 29 bit EFF.\n");
 	fprintf(stderr, "Without any given filter all data frames are received ('0:0' default filter).\n");
@@ -218,6 +219,7 @@ int main(int argc, char **argv)
 	int rcvbuf_size = 0;
 	int opt, ret;
 	int currmax, numfilter;
+	int join_filter;
 	char *ptr, *nptr;
 	struct sockaddr_can addr;
 	char ctrlmsg[CMSG_SPACE(sizeof(struct timeval)) + CMSG_SPACE(sizeof(__u32))];
@@ -467,6 +469,7 @@ int main(int argc, char **argv)
 
 			numfilter = 0;
 			err_mask = 0;
+			join_filter = 0;
 
 			while (nptr) {
 
@@ -484,6 +487,8 @@ int main(int argc, char **argv)
  					rfilter[numfilter].can_id |= CAN_INV_FILTER;
  					rfilter[numfilter].can_mask &= ~CAN_ERR_FLAG;
 					numfilter++;
+				} else if (*ptr == 'j' || *ptr == 'J') {
+					join_filter = 1;
 				} else if (sscanf(ptr, "#%x", &err_mask) != 1) { 
 					fprintf(stderr, "Error in filter option parsing: '%s'\n", ptr);
 					return 1;
@@ -494,6 +499,12 @@ int main(int argc, char **argv)
 				setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
 					   &err_mask, sizeof(err_mask));
 
+			if (join_filter && setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_JOIN_FILTERS,
+						      &join_filter, sizeof(join_filter)) < 0) {
+				perror("setsockopt CAN_RAW_JOIN_FILTERS not supported by your Linux Kernel");
+				return 1;
+			}
+
 			if (numfilter)
 				setsockopt(s[i], SOL_CAN_RAW, CAN_RAW_FILTER,
 					   rfilter, numfilter * sizeof(struct can_filter));
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index c7d8c33..c9e7c2e 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -57,6 +57,7 @@ enum {
 	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
 	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
 	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
+	CAN_RAW_JOIN_FILTERS,	/* all filters must match to trigger */
 };
 
 #endif
-- 
2.1.4

