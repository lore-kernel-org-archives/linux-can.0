Return-Path: <SRS0=EbP5=B2=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32EC433DF
	for <linux-can@archiver.kernel.org>; Sun, 16 Aug 2020 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF0B20772
	for <linux-can@archiver.kernel.org>; Sun, 16 Aug 2020 23:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHPXFI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPXFH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Aug 2020 19:05:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A2C061786;
        Sun, 16 Aug 2020 16:05:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1CFC711E47940;
        Sun, 16 Aug 2020 15:48:20 -0700 (PDT)
Date:   Sun, 16 Aug 2020 16:05:05 -0700 (PDT)
Message-Id: <20200816.160505.374966632241402758.davem@davemloft.net>
To:     mkl@pengutronix.de
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: pull-request: can 2020-08-15
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200815092116.424137-1-mkl@pengutronix.de>
References: <20200815092116.424137-1-mkl@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 16 Aug 2020 15:48:20 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 15 Aug 2020 11:21:12 +0200

> this is a pull request of 4 patches for net/master.
> 
> All patches are by Zhang Changzhong and fix broadcast related problems in the
> j1939 CAN networking stack.

Pulled, thanks Marc.
