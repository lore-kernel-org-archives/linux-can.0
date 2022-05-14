Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A5CC433F5
	for <linux-can@archiver.kernel.org>; Sat, 14 May 2022 18:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiENS5s (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 14 May 2022 14:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiENS5r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 May 2022 14:57:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D313F08
        for <linux-can@vger.kernel.org>; Sat, 14 May 2022 11:57:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1npwxU-0001yt-R3
        for linux-can@vger.kernel.org; Sat, 14 May 2022 20:57:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4CBAE7E3CB
        for <linux-can@vger.kernel.org>; Sat, 14 May 2022 18:57:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DFFFE7E3C6;
        Sat, 14 May 2022 18:57:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d42e406e;
        Sat, 14 May 2022 18:57:43 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH net 0/2] pull-request: can 2022-05-14
Date:   Sat, 14 May 2022 20:57:40 +0200
Message-Id: <20220514185742.407230-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
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

this is a pull request of 2 patches for net/master.

Changes to linux-can-fixes-for-5.18-20220513:
- adjusted Fixes: Tag on "Revert "can: m_can: pci: use custom bit timings for Elkhart Lake""
  (Thanks Jakub)

Both patches are by Jarkko Nikula, target the m_can PCI driver
bindings, and fix usage of wrong bit timing constants for the Elkhart
Lake platform.

regards,
Marc

---

The following changes since commit f3f19f939c11925dadd3f4776f99f8c278a7017b:

  Merge tag 'net-5.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-05-12 11:51:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-5.18-20220514

for you to fetch changes up to d6da7881020f9b37edb80ada12ce9b50b9232dc1:

  can: m_can: remove support for custom bit timing, take #2 (2022-05-14 20:53:01 +0200)

----------------------------------------------------------------
linux-can-fixes-for-5.18-20220514

----------------------------------------------------------------
Jarkko Nikula (2):
      Revert "can: m_can: pci: use custom bit timings for Elkhart Lake"
      can: m_can: remove support for custom bit timing, take #2

 drivers/net/can/m_can/m_can.c     | 24 +++++---------------
 drivers/net/can/m_can/m_can.h     |  3 ---
 drivers/net/can/m_can/m_can_pci.c | 48 ++++-----------------------------------
 3 files changed, 10 insertions(+), 65 deletions(-)


