Return-Path: <SRS0=VTa6=C3=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2377C43464
	for <linux-can@archiver.kernel.org>; Fri, 18 Sep 2020 17:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDC82073A
	for <linux-can@archiver.kernel.org>; Fri, 18 Sep 2020 17:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRRZm (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRRZm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2020 13:25:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6682AC0613CE
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2020 10:25:42 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kJK8g-0006bc-ES; Fri, 18 Sep 2020 19:25:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     manivannan.sadhasivam@linaro.org, dev.kurt@vandijck-laurijssen.be
Subject: [PATCH v53 1/6] mcp25xxfd: initial driver support
Date:   Fri, 18 Sep 2020 19:25:30 +0200
Message-Id: <20200918172536.2074504-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this is the mcp25xxfd driver I'm including in the upcoming pull request.
Changes since the last post:

- Limit SPI clock to 85% of sysclk/2 (thx Thomas Kopp)
- Add clock rate overview for atmel,sama5d27 (thx Thomas Kopp)
- Add Thomas Kopp as reveiwer
- configure rx_int gpio before requesting interrupts
- print frequency of external osc during registration
- Update clock rate table for imx8mm and alwinner h3
- sanitize contents on CAN messages where length is inbetween two dlcs
- add commets to smp_mb()

regards,
Marc


