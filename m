From: yegorslists@googlemail.com
Subject: [PATCH 2/2] slcand: reimplement daemonize routine
Date: Mon, 13 Jan 2014 09:54:05 +0100
Message-ID: <1389603245-24023-2-git-send-email-yegorslists@googlemail.com>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:59307 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaAMJPh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 04:15:37 -0500
In-Reply-To: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, u.kleine-koenig@pengutronix.de, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Replace daemonize() routine with daemone() system call, because of
conflicting licenses. daemonize() routine was derived from under
GNU Free Documentation License licensed code. This license is
incompatible with GPL-2+.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 slcand.c |  144 +++-----------------------------------------------------------
 1 files changed, 6 insertions(+), 138 deletions(-)

diff --git a/slcand.c b/slcand.c
index 996c8d2..66e62e0 100644
--- a/slcand.c
+++ b/slcand.c
@@ -18,20 +18,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  *
- * This code is derived from an example daemon code from
- *
- * http://en.wikipedia.org/wiki/Daemon_(computer_software)#Sample_Program_in_C_on_Linux
- * (accessed 2009-05-05)
- *
- * So it is additionally licensed under the GNU Free Documentation License:
- *
- * Permission is granted to copy, distribute and/or modify this document
- * under the terms of the GNU Free Documentation License, Version 1.2
- * or any later version published by the Free Software Foundation;
- * with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
- * A copy of the license is included in the section entitled "GNU
- * Free Documentation License".
- *
  * Send feedback to <linux-can@vger.kernel.org>
  *
  */
@@ -63,9 +49,6 @@
 /* The length of ttypath buffer */
 #define TTYPATH_LENGTH	64
 
-/* The length of pidfile name buffer */
-#define PIDFILE_LENGTH	64
-
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
@@ -96,7 +79,6 @@ void print_usage(char *prg)
 static int slcand_running;
 static int exit_code;
 static char ttypath[TTYPATH_LENGTH];
-static char pidfile[PIDFILE_LENGTH];
 
 static void child_handler(int signum)
 {
@@ -178,117 +160,6 @@ static int look_up_uart_speed(long int s)
 	}
 }
 
