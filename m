From: yegorslists@googlemail.com
Subject: [PATCH] candump: resolve signedness warnings
Date: Thu, 19 Apr 2012 09:44:06 +0200
Message-ID: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:44655 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab2DSHo2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 03:44:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 candump.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/candump.c b/candump.c
index 5ba9431..ac51192 100644
--- a/candump.c
+++ b/candump.c
@@ -611,7 +611,7 @@ int main(int argc, char **argv)
 					return 1;
 				}
 
-				if (nbytes < sizeof(struct can_frame)) {
+				if ((size_t)nbytes < sizeof(struct can_frame)) {
 					fprintf(stderr, "read: incomplete CAN frame\n");
 					return 1;
 				}
@@ -627,7 +627,7 @@ int main(int argc, char **argv)
 					if (nbytes < 0) {
 						perror("bridge write");
 						return 1;
-					} else if (nbytes < sizeof(struct can_frame)) {
+					} else if ((size_t)nbytes < sizeof(struct can_frame)) {
 						fprintf(stderr,"bridge write: incomplete CAN frame\n");
 						return 1;
 					}
-- 
1.7.7

