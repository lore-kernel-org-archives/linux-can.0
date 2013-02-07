From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] cangen: use long long in time computation for -g to support >2.1s
Date: Thu,  7 Feb 2013 11:38:09 +0100
Message-ID: <1360233489-14471-1-git-send-email-mkl@pengutronix.de>
References: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56274 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab3BGKiN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 05:38:13 -0500
In-Reply-To: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Konrad Anton <konrad.anton@awinia.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Konrad Anton <konrad.anton@awinia.de>

The computation of nanosleep times for the "-g" option to cangen.c (delay
between sends) overflows when more than 2100ms are given.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

This is the pull gitorious pull reqeust transformed into a standard git one. :)

Marc

 cangen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cangen.c b/cangen.c
index 7518c12..db4c803 100644
--- a/cangen.c
+++ b/cangen.c
@@ -269,7 +269,7 @@ int main(int argc, char **argv)
 	}
 
 	ts.tv_sec = gap / 1000;
-	ts.tv_nsec = ((int)(gap * 1000000)) % 1000000000;
+	ts.tv_nsec = (long)(((long long)(gap * 1000000)) % 1000000000ll);
 
 	/* recognize obviously missing commandline option */
 	if (id_mode == MODE_FIX && frame.can_id > 0x7FF && !extended) {
-- 
1.7.10.4

