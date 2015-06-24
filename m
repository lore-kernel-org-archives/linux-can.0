From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] treewide: use if_nametoindex to avoid overflows
Date: Wed, 24 Jun 2015 20:22:04 +0200
Message-ID: <1435170124-18081-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45451 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbFXSWM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Jun 2015 14:22:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Sven Schmitt <sven.schmitt@volkswagen.de>

From: Sven Schmitt <sven.schmitt@volkswagen.de>

replaced strcpy(if_name, argv[x]) by if_name=if_nametoindex(argv[x]) to avoid
overflows caused by long user input.

Waiting for Sob: Sven Schmitt <sven.schmitt@volkswagen.de>
Not-yet-Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
This came via github.

Marc

 canfdtest.c    |  5 +----
 cansend.c      | 11 ++++++-----
 isotpdump.c    |  8 +-------
 isotprecv.c    |  5 +----
 isotpsend.c    |  5 +----
 isotpserver.c  |  7 +------
 isotpsniffer.c |  9 +++++++--
 isotptun.c     | 10 ++++++++--
 slcanpty.c     |  9 +--------
 9 files changed, 27 insertions(+), 42 deletions(-)

diff --git a/canfdtest.c b/canfdtest.c
index 28b204263aaa..24070278109f 100644
--- a/canfdtest.c
+++ b/canfdtest.c
@@ -312,7 +312,6 @@ static int can_echo_gen(void)
 
 int main(int argc, char *argv[])
 {
-	struct ifreq ifr;
 	struct sockaddr_can addr;
 	char *intf_name;
 	int family = PF_CAN, type = SOCK_RAW, proto = CAN_RAW;
@@ -356,9 +355,7 @@ int main(int argc, char *argv[])
 	}
 
 	addr.can_family = family;
-	strcpy(ifr.ifr_name, intf_name);
-	ioctl(sockfd, SIOCGIFINDEX, &ifr);
-	addr.can_ifindex = ifr.ifr_ifindex;
+	addr.can_ifindex = if_nametoindex(intf_name);
 
 	if (bind(sockfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 		perror("bind");
diff --git a/cansend.c b/cansend.c
index aec64a5c9e61..a0b9bbbfb25d 100644
--- a/cansend.c
+++ b/cansend.c
@@ -94,13 +94,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	addr.can_family = AF_CAN;
-
-	strcpy(ifr.ifr_name, argv[1]);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
+	strncpy(ifr.ifr_name, argv[1], IFNAMSIZ);
+	ifr.ifr_ifindex = if_nametoindex(ifr.ifr_name);
+	if (!ifr.ifr_ifindex) {
+		perror("if_nametoindex");
 		return 1;
 	}
+
+	addr.can_family = AF_CAN;
 	addr.can_ifindex = ifr.ifr_ifindex;
 
 	if (required_mtu > CAN_MTU) {
diff --git a/isotpdump.c b/isotpdump.c
index 6e64eefba5d4..b2b650aa7996 100644
--- a/isotpdump.c
+++ b/isotpdump.c
@@ -96,8 +96,6 @@ int main(int argc, char **argv)
 	int timestamp = 0;
 	int datidx = 0;
 	unsigned long fflen = 0;
-	struct ifreq ifr;
-	int ifindex;
 	struct timeval tv, last_tv;
 	unsigned int n_pci;
 	int opt;
@@ -202,12 +200,8 @@ int main(int argc, char **argv)
 
 	setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, &rfilter, sizeof(rfilter));
 
-	strcpy(ifr.ifr_name, argv[optind]);
-	ioctl(s, SIOCGIFINDEX, &ifr);
-	ifindex = ifr.ifr_ifindex;
-
 	addr.can_family = AF_CAN;
-	addr.can_ifindex = ifindex;
+	addr.can_ifindex = if_nametoindex(argv[optind]);
 
 	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 		perror("bind");
diff --git a/isotprecv.c b/isotprecv.c
index 5c4f2a5f11ce..763da39315ef 100644
--- a/isotprecv.c
+++ b/isotprecv.c
@@ -81,7 +81,6 @@ int main(int argc, char **argv)
 {
     int s;
     struct sockaddr_can addr;
-    struct ifreq ifr;
     static struct can_isotp_options opts;
     static struct can_isotp_fc_options fcopts;
     static struct can_isotp_ll_options llopts;
@@ -232,9 +231,7 @@ int main(int argc, char **argv)
 	    setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &force_rx_stmin, sizeof(force_rx_stmin));
 
     addr.can_family = AF_CAN;
-    strcpy(ifr.ifr_name, argv[optind]);
-    ioctl(s, SIOCGIFINDEX, &ifr);
-    addr.can_ifindex = ifr.ifr_ifindex;
+    addr.can_ifindex = if_nametoindex(argv[optind]);
 
     if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 	perror("bind");
diff --git a/isotpsend.c b/isotpsend.c
index e0256cb9083e..b6a56708fb4d 100644
--- a/isotpsend.c
+++ b/isotpsend.c
@@ -79,7 +79,6 @@ int main(int argc, char **argv)
 {
     int s;
     struct sockaddr_can addr;
-    struct ifreq ifr;
     static struct can_isotp_options opts;
     static struct can_isotp_ll_options llopts;
     int opt;
@@ -224,9 +223,7 @@ int main(int argc, char **argv)
 	    setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &force_tx_stmin, sizeof(force_tx_stmin));
 
     addr.can_family = AF_CAN;
-    strcpy(ifr.ifr_name, argv[optind]);
-    ioctl(s, SIOCGIFINDEX, &ifr);
-    addr.can_ifindex = ifr.ifr_ifindex;
+    addr.can_ifindex = if_nametoindex(argv[optind]);
 
     if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 	perror("bind");
diff --git a/isotpserver.c b/isotpserver.c
index b900f279b01d..403585b18b9f 100644
--- a/isotpserver.c
+++ b/isotpserver.c
@@ -345,12 +345,7 @@ int main(int argc, char **argv)
 	}
 
 	caddr.can_family = AF_CAN;
-	strcpy(ifr.ifr_name, argv[optind]);
-	if (ioctl(sc, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		exit(1);
-	}
-	caddr.can_ifindex = ifr.ifr_ifindex;
+	caddr.can_ifindex = if_nametoindex(argv[optind]);
 
 	if (bind(sc, (struct sockaddr *)&caddr, caddrlen) < 0) {
 		perror("bind");
diff --git a/isotpsniffer.c b/isotpsniffer.c
index 7618dca549a0..9182fcc240b6 100644
--- a/isotpsniffer.c
+++ b/isotpsniffer.c
@@ -271,9 +271,14 @@ int main(int argc, char **argv)
 
 	opts.flags |= CAN_ISOTP_LISTEN_MODE;
 
+	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
+	ifr.ifr_ifindex = if_nametoindex(ifr.ifr_name);
+	if (!ifr.ifr_ifindex) {
+		perror("if_nametoindex");
+		return 1;
+	}
+
 	addr.can_family = AF_CAN;
-	strcpy(ifr.ifr_name, argv[optind]);
-	ioctl(s, SIOCGIFINDEX, &ifr);
 	addr.can_ifindex = ifr.ifr_ifindex;
 
 	setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts));
diff --git a/isotptun.c b/isotptun.c
index c793f42015fb..400e1b74e8bd 100644
--- a/isotptun.c
+++ b/isotptun.c
@@ -265,9 +265,15 @@ int main(int argc, char **argv)
 		}
 	}
 
+	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
+	ifr.ifr_ifindex = if_nametoindex(ifr.ifr_name);
+	if (!ifr.ifr_ifindex) {
+		perror("if_nametoindex");
+		close(s);
+		exit(1);
+	}
+
 	addr.can_family = AF_CAN;
-	strcpy(ifr.ifr_name, argv[optind]);
-	ioctl(s, SIOCGIFINDEX, &ifr);
 	addr.can_ifindex = ifr.ifr_ifindex;
 
 	if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
diff --git a/slcanpty.c b/slcanpty.c
index f485ac775a53..5cf14ef98374 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -422,7 +422,6 @@ int main(int argc, char **argv)
 	int s; /* can raw socket */ 
 	struct sockaddr_can addr;
 	struct termios topts;
-	struct ifreq ifr;
 	int select_stdin = 0;
 	int running = 1;
 	int tstamp = 0;
@@ -497,13 +496,7 @@ int main(int argc, char **argv)
 	}
 
 	addr.can_family = AF_CAN;
-
-	strcpy(ifr.ifr_name, argv[2]);
-	if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
-		perror("SIOCGIFINDEX");
-		return 1;
-	}
-	addr.can_ifindex = ifr.ifr_ifindex;
+	addr.can_ifindex = if_nametoindex(argv[2]);
 
 	/* disable reception of CAN frames until we are opened by 'O' */
 	setsockopt(s, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
-- 
2.1.4

