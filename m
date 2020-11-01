Return-Path: <SRS0=QGsL=EH=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA9C2D0A3
	for <linux-can@archiver.kernel.org>; Sun,  1 Nov 2020 16:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DDC2242A
	for <linux-can@archiver.kernel.org>; Sun,  1 Nov 2020 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgKAQ0d (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 1 Nov 2020 11:26:33 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:42500 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQ0c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 11:26:32 -0500
Received: from tomoyo.flets-east.jp ([153.230.197.127])
        by mwinf5d34 with ME
        id n4SL2300c2lQRaH034SUzb; Sun, 01 Nov 2020 17:26:30 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Nov 2020 17:26:30 +0100
X-ME-IP: 153.230.197.127
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] cangen: flush the CAN frame at each iteration
Date:   Mon,  2 Nov 2020 01:26:13 +0900
Message-Id: <20201101162613.503055-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The variable 'frame' is declared on the stack and is reused at each
iteration of the while loop.

If not flushed, garbage data from the previous iteration of the loop
could remain causing unexpected behavior. This is the case in DLC
random mode: the field frame.len8_dlc is not cleared when the dlc is
exactly 8 and the len8_dlc value of the previous iteration will be
sent again.

This can be observed by running 'cangen -8 can0'. Once a frame of DLC
in the range 9..15 is generated, no more frames of DLC 8 show out in
the log.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
--

Changes in v2: v1 was dumb and broke everything which was not in
random mode.  Just clear the len8_dlc.

---
 cangen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cangen.c b/cangen.c
index ab8122c..14887c8 100644
--- a/cangen.c
+++ b/cangen.c
@@ -171,7 +171,7 @@ int main(int argc, char **argv)
 	struct pollfd fds;
 
 	struct sockaddr_can addr;
-	static struct canfd_frame frame;
+	static struct canfd_frame frame = { 0 };
 	int nbytes;
 	int i;
 	struct ifreq ifr;
@@ -418,16 +418,16 @@ int main(int argc, char **argv)
 			if (canfd)
 				frame.len = can_dlc2len(random() & 0xF);
 			else {
+				struct can_frame *ccf = (struct can_frame *)&frame;
+
 				frame.len = random() & 0xF;
+				ccf->len8_dlc = 0;
 
 				if (frame.len > CAN_MAX_DLEN) {
-					if (len8_dlc) {
-						struct can_frame *ccf = (struct can_frame *)&frame;
-
+					if (len8_dlc)
 						/* generate Classic CAN len8 DLCs */
 						ccf->len8_dlc = frame.len;
-					}
-					frame.len = 8; /* for about 50% of the frames */
+					frame.len = CAN_MAX_DLEN; /* for about 50% of the frames */
 				}
 			}
 		}
-- 
2.26.2

