Return-Path: <SRS0=L53H=DN=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63996C4363D
	for <linux-can@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E5320866
	for <linux-can@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgJFUhv (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUhv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Oct 2020 16:37:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFDC061755
        for <linux-can@vger.kernel.org>; Tue,  6 Oct 2020 13:37:51 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kPtiX-0002n3-UN; Tue, 06 Oct 2020 22:37:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
Subject: [RFC]: can-next 2020-10-06
Date:   Tue,  6 Oct 2020 22:37:31 +0200
Message-Id: <20201006203748.1750156-1-mkl@pengutronix.de>
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

this is my upcoming pull request to linux-can-next.

It consists of picked up patches from the ML as well as some new by me:

1, 2, 3: fix some W=1 findings.

13 and 14 remove the ack_grp and ack_bit from the binding and driver as they
are not used anymore.

regards,
Marc


