From: Armin Burchardt <armin@uni-bremen.de>
Subject: [PATCH 3/3] slcand: add option -u to set interface up/down state.
Date: Mon,  8 Jun 2015 13:55:40 +0200
Message-ID: <1433764540-24917-3-git-send-email-armin@uni-bremen.de>
References: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:44921 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751387AbbFHLzp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 07:55:45 -0400
In-Reply-To: <1433764540-24917-1-git-send-email-armin@uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Armin Burchardt <armin@uni-bremen.de>

Signed-off-by: Armin Burchardt <armin@uni-bremen.de>
---
 slcand.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/slcand.c b/slcand.c
index 8fd1418..aa1c79b 100644
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
@@ -159,6 +160,43 @@ static int look_up_uart_speed(long int s)
 	}
 }
 
+/* set selected interface flags */
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
+	/* copy interface name to ioctl data */
+	strncpy(ifr.ifr_name, name, IFNAMSIZ);
+	/* get flags for interface with that name */
+	err = ioctl(fd, SIOCGIFFLAGS, &ifr);
+	if (err == -1) {
+		perror("SIOCGIFFLAGS");
+	} else {
+		/* clear all flags which are selected in mask */
+		ifr.ifr_flags &= ~mask;
+		/* set requested flags which are selected in mask,
+		 * keep values of flags which are not selected. */
+		ifr.ifr_flags |= mask&flags;
+		/* write flags back to interface */
+		err = ioctl(fd, SIOCSIFFLAGS, &ifr);
+		if (err == -1) {
+			perror("SIOSSIFFLAGS");
+		}
+	}
+	close(fd);
+	return err;
+}
+
 int main(int argc, char *argv[])
 {
 	char *tty = NULL;
@@ -173,6 +211,7 @@ int main(int argc, char *argv[])
 	int send_open = 0;
 	int send_close = 0;
 	int send_read_status_flags = 0;
+	int control_ifstate = 0;
 	char *speed = NULL;
 	char *uart_speed_str = NULL;
 	long int uart_speed = 0;
@@ -186,7 +225,7 @@ int main(int argc, char *argv[])
 
 	ttypath[0] = '\0';
 
-	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p:?hF")) != -1) {
+	while ((opt = getopt(argc, argv, "ocfs:S:t:b:p:u?hF")) != -1) {
 		switch (opt) {
 		case 'o':
 			send_open = 1;
@@ -234,6 +273,9 @@ int main(int argc, char *argv[])
 		case 'p':
 			pidfile = optarg;
 			break;
+		case 'u':
+			control_ifstate = 1;
+			break;
 		case 'h':
 		case '?':
 		default:
@@ -355,6 +397,18 @@ int main(int argc, char *argv[])
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
 	/* Daemonize (_after_ interface is up to avoid race-conditions,
 	 * ie. between init.d-scripts). */
 	if (run_as_daemon) {
@@ -397,6 +451,13 @@ int main(int argc, char *argv[])
 	while (slcand_running)
 		sleep(1); /* wait 1 second */
 
+	/* set interface state to 'DOWN' */
+	if (control_ifstate) {
+		/* clear 'IFF_UP' flag */
+		candev_setflags(name ? name : buf, ~IFF_UP, IFF_UP);
+		syslog(LOG_ERR, "could not set %s state to 'DOWN'", name);
+	}
+
 	/* Reset line discipline */
 	syslog(LOG_INFO, "stopping on TTY device %s", ttypath);
 	ldisc = N_TTY;
-- 
1.9.1

