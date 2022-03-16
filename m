Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF51C433EF
	for <linux-can@archiver.kernel.org>; Wed, 16 Mar 2022 20:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358078AbiCPUux (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358063AbiCPUuv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2022 16:50:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85DE3B28D
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 13:49:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUaaM-0003ta-9o
        for linux-can@vger.kernel.org; Wed, 16 Mar 2022 21:49:34 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CF0164CB89
        for <linux-can@vger.kernel.org>; Wed, 16 Mar 2022 20:47:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8E0BA4CB64;
        Wed, 16 Mar 2022 20:47:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ac314e07;
        Wed, 16 Mar 2022 20:47:11 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Derek Will <derekrobertwill@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/5] can: isotp: return -EADDRNOTAVAIL when reading from unbound socket
Date:   Wed, 16 Mar 2022 21:47:07 +0100
Message-Id: <20220316204710.716341-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316204710.716341-1-mkl@pengutronix.de>
References: <20220316204710.716341-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

When reading from an unbound can-isotp socket the syscall blocked
indefinitely. As unbound sockets (without given CAN address information)
do not make sense anyway we directly return -EADDRNOTAVAIL on read()
analogue to the known behavior from sendmsg().

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Link: https://github.com/linux-can/can-utils/issues/349
Link: https://lore.kernel.org/all/20220316164258.54155-2-socketcan@hartkopp.net
Suggested-by: Derek Will <derekrobertwill@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1662103ce125..6b6c82206c30 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1046,12 +1046,16 @@ static int isotp_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
+	struct isotp_sock *so = isotp_sk(sk);
 	int err = 0;
 	int noblock;
 
 	noblock = flags & MSG_DONTWAIT;
 	flags &= ~MSG_DONTWAIT;
 
+	if (!so->bound)
+		return -EADDRNOTAVAIL;
+
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
 		return err;
-- 
2.35.1


