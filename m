Return-Path: <SRS0=gX5R=DX=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8656C433DF
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606EA205CB
	for <linux-can@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgJPUwP (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408456AbgJPUwO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Oct 2020 16:52:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38BDC061755
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2020 13:52:14 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kTWhx-00084g-A4; Fri, 16 Oct 2020 22:52:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Magnus=20Aagaard=20S=C3=B8rensen?= 
        <mas@csselectronics.com>
Subject: [PATCH v2 0/3] can: mcp251xfd: PLL support
Date:   Fri, 16 Oct 2020 22:52:08 +0200
Message-Id: <20201016205211.1141590-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I've looked at Magnus Aagaard Sørensen's patches and decided the PLL idea looks
quite good, but the runtime pm change should better made after adding PLL support.

This series focuses on adding PLL support only. Consider this as an RFC, the
patches need proper description.

I've tested the setup here with two mcp2518fd, where one supplies the 4MHz for
the other and it works for me.

Testing welcome.

regards,
Marc


