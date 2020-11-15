Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB70BC56202
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 01:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B8524178
	for <linux-can@archiver.kernel.org>; Sun, 15 Nov 2020 01:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKA/9VjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKOBjS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 14 Nov 2020 20:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgKOBjS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 14 Nov 2020 20:39:18 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82DD24137;
        Sun, 15 Nov 2020 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605404358;
        bh=gkdsXGCRLP6jS46lHcoA/gadm7IkxG50zBM0pa4Gc30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IKA/9VjKdnIkH/1jZBFrevZO5Dw/z0dqR2Z2D26zvSABpnsdFkmKXZWqNFavy/7Qe
         rZ8XVhi45BbpJbVRlMvUlXQJbhFFTYr+4136VUv4iZxfyGrJ/dk51i1zrmm/0Zj8ZS
         yMRrxp3ySeyKJnX05LWTSXqTJXHFN6Z9GRlKqfGc=
Date:   Sat, 14 Nov 2020 17:39:16 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: pull-request: can 2020-11-14
Message-ID: <20201114173916.64217d86@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201114173501.023b5e49@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201114173358.2058600-1-mkl@pengutronix.de>
        <20201114173501.023b5e49@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat, 14 Nov 2020 17:35:01 -0800 Jakub Kicinski wrote:
> Two invalid fixes tags here, do you want to respin or should I pull?

Just realized you probably have these objects in your tree so it'd be
useful if I told you which ones ;)

Commit: be719591ede2 ("can: m_can: Fix freeing of can device from peripherials")
	Fixes tag: Fixes: d42f4e1d06d9 ("can: m_can: Create a m_can platform framework")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: aff1dea235ee ("can: m_can: m_can_class_free_dev(): introduce new function")
	Fixes tag: Fixes: d42f4e1d06d9 ("can: m_can: Create a m_can platform framework")
	Has these problem(s):
		- Target SHA1 does not exist
