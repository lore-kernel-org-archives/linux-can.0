Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBACC433E6
	for <linux-can@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB59864E68
	for <linux-can@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350244AbhCDAYC (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59102 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576221AbhCCVNR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 16:13:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 07D6F4D2ECC93;
        Wed,  3 Mar 2021 13:12:35 -0800 (PST)
Date:   Wed, 03 Mar 2021 13:12:31 -0800 (PST)
Message-Id: <20210303.131231.1574207832462999993.davem@davemloft.net>
To:     mkl@pengutronix.de
Cc:     martin@strongswan.org, kuba@kernel.org, wg@grandegger.com,
        netdev@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH net] can: dev: Move device back to init netns on owning
 netns delete,Re: [PATCH net] can: dev: Move device back to init netns on
 owning netns delete
From:   David Miller <davem@davemloft.net>
In-Reply-To: <86f703d8-d658-505a-6493-54bf09ed65b2@pengutronix.de>
References: <20210302122423.872326-1-martin@strongswan.org>
        <20210302122423.872326-1-martin@strongswan.org>
        <86f703d8-d658-505a-6493-54bf09ed65b2@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 03 Mar 2021 13:12:36 -0800 (PST)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 3 Mar 2021 21:29:39 +0100

> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> David, Jakub are you taking this patch?

Nope, please take via the can tree, thanks!
