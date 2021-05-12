Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E75C433B4
	for <linux-can@archiver.kernel.org>; Wed, 12 May 2021 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C6861260
	for <linux-can@archiver.kernel.org>; Wed, 12 May 2021 07:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELHME (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 12 May 2021 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhELHMD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 May 2021 03:12:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1668C061574
        for <linux-can@vger.kernel.org>; Wed, 12 May 2021 00:10:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lgj1C-0005yG-Ig
        for linux-can@vger.kernel.org; Wed, 12 May 2021 09:10:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 064FB622BE4
        for <linux-can@vger.kernel.org>; Wed, 12 May 2021 07:10:53 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7D76B622BDD;
        Wed, 12 May 2021 07:10:52 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ec6b43b;
        Wed, 12 May 2021 07:10:52 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: pull-request: can 2021-05-12
Date:   Wed, 12 May 2021 09:10:49 +0200
Message-Id: <20210512071050.1760001-1-mkl@pengutronix.de>
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

Hello Jakub, hello David,

this is a pull request of a single patch for net/master.

The patch is by Norbert Slusarek and it fixes a race condition in the
CAN ISO-TP socket between isotp_bind() and isotp_setsockopt().

regards,
Marc

---

The following changes since commit 440c3247cba3d9433ac435d371dd7927d68772a7:

  net: ipa: memory region array is variable size (2021-05-11 16:22:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.13-20210512

for you to fetch changes up to 2b17c400aeb44daf041627722581ade527bb3c1d:

  can: isotp: prevent race between isotp_bind() and isotp_setsockopt() (2021-05-12 08:52:47 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.13-20210512

----------------------------------------------------------------
Norbert Slusarek (1):
      can: isotp: prevent race between isotp_bind() and isotp_setsockopt()

 net/can/isotp.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)


