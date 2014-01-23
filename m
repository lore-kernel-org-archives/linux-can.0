From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils] trivial: fix typo concerning "bandwidth"
Date: Thu, 23 Jan 2014 20:25:41 +0100
Message-ID: <1390505141-2348-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38455 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbaAWT0P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 14:26:15 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 canbusload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/canbusload.c b/canbusload.c
index a5fb553b7dab..a3e0750ab6f9 100644
--- a/canbusload.c
+++ b/canbusload.c
@@ -95,7 +95,7 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -c (colorize lines)\n");
 	fprintf(stderr, "         -b (show bargraph in %d%% resolution)\n", P=
ERCENTRES);
 	fprintf(stderr, "         -r (redraw the terminal - similar to top)\n=
");
-	fprintf(stderr, "         -i (ignore bitstuffing estimation in bandwi=
th calculation)\n");
+	fprintf(stderr, "         -i (ignore bitstuffing estimation in bandwi=
dth calculation)\n");
 	fprintf(stderr, "\n");
 	fprintf(stderr, "Up to %d CAN interfaces with mandatory bitrate can b=
e specified on the \n", MAXSOCK);
 	fprintf(stderr, "commandline in the form: <ifname>@<bitrate>\n\n");
--=20
1.8.5.2

