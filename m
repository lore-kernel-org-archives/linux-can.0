Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A6C48BC2
	for <linux-can@archiver.kernel.org>; Mon, 21 Jun 2021 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEDD60724
	for <linux-can@archiver.kernel.org>; Mon, 21 Jun 2021 12:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFUMhB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFUMg6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 21 Jun 2021 08:36:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F796C061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 05:34:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvJ8T-0007AI-JB
        for linux-can@vger.kernel.org; Mon, 21 Jun 2021 14:34:41 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CA42E6405E7
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 12:34:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BDEE46405D8;
        Mon, 21 Jun 2021 12:34:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a47d0ddc;
        Mon, 21 Jun 2021 12:34:37 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [RFC]: can-next 2021-06-21: try to fix softirq error from threaded IRQs
Date:   Mon, 21 Jun 2021 14:34:28 +0200
Message-Id: <20210621123436.2897023-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this series tries to fix the softirq error which occurs if NAPI is
scheduled from threaded IRQ context [1][2]. Also it fixes a RX-before-TX
problem seen on the mcp251xfd driver.

regards,
Marc

[1] https://lore.kernel.org/r/20210310064626.GA11893@homes.emlix.com
[2] http://lore.kernel.org/r/CAOMZO5AMP537Qz1MAb-D_27C=WH-5Cf602hichxty95A6db9-A@mail.gmail.com




