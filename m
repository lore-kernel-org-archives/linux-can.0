From: yegorslists@googlemail.com
Subject: [PATCH 1/2] slcand: add flow control option
Date: Mon, 13 Jan 2014 09:54:04 +0100
Message-ID: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:59306 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaAMJPg (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 13 Jan 2014 04:15:36 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, u.kleine-koenig@pengutronix.de, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Add option '-t' to specify flow control type. Two types are
supported: 'hw' - RTS/CTS and 'sw' - XON/XOFF.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcand.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/slcand.c b/slcand.c
index 30f5127..996c8d2 100644
--- a/slcand.c
+++ b/slcand.c
@@ -69,6 +69,11 @@
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
+/* UART flow control types */
+#define FLOW_NONE 0
+#define FLOW_HW 1
+#define FLOW_SW 2
+
 void print_usage(char *prg)
 {
 	fprintf(stderr, "\nUsage: %s [options] <tty> [canif-name]\n\n", prg);
@@ -77,6 +82,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -f         (read status flags with 'F\\r' to reset error states)\n");
 	fprintf(stderr, "         -s <speed> (set CAN speed 0..8)\n");
 	fprintf(stderr, "         -S <speed> (set UART speed in baud)\n");
+	fprintf(stderr, "         -t <type>  (set UART flow control type 'hw' or 'sw')\n");
 	fprintf(stderr, "         -b <btr>   (set bit time register value)\n");
 	fprintf(stderr, "         -F         (stay in foreground; no daemonize)\n");
 	fprintf(stderr, "         -h         (show this help page)\n");
@@ -300,6 +306,7 @@ int main(int argc, char *argv[])
 	char *speed = NULL;
 	char *uart_speed_str = NULL;
 	long int uart_speed = 0;
+	int flow_type = FLOW_NONE;
 	char *btr = NULL;
 	int run_as_daemon = 1;
 	pid_t parent_pid = 0;
@@ -309,7 +316,7 @@ int main(int argc, char *argv[])
 
 	ttypath[0] = '\0';
 
-	while ((opt = getopt(argc, argv, "ocfs:S:b:?hF")) != -1) {
+	while ((opt = getopt(argc, argv, "ocfs:S:t:b:?hF")) != -1) {
 		switch (opt) {
 		case 'o':
 			send_open = 1;
@@ -336,6 +343,18 @@ int main(int argc, char *argv[])
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case 't':
+			if (!strcmp(optarg, "hw")) {
+				flow_type = FLOW_HW;
+			}
+			else if (!strcmp(optarg, "sw")) {
+				flow_type = FLOW_SW;
+			}
+			else {
+				fprintf(stderr, "Unsupported flow type (%s)\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		case 'b':
 			btr = optarg;
 			if (strlen(btr) > 6)
@@ -401,10 +420,21 @@ int main(int argc, char *argv[])
 	old_ispeed = cfgetispeed(&tios);
 	old_ospeed = cfgetospeed(&tios);
 
+	/* Reset UART settings */
+	cfmakeraw(&tios);
+	tios.c_iflag &= ~IXOFF;
+	tios.c_cflag &= ~CRTSCTS;
+
 	/* Baud Rate */
 	cfsetispeed(&tios, look_up_uart_speed(uart_speed));
 	cfsetospeed(&tios, look_up_uart_speed(uart_speed));
 
+	/* Flow control */
+	if (flow_type == FLOW_HW)
+		tios.c_cflag |= CRTSCTS;
+	else if (flow_type == FLOW_SW)
+		tios.c_iflag |= (IXON | IXOFF);
+
 	/* apply changes */
 	if (tcsetattr(fd, TCSADRAIN, &tios) < 0)
 		syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n", ttypath, strerror(errno));
-- 
1.7.7

