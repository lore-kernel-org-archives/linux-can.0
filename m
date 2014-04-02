From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 2/2] net can softing: remove unused sysfs attributes
Date: Wed,  2 Apr 2014 21:17:48 +0200
Message-ID: <1396466269-28444-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:2508 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932723AbaDBTSC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 15:18:02 -0400
Received: from airbook.e-circ.lan (unknown [192.168.0.70])
	by cylon.vandijck-laurijssen.be (Postfix) with ESMTP id 3CE3D4CE6C
	for <linux-can@vger.kernel.org>; Wed,  2 Apr 2014 21:17:59 +0200 (CEST)
In-Reply-To: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

'frequency' indicates the embedded cpu's frequency, but that
should not be necessary for any purpose.
'txpending' is an attribute for debugging.

Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
---
 drivers/net/can/softing/softing_main.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 6cfbccd..fb5312c 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -714,8 +714,6 @@ DEV_ATTR_RO(firmware_version, id.fw_version);
 DEV_ATTR_RO_STR(hardware, pdat->name);
 DEV_ATTR_RO(hardware_version, id.hw_version);
 DEV_ATTR_RO(license, id.license);
-DEV_ATTR_RO(frequency, id.freq);
-DEV_ATTR_RO(txpending, tx.pending);
 
 static struct attribute *softing_pdev_attrs[] = {
 	&dev_attr_serial.attr,
@@ -724,8 +722,6 @@ static struct attribute *softing_pdev_attrs[] = {
 	&dev_attr_hardware.attr,
 	&dev_attr_hardware_version.attr,
 	&dev_attr_license.attr,
-	&dev_attr_frequency.attr,
-	&dev_attr_txpending.attr,
 	NULL,
 };
 
-- 
1.7.10.4

