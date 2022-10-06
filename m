Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BBCC433FE
	for <linux-can@archiver.kernel.org>; Thu,  6 Oct 2022 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJFQZL (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFQZG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2022 12:25:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84E122BF8
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 09:24:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogTg9-0002pL-NC
        for linux-can@vger.kernel.org; Thu, 06 Oct 2022 18:24:57 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 22DBBF6636
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2022 16:24:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D1B1AF6634;
        Thu,  6 Oct 2022 16:24:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 84573c82;
        Thu, 6 Oct 2022 16:24:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 0/6] can: gs_usb: new features: GS_CAN_FEATURE_GET_STATE, GS_CAN_FEATURE_BERR_REPORTING
Date:   Thu,  6 Oct 2022 18:24:46 +0200
Message-Id: <20221006162452.200322-1-mkl@pengutronix.de>
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

Hello,

this series consists of a few clean up patches by me and Jeroen
Hofstee patches that adds 2 new features (GS_CAN_FEATURE_GET_STATE,
GS_CAN_FEATURE_BERR_REPORTING). These patches are based on the
venus-5.19.4-gsusb branch of his Linux tree.

| https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb

Changes since venus-5.19.4-gsusb:
- fixed 2nd parameter of usb_control_msg_recv()
- rebased to current net-next/main
- renumbered the FEATURE, MODE and BREQ bits, as termination support
  landed mainline first
- split GS_CAN_FEATURE_GET_STATE patch into documentation and
  implementation part
- added Not-Signed-off-by: tag, as these patches are not Signed-off yet

regards,
Marc

Link: https://github.com/candle-usb/candleLight_fw/pull/107
Link: https://github.com/jhofstee/linux/tree/venus-5.19.4-gsusb


