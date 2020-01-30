From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] can-utils: candump: remove bridging functionality
Date: Thu, 30 Jan 2020 13:24:57 +0100
Message-ID: <20200130122457.1875-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:34205 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgA3M2S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2020 07:28:18 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The tool 'candump' is used to dump CAN traffic to stdout or logfile.
In early days where the in-kernel CAN gateway (can-gw) with the cangw tool was
not yet implemented the bridging functionality allowed to send received (and
filtered) CAN frames to another outgoing CAN interface.

As we now have can-gw and sending CAN frames from a 'reading tool' seems wrong
especially from the Unix philosophy "Write programs that do one thing and do
it well." this patch removes the obsolete functionality from candump.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 candump.c | 70 +------------------------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/candump.c b/candump.c
index f2ff03b..16382d1 100644
--- a/candump.c
+++ b/candump.c
@@ -125,9 +125,6 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -a          (enable additional ASCII output)\n");
 	fprintf(stderr, "         -S          (swap byte order in printed CAN data[] - marked with '%c' )\n", SWAP_DELIMITER);
 	fprintf(stderr, "         -s <level>  (silent mode - %d: off (default) %d: animation %d: silent)\n", SILENT_OFF, SILENT_ANI, SILENT_ON);
-	fprintf(stderr, "         -b <can>    (bridge mode - send received frames to <can>)\n");
-	fprintf(stderr, "         -B <can>    (bridge mode - like '-b' with disabled loopback)\n");
-	fprintf(stderr, "         -u <usecs>  (delay bridge forwarding by <usecs> microseconds)\n");
 	fprintf(stderr, "         -l          (log CAN-frames into file. Sets '-s %d' by default)\n", SILENT_ON);
 	fprintf(stderr, "         -L          (use log file format on stdout)\n");
 	fprintf(stderr, "         -n <count>  (terminate after reception of <count> CAN frames)\n");
@@ -217,8 +214,6 @@ int main(int argc, char **argv)
 {
 	fd_set rdfs;
 	int s[MAXSOCK];
-	int bridge = 0;
-	useconds_t bridge_delay = 0;
 	unsigned char timestamp = 0;
 	unsigned char hwtimestamp = 0;
 	unsigned char down_causes_exit = 1;
@@ -257,7 +252,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:HciaSs:b:B:u:lDdxLn:r:heT:?")) != -1) {
+	while ((opt = getopt(argc, argv, "t:HciaSs:lDdxLn:r:heT:?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -301,52 +296,6 @@ int main(int argc, char **argv)
 			}
 			break;
 
-		case 'b':
-		case 'B':
-			if (strlen(optarg) >= IFNAMSIZ) {
-				fprintf(stderr, "Name of CAN device '%s' is too long!\n\n", optarg);
-				return 1;
-			} else {
-				bridge = socket(PF_CAN, SOCK_RAW, CAN_RAW);
-				if (bridge < 0) {
-					perror("bridge socket");
-					return 1;
-				}
-				addr.can_family = AF_CAN;
-				strcpy(ifr.ifr_name, optarg);
-				if (ioctl(bridge, SIOCGIFINDEX, &ifr) < 0)
-					perror("SIOCGIFINDEX");
-				addr.can_ifindex = ifr.ifr_ifindex;
-		
-				if (!addr.can_ifindex) {
-					perror("invalid bridge interface");
-					return 1;
-				}
-
-				/* disable default receive filter on this write-only RAW socket */
-				setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
-
-				/* try to switch the bridge socket into CAN FD mode */
-				setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
-
-				if (opt == 'B') {
-					const int loopback = 0;
-
-					setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
-						   &loopback, sizeof(loopback));
-				}
-
-				if (bind(bridge, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-					perror("bridge bind");
-					return 1;
-				}
-			}
-			break;
-	    
-		case 'u':
-			bridge_delay = (useconds_t)strtoul(optarg, (char **)NULL, 10);
-			break;
-
 		case 'l':
 			log = 1;
 			break;
@@ -706,20 +655,6 @@ int main(int argc, char **argv)
 
 				if (count && (--count == 0))
 					running = 0;
-
-				if (bridge) {
-					if (bridge_delay)
-						usleep(bridge_delay);
-
-					nbytes = write(bridge, &frame, nbytes);
-					if (nbytes < 0) {
-						perror("bridge write");
-						return 1;
-					} else if ((size_t)nbytes != CAN_MTU && (size_t)nbytes != CANFD_MTU) {
-						fprintf(stderr,"bridge write: incomplete CAN frame\n");
-						return 1;
-					}
-				}
 		    
 				for (cmsg = CMSG_FIRSTHDR(&msg);
 				     cmsg && (cmsg->cmsg_level == SOL_SOCKET);
@@ -862,9 +797,6 @@ int main(int argc, char **argv)
 	for (i=0; i<currmax; i++)
 		close(s[i]);
 
-	if (bridge)
-		close(bridge);
-
 	if (log)
 		fclose(logfile);
 
-- 
2.20.1
