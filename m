Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF5C2D0A3
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 18:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E343D2224B
	for <linux-can@archiver.kernel.org>; Mon, 16 Nov 2020 18:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgKPSuB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:50:01 -0500
Received: from pd9568d8c.dip0.t-ipconnect.de ([217.86.141.140]:49650 "EHLO
        remote.esd.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727701AbgKPSuB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Nov 2020 13:50:01 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 13:50:01 EST
Received: from esd-s7 ([10.0.0.77]:56811 helo=esd-s7.esd)
        by remote.esd.eu with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <stefan.maetje@esd.eu>)
        id 1kejUM-00080b-2x; Mon, 16 Nov 2020 19:44:30 +0100
Received: from esd-s9.esd.local (unknown [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTP id D86807C1631;
        Mon, 16 Nov 2020 19:44:30 +0100 (CET)
Received: by esd-s9.esd.local (Postfix, from userid 2044)
        id C11A8E00E4; Mon, 16 Nov 2020 19:44:30 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     socketcan@hartkopp.net, linux-can@vger.kernel.org
Cc:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Subject: [PATCH 0/1] Add support for CAN_CTRLMODE_CC_LEN8_DLC to esd_usb2
Date:   Mon, 16 Nov 2020 19:44:29 +0100
Message-Id: <20201116184430.25462-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stefan Mätje <Stefan.Maetje@esd.eu>

Hi Oliver,

here is my patch to add support for CAN_CTRLMODE_CC_LEN8_DLC to the esd_usb2
driver. I have tested it with both supported devices the CAN-USB/2 and the
CAN-USB/Micro.

The patch is based on Marc's 'testing' branch of linux-can-next. I cloned it from
here:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

Btw. is there a simple way to read out the supported control modes of the
device (perhaps an ioctl())? The libsocketcan (at least the version 0.0.10) that
I have here on my system does only support to get/set the current control mode
and not the supported control modes.

Best regards,
Stefan

PS: I cloned the wording for the patch subject and comment shameless from your 
patch for the other device drivers.

Stefan Mätje (1):
  can: drivers: add len8_dlc support for esd_usb2 CAN adapter

 drivers/net/can/usb/esd_usb2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

