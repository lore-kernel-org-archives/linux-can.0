Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D4C433EF
	for <linux-can@archiver.kernel.org>; Thu, 17 Feb 2022 10:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiBQKip (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:38:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBQKio (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Feb 2022 05:38:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF58284D13
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 02:38:30 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKeBA-0003b0-Pu
        for linux-can@vger.kernel.org; Thu, 17 Feb 2022 11:38:28 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3720C362A0
        for <linux-can@vger.kernel.org>; Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0998E36299;
        Thu, 17 Feb 2022 10:38:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 40abe654;
        Thu, 17 Feb 2022 10:38:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
Subject: [PATCH net-next 0/8] can: mcp251xfd: add support for multiple
Date:   Thu, 17 Feb 2022 11:38:18 +0100
Message-Id: <20220217103826.2299157-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
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

this patch series enables support for multiple RX-FIFOs and prepares
the driver for RX/TX IRQ coalescing support. I have a working IRQ
coalescing proof of concept series, but it needs cleanups und more
testing. I hope I can find some time to polish the remaining patches
and get them upstream in this merge window.

regards,
Marc

P.S.: The mcp251xfd-dump tool of can-utils does not yet support the
changed order of RX and TX FIFOs, I'm working on an update, too.



