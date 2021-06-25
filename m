Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B3C2B9F4
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 13:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A94161949
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 13:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFYNNQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 25 Jun 2021 09:13:16 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32176 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhFYNNQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:16 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id F37275FFAC;
        Fri, 25 Jun 2021 15:10:21 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/5] can: peak_usb: upgrade driver for PCAN-USB
Date:   Fri, 25 Jun 2021 15:09:26 +0200
Message-Id: <20210625130931.27438-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bundle of patches allows to upgrade the old code of the device
driver for the PCAN-USB made by PEAK-System GmbH. In particular:

- it adds support for loopback and one-shot modes when the version of the
  embedded firmware allows it
- it corrects the reading of error counters
- it updates the management of bus state changes using the functions
  exported by the can-dev module and the error counters values

Stephane Grosjean (5):
  can: peak_usb: pcan_usb_get_device_id(): read value only in case of
    success
  can: peak_usb: PCAN-USB: add support of loopback and one-short mode
  can: peak_usb: pcan_usb_handle_bus_evt(): fix reading rxerr/txerr
    values
  can: peak_usb: pcan_usb_encode_msg(): adds information
  can: peak_usb: upgrades the handling of bus state changes

 drivers/net/can/usb/peak_usb/pcan_usb.c | 238 ++++++++++--------------
 1 file changed, 99 insertions(+), 139 deletions(-)

-- 
2.25.1

