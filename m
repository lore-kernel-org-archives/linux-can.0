From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: fix oops caused by wrong rtnl dellink usage
Date: Tue, 21 Jun 2016 15:45:47 +0200
Message-ID: <1466516747-5192-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:22665 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbcFUN61 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2016 09:58:27 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

For 'real' hardware CAN devices the netlink interface is used to set CAN
specific communication parameters. Real CAN hardware can not be created nor
removed with the ip tool ...

This patch adds a private dellink function for the CAN device driver interface
that does just nothing.

It's a follow up to commit 993e6f2fd ("can: fix oops caused by wrong rtnl
newlink usage") but for dellink.

Reported-by: ajneu <ajneu1@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 910c12e..b1dc109 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -1008,6 +1008,11 @@ static int can_newlink(struct net *src_net, struct net_device *dev,
 	return -EOPNOTSUPP;
 }
 
+static void can_dellink(struct net_device *dev, struct list_head *head)
+{
+	return;
+}
+
 static struct rtnl_link_ops can_link_ops __read_mostly = {
 	.kind		= "can",
 	.maxtype	= IFLA_CAN_MAX,
@@ -1016,6 +1021,7 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
 	.validate	= can_validate,
 	.newlink	= can_newlink,
 	.changelink	= can_changelink,
+	.dellink	= can_dellink,
 	.get_size	= can_get_size,
 	.fill_info	= can_fill_info,
 	.get_xstats_size = can_get_xstats_size,
-- 
2.8.1

