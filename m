Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35790C4320A
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207696008E
	for <linux-can@archiver.kernel.org>; Mon, 26 Jul 2021 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhGZNdP (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhGZNcy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:32:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF0C0617A5
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81LF-0001ix-Bo
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 1983465823E
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:12:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EE2136581B8;
        Mon, 26 Jul 2021 14:11:54 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 90596ae0;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/46] can: at91_can: use DEVICE_ATTR_RW() helper macro
Date:   Mon, 26 Jul 2021 16:11:20 +0200
Message-Id: <20210726141144.862529-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726141144.862529-1-mkl@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Use DEVICE_ATTR_RW() helper macro instead of plain DEVICE_ATTR(), which
makes the code a bit shorter and easier to read.

Link: https://lore.kernel.org/r/20210603100233.11877-1-thunder.leizhen@huawei.com
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 04d0bb3ffe89..ca736b26e218 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1176,8 +1176,8 @@ static const struct net_device_ops at91_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static ssize_t at91_sysfs_show_mb0_id(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t mb0_id_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct at91_priv *priv = netdev_priv(to_net_dev(dev));
 
@@ -1187,8 +1187,8 @@ static ssize_t at91_sysfs_show_mb0_id(struct device *dev,
 		return snprintf(buf, PAGE_SIZE, "0x%03x\n", priv->mb0_id);
 }
 
-static ssize_t at91_sysfs_set_mb0_id(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t mb0_id_store(struct device *dev,
+			    struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct net_device *ndev = to_net_dev(dev);
 	struct at91_priv *priv = netdev_priv(ndev);
@@ -1222,7 +1222,7 @@ static ssize_t at91_sysfs_set_mb0_id(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(mb0_id, 0644, at91_sysfs_show_mb0_id, at91_sysfs_set_mb0_id);
+static DEVICE_ATTR_RW(mb0_id);
 
 static struct attribute *at91_sysfs_attrs[] = {
 	&dev_attr_mb0_id.attr,
-- 
2.30.2


