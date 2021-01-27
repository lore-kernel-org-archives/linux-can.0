Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A999C433E9
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499E92076E
	for <linux-can@archiver.kernel.org>; Wed, 27 Jan 2021 09:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhA0JoJ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 27 Jan 2021 04:44:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39397 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhA0Jla (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:41:30 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4hJR-0002Hy-3l
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 10:40:33 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B73F05CF835
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 09:40:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E50BE5CF82B;
        Wed, 27 Jan 2021 09:40:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f253ac90;
        Wed, 27 Jan 2021 09:40:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-01-27
Date:   Wed, 27 Jan 2021 10:40:27 +0100
Message-Id: <20210127094028.2778793-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jakub, hello David,

this is a pull request of 1 patch for net/master.

The patch is by Dan Carpenter and fixes a potential information leak in
can_fill_info().

Note: Sorry to say this again: This patch touches "drivers/net/can/dev.c". In
net-next/master this file has been moved to drivers/net/can/dev/dev.c [1] and
parts of it have been transfered into separate files. This may result in a
merge conflict. Please carry this patch forward, the change is rather simple.

[1] 3e77f70e7345 can: dev: move driver related infrastructure into separate subdir

regards,
Marc

---

The following changes since commit b491e6a7391e3ecdebdd7a097550195cc878924a:

  net: lapb: Add locking to the lapb module (2021-01-26 17:53:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.11-20210127

for you to fetch changes up to b552766c872f5b0d90323b24e4c9e8fa67486dd5:

  can: dev: prevent potential information leak in can_fill_info() (2021-01-27 10:25:01 +0100)

----------------------------------------------------------------
linux-can-fixes-for-5.11-20210127

----------------------------------------------------------------
Dan Carpenter (1):
      can: dev: prevent potential information leak in can_fill_info()

 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


