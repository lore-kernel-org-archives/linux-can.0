From: Armin Burchardt <armin@uni-bremen.de>
Subject: slcand in init.d-scripts
Date: Mon, 08 Jun 2015 10:14:12 +0000
Message-ID: <20150608101412.Horde.cpWZ5_FJEM-ciNcxvoY5Nkf@webmail.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_zZmL19KkEbFFxVMDvv8YDsg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:59093 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbbFHKUz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 06:20:55 -0400
Received: from uni-bremen.de (webmail-2.zfn.uni-bremen.de [134.102.50.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.uni-bremen.de (Postfix) with ESMTPSA id BA1F6120C16
	for <linux-can@vger.kernel.org>; Mon,  8 Jun 2015 12:14:12 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This message is in MIME format.

--=_zZmL19KkEbFFxVMDvv8YDsg
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline


Hello,

to make init.d-scripts easier to write, I propose some changes to slcand:
* write pidfile
* set up-flag
* do not daemonize too early

Regards
Armin

--=_zZmL19KkEbFFxVMDvv8YDsg
Content-Type: text/x-diff;
 name=0001-slcand-add-option-p-file-to-write-pid-to-a-file.patch
Content-Disposition: attachment; size=2560;
 filename=0001-slcand-add-option-p-file-to-write-pid-to-a-file.patch

From 3529ab715aaa06fddea46ac385b2a95003c5ea44 Mon Sep 17 00:00:00 2001
From: Armin Burchardt <armin@uni-bremen.de>
Date: Mon, 8 Jun 2015 11:13:11 +0200
Subject: [PATCH 1/3] slcand: add option -p<file> to write pid to a file.

Useful in combination with start-stop-daemon.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/slcand.c b/slcand.c
index e5e4752..01b9625 100644
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
@@ -271,6 +277,27 @@ int main(int argc, char *argv[])
 	/* */
 	slcand_running = 1;
 
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
 	/* Now we are a daemon -- do the work for which we were paid */
 	fd = open(ttypath, O_RDWR | O_NONBLOCK | O_NOCTTY);
 	if (fd < 0) {
-- 
1.9.1


--=_zZmL19KkEbFFxVMDvv8YDsg
Content-Type: text/x-diff;
 name=0002-slcand-add-option-u-to-set-interface-up-down-state.patch
Content-Disposition: attachment; size=3666;
 filename=0002-slcand-add-option-u-to-set-interface-up-down-state.patch

From 8173654a5e710e894e0bd6d04ab29236a8823f5c Mon Sep 17 00:00:00 2001
From: Armin Burchardt <armin@uni-bremen.de>
Date: Mon, 8 Jun 2015 11:13:24 +0200
Subject: [PATCH 2/3] slcand: add option -u to set interface up/down state.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/slcand.c b/slcand.c
index 01b9625..f60c0d8 100644
--- a/slcand.c
+++ b/slcand.c
@@ -65,6 +65,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -b <btr>   (set bit time register value)\n");
 	fprintf(stderr, "         -F         (stay in foreground; no daemonize)\n");
 	fprintf(stderr, "         -p <file>  (write PID of daemon to file)\n");
+	fprintf(stderr, "         -u         (control interface state ('UP' and 'DOWN')\n");
 	fprintf(stderr, "         -h         (show this help page)\n");
 	fprintf(stderr, "\nExamples:\n");
 	fprintf(stderr, "slcand -o -c -f -s6 ttyUSB0\n");
@@ -159,6 +160,36 @@ static int look_up_uart_speed(long int s)
 	}
 }
 
+static int candev_setflags(const char* name, __u32 flags, __u32 mask)
+{
+	int err = 0;
+	struct ifreq ifr;
+	int fd;
+
+	if (strlen(name) >= IFNAMSIZ) {
+		return -1;
+	}
+	fd = socket(PF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		perror("socket()");
+		return -1;
+	}
+	strncpy(ifr.ifr_name, name, IFNAMSIZ);
+	err = ioctl(fd, SIOCGIFFLAGS, &ifr);
+	if (err == -1) {
+		perror(name);
+	} else {
+		ifr.ifr_flags &= ~mask;
+		ifr.ifr_flags |= mask&flags;
+		err = ioctl(fd, SIOCSIFFLAGS, &ifr);
+		if (err == -1) {
+			perror("SIOSGIFFLAGS");
+		}
+	}
+	close(fd);
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	char *tty = NULL;
@@ -173,6 +204,7 @@ int main(int argc, char *argv[])
 	int send_open = 0;
 	int send_close = 0;
 	int send_read_status_flags = 0;
+	int control_ifstate = 0;
 	char *speed = NULL;
 	char *uart_speed_str = NULL;
 	long int uart_speed = 0;
@@ -186,7 +218,7 @@ int main(int argc, char *argv[])
 
 	ttypath[0] = '\0';
 
-	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p:?hF")) != -1) {
+	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p:u?hF")) != -1) {
 		switch (opt) {
 		case 'o':
 			send_open = 1;
@@ -234,6 +266,9 @@ int main(int argc, char *argv[])
 		case 'p':
 			pidfile = optarg;
 			break;
+		case 'u':
+			control_ifstate = 1;
+			break;
 		case 'h':
 		case '?':
 		default:
@@ -392,10 +427,28 @@ int main(int argc, char *argv[])
 		}	
 	}
 
+	/* set interface state to 'UP' */
+	if (control_ifstate) {
+		if (candev_setflags(name ? name : buf, IFF_UP, IFF_UP) == -1) {
+			syslog(LOG_ERR, "could not set %s state to 'UP'", buf);
+			exit(EXIT_FAILURE);
+		} else {
+			syslog(LOG_NOTICE, "%s: set flag 'UP'", buf);
+		}
+	} else {
+		syslog(LOG_NOTICE, "please remember to set %s to 'UP'", buf);
+	}
+
 	/* The Big Loop */
 	while (slcand_running)
 		sleep(1); /* wait 1 second */
 
+	/* set interface state to 'DOWN' */
+	if (control_ifstate) {
+		candev_setflags(name ? name : buf, ~IFF_UP, IFF_UP);
+		syslog(LOG_ERR, "could not set %s state to 'DOWN'", name);
+	}
+
 	/* Reset line discipline */
 	syslog(LOG_INFO, "stopping on TTY device %s", ttypath);
 	ldisc = N_TTY;
@@ -417,6 +470,13 @@ int main(int argc, char *argv[])
 	if (tcsetattr(fd, TCSADRAIN, &tios) < 0)
 		syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n", ttypath, strerror(errno));
 
+	if (pidfile != NULL) {
+		if (unlink(pidfile) < 0) {
+			syslog(LOG_NOTICE, "Could not remove pidfile '%s'\n", pidfile);
+			perror("unlink()");
+		}
+	}
+
 	/* Finish up */
 	syslog(LOG_NOTICE, "terminated on %s", ttypath);
 	closelog();
-- 
1.9.1


--=_zZmL19KkEbFFxVMDvv8YDsg
Content-Type: text/x-diff;
 name=0003-slcand-daemonize-_after_-interface-is-created-rename.patch
Content-Disposition: attachment; size=2853;
 filename=0003-slcand-daemonize-_after_-interface-is-created-rename.patch

From 2c561cdcc94102637adaa380422b3bef479ace75 Mon Sep 17 00:00:00 2001
From: Armin Burchardt <armin@uni-bremen.de>
Date: Mon, 8 Jun 2015 11:13:34 +0200
Subject: [PATCH 3/3] slcand: daemonize _after_ interface is created, renamed
 and up.

Create interface, then daemonize to avoid race-conditions,
ie. in init.d-scripts.

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 77 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/slcand.c b/slcand.c
index f60c0d8..6166ee7 100644
--- a/slcand.c
+++ b/slcand.c
@@ -296,44 +296,7 @@ int main(int argc, char *argv[])
 
 	syslog(LOG_INFO, "starting on TTY device %s", ttypath);
 
-	/* Daemonize */
-	if (run_as_daemon) {
-		if (daemon(0, 0)) {
-			syslog(LOG_ERR, "failed to daemonize");
-			exit(EXIT_FAILURE);
-		}
-	}
-	else {
-		/* Trap signals that we expect to receive */
-		signal(SIGINT, child_handler);
-		signal(SIGTERM, child_handler);
-	}
-
-	/* */
-	slcand_running = 1;
-
-	/* write pidfile */
-	if (pidfile) {
-		FILE *pidfd;
-		pidfd = fopen(pidfile, "w");
-		if (pidfd == NULL) {
-			syslog(LOG_ERR, "could not open pidfile");
-			perror(pidfile);
-			exit(EXIT_FAILURE);
-		}
-		if (fprintf(pidfd, "%i\n", getpid()) < 0) {
-			syslog(LOG_ERR, "could not write to pidfile");
-			perror(pidfile);
-			exit(EXIT_FAILURE);
-		}
-		if (fclose(pidfd) != 0) {
-			syslog(LOG_ERR, "could not close pidfile");
-			perror(pidfile);
-			exit(EXIT_FAILURE);
-		}
-	}
-
-	/* Now we are a daemon -- do the work for which we were paid */
+	/* Create file handle for tty device. */
 	fd = open(ttypath, O_RDWR | O_NONBLOCK | O_NOCTTY);
 	if (fd < 0) {
 		syslog(LOG_NOTICE, "failed to open TTY device %s\n", ttypath);
@@ -439,6 +402,44 @@ int main(int argc, char *argv[])
 		syslog(LOG_NOTICE, "please remember to set %s to 'UP'", buf);
 	}
 
+	/* Daemonize (_after_ interface is up to avoid race-conditions,
+	 * ie. between init.d-scripts). */
+	if (run_as_daemon) {
+		if (daemon(0, 0)) {
+			syslog(LOG_ERR, "failed to daemonize");
+			exit(EXIT_FAILURE);
+		}
+	}
+	else {
+		/* Trap signals that we expect to receive */
+		signal(SIGINT, child_handler);
+		signal(SIGTERM, child_handler);
+	}
+
+	/* */
+	slcand_running = 1;
+
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
 	/* The Big Loop */
 	while (slcand_running)
 		sleep(1); /* wait 1 second */
-- 
1.9.1


--=_zZmL19KkEbFFxVMDvv8YDsg--

