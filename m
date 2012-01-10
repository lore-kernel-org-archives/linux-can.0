From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] canutils: candump: Add error frame's handling
Date: Tue, 10 Jan 2012 18:55:11 +0530
Message-ID: <1326201911-18255-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48157 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab2AJNZn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 08:25:43 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, m.kleine-budde@pengutronix.de, r.schwebel@pengutronix.de, linux-can@vger.kernel.org
Cc: nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch adds the error handling capability to candump utility
by adding error flags for displaying all kind of error frames
like tx_timeout, lost arbitration, controller problems, buserrors,
bus warnings etc.

Usage of candump for error frame display on console:
candump [<can-interface>] [Options]
Ex: candump can0 --error

This patch is created on top of canutils-4.0.6 tag from
http://git.pengutronix.de/?p=tools/canutils.git

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 src/candump.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/candump.c b/src/candump.c
index 259d442..c16425b 100644
--- a/src/candump.c
+++ b/src/candump.c
@@ -20,6 +20,7 @@
 
 #include <linux/can.h>
 #include <linux/can/raw.h>
+#include <linux/can/error.h>
 
 extern int optind, opterr, optopt;
 
@@ -40,6 +41,7 @@ static void print_usage(char *prg)
 		" -p, --protocol=PROTO\t"	"CAN protocol (default CAN_RAW = %d)\n"
 		"     --filter=id:mask[:id:mask]...\n"
 		"\t\t\t"			"apply filter\n"
+		" -e, --error\t\t"		"dump error frames along with data frames\n"
 		" -h, --help\t\t"		"this help\n"
 		" -o <filename>\t\t"		"output into filename\n"
 		" -d\t\t\t"			"daemonize\n"
@@ -86,6 +88,11 @@ int main(int argc, char **argv)
 	int nbytes, i;
 	int opt, optdaemon = 0;
 	uint32_t id, mask;
+	int error = 0;
+	can_err_mask_t err_mask = (CAN_ERR_TX_TIMEOUT | CAN_ERR_LOSTARB |
+					CAN_ERR_CRTL | CAN_ERR_PROT |
+					CAN_ERR_TRX | CAN_ERR_ACK | CAN_ERR_BUSOFF |
+					CAN_ERR_BUSERROR);
 
 	signal(SIGPIPE, SIG_IGN);
 
@@ -95,6 +102,7 @@ int main(int argc, char **argv)
 		{ "protocol", required_argument, 0, 'p' },
 		{ "type", required_argument, 0, 't' },
 		{ "filter", required_argument, 0, FILTER_OPTION },
+		{ "error", no_argument, 0, 'e' },
 		{ "version", no_argument, 0, VERSION_OPTION},
 		{ 0, 0, 0, 0},
 	};
@@ -121,6 +129,10 @@ int main(int argc, char **argv)
 			proto = strtoul(optarg, NULL, 0);
 			break;
 
+		case 'e':
+			error = 1;
+			break;
+
 		case 'o':
 			optout = optarg;
 			break;
@@ -186,6 +198,14 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (error) {
+		if (setsockopt(s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER, &err_mask,
+			       sizeof(err_mask)) != 0) {
+			perror("setsockopt");
+			exit(1);
+		}
+	}
+
 	if (optdaemon)
 		daemon(1, 0);
 	else {
-- 
1.7.5.4

