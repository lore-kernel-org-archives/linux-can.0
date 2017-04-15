From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Fwd: [PATCH] can: use namespace aware procfs function
Date: Sat, 15 Apr 2017 20:12:08 +0200
Message-ID: <da6d2ac9-a6b1-2cdc-b80c-a47fef8ae887@hartkopp.net>
References: <20170415180629.2268-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:17182 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdDOSMQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Apr 2017 14:12:16 -0400
In-Reply-To: <20170415180629.2268-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey Marc,

can you squash this fix into my original RFC v2 patch?

I missed this change which then leads to a segfault.

Alternatively I can send a v3.

Regards,
Oliver


-------- Forwarded Message --------
Subject: [PATCH] can: use namespace aware procfs function
Date: Sat, 15 Apr 2017 20:06:29 +0200
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
CC: Oliver Hartkopp <socketcan@hartkopp.net>

Fixes 'can: complete initial namespace support'

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
  net/can/proc.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/proc.c b/net/can/proc.c
index 1a7d95e2335b..83045f00c63c 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -272,7 +272,7 @@ static int can_stats_proc_show(struct seq_file *m, 
void *v)
   static int can_stats_proc_open(struct inode *inode, struct file *file)
  {
-	return single_open(file, can_stats_proc_show, NULL);
+	return single_open_net(inode, file, can_stats_proc_show);
  }
   static const struct file_operations can_stats_proc_fops = {
@@ -306,7 +306,7 @@ static int can_reset_stats_proc_show(struct seq_file 
*m, void *v)
   static int can_reset_stats_proc_open(struct inode *inode, struct file 
*file)
  {
-	return single_open(file, can_reset_stats_proc_show, NULL);
+	return single_open_net(inode, file, can_reset_stats_proc_show);
  }
   static const struct file_operations can_reset_stats_proc_fops = {
@@ -325,7 +325,7 @@ static int can_version_proc_show(struct seq_file *m, 
void *v)
   static int can_version_proc_open(struct inode *inode, struct file *file)
  {
-	return single_open(file, can_version_proc_show, NULL);
+	return single_open_net(inode, file, can_version_proc_show);
  }
   static const struct file_operations can_version_proc_fops = {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
