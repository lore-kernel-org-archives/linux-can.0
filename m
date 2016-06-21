From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: fix handling of unmodifiable configuration options fix
Date: Tue, 21 Jun 2016 12:14:07 +0200
Message-ID: <1466504047-5110-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:23185 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcFUKPR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 06:15:17 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

With upstream commit bb208f144cf3f59 (can: fix handling of unmodifiable
configuration options) a new can_validate() function was introduced.

When invoking 'ip link set can0 type can' without any configuration data
can_validate() tries to validate the content without taking into account that
there's totally no content. This patch adds a check for missing content.

Reported-by: ajneu <ajneu1@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 910c12e..348dd50 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -798,6 +798,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[])
 	 * - control mode with CAN_CTRLMODE_FD set
 	 */
 
+	if (!data)
+		return 0;
+
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-- 
2.8.1

