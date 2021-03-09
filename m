Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8F9C433E9
	for <linux-can@archiver.kernel.org>; Tue,  9 Mar 2021 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B375A652AB
	for <linux-can@archiver.kernel.org>; Tue,  9 Mar 2021 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCIIWZ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 9 Mar 2021 03:22:25 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:8296 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCIIWH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 03:22:07 -0500
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 140DE5FFD0;
        Tue,  9 Mar 2021 09:22:03 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/3] can/peak_usb: Added improvement to the peak_usb driver
Date:   Tue,  9 Mar 2021 09:21:25 +0100
Message-Id: <20210309082128.23125-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches adds the following improvements:

- allows to identify CAN ports by their LEDs
- completes the list of devices supported by the module
- adds ONE_SHOT mode to some devices

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Stephane Grosjean (3):
  can/peak_usb: add support of ethtool set_phys_id() callback
  can/peak_usb: add forgotten supported devices
  can/peak_usb: add support of ONE_SHOT mode

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 47 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 47 ++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 46 +++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  6 +++
 6 files changed, 144 insertions(+), 8 deletions(-)

-- 
2.25.1

