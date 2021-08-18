Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF3C4338F
	for <linux-can@archiver.kernel.org>; Wed, 18 Aug 2021 07:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2733E61053
	for <linux-can@archiver.kernel.org>; Wed, 18 Aug 2021 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHRHNU (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbhHRHNQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Aug 2021 03:13:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43AC06129D
        for <linux-can@vger.kernel.org>; Wed, 18 Aug 2021 00:12:41 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mGFkY-00050G-M3; Wed, 18 Aug 2021 09:12:34 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mGFkX-0005NQ-NS; Wed, 18 Aug 2021 09:12:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, David Jander <david@protonic.nl>
Subject: [PATCH v2 0/3] can: provide GPIO based termination 
Date:   Wed, 18 Aug 2021 09:12:29 +0200
Message-Id: <20210818071232.20585-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

changes v3:
- use u32 instead of u16 for termination-ohms
- extend error handling

changes v2:
- add CAN_TERMINATION_GPIO_MAX
- remove fsl,scu-index from yaml example. It is not used on imx6q

Oleksij Rempel (3):
  dt-bindings: can-controller: add support for termination-gpios
  dt-bindings: can: fsl,flexcan: enable termination-* bindings
  can: dev: provide optional GPIO based termination support

 .../bindings/net/can/can-controller.yaml      |  9 +++
 .../bindings/net/can/fsl,flexcan.yaml         | 17 +++++
 drivers/net/can/dev/dev.c                     | 66 +++++++++++++++++++
 include/linux/can/dev.h                       |  8 +++
 4 files changed, 100 insertions(+)

-- 
2.30.2

