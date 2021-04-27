Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055D6C43460
	for <linux-can@archiver.kernel.org>; Tue, 27 Apr 2021 05:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEA8613BD
	for <linux-can@archiver.kernel.org>; Tue, 27 Apr 2021 05:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhD0FWj (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 27 Apr 2021 01:22:39 -0400
Received: from mout02.posteo.de ([185.67.36.66]:55661 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhD0FWg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 27 Apr 2021 01:22:36 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C0CDB2400FD
        for <linux-can@vger.kernel.org>; Tue, 27 Apr 2021 07:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1619500911; bh=9OnaEzP7+K30fSr267P0abZkCLV5RfY0Ce9iEMsTJgU=;
        h=From:To:Subject:Date:From;
        b=pWY14SFSs5+n0YJS6P128no1j/HE9TMuwAWXlmTAYH24SFkPpCQPCedR31Z0CvvYA
         NeZbUzY1Pv7bwYz6VGA6Is+LGpIOxWaAjHyUsYAsf4nHj8/4KJP+9PkOsDX6vF+m9S
         Gderr/Pzj138dfLItnzLoLUZyo0U7Qgr2RPhnfgkjk0W2IipyaItB8iUaiPagX+UcD
         8pFDkgZkWB93KmOkWgt3L62YnYDC4MVFIn7zWjWdzWR/wQRH1f8V+v2KHTEvylSUDR
         FdlOaXsMnzEMZwMcSbxvxS0lIe82UOHSGioZxx1Qi73lSAR2DXLvhY5QCYIEDI3hc9
         9pXdggK5abM3g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FTqrG3sdWz9rxG;
        Tue, 27 Apr 2021 07:21:50 +0200 (CEST)
From:   Patrick Menschel <menschel.p@posteo.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] can-isotp: Add more comprehensive error messages
Date:   Tue, 27 Apr 2021 05:21:46 +0000
Message-Id: <20210427052150.2308-1-menschel.p@posteo.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch series adds more comprehensive error messages to isotp.c by
using error pointers instead of decimal error numbers.

https://www.kernel.org/doc/html/latest/core-api/printk-formats.html#error-pointers

It also adds a more comprehensive error message in case txqueue is full
due to a burst transfer, telling the user to increase txqueuelen to 
prevent this from happening.


Patrick Menschel (3):
  can-isotp: Change error format from decimal to symbolic error names
  can-isotp: Add symbolic error message to isotp_module_init()
  can-isotp: Add error message if txqueuelen is too small

 net/can/isotp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.17.1

