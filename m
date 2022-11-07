Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15197C4321E
	for <linux-can@archiver.kernel.org>; Tue,  8 Nov 2022 10:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiKHKTZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiKHKTR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2022 05:19:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698D1A05D
        for <linux-can@vger.kernel.org>; Tue,  8 Nov 2022 02:19:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1osLhL-0006Ol-33
        for linux-can@vger.kernel.org; Tue, 08 Nov 2022 11:19:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A2268115C3E
        for <linux-can@vger.kernel.org>; Mon,  7 Nov 2022 13:32:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1E950115C27;
        Mon,  7 Nov 2022 13:32:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id fa5bdaa3;
        Mon, 7 Nov 2022 13:32:20 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Chen Zhongjin <chenzhongjin@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/6] can: af_can: can_exit(): add missing dev_remove_pack() of canxl_packet
Date:   Mon,  7 Nov 2022 14:32:12 +0100
Message-Id: <20221107133217.59861-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221107133217.59861-1-mkl@pengutronix.de>
References: <20221107133217.59861-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Chen Zhongjin <chenzhongjin@huawei.com>

In can_init(), dev_add_pack(&canxl_packet) is added but not removed in
can_exit(). It breaks the packet handler list and can make kernel
panic when can_init() is called for the second time.

| > modprobe can && rmmod can
| > rmmod xxx && modprobe can
|
| BUG: unable to handle page fault for address: fffffbfff807d7f4
| RIP: 0010:dev_add_pack+0x133/0x1f0
| Call Trace:
|  <TASK>
|  can_init+0xaa/0x1000 [can]
|  do_one_initcall+0xd3/0x4e0
|  ...

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/all/20221031033053.37849-1-chenzhongjin@huawei.com
[mkl: adjust subject and commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 9503ab10f9b8..5e9e3e1e9825 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -902,6 +902,7 @@ static __init int can_init(void)
 static __exit void can_exit(void)
 {
 	/* protocol unregister */
+	dev_remove_pack(&canxl_packet);
 	dev_remove_pack(&canfd_packet);
 	dev_remove_pack(&can_packet);
 	sock_unregister(PF_CAN);

base-commit: c23fb2c82267638f9d206cb96bb93e1f93ad7828
-- 
2.35.1


