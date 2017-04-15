From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: use namespace aware procfs function
Date: Sat, 15 Apr 2017 20:06:29 +0200
Message-ID: <20170415180629.2268-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:23583 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbdDOSGs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Apr 2017 14:06:48 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Fixes 'can: complete initial namespace support'

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 1a7d95e2335b..83045f00c63c 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -272,7 +272,7 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 static int can_stats_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_stats_proc_show, NULL);
+	return single_open_net(inode, file, can_stats_proc_show);
 }
 
 static const struct file_operations can_stats_proc_fops = {
@@ -306,7 +306,7 @@ static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 
 static int can_reset_stats_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_reset_stats_proc_show, NULL);
+	return single_open_net(inode, file, can_reset_stats_proc_show);
 }
 
 static const struct file_operations can_reset_stats_proc_fops = {
@@ -325,7 +325,7 @@ static int can_version_proc_show(struct seq_file *m, void *v)
 
 static int can_version_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_version_proc_show, NULL);
+	return single_open_net(inode, file, can_version_proc_show);
 }
 
 static const struct file_operations can_version_proc_fops = {
-- 
2.11.0

