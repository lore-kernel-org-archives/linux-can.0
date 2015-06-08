From: Armin Burchardt <armin@uni-bremen.de>
Subject: [PATCH 2/3] slcand: add option -p<file> to write pid to a file.
Date: Mon,  8 Jun 2015 13:55:39 +0200
Message-ID: <1433764540-24917-2-git-send-email-armin@uni-bremen.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:44917 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752134AbbFHLzp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 07:55:45 -0400
In-Reply-To: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Armin Burchardt <armin@uni-bremen.de>

Useful in combination with start-stop-daemon.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/slcand.c b/slcand.c
index af7ca98..8fd1418 100644
--- a/slcand.c
+++ b/slcand.c
@@ -64,11 +64,13 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -t <type>  (set UART flow control type 'hw' or 'sw')\n");
 	fprintf(stderr, "         -b <btr>   (set bit time register value)\n");
 	fprintf(stderr, "         -F         (stay in foreground; no daemonize)\n");
+	fprintf(stderr, "         -p <file>  (write PID of daemon to file)\n");
 	fprintf(stderr, "         -h         (show this help page)\n");
 	fprintf(stderr, "\nExamples:\n");
 	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0\n");
 	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0 can0\n");
 	fprintf(stderr, "slcand -o -c -f -s6 /dev/ttyUSB0\n");
+	fprintf(stderr, "slcand -o -c -f -s6 -p/var/run/slcand-can0.pid /dev/ttyUSB0\n");
 	fprintf(stderr, "\n");
 	exit(EXIT_FAILURE);
 }
@@ -178,12 +180,13 @@ int main(int argc, char *argv[])
 	char *btr = NULL;
 	int run_as_daemon = 1;
 	char *pch;
+	char *pidfile = NULL;
 	int ldisc = N_SLCAN;
 	int fd;
 
 	ttypath[0] = '\0';
 
-	while ((opt = getopt(argc, argv, "ocfs:S:t:b:?hF")) != -1) {
+	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p:?hF")) != -1) {
 		switch (opt) {
 		case 'o':
 			send_open = 1;
@@ -228,6 +231,9 @@ int main(int argc, char *argv[])
 		case 'F':
 			run_as_daemon = 0;
 			break;
+		case 'p':
+			pidfile = optarg;
+			break;
 		case 'h':
 		case '?':
 		default:
@@ -363,6 +369,27 @@ int main(int argc, char *argv[])
 		signal(SIGTERM, child_handler);
 	}
 
+	/* write pidfile */
+	if (pidfile) {
+		FILE *pidfd;
+		pidfd = fopen(pidfile, "w");
+		if (pidfd == NULL) {
+			syslog(LOG_ERR, "could not open pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+		if (fprintf(pidfd, "%i\n", getpid()) < 0) {
+			syslog(LOG_ERR, "could not write to pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+		if (fclose(pidfd) != 0) {
+			syslog(LOG_ERR, "could not close pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+	}
+
 	/* */
 	slcand_running = 1;
 
@@ -391,6 +418,13 @@ int main(int argc, char *argv[])
 	if (tcsetattr(fd, TCSADRAIN, &tios) < 0)
 		syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n", ttypath, strerror(errno));
 
+	/* Remove pidfile */
+	if (pidfile) {
+		if (unlink(pidfile) < 0) {
+			syslog(LOG_ERR, "Can not remove pidfile '%s': %s", pidfile, strerror(errno));
+		}
+	}
+
 	/* Finish up */
 	syslog(LOG_NOTICE, "terminated on %s", ttypath);
 	closelog();
-- 
1.9.1

