From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC] sched policies for candump
Date: Thu, 18 Dec 2014 10:41:58 +0100
Message-ID: <5492A166.4090806@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net> <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com> <53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl> <53DA39CF.2070303@pengutronix.de> <53DA4E89.1080206@hartkopp.net> <CA+V-a8uhnn9cfuxULZQ4oBScy9jYfev+n50SphK+HDTVLPVO_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:62586 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbaLRJmC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 04:42:02 -0500
In-Reply-To: <CA+V-a8uhnn9cfuxULZQ4oBScy9jYfev+n50SphK+HDTVLPVO_g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Prabhakar,

I just discovered your pull-request for candump to add scheduling policies for candump:

https://gitorious.org/linux-can/can-utils/commit/0ea8caacfa723271778d000e8cb97b2be4f92165

Is this still needed / valuable?

If so I would suggest to make the commandline option able to handle more than only SCHED_RR ...

Would the following patch be ok for you?

Regards,
Oliver

---

diff --git a/candump.c b/candump.c
index a1146f5..4334be5 100644
--- a/candump.c
+++ b/candump.c
@@ -51,6 +51,7 @@
 #include <libgen.h>
 #include <time.h>
 #include <errno.h>
+#include <sched.h>
 
 #include <sys/time.h>
 #include <sys/types.h>
@@ -124,6 +125,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -e          (dump CAN error frames in human-readable format)\n");
 	fprintf(stderr, "         -x          (print extra message infos, rx/tx brs esi)\n");
 	fprintf(stderr, "         -T <msecs>  (terminate after <msecs> without any reception)\n");
+	fprintf(stderr, "         -R <p:prio> (set priority for scheduling policy p={R,F})\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with optional filter sets can be specified\n", MAXSOCK);
 	fprintf(stderr, "on the commandline in the form: <ifname>[,filter]*\n");
@@ -216,6 +218,8 @@ int main(int argc, char **argv)
 	unsigned char logfrmt = 0;
 	int count = 0;
 	int rcvbuf_size = 0;
+	int sched_policy = 0;
+	int sched_priority = 0;
 	int opt, ret;
 	int currmax, numfilter;
 	char *ptr, *nptr;
@@ -240,7 +244,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:?")) != -1) {
+	while ((opt = getopt(argc, argv, "t:ciaSs:b:B:u:ldxLn:r:heT:R:?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -366,6 +370,23 @@ int main(int argc, char **argv)
 			timeout_config.tv_usec = (timeout_config.tv_usec % 1000) * 1000;
 			timeout_current = &timeout;
 			break;
+
+		case 'R':
+		{
+			/* check for supported scheduling policy 'p:<prio>' */
+			if (optarg[0] == 'R' && optarg[1] == ':')
+				sched_policy = SCHED_RR;
+			else if (optarg[0] == 'F' && optarg[1] == ':')
+				sched_policy = SCHED_FIFO;
+			else {
+				print_usage(basename(argv[0]));
+				exit(1);
+			}
+			/* get priority from behind the ':' */
+			sched_priority = atoi(optarg+2);
+			break;
+		}
+
 		default:
 			print_usage(basename(argv[0]));
 			exit(1);
@@ -596,6 +617,17 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/* set scheduler policy and priority */
+	if (sched_policy) {
+		struct sched_param sched;
+
+		memset(&sched, 0, sizeof sched);
+		sched.sched_priority = sched_priority;
+		if (sched_setscheduler(0, sched_policy, &sched) < 0)
+			fprintf(stderr, "\nFailed to select scheduler policy: %s (%d)\n",
+				strerror(errno), errno);
+	}
+
 	/* these settings are static and can be held out of the hot path */
 	iov.iov_base = &frame;
 	msg.msg_name = &addr;


