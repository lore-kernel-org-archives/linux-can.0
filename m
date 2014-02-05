From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] cangw: Print error message on misspelled interface
Date: Wed,  5 Feb 2014 16:48:30 +0100
Message-ID: <1391615310-10731-1-git-send-email-sojkam1@fel.cvut.cz>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:44596 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaBEPsq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Feb 2014 10:48:46 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id A75073CFE84
	for <linux-can@vger.kernel.org>; Wed,  5 Feb 2014 16:48:45 +0100 (CET)
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id cfWBFJnpGYEM for <linux-can@vger.kernel.org>;
	Wed,  5 Feb 2014 16:48:41 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6EB6919F35DC
	for <linux-can@vger.kernel.org>; Wed,  5 Feb 2014 16:48:41 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Michal Sojka <sojkam1@fel.cvut.cz>

If can interface is misspelled or the kernel is configured without netlink
cangw displayed only generic usage instruction. Now, an appropriate error
message is displayed.

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 cangw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cangw.c b/cangw.c
index b908fe4..effb7ed 100644
--- a/cangw.c
+++ b/cangw.c
@@ -595,10 +595,18 @@ int main(int argc, char **argv)
 
 		case 's':
 			src_ifindex = if_nametoindex(optarg);
+			if (src_ifindex == 0) {
+				perror(optarg);
+				return 1;
+			}
 			break;
 
 		case 'd':
 			dst_ifindex = if_nametoindex(optarg);
+			if (dst_ifindex == 0) {
+				perror(optarg);
+				return 1;
+			}
 			break;
 
 		case 't':
-- 
1.8.5.2