-static pid_t daemonize(const char *lockfile, char *tty, char *name)
-{
-	pid_t pid, sid, parent;
-	int lfp = -1;
-	FILE *pFile;
-	char const *pidprefix = "/var/run/";
-	char const *pidsuffix = ".pid";
-
-	snprintf(pidfile, PIDFILE_LENGTH, "%s%s-%s%s", pidprefix, DAEMON_NAME, tty, pidsuffix);
-
-	/* already a daemon */
-	if (getppid() == 1)
-		return 0;
-
-	/* Create the lock file as the current user */
-	if (lockfile && lockfile[0]) {
-
-		lfp = open(lockfile, O_RDWR | O_CREAT, 0640);
-		if (lfp < 0)
-		{
-			syslog(LOG_ERR, "unable to create lock file %s, code=%d (%s)",
-			       lockfile, errno, strerror(errno));
-			exit(EXIT_FAILURE);
-		}
-	}
-
-	/* Drop user if there is one, and we were run as root */
-	if (getuid() == 0 || geteuid() == 0) {
-		struct passwd *pw = getpwnam(RUN_AS_USER);
-
-		if (pw)
-		{
-			/* syslog(LOG_NOTICE, "setting user to " RUN_AS_USER); */
-			setuid(pw->pw_uid);
-		}
-	}
-
-	/* Trap signals that we expect to receive */
-	signal(SIGINT, child_handler);
-	signal(SIGTERM, child_handler);
-	signal(SIGCHLD, child_handler);
-	signal(SIGUSR1, child_handler);
-	signal(SIGALRM, child_handler);
-
-	/* Fork off the parent process */
-	pid = fork();
-	if (pid < 0) {
-		syslog(LOG_ERR, "unable to fork daemon, code=%d (%s)",
-		       errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	/* If we got a good PID, then we can exit the parent process. */
-	if (pid > 0) {
-		/* Wait for confirmation from the child via SIGTERM or SIGCHLD, or
-		   for five seconds to elapse (SIGALRM).  pause() should not return. */
-		alarm(5);
-		pause();
-		exit(EXIT_FAILURE);
-	}
-
-	/* At this point we are executing as the child process */
-	parent = getppid();
-
-	/* Cancel certain signals */
-	signal(SIGCHLD, SIG_DFL);	/* A child process dies */
-	signal(SIGTSTP, SIG_IGN);	/* Various TTY signals */
-	signal(SIGTTOU, SIG_IGN);
-	signal(SIGTTIN, SIG_IGN);
-	signal(SIGHUP, SIG_IGN);	/* Ignore hangup signal */
-	signal(SIGINT, child_handler);
-	signal(SIGTERM, child_handler);
-
-	/* Change the file mode mask */
-	umask(0);
-
-	/* Create a new SID for the child process */
-	sid = setsid();
-	if (sid < 0) {
-		syslog(LOG_ERR, "unable to create a new session, code %d (%s)",
-		       errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	pFile = fopen(pidfile, "w");
-	if (NULL == pFile) {
-		syslog(LOG_ERR, "unable to create pid file %s, code=%d (%s)",
-		       pidfile, errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-	fprintf(pFile, "%d\n", sid);
-	fclose(pFile);
-
-	/* Change the current working directory.  This prevents the current
-	   directory from being locked; hence not being able to remove it. */
-	if (chdir("/") < 0) {
-		syslog(LOG_ERR, "unable to change directory to %s, code %d (%s)",
-		       "/", errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	/* Redirect standard files to /dev/null */
-	pFile = freopen("/dev/null", "r", stdin);
-	pFile = freopen("/dev/null", "w", stdout);
-	pFile = freopen("/dev/null", "w", stderr);
-
-	/* Tell the parent process that we are A-okay */
-	/* kill(parent, SIGUSR1); */
-	return parent;
-}
-
 int main(int argc, char *argv[])
 {
 	char *tty = NULL;
@@ -309,7 +180,6 @@ int main(int argc, char *argv[])
 	int flow_type = FLOW_NONE;
 	char *btr = NULL;
 	int run_as_daemon = 1;
-	pid_t parent_pid = 0;
 	char *pch;
 	int ldisc = LDISC_N_SLCAN;
 	int fd;
@@ -390,8 +260,12 @@ int main(int argc, char *argv[])
 	syslog(LOG_INFO, "starting on TTY device %s", ttypath);
 
 	/* Daemonize */
-	if (run_as_daemon)
-		parent_pid = daemonize("/var/lock/" DAEMON_NAME, tty, name);
+	if (run_as_daemon) {
+		if (daemon(0, 0)) {
+			syslog(LOG_ERR, "failed to daemonize");
+			exit(EXIT_FAILURE);
+		}
+	}
 	else {
 		/* Trap signals that we expect to receive */
 		signal(SIGINT, child_handler);
@@ -494,8 +368,6 @@ int main(int argc, char *argv[])
 			close(s);
 		}	
 	}
-	if (parent_pid > 0)
-		kill(parent_pid, SIGUSR1);
 
 	/* The Big Loop */
 	while (slcand_running)
@@ -522,10 +394,6 @@ int main(int argc, char *argv[])
 	if (tcsetattr(fd, TCSADRAIN, &tios) < 0)
 		syslog(LOG_NOTICE, "Cannot set attributes for device \"%s\": %s!\n", ttypath, strerror(errno));
 
-	/* Remove pidfile */
-	if (run_as_daemon)
-		unlink(pidfile);
-
 	/* Finish up */
 	syslog(LOG_NOTICE, "terminated on %s", ttypath);
 	closelog();
-- 
1.7.7

