Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB85C54EE9
	for <linux-can@archiver.kernel.org>; Tue, 20 Sep 2022 10:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiITKEx (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 20 Sep 2022 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiITKEv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 06:04:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98220BDA
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 03:04:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaa7U-0003qR-Hd
        for linux-can@vger.kernel.org; Tue, 20 Sep 2022 12:04:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DC24EE7470
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 69483E7468;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 75a2c362;
        Tue, 20 Sep 2022 10:04:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>
Subject: 
Date:   Tue, 20 Sep 2022 12:04:14 +0200
Message-Id: <20220920100416.959226-1-mkl@pengutronix.de>
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

Subject: [PATCH 0/3] can: gs_usb: fix hardware timestamping issues
In-Reply-To:

Hello,

while playing around with the hardware timestamping code, I found some
issues, which are fixed in this series.

John, can you test if timestamping still works on your hardware.

regards,
Marc



