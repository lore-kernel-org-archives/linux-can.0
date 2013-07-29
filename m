From: yegorslists@googlemail.com
Subject: [PATCH] slcanpty: add TCP support
Date: Mon, 29 Jul 2013 11:37:57 +0200
Message-ID: <1375090677-4758-2-git-send-email-yegorslists@googlemail.com>
References: <1375090677-4758-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:55600 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab3G2JiX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 29 Jul 2013 05:38:23 -0400
In-Reply-To: <1375090677-4758-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, socketcan@hartkopp.net, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

If TCP port number is supplied, slcanpty would accept TCP connection
instead of pty one. If TCP socket is closed wait for another connection.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcanpty.c |  164 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 126 insertions(+), 38 deletions(-)

diff --git a/slcanpty.c b/slcanpty.c
index 2c1cabe..0776a03 100644
--- a/slcanpty.c
+++ b/slcanpty.c
@@ -28,10 +28,13 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <termios.h>
 
+#include <netinet/in.h>
+#include <arpa/inet.h>
 #include <net/if.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
@@ -47,6 +50,9 @@
 
 #define DEBUG
 
+#define MODE_PTY 0
+#define MODE_TCP 1
+
 static int asc2nibble(char c)
 {
 
@@ -386,6 +392,103 @@ int can2pty(int pty, int socket, int *tstamp)
 	return 0;
 }
 
+int init_tcp_channel(int port)
+{
+	int listenfd = 0, connfd = 0, i;
+	struct sockaddr_in serv_addr;
+
+	listenfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (listenfd < 0) {
+		perror("TCP socket");
+		goto error;
+	}
+	memset(&serv_addr, '0', sizeof(serv_addr));
+
+	/* set SO_REUSEADDR */
+	i = 1;
+	if(setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR, &i, sizeof(i)) < 0) {
+		perror("TCP setsockopt");
+		goto error;
+	}
+
+	serv_addr.sin_family = AF_INET;
+	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	serv_addr.sin_port = htons(port);
+
+	if (bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr))) {
+		perror("TCP bind");
+		goto error;
+	}
+
+	if (listen(listenfd, 1)) {
+		perror("TCP listen");
+		goto error;
+	}
+
+
+
+	return listenfd;
+error:
+
+	return -1;
+}
+
+int init_pty_channel(char *name)
+{
+	int p; /* pty master file */
+	struct termios topts;
+
+	/* open pty */
+	p = open(name, O_RDWR);
+	if (p < 0) {
+		perror("open pty");
+		goto error;
+	}
+
+	if (tcgetattr(p, &topts)) {
+		perror("tcgetattr");
+		goto error;
+	}
+
+	/* disable local echo which would cause double frames */
+	topts.c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK |
+			   ECHONL | ECHOPRT | ECHOKE);
+	topts.c_iflag &= ~(ICRNL);
+	topts.c_iflag |= INLCR;
+	tcsetattr(p, TCSANOW, &topts);
+
+	/* Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N */
+	if  (strcmp(name, DEVICE_NAME_PTMX) == 0) {
+
+		char *name_pts = NULL;	/* slave pseudo-terminal device name */
+
+		if (grantpt(p) < 0) {
+			perror("grantpt");
+			goto error;
+		}
+
+		if (unlockpt(p) < 0) {
+			perror("unlockpt");
+			goto error;
+		}
+
+		name_pts = ptsname(p);
+		if (name_pts == NULL) {
+			perror("ptsname");
+			goto error;
+		}
+		printf("open: %s: slave pseudo-terminal is %s\n", name, name_pts);
+	}
+
+	return p;
+
+error:
+	if (p > 0)
+		close(p);
+
+	return -1;
+}
+
 int check_select_stdin(void)
 {
 	fd_set rdfs;
@@ -413,14 +516,15 @@ int main(int argc, char **argv)
 	fd_set rdfs;
 	int p; /* pty master file */ 
 	int s; /* can raw socket */ 
+	int listenfd;
 	struct sockaddr_can addr;
-	struct termios topts;
 	struct ifreq ifr;
 	int select_stdin = 0;
 	int running = 1;
 	int tstamp = 0;
 	int is_open = 0;
 	struct can_filter fi;
+	int mode = MODE_PTY;
 
 	/* check command line options */
 	if (argc != 3) {
@@ -440,46 +544,24 @@ int main(int argc, char **argv)
 
 	select_stdin = check_select_stdin();
 
-	/* open pty */
-	p = open(argv[1], O_RDWR);
-	if (p < 0) {
-		perror("open pty");
-		return 1;
-	}
+	/* check for TCP port vs pty */
+	if (isdigit(argv[1][0]))
+		mode = MODE_TCP;
 
-	if (tcgetattr(p, &topts)) {
-		perror("tcgetattr");
-		return 1;
+	if (mode == MODE_PTY) {
+		p = init_pty_channel(argv[1]);
+	} else {
+		listenfd = init_tcp_channel(atoi(argv[1]));
 	}
 
-	/* disable local echo which would cause double frames */
-	topts.c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK |
-			   ECHONL | ECHOPRT | ECHOKE);
-	topts.c_iflag &= ~(ICRNL);
-	topts.c_iflag |= INLCR;
-	tcsetattr(p, TCSANOW, &topts);
-
-	/* Support for the Unix 98 pseudo-terminal interface /dev/ptmx /dev/pts/N */
-	if  (strcmp(argv[1], DEVICE_NAME_PTMX) == 0) {
-
-		char *name_pts = NULL;	/* slave pseudo-terminal device name */
-
-		if (grantpt(p) < 0) {
-			perror("grantpt");
-			return 1;
-		}
-
-		if (unlockpt(p) < 0) {
-			perror("unlockpt");
-			return 1;
-		}
+restart:
+	if (mode == MODE_TCP) {
+		p = accept(listenfd, (struct sockaddr*)NULL, NULL);
+	}
 
-		name_pts = ptsname(p);
-		if (name_pts == NULL) {
-			perror("ptsname");
-			return 1;
-		}
-		printf("open: %s: slave pseudo-terminal is %s\n", argv[1], name_pts);
+	/* check if the channel was properly opened */
+	if (p < 0) {
+		return 1;
 	}
 
 	/* open socket */
@@ -520,7 +602,7 @@ int main(int argc, char **argv)
 		FD_SET(p, &rdfs);
 		FD_SET(s, &rdfs);
 
-		if (select(s+1, &rdfs, NULL, NULL, NULL) < 0) {
+		if (select(s > p?s+1:p+1, &rdfs, NULL, NULL, NULL) < 0) {
 			perror("select");
 			return 1;
 		}
@@ -532,6 +614,12 @@ int main(int argc, char **argv)
 
 		if (FD_ISSET(p, &rdfs))
 			if (pty2can(p, s, &fi, &is_open, &tstamp)) {
+			if (mode == MODE_TCP)
+			{
+				close(p);
+				close(s);
+				goto restart;
+			}
 			running = 0;
 			continue;
 		}
-- 
1.7.7

