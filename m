Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA1C433E0
	for <linux-can@archiver.kernel.org>; Sun, 10 Jan 2021 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78F923731
	for <linux-can@archiver.kernel.org>; Sun, 10 Jan 2021 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAJKiZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 10 Jan 2021 05:38:25 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:53377 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhAJKiZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Jan 2021 05:38:25 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d52 with ME
        id EycA2400E3PnFJp03ycdtu; Sun, 10 Jan 2021 11:36:41 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Jan 2021 11:36:41 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/1] Add software TX timestamps to the CAN devices
Date:   Sun, 10 Jan 2021 19:35:25 +0900
Message-Id: <20210110103526.61047-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With the ongoing work to add BQL to Socket CAN, I figured out that it
would be nice to have an easy way to mesure the latency.

And one easy way to do so it to check the round trip time of the
packet by doing the difference between the software rx timestamp and
the software tx timestamp.

rx timestamps are already available. This patch gives the missing
piece: add a tx software timestamp feature to the CAN devices.

Of course, the tx software timestamp might also be used for other
purposes such as performance measurements of the different queuing
disciplines (e.g. by checking the difference between the kernel tx
software timestamp and the userland tx software timestamp).

Vincent Mailhol (1):
  can: dev: add software tx timestamps

 drivers/net/can/dev.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.26.2

