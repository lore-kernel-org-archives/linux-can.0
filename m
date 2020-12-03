Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582BC43211
	for <linux-can@archiver.kernel.org>; Thu,  3 Dec 2020 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D3320705
	for <linux-can@archiver.kernel.org>; Thu,  3 Dec 2020 14:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLCOKH (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 3 Dec 2020 09:10:07 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:24684 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLCOKH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2020 09:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607004375;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=o2aVCg1kg+q3SZ6n9/rKxcpTwXIc2+cKzCUR2epdngU=;
        b=iTB8gsrQT6G27vTJZMeMZbVZYFywbGddt7Sab+F+0YL0/w4MhUOKtaFd+Z44w5XxBC
        7lAyD4C8T5lgsj3RJIsvAIw9WZqcGR3hQFiytZ+Y9c3DCMi0lUBD9uZa1VUE4EMwgoV/
        xnkx4OdUCgKbnCkAPcvy5wJlI01RGClbduJ4tEqFFckWaXFODVekdbAsyGWhg6vuPBMD
        Bw2aX7vQoMhYX6wikLilzFG2jK1Z385tyNLEmq9RkYeNxW7ZzFvmnu491jeDSYvBkBPe
        RKlGUZXQ7txx0jAiR/Bhzen54X+rg3vz22LH84d4E7o4LqIWU9OClbRRzxGEfx8bAlkM
        iELw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9dyKNLCWJaRrQ0pDCeGtVbNHMQ98lI/DcPKMT"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id n07f3bwB3E6DFop
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 3 Dec 2020 15:06:13 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mkl@pengutronix.de, kuba@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/2] can-isotp fix and functional addressing
Date:   Thu,  3 Dec 2020 15:06:02 +0100
Message-Id: <20201203140604.25488-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch set contains a fix that showed up while implementing the
functional addressing switch suggested by Thomas Wagner.

Unfortunately the functional addressing switch came in very late but
it is really very simple and already tested.

I would like to leave it to the maintainers whether the second patch
can still go into the 5.10-rc tree, which is intended for long-term.

Oliver Hartkopp (2):
  can-isotp: block setsockopt on bound sockets
  can-isotp: add SF_BROADCAST support for functional addressing

 include/uapi/linux/can/isotp.h |  2 +-
 net/can/isotp.c                | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.29.2

