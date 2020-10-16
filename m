Return-Path: <SRS0=gX5R=DX=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A9BC433E7
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC69220848
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 07:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgJPHd1 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 16 Oct 2020 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404514AbgJPHd1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Oct 2020 03:33:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3734C061755
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2020 00:33:26 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kTKEq-00064p-EO; Fri, 16 Oct 2020 09:33:20 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kTKEm-0004El-Dy; Fri, 16 Oct 2020 09:33:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     mkl@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH v2 0/2] convert flexcan to the yaml
Date:   Fri, 16 Oct 2020 09:33:13 +0200
Message-Id: <20201016073315.16232-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

changes v2:
- add can-controller.yaml for common patterns
- use phandle-array instead of uint32-array
- Drop the outer 'items' in fsl,stop-mode
- use can@ instead of flexcan@

Oleksij Rempel (2):
  dt-bindings: can: add can-controller.yaml
  dt-bindings: can: flexcan: convert fsl,*flexcan bindings to yaml

 .../bindings/net/can/can-controller.yaml      |  16 ++
 .../bindings/net/can/fsl,flexcan.yaml         | 137 ++++++++++++++++++
 .../bindings/net/can/fsl-flexcan.txt          |  57 --------
 3 files changed, 153 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/can-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

-- 
2.28.0

