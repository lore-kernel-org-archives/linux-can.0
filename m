Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEADFC433ED
	for <linux-can@archiver.kernel.org>; Thu, 20 May 2021 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D8E6101B
	for <linux-can@archiver.kernel.org>; Thu, 20 May 2021 22:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhETWnu (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 20 May 2021 18:43:50 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:39225 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230239AbhETWnu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 20 May 2021 18:43:50 -0400
Received: from MTA-13-4.privateemail.com (mta-13.privateemail.com [198.54.118.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 6733E816BF
        for <linux-can@vger.kernel.org>; Thu, 20 May 2021 18:27:44 -0400 (EDT)
Received: from mta-13.privateemail.com (localhost [127.0.0.1])
        by mta-13.privateemail.com (Postfix) with ESMTP id 5A9CD8007A;
        Thu, 20 May 2021 18:27:43 -0400 (EDT)
Received: from localhost (unknown [10.20.151.207])
        by mta-13.privateemail.com (Postfix) with ESMTPA id 2D9D380078;
        Thu, 20 May 2021 18:27:43 -0400 (EDT)
Date:   Thu, 20 May 2021 15:27:36 -0700
From:   Matt Kline <mkline@anduril.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: [PATCH 0/2] can: m_can: Merge FIFO ops to increase throughput
Message-ID: <cover.1621547812.git.mkline@anduril.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

While debugging low throughput on a tcan4x5x chip using a logic
analyzer, I found that the SPI bus is silent for the *vast* majority of
time spent sending or receiving a CAN frame.
Each SPI transfer takes ~5 microseconds, but there's an order of
magnitude more time (50-60 microseconds) between them. This doesn't seem
to be caused by any sort of contention - it happens on a SPI bus with a
single chip select and no other drivers accessing it. Presumably there's
a (relatively) large fixed cost to request a transfer from the SPI
controller on the hardware I'm using (an NVIDIA Jetson platform).

Let's improve throughput by combining FIFO reads and writes into larger
transfers - one for ID & DLC, one for the frame data - instead of
handling single words at a time. We could reduce the number of transfers
further by batching certain control register reads, but this is an easy
place to start, since FIFO registers are contiguous.

Since TX and RX time is dominated by the fixed, per-transfer delays
mentioned above, this nets substantial performance improvements - about
20% faster for small CAN frames and nearly 5x faster for max size
(64 byte) CAN FD frames.

Matt Kline (2):
  can: m_can: Batch FIFO reads during CAN receive
  can: m_can: Batch FIFO writes during CAN send

 drivers/net/can/m_can/m_can.c          | 77 +++++++++++++-------------
 drivers/net/can/m_can/m_can.h          |  4 +-
 drivers/net/can/m_can/m_can_pci.c      | 11 ++--
 drivers/net/can/m_can/m_can_platform.c | 11 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 12 ++--
 5 files changed, 60 insertions(+), 55 deletions(-)

-- 
2.31.1

