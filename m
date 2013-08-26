From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-utils] cangw: add per rule limitation of frame hops option
Date: Mon, 26 Aug 2013 15:06:50 +0200
Message-ID: <521B52EA.7030802@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:53683 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab3HZNHb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Aug 2013 09:07:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Usually the received CAN frames can be processed/routed as much as 'max_hops'
times (which is given at module load time of the can-gw module).
Introduce a new configuration option to reduce the number of possible hops
for a specific gateway rule to a value smaller then max_hops.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/cangw.c b/cangw.c
index 802aa86..b908fe4 100644
--- a/cangw.c
+++ b/cangw.c
@@ -196,6 +196,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "Options:   -t (preserve src_dev rx timestamp)\n");
 	fprintf(stderr, "           -e (echo sent frames - recommended on vcanx)\n");
 	fprintf(stderr, "           -i (allow to route to incoming interface)\n");
+	fprintf(stderr, "           -l <hops> (limit the number of frame hops / routings)\n");
 	fprintf(stderr, "           -f <filter> (set CAN filter)\n");
 	fprintf(stderr, "           -m <mod> (set frame modifications)\n");
 	fprintf(stderr, "           -x <from_idx>:<to_idx>:<result_idx>:<init_xor_val> (XOR checksum)\n");
@@ -417,6 +418,7 @@ int parse_rtlist(char *prgname, unsigned char *rxbuf, int len)
 			case CGW_MOD_OR:
 			case CGW_MOD_XOR:
 			case CGW_MOD_SET:
+			case CGW_LIM_HOPS:
 			case CGW_CS_XOR:
 			case CGW_CS_CRC8:
 				break;
@@ -489,6 +491,10 @@ int parse_rtlist(char *prgname, unsigned char *rxbuf, int len)
 				printmod("SET", RTA_DATA(rta));
 				break;
 
+			case CGW_LIM_HOPS:
+				printf("-l %d ", *(__u8 *)RTA_DATA(rta));
+				break;
+
 			case CGW_CS_XOR:
 				print_cs_xor((struct cgw_csum_xor *)RTA_DATA(rta));
 				break;
@@ -545,6 +551,7 @@ int main(int argc, char **argv)
 	struct nlmsgerr *rte;
 	unsigned int src_ifindex = 0;
 	unsigned int dst_ifindex = 0;
+	__u8 limit_hops = 0;
 	__u16 flags = 0;
 	int len;
 
@@ -563,7 +570,7 @@ int main(int argc, char **argv)
 	memset(&cs_xor, 0, sizeof(cs_xor));
 	memset(&cs_crc8, 0, sizeof(cs_crc8));
 
-	while ((opt = getopt(argc, argv, "ADFLs:d:teif:c:p:x:m:?")) != -1) {
+	while ((opt = getopt(argc, argv, "ADFLs:d:teil:f:c:p:x:m:?")) != -1) {
 		switch (opt) {
 
 		case 'A':
@@ -606,6 +613,13 @@ int main(int argc, char **argv)
 			flags |= CGW_FLAGS_CAN_IIF_TX_OK;
 			break;
 
+		case 'l':
+			if (sscanf(optarg, "%hhd", &limit_hops) != 1 || !(limit_hops)) {
+				printf("Bad hop limit definition '%s'.\n", optarg);
+				exit(1);
+			}
+			break;
+
 		case 'f':
 			if (sscanf(optarg, "%x:%x", &filter.can_id,
 				   &filter.can_mask) == 2) {
@@ -743,6 +757,9 @@ int main(int argc, char **argv)
 	if (have_cs_xor)
 		addattr_l(&req.nh, sizeof(req), CGW_CS_XOR, &cs_xor, sizeof(cs_xor));
 
+	if (limit_hops)
+		addattr_l(&req.nh, sizeof(req), CGW_LIM_HOPS, &limit_hops, sizeof(__u8));
+
 	/*
 	 * a better example code
 	 * modmsg.modtype = CGW_MOD_ID;
diff --git a/include/socketcan/can/gw.h b/include/socketcan/can/gw.h
index 9c290dc..56d3246 100644
--- a/include/socketcan/can/gw.h
+++ b/include/socketcan/can/gw.h
@@ -45,6 +45,7 @@ enum {
 	CGW_DST_IF,	/* ifindex of destination network interface */
 	CGW_FILTER,	/* specify struct can_filter on source CAN device */
 	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
+	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
 	__CGW_MAX
 };
 
@@ -116,13 +117,19 @@ enum {
  * Sets a CAN receive filter for the gateway job specified by the
  * struct can_filter described in include/linux/can.h
  *
- * CGW_MOD_XXX (length 17 bytes):
+ * CGW_MOD_(AND|OR|XOR|SET) (length 17 bytes):
  * Specifies a modification that's done to a received CAN frame before it is
  * send out to the destination interface.
  *
  * <struct can_frame> data used as operator
  * <u8> affected CAN frame elements
  *
+ * CGW_LIM_HOPS (length 1 byte):
+ * Limit the number of hops of this specific rule. Usually the received CAN
+ * frame can be processed as much as 'max_hops' times (which is given at module
+ * load time of the can-gw module). This value is used to reduce the number of
+ * possible hops for this gateway rule to a value smaller then max_hops.
+ *
  * CGW_CS_XOR (length 4 bytes):
  * Set a simple XOR checksum starting with an initial value into
  * data[result-idx] using data[start-idx] .. data[end-idx]

