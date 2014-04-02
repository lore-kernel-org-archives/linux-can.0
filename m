From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 1/2] net can softing: drop 'channel' sysfs attribute
Date: Wed,  2 Apr 2014 21:17:47 +0200
Message-ID: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:59736 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932906AbaDBTSC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 15:18:02 -0400
Received: from airbook.e-circ.lan (unknown [192.168.0.70])
	by cylon.vandijck-laurijssen.be (Postfix) with ESMTP id 2E9B94CD4E
	for <linux-can@vger.kernel.org>; Wed,  2 Apr 2014 21:17:59 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

netdev->dev_id obsoletes this property.
None of the remaining properties contribute to udev detection methods.
The regular calls for the sysfs group can thus safely be restored.

Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
---
 drivers/net/can/softing/softing_main.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 65eef1e..6cfbccd 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -558,15 +558,6 @@ failed:
 /*
  * netdev sysfs
  */
-static ssize_t show_channel(struct device *dev, struct device_attribute *attr,
-		char *buf)
-{
-	struct net_device *ndev = to_net_dev(dev);
-	struct softing_priv *priv = netdev2softing(ndev);
-
-	return sprintf(buf, "%i\n", priv->index);
-}
-
 static ssize_t show_chip(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -611,12 +602,10 @@ static ssize_t store_output(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static const DEVICE_ATTR(channel, S_IRUGO, show_channel, NULL);
 static const DEVICE_ATTR(chip, S_IRUGO, show_chip, NULL);
 static const DEVICE_ATTR(output, S_IRUGO | S_IWUSR, show_output, store_output);
 
 static const struct attribute *const netdev_sysfs_attrs[] = {
-	&dev_attr_channel.attr,
 	&dev_attr_chip.attr,
 	&dev_attr_output.attr,
 	NULL,
@@ -680,17 +669,20 @@ static int softing_netdev_register(struct net_device *netdev)
 {
 	int ret;
 
-	netdev->sysfs_groups[0] = &netdev_sysfs_group;
 	ret = register_candev(netdev);
 	if (ret) {
 		dev_alert(&netdev->dev, "register failed\n");
 		return ret;
 	}
+	if (sysfs_create_group(&netdev->dev.kobj, &netdev_sysfs_group) < 0)
+		netdev_alert(netdev, "sysfs group failed\n");
+
 	return 0;
 }
 
 static void softing_netdev_cleanup(struct net_device *netdev)
 {
+	sysfs_remove_group(&netdev->dev.kobj, &netdev_sysfs_group);
 	unregister_candev(netdev);
 	free_candev(netdev);
 }
-- 
1.7.10.4

