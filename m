Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F139C5479D
	for <linux-can@archiver.kernel.org>; Wed, 11 Jan 2023 22:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjAKWWD (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjAKWWB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2023 17:22:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A954319D
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 14:21:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pFjTp-0003xr-VY
        for linux-can@vger.kernel.org; Wed, 11 Jan 2023 23:21:58 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 495CE154C71
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2023 22:20:46 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1612F154C45;
        Wed, 11 Jan 2023 22:20:45 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id def5c8c0;
        Wed, 11 Jan 2023 22:20:44 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        =?UTF-8?q?Stefan=20Alth=C3=B6fer?= <Stefan.Althoefer@janztec.com>,
        kernel@pengutroniux.de
Subject: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Date:   Wed, 11 Jan 2023 23:20:37 +0100
Message-Id: <20230111222042.1139027-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this is a proof of concept implementation to work around the
"double-RX" erratum found by Stefan Althöfer.

With the help of Thomas we found out that the chip has a time window
after receiving a CAN frame where the RX FIFO STA register content is
not read correctly.

From the driver's point of view, everything looks consistent at first,
but the head index of the chip is too large. This causes the driver to
rehandle old CAN frames that have already been processed.

The workaround uses the RX timestamp to distinguish between new and
old data. As soon as old data is found, processing is stopped.

The series applies against current net/main. The patches lack proper
descriptions, I'll add them in the next round.

Happy testing,
Marc

Link: https://lore.kernel.org/all/FR0P281MB1966273C216630B120ABB6E197E89@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM



