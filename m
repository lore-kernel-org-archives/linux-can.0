From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH]: canfdtest typo while waiting for tv_stop time
Date: Wed, 16 Nov 2016 11:46:19 +0100
Message-ID: <5bd8e04f-606c-0b25-dab9-7a1090ca8810@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:45607 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbcKPKq2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Nov 2016 05:46:28 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Mark,

After a few complaint about 100% CPU usage of canfdtest over our PCI 
-like boards, I have had a look to the source file, and think I have 
found the issue in:

diff --git a/canfdtest.c b/canfdtest.c
index 2407027..d7ba740 100644
--- a/canfdtest.c
+++ b/canfdtest.c
@@ -239,7 +239,7 @@ static int can_echo_dut(void)
                                 }
                                 gettimeofday(&tvn, NULL);
                                 while ((tv_stop.tv_sec > tvn.tv_sec) ||
-                                      ((tv_stop.tv_sec = tvn.tv_sec) &&
+                                      ((tv_stop.tv_sec == tvn.tv_sec) &&
                                         (tv_stop.tv_usec >= tvn.tv_usec)))
                                         gettimeofday(&tvn, NULL);
                         }

Am I right?

Regards,

Stéphane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
