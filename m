From: Armin Burchardt <armin@uni-bremen.de>
Subject: [PATCH v2 2/3] slcand: add option -p<file> to write pid to a file.
Date: Tue,  9 Jun 2015 11:15:27 +0200
Message-ID: <1433841328-15581-3-git-send-email-armin@uni-bremen.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
 <1433841328-15581-1-git-send-email-armin@uni-bremen.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:54231 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753681AbbFIJPf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Jun 2015 05:15:35 -0400
In-Reply-To: <1433841328-15581-1-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Armin Burchardt <armin@uni-bremen.de>

Useful in combination with start-stop-daemon.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/slcand.c b/slcand.c
index 9373361..e3c5f18 100644
--- a/slcand.c
+++ b/slcand.c
@@ -45,6 +45,8 @@
 /* Change this to the user under which to run */
 #define RUN_AS_USER "root"
 
+#define DEFAULT_PIDFILE "/run/slcand.pid"
+
 /* The length of ttypath buffer */
 #define TTYPATH_LENGTH	64
 
@@ -64,11 +66,13 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -t <type>  (set UART flow control type 'hw' or 'sw')\n");
 	fprintf(stderr, "         -b <btr>   (set bit time register value)\n");
 	fprintf(stderr, "         -F         (stay in foreground; no daemonize)\n");
+	fprintf(stderr, "         -p [file]  (write PID of daemon to file. without argument, write to '%s')\n", DEFAULT_PIDFILE);
 	fprintf(stderr, "         -h         (show this help page)\n");
 	fprintf(stderr, "\nExamples:\n");
 	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0\n");
 	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0 can0\n");
 	fprintf(stderr, "slcand -o -c -f -s6 /dev/ttyUSB0\n");
+	fprintf(stderr, "slcand -o -c -f -s6 -p/run/slcand/ttyUSB0.pid /dev/ttyUSB0\n");
 	fprintf(stderr, "\n");
 	exit(EXIT_FAILURE);
 }
@@ -171,6 +175,8 @@ int main(int argc, char *argv[])
 	int send_open = 0;
 	int send_close = 0;
 	int send_read_status_flags = 0;
+	int create_pidfile = 0;
+	char *pidfile = NULL;
 	char *speed = NULL;
 	char *uart_speed_str = NULL;
 	long int uart_speed = 0;
@@ -183,7 +189,7 @@ int main(int argc, char *argv[])
 
 	ttypath[0] = '\0';
 
-	while ((opt = getopt(argc, argv, "ocfs:S:t:b:?hF")) != -1) {
+	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p::?hF")) != -1) {
 		switch (opt) {
 		case 'o':
 			send_open = 1;
@@ -228,6 +234,15 @@ int main(int argc, char *argv[])
 		case 'F':
 			run_as_daemon = 0;
 			break;
+		case 'p':
+			create_pidfile = 1;
+			/* argument is optional */
+			if (optarg) {
+				pidfile = optarg;
+			} else {
+				pidfile = DEFAULT_PIDFILE;
+			}
+			break;
 		case 'h':
 		case '?':
 		default:
@@ -362,6 +377,27 @@ int main(int argc, char *argv[])
 		signal(SIGTERM, child_handler);
 	}
 
+	/* write pidfile */
+	if (create_pidfile) {
+		FILE *stream;
+		stream = fopen(pidfile, "w");
+		if (stream == NULL) {
+			syslog(LOG_ERR, "could not open pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+		if (fprintf(stream, "%i\n", getpid()) < 0) {
+			syslog(LOG_ERR, "could not write to pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+		if (fclose(stream) != 0) {
+			syslog(LOG_ERR, "could not close pidfile");
+			perror(pidfile);
+			exit(EXIT_FAILURE);
+		}
+	}
+
 	/* The Big Loop */
 	slcand_running = 1;
 	while (slcand_running)
@@ -388,6 +424,13 @@ int main(int argc, char *argv[])
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

